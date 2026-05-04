import json
import os
import numpy as np
from sentence_transformers import SentenceTransformer
from sklearn.metrics.pairwise import cosine_similarity

# ============================================================
# EXTRAÇÃO DE TAGS (a partir de habilidade, unidade, objeto)
# ============================================================
def gerar_tags(hab_desc, unidade="", objeto=""):
    """Retorna um conjunto de tags baseadas no conteúdo da habilidade."""
    texto = f"{hab_desc} {unidade} {objeto}".lower()
    tags = set()

    # Verbos de habilidade
    if any(p in texto for p in ["identificar", "reconhecer", "diferenciar", "comparar", "analisar", "classificar"]):
        tags.add("análise")
    if any(p in texto for p in ["ler", "compreender", "interpretar", "inferir"]):
        tags.add("leitura")
    if any(p in texto for p in ["escrever", "produzir", "redigir", "editar", "revisar"]):
        tags.add("escrita")
    if any(p in texto for p in ["oral", "falar", "debater", "entrevistar", "declarar", "recitar"]):
        tags.add("oralidade")
    if any(p in texto for p in ["pesquisar", "buscar", "selecionar", "coletar"]):
        tags.add("pesquisa")

    # Campos do conhecimento
    if any(p in texto for p in ["ortografia", "grafia", "acentuação", "pontuação"]):
        tags.add("ortografia")
    if any(p in texto for p in ["concordância", "verbal", "nominal", "regência"]):
        tags.add("sintaxe")
    if any(p in texto for p in ["substantivo", "adjetivo", "verbo", "advérbio", "pronome", "preposição"]):
        tags.add("morfologia")
    if any(p in texto for p in ["figuras de linguagem", "metáfora", "ironia", "hipérbole"]):
        tags.add("figuras de linguagem")
    if any(p in texto for p in ["gênero", "texto", "carta", "notícia", "receita", "bilhete", "poema"]):
        tags.add("gêneros textuais")
    if any(p in texto for p in ["literatura", "poema", "conto", "crônica", "romance", "teatro", "dramático"]):
        tags.add("literatura")
    if any(p in texto for p in ["argument", "opinião", "debate", "persuas", "convenc"]):
        tags.add("argumentação")
    if any(p in texto for p in ["tecnologia", "digital", "vídeo", "podcast", "blog", "vlog"]):
        tags.add("tecnologia")
    if any(p in texto for p in ["colabor", "grupo", "coletiv", "equipe"]):
        tags.add("colaboração")

    # Se não detectou nenhuma, coloca genérica
    if not tags:
        tags.add("geral")

    return tags


