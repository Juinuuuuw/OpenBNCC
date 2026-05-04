import numpy as np
from sentence_transformers import SentenceTransformer

# ============================================================
# NORMALIZAÇÃO E CORREÇÕES
# ============================================================
def normalizar(texto):
    return texto.strip().lower()

CORRECOES = {
    "hiperonimo": "hiperônimo",
    "hiperonimos": "hiperônimo",
    "hiperônimos": "hiperônimo",
    # adicione outras correções aqui
}

def preprocessar(query):
    query = normalizar(query)
    return CORRECOES.get(query, query)

# ============================================================
# EXPANSÃO SEMÂNTICA (sinônimos e termos relacionados)
# ============================================================
EXPANSOES = {
    "hiperônimo": [
        "relações semânticas",
        "vocabulário",
        "campo lexical",
        "coesão lexical",
        "sinonímia"
    ],
    "transitividade verbal": [
        "verbo transitivo",
        "objeto direto",
        "predicação verbal",
        "complemento verbal"
    ],
    "figuras de linguagem": [
        "metáfora",
        "comparação",
        "personificação",
        "hipérbole",
        "eufemismo",
        "ironia"
    ],
    # continue com outros tópicos...
}

def expandir(query):
    return [query] + EXPANSOES.get(query, [])

# ============================================================
# GERAÇÃO DE TAGS AUTOMÁTICAS
# ============================================================
def gerar_tags(habilidade):
    tags = set()
    texto = habilidade.lower()
    if any(p in texto for p in ["identificar", "reconhecer", "diferenciar", "analisar"]):
        tags.add("análise")
    if any(p in texto for p in ["ler", "compreender", "interpretar"]):
        tags.add("leitura")
    if any(p in texto for p in ["vocabulário", "sentido", "significado", "polissemia"]):
        tags.add("semântica")
    if any(p in texto for p in ["escrever", "produzir", "redigir"]):
        tags.add("escrita")
    if any(p in texto for p in ["verbo", "oração", "sujeito", "predicado"]):
        tags.add("sintaxe")
    return tags

# ============================================================
# BUSCADOR SEMÂNTICO TURBINADO
# ============================================================
class BuscadorSemantico:
    def __init__(self, cursor, modelo_path=None):
        if modelo_path and os.path.exists(modelo_path):
            self.modelo = SentenceTransformer(modelo_path)
        else:
            self.modelo = SentenceTransformer('all-MiniLM-L6-v2')
        
        self.codigos = []
        self.embeddings = None
        self.textos_originais = []
        self.dados_completos = []  # guarda (codigo, habilidade, unidade, objeto, componente)
        self._carregar_embeddings(cursor)

    def _carregar_embeddings(self, cursor):
        cursor.execute("""
            SELECT codigo, habilidade, unidade_tematica, objeto_conhecimento, componente
            FROM habilidades
        """)
        dados = cursor.fetchall()
        self.dados_completos = dados
        textos_index = []
        for codigo, hab, un, obj, comp in dados:
            # Embedding ENRIQUECIDO (inclui contexto)
            texto = f"{hab}\nUnidade: {un or ''}\nObjeto: {obj or ''}\nComponente: {comp or ''}"
            textos_index.append(texto)
            self.textos_originais.append(hab)
            self.codigos.append(codigo)
        if textos_index:
            self.embeddings = self.modelo.encode(textos_index, show_progress_bar=False)

    def buscar(self, consulta, filtro_etapa=None, filtro_ano=None, filtro_componente=None, top_n=10):
        if self.modelo is None or self.embeddings is None:
            return []
        
        # Pré-processamento e expansão
        query = preprocessar(consulta)
        termos = expandir(query)
        
        # Embedding da consulta (usando o texto expandido para dar mais contexto)
        emb_consulta = self.modelo.encode([" ".join(termos)])
        sims = np.dot(self.embeddings, emb_consulta.T).flatten()
        
        # Filtro por contexto (ano, componente)
        mascara = np.ones(len(sims), dtype=bool)
        if filtro_ano:
            mascara &= np.array([ano == filtro_ano for _, _, _, _, ano in self.dados_completos])
        if filtro_componente:
            mascara &= np.array([comp == filtro_componente for _, _, _, _, comp in self.dados_completos])
        # Etapa pode ser tratada similarmente se necessário
        
        indices = np.argsort(sims)[::-1]
        
        resultados = []
        for i in indices:
            if not mascara[i]:
                continue
            score = sims[i]
            codigo = self.codigos[i]
            texto_hab = self.textos_originais[i]
            
            # SCORE HÍBRIDO
            texto_lower = texto_hab.lower()
            # boost por palavra exata
            if query in texto_lower:
                score += 0.2
            # boost por termos expandidos
            for termo in termos[1:]:  # pula o original
                if termo in texto_lower:
                    score += 0.1
            # boost por tags
            tags = gerar_tags(texto_hab)
            if query in tags:
                score += 0.3
            # boost se o próprio código contém o termo (ex: "EF67LP38")
            if query in codigo.lower():
                score += 0.1
            
            resultados.append((codigo, score, tags))
            if len(resultados) >= top_n:
                break
        
        # Re-ranking final
        resultados.sort(key=lambda x: x[1], reverse=True)
        return resultados