# ============================================================
# CLASSE PRINCIPAL DO GERADOR
# ============================================================
class GeradorSugestoes:
    def __init__(self, db_path="atividades.json", modelo_path=None):
        # Carrega o modelo de embeddings
        if modelo_path and os.path.exists(modelo_path):
            self.modelo = SentenceTransformer(modelo_path)
        else:
            self.modelo = SentenceTransformer('all-MiniLM-L6-v2')

        # Carrega o banco de atividades
        self.atividades = self._carregar_atividades(db_path)

        # Pré-computa embeddings das descrições e das tags combinadas
        self.metodologias = self.atividades.get("metodologias", [])
        self.avaliacoes = self.atividades.get("avaliacoes", [])

        # Cria textos enriquecidos para embedding: "descricao [TAGS]"
        textos_met = [f"{m['descricao']} [{' '.join(m['tags'])}]" for m in self.metodologias]
        textos_ava = [f"{a['descricao']} [{' '.join(a['tags'])}]" for a in self.avaliacoes]

        self.emb_metodologias = self.modelo.encode(textos_met) if textos_met else None
        self.emb_avaliacoes = self.modelo.encode(textos_ava) if textos_ava else None

    def _carregar_atividades(self, path):
        if not os.path.exists(path):
            # Retorna estrutura vazia se não achar o arquivo
            return {"metodologias": [], "avaliacoes": []}
        with open(path, "r", encoding="utf-8") as f:
            return json.load(f)

    def _calcular_score(self, embedding_atividades, tags_consulta, emb_consulta):
        """Combina similaridade de embedding com sobreposição de tags."""
        if embedding_atividades is None:
            return []

        sims = cosine_similarity(emb_consulta, embedding_atividades)[0]
        scores = []
        for idx, sim in enumerate(sims):
            # Pega as tags da atividade
            atividade_tags = set(self.metodologias[idx]['tags']) if len(scores) < len(self.metodologias) else set(self.avaliacoes[idx]['tags'])
            # Sobreposição: quantas tags em comum
            overlap = len(tags_consulta.intersection(atividade_tags))
            # Score final: 70% similaridade + 30% overlap (máximo 1.0)
            score = 0.7 * sim + 0.3 * (overlap / max(len(tags_consulta), 1))
            scores.append(score)
        return scores

    def _selecionar_top(self, scores, lista_atividades, top_n=3, limiar=0.4):
        """Retorna as top N atividades que pontuaram acima do limiar, sem repetir descrições."""
        indices = np.argsort(scores)[::-1]
        selecionadas = []
        descricoes_vistas = set()
        for i in indices:
            if scores[i] < limiar:
                break
            desc = lista_atividades[i]['descricao']
            if desc not in descricoes_vistas:
                selecionadas.append(desc)
                descricoes_vistas.add(desc)
            if len(selecionadas) >= top_n:
                break
        return selecionadas

    def gerar_metodologia(self, habilidades_data):
        # Extrai tags globais de todas as habilidades
        tags = set()
        descricao_composta = ""
        for hab in habilidades_data:
            tags.update(gerar_tags(hab["descricao"], hab.get("unidade", ""), hab.get("objeto", "")))
            descricao_composta += hab["descricao"] + " "
        if not tags:
            tags.add("ensino")

        # Embedding da consulta é a média das descrições
        emb_consulta = self.modelo.encode([descricao_composta])

        # Similaridade com metodologias
        scores = self._calcular_score(self.emb_metodologias, tags, emb_consulta)
        if not scores:
            return "Nenhuma sugestão disponível no banco de atividades."

        sugestoes = self._selecionar_top(scores, self.metodologias, top_n=3)

        if sugestoes:
            return "\n".join(f"• {s}" for s in sugestoes)
        else:
            # Fallback genérico baseado nas tags
            return self._fallback(tags, "metodologia")

    def gerar_avaliacao(self, habilidades_data):
        tags = set()
        descricao_composta = ""
        for hab in habilidades_data:
            tags.update(gerar_tags(hab["descricao"], hab.get("unidade", ""), hab.get("objeto", "")))
            descricao_composta += hab["descricao"] + " "
        if not tags:
            tags.add("ensino")

        emb_consulta = self.modelo.encode([descricao_composta])
        scores = self._calcular_score(self.emb_avaliacoes, tags, emb_consulta)
        if not scores:
            return "Nenhum critério de avaliação disponível."

        sugestoes = self._selecionar_top(scores, self.avaliacoes, top_n=3)
        if sugestoes:
            return "\n".join(f"• {s}" for s in sugestoes)
        else:
            return self._fallback(tags, "avaliação")

    def _fallback(self, tags, tipo):
        """Gera uma sugestão simples baseada nas tags, caso nenhuma atividade atinja o limiar."""
        if tipo == "metodologia":
            base = "Sugestão gerada automaticamente com base nas habilidades selecionadas:"
            if "leitura" in tags:
                base += "\n• Leitura e discussão de textos diversos."
            if "escrita" in tags:
                base += "\n• Produção textual com etapa de revisão."
            if "oralidade" in tags:
                base += "\n• Atividade de debate ou apresentação oral."
            if "análise" in tags:
                base += "\n• Exercícios de análise linguística e gramatical."
            if not base:
                base += "\n• Aula expositiva dialogada com participação ativa."
            return base
        else:  # avaliação
            base = "Sugestão de critérios avaliativos:"
            if "escrita" in tags:
                base += "\n• Observar domínio da norma culta na produção textual."
            if "oralidade" in tags:
                base += "\n• Avaliar clareza e organização da fala durante apresentações."
            if "leitura" in tags:
                base += "\n• Verificar compreensão leitora por meio de questões ou resumos."
            if "análise" in tags:
                base += "\n• Aplicar exercícios de fixação e correção de acordo com gabarito."
            if not base:
                base += "\n• Participação nas atividades e cumprimento das tarefas."
            return base

# ============================================================
# FUNÇÕES DE MÓDULO COMPATÍVEIS COM O MAIN
# ============================================================
_gerador = None

def carregar_gerador():
    global _gerador
    if _gerador is None:
        _gerador = GeradorSugestoes("atividades.json", modelo_path="modelo_ia")
    return _gerador

def gerar_metodologia(habilidades_data):
    return carregar_gerador().gerar_metodologia(habilidades_data)

def gerar_avaliacao(habilidades_data):
    return carregar_gerador().gerar_avaliacao(habilidades_data)