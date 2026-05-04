import sqlite3
import tkinter as tk
from tkinter import ttk, messagebox, scrolledtext, simpledialog
import json
import os
import threading

# Importa o buscador melhorado (com correção, expansão, score híbrido, etc.)
from buscador_semantico import BuscadorSemantico

import gerador_sugestoes

class BNCCApp:
    def __init__(self, root):
        self.root = root
        self.root.title("OpenBNCC - Simplificando a BNCC")
        self.root.geometry("1300x800")

        # Paleta de cores 2026 (Minimalista)
        self.colors = {
            "bg_app": "#F3F4F6",
            "bg_card": "#FFFFFF",
            "text_main": "#1F2937",
            "text_sec": "#6B7280",
            "border": "#E5E7EB",
            "primary": "#3B82F6",
            "success": "#10B981",
            "danger": "#EF4444",
            "hover_blue": "#DBEAFE",
            "hover_green": "#D1FAE5"
        }

        self.font_main = ("Segoe UI", 10)
        self.font_title = ("Segoe UI", 14, "bold")
        self.font_subtitle = ("Segoe UI", 11, "bold")
        self.font_code = ("Consolas", 11)

        self.root.configure(bg=self.colors["bg_app"])

        # Estilo global do TTK
        style = ttk.Style()
        style.theme_use('clam')
        style.configure('TCombobox', fieldbackground='#FFFFFF', background='#FFFFFF', borderwidth=1, relief='flat')
        style.configure('TScrollbar', background=self.colors["border"], troughcolor=self.colors["bg_app"], borderwidth=0, arrowsize=12)
        style.configure('TPanedwindow', background=self.colors["bg_app"])

        self.db_path = 'bncc.db'
        if not os.path.exists(self.db_path):
            messagebox.showerror("Erro", f"Banco de dados '{self.db_path}' não encontrado!")
            root.destroy()
            return

        self.conn = sqlite3.connect(self.db_path)
        self.cursor = self.conn.cursor()

        self.criar_tabela_planos()
        self.habilidades_marcadas_pre_add = set()

        # Verifica se a tabela de tópicos existe
        self.topicos_disponiveis = self._verificar_tabela_topicos()

        # Inicializa o buscador semântico (modelo leve, ~80 MB)
        self.buscador_semantico = None
        self._inicializar_buscador_semantico()

        # Divisão da tela
        self.paned_window = ttk.PanedWindow(root, orient=tk.HORIZONTAL)
        self.paned_window.pack(fill='both', expand=True, padx=20, pady=20)

        self.frame_esq = tk.Frame(self.paned_window, bg=self.colors["bg_app"])
        self.frame_dir = tk.Frame(self.paned_window, bg=self.colors["bg_app"])

        self.paned_window.add(self.frame_esq, weight=3)
        self.paned_window.add(self.frame_dir, weight=2)

        self.criar_interface_busca()
        self.criar_interface_plano_com_scroll()

        self.carregar_anos()
        self.carregar_componentes()
        self.carregar_todos_codigos()

    def _verificar_tabela_topicos(self):
        try:
            self.cursor.execute("SELECT name FROM sqlite_master WHERE type='table' AND name='topicos_habilidades'")
            return self.cursor.fetchone() is not None
        except sqlite3.Error:
            return False

    def _inicializar_buscador_semantico(self):
        try:
            # Caminho local para empacotamento: coloque a pasta 'modelo_ia' ao lado do executável
            base_dir = os.path.dirname(os.path.abspath(__file__))
            modelo_path = os.path.join(base_dir, 'modelo_ia')
            self.buscador_semantico = BuscadorSemantico(self.cursor, modelo_path if os.path.exists(modelo_path) else None)
        except Exception as e:
            print("Aviso: busca semântica não disponível:", e)

    # =========================================================================
    # GERAÇÃO DE SUGESTÕES POR TEMPLATES
    # =========================================================================
    def gerar_sugestoes_template(self):
        codigos = list(self.lista_habilidades.get(0, tk.END))
        if not codigos:
            messagebox.showwarning("Aviso", "Adicione ao menos uma habilidade antes de gerar sugestões.")
            return

        placeholders = ','.join('?'*len(codigos))
        self.cursor.execute(
            f"SELECT codigo, componente, ano, unidade_tematica, objeto_conhecimento, habilidade FROM habilidades WHERE codigo IN ({placeholders})",
            codigos
        )
        rows = self.cursor.fetchall()
        habilidades_data = []
        for cod, comp, ano, un, obj, hab in rows:
            habilidades_data.append({
                "codigo": cod,
                "componente": comp,
                "ano": ano,
                "unidade": un or "",
                "objeto": obj or "",
                "descricao": hab or ""
            })

        def _gerar():
            try:
                metodologia = gerador_sugestoes.gerar_metodologia(habilidades_data)
                avaliacao   = gerador_sugestoes.gerar_avaliacao(habilidades_data)
                self.root.after(0, lambda: self.txt_metodologia.insert('1.0', metodologia))
                self.root.after(0, lambda: self.txt_avaliacao.insert('1.0', avaliacao))
            except Exception as e:
                self.root.after(0, lambda: messagebox.showerror("Erro", f"Falha ao gerar sugestões:\n{e}"))

        threading.Thread(target=_gerar, daemon=True).start()

    # =========================================================================
    # CRIAÇÃO DA TABELA DE PLANOS
    # =========================================================================
    def criar_tabela_planos(self):
        self.cursor.execute("""
            CREATE TABLE IF NOT EXISTS planos_aula (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                titulo TEXT NOT NULL,
                data_criacao TEXT DEFAULT (datetime('now','localtime')),
                habilidades_selecionadas TEXT,
                campos_auto TEXT,
                metodologia TEXT,
                avaliacao TEXT
            )
        """)
        self.conn.commit()

    def criar_card(self, parent, titulo=""):
        card = tk.Frame(parent, bg=self.colors["bg_card"], highlightbackground=self.colors["border"], highlightthickness=1)
        if titulo:
            tk.Label(card, text=titulo, font=self.font_subtitle, bg=self.colors["bg_card"], fg=self.colors["text_main"]).pack(anchor='w', padx=15, pady=(15, 5))
        content = tk.Frame(card, bg=self.colors["bg_card"])
        content.pack(fill='both', expand=True, padx=15, pady=(0, 15))
        return card, content

    def criar_botao(self, parent, text, color, command, is_bold=False):
        font = ("Segoe UI", 10, "bold") if is_bold else self.font_main
        btn = tk.Button(parent, text=text, font=font, bg=color, fg='white', relief='flat', bd=0, cursor='hand2', padx=15, pady=6, command=command)
        return btn

    def criar_interface_busca(self):
        tk.Label(self.frame_esq, text="Pesquisa de Habilidades", font=self.font_title, bg=self.colors["bg_app"], fg=self.colors["text_main"]).pack(pady=(0, 15), anchor='w')

        card_filtros, content_filtros = self.criar_card(self.frame_esq)
        card_filtros.pack(fill='x', pady=(0, 15))

        linha1 = tk.Frame(content_filtros, bg=self.colors["bg_card"])
        linha1.pack(fill='x', pady=(15, 5))

        tk.Label(linha1, text="Etapa", bg=self.colors["bg_card"], fg=self.colors["text_sec"], font=self.font_main).pack(side='left', padx=(0,5))
        self.etapa_var = tk.StringVar()
        self.etapa_combo = ttk.Combobox(linha1, textvariable=self.etapa_var, state='readonly', width=18, font=self.font_main)
        self.etapa_combo['values'] = ['Todas', 'Educação Infantil', 'Ensino Fundamental', 'Ensino Médio']
        self.etapa_combo.current(2)
        self.etapa_combo.pack(side='left', padx=(0, 15))
        self.etapa_combo.bind('<<ComboboxSelected>>', self.on_etapa_change)

        tk.Label(linha1, text="Ano", bg=self.colors["bg_card"], fg=self.colors["text_sec"], font=self.font_main).pack(side='left', padx=(0,5))
        self.ano_var = tk.StringVar()
        self.ano_combo = ttk.Combobox(linha1, textvariable=self.ano_var, state='readonly', width=8, font=self.font_main)
        self.ano_combo.pack(side='left', padx=(0, 15))

        tk.Label(linha1, text="Componente", bg=self.colors["bg_card"], fg=self.colors["text_sec"], font=self.font_main).pack(side='left', padx=(0,5))
        self.componente_var = tk.StringVar()
        self.componente_combo = ttk.Combobox(linha1, textvariable=self.componente_var, state='readonly', width=15, font=self.font_main)
        self.componente_combo.pack(side='left', fill='x', expand=True)

        linha2 = tk.Frame(content_filtros, bg=self.colors["bg_card"])
        linha2.pack(fill='x', pady=5)

        tk.Label(linha2, text="Termo", bg=self.colors["bg_card"], fg=self.colors["text_sec"], font=self.font_main).pack(side='left', padx=(0,5))

        entry_frame = tk.Frame(linha2, bg=self.colors["bg_card"], highlightbackground=self.colors["border"], highlightthickness=1)
        entry_frame.pack(side='left', fill='x', expand=True, padx=(0, 15))
        self.busca_entry = tk.Entry(entry_frame, font=self.font_main, bd=0, relief='flat')
        self.busca_entry.pack(fill='both', expand=True, padx=8, pady=6)
        self.busca_entry.bind('<Return>', lambda e: self.buscar())

        self.btn_buscar = self.criar_botao(linha2, "Buscar", self.colors["primary"], self.buscar, is_bold=True)
        self.btn_buscar.pack(side='left', padx=(0, 10))

        # Botão de busca inteligente (IA local)
        self.btn_ia = self.criar_botao(linha2, "🔍 Busca Inteligente", self.colors["primary"], self.busca_semantica)
        self.btn_ia.pack(side='left', padx=(0, 10))
        if not self.buscador_semantico or self.buscador_semantico.modelo is None:
            self.btn_ia.config(state='disabled', text="IA indisponível")

        self.btn_limpar = self.criar_botao(linha2, "Limpar", self.colors["text_sec"], self.limpar_filtros)
        self.btn_limpar.pack(side='left')

        tk.Label(self.frame_esq, text="💡 Dica: Clique no texto da habilidade para marcá-la, depois clique em Adicionar.", font=("Segoe UI", 9), bg=self.colors["bg_app"], fg=self.colors["text_sec"]).pack(anchor='w', pady=(0, 5))

        card_res, content_res = self.criar_card(self.frame_esq)
        card_res.pack(fill='both', expand=True, pady=(0, 15))

        self.resultado_label = tk.Label(content_res, text="0 habilidades encontradas", font=("Segoe UI", 9, "bold"), bg=self.colors["bg_card"], fg=self.colors["text_sec"])
        self.resultado_label.pack(anchor='w', pady=(10, 5))

        self.resultado_text = scrolledtext.ScrolledText(content_res, wrap=tk.WORD, font=self.font_main, bg=self.colors["bg_card"], fg=self.colors["text_main"], relief='flat', bd=0)
        self.resultado_text.pack(fill='both', expand=True)

        self.resultado_text.tag_configure('codigo', font=self.font_code, foreground=self.colors["primary"], spacing1=5)
        self.resultado_text.tag_configure('componente', font=("Segoe UI", 9, "bold"), foreground=self.colors["success"])
        self.resultado_text.tag_configure('tematica', font=("Segoe UI", 9), foreground=self.colors["text_sec"])
        self.resultado_text.tag_configure('habilidade', font=self.font_main, foreground=self.colors["text_main"], spacing3=15)
        self.resultado_text.tag_configure('separador', foreground=self.colors["border"], spacing3=15)

        self.resultado_text.tag_bind('clicavel', '<Button-1>', self.on_click_habilidade)
        self.resultado_text.tag_bind('clicavel', '<Enter>', lambda e: self.resultado_text.config(cursor="hand2"))
        self.resultado_text.tag_bind('clicavel', '<Leave>', lambda e: self.resultado_text.config(cursor=""))

        self.btn_enviar_plano = self.criar_botao(self.frame_esq, "Adicionar Habilidades Marcadas ➔", self.colors["success"], self.enviar_marcadas_para_plano, is_bold=True)
        self.btn_enviar_plano.config(pady=10)
        self.btn_enviar_plano.pack(fill='x')

    def criar_interface_plano_com_scroll(self):
        # ... (mantido exatamente como no código anterior, sem alterações)
        tk.Label(self.frame_dir, text="Plano de Aula", font=self.font_title, bg=self.colors["bg_app"], fg=self.colors["text_main"]).pack(pady=(0, 15), anchor='w', padx=10)

        self.canvas_dir = tk.Canvas(self.frame_dir, bg=self.colors["bg_app"], highlightthickness=0)
        scrollbar_dir = ttk.Scrollbar(self.frame_dir, orient="vertical", command=self.canvas_dir.yview)

        self.plano_content = tk.Frame(self.canvas_dir, bg=self.colors["bg_app"], padx=10)
        self.plano_content.bind("<Configure>", lambda e: self.canvas_dir.configure(scrollregion=self.canvas_dir.bbox("all")))
        self.canvas_window = self.canvas_dir.create_window((0, 0), window=self.plano_content, anchor="nw")
        self.canvas_dir.configure(yscrollcommand=scrollbar_dir.set)
        self.canvas_dir.bind('<Configure>', lambda e: self.canvas_dir.itemconfig(self.canvas_window, width=e.width))

        self.canvas_dir.pack(side="left", fill="both", expand=True)
        scrollbar_dir.pack(side="right", fill="y")
        self.canvas_dir.bind_all("<MouseWheel>", self._on_mousewheel)

        # 1. Habilidades Selecionadas
        card_sel, content_sel = self.criar_card(self.plano_content, "Habilidades no Plano")
        card_sel.pack(fill='x', pady=(0, 15))

        manual_add_frame = tk.Frame(content_sel, bg=self.colors["bg_card"])
        manual_add_frame.pack(fill='x', pady=(0, 10))
        tk.Label(manual_add_frame, text="Inserir manualmente:", font=self.font_main, bg=self.colors["bg_card"], fg=self.colors["text_sec"]).pack(side='left', padx=(0,5))
        self.codigo_manual_var = tk.StringVar()
        self.combo_manual = ttk.Combobox(manual_add_frame, textvariable=self.codigo_manual_var, width=15, font=self.font_main)
        self.combo_manual.pack(side='left', padx=(0,10))
        btn_add_manual = self.criar_botao(manual_add_frame, "Adicionar", self.colors["primary"], self.adicionar_habilidade_manual)
        btn_add_manual.config(padx=10, pady=2)
        btn_add_manual.pack(side='left')

        list_frame = tk.Frame(content_sel, highlightbackground=self.colors["border"], highlightthickness=1)
        list_frame.pack(fill='both', expand=True, pady=(0,10))
        self.lista_habilidades = tk.Listbox(list_frame, height=3, selectmode='multiple', font=self.font_code, bg='#F9FAFB', bd=0, relief='flat', fg=self.colors["text_main"])
        self.lista_habilidades.pack(fill='both', expand=True, padx=5, pady=5)

        btn_remover = self.criar_botao(content_sel, "Remover Selecionada", self.colors["danger"], self.remover_selecionadas)
        btn_remover.pack(anchor='e')

        # 2. Informações Oficiais
        card_auto, content_auto = self.criar_card(self.plano_content, "Informações Oficiais")
        card_auto.pack(fill='x', pady=(0, 15))

        self.txt_unidades = self.criar_campo_texto(content_auto, "Unidade(s) Temática(s):", height=2)
        self.txt_objetos = self.criar_campo_texto(content_auto, "Objeto(s) de Conhecimento:", height=2)
        self.txt_habilidades = self.criar_campo_texto(content_auto, "Descrição das Habilidades:", height=4)

        # 3. Planejamento
        card_plan, content_plan = self.criar_card(self.plano_content, "Seu Planejamento")
        card_plan.pack(fill='x', pady=(0, 15))

        self.txt_metodologia = self.criar_campo_texto(content_plan, "Metodologia / Atividades Propostas:", height=5, is_auto=False)
        self.txt_avaliacao = self.criar_campo_texto(content_plan, "Critérios de Avaliação:", height=4, is_auto=False)

        btn_gerar_template = self.criar_botao(
            content_plan,
            "📋 Gerar Sugestões (Template)",
            self.colors["primary"],
            self.gerar_sugestoes_template,
            is_bold=True
        )
        btn_gerar_template.pack(pady=(10, 0))

        btn_salvar = self.criar_botao(self.plano_content, "Salvar Plano de Aula", self.colors["text_main"], self.salvar_plano, is_bold=True)
        btn_salvar.config(pady=12, font=("Segoe UI", 12, "bold"))
        btn_salvar.pack(fill='x', pady=(0, 20))

    def criar_campo_texto(self, parent, label_text, height, is_auto=True):
        tk.Label(parent, text=label_text, bg=self.colors["bg_card"], fg=self.colors["text_main"], font=("Segoe UI", 9, "bold")).pack(anchor='w', pady=(10, 5))
        bg_color = '#F9FAFB' if is_auto else '#FFFFFF'
        frame_text = tk.Frame(parent, bg=bg_color, highlightbackground=self.colors["border"], highlightthickness=1)
        frame_text.pack(fill='x')
        txt = scrolledtext.ScrolledText(frame_text, height=height, wrap=tk.WORD, font=self.font_main, bg=bg_color, fg=self.colors["text_main"], relief='flat', bd=0)
        txt.pack(fill='x', padx=8, pady=8)
        return txt

    def _on_mousewheel(self, event):
        self.canvas_dir.yview_scroll(int(-1*(event.delta/120)), "units")

    def on_click_habilidade(self, event):
        index = self.resultado_text.index(f"@{event.x},{event.y}")
        tags = self.resultado_text.tag_names(index)
        for tag in tags:
            if tag.startswith("codigo_"):
                codigo = tag.split("codigo_")[1]
                self.marcar_desmarcar_para_add(codigo)
                break

    def marcar_desmarcar_para_add(self, codigo):
        habilidades_no_plano = list(self.lista_habilidades.get(0, tk.END))
        if codigo in habilidades_no_plano:
            messagebox.showinfo("Info", "Esta habilidade já foi adicionada ao plano!")
            return
        if codigo in self.habilidades_marcadas_pre_add:
            self.habilidades_marcadas_pre_add.remove(codigo)
            self.resultado_text.tag_configure(f"codigo_{codigo}", background=self.colors["bg_card"])
        else:
            self.habilidades_marcadas_pre_add.add(codigo)
            self.resultado_text.tag_configure(f"codigo_{codigo}", background=self.colors["hover_blue"])

    def enviar_marcadas_para_plano(self):
        if not self.habilidades_marcadas_pre_add:
            messagebox.showinfo("Aviso", "Clique em alguma habilidade no texto (ficará azul) antes de adicionar.")
            return
        for codigo in self.habilidades_marcadas_pre_add:
            self.lista_habilidades.insert(tk.END, codigo)
            try:
                self.resultado_text.tag_configure(f"codigo_{codigo}", background=self.colors["hover_green"])
            except tk.TclError:
                pass
        self.habilidades_marcadas_pre_add.clear()
        self.update_auto_fields()

    def adicionar_habilidade_manual(self):
        codigo = self.codigo_manual_var.get().strip().upper()
        if not codigo: return
        self.cursor.execute("SELECT 1 FROM habilidades WHERE codigo = ?", (codigo,))
        if not self.cursor.fetchone():
            messagebox.showwarning("Aviso", "Código não encontrado no banco.")
            return
        habilidades_atuais = list(self.lista_habilidades.get(0, tk.END))
        if codigo not in habilidades_atuais:
            self.lista_habilidades.insert(tk.END, codigo)
            try:
                self.resultado_text.tag_configure(f"codigo_{codigo}", background=self.colors["hover_green"])
            except tk.TclError:
                pass
            if codigo in self.habilidades_marcadas_pre_add:
                self.habilidades_marcadas_pre_add.remove(codigo)
            self.update_auto_fields()
        self.codigo_manual_var.set('')

    def buscar(self):
        """Busca textual normal; se não encontrar nada, tenta busca semântica automaticamente."""
        self.resultado_text.configure(state='normal')
        self.resultado_text.delete(1.0, tk.END)
        self.habilidades_marcadas_pre_add.clear()

        query = "SELECT codigo, etapa, ano, componente, unidade_tematica, objeto_conhecimento, habilidade FROM habilidades WHERE 1=1"
        params = []

        etapa = self.etapa_var.get()
        if etapa and etapa != 'Todas':
            query += " AND etapa = ?"
            params.append(etapa)

        ano = self.ano_var.get()
        if ano and ano != 'Todos':
            query += " AND ano = ?"
            params.append(int(ano))

        componente = self.componente_var.get()
        if componente and componente != 'Todos':
            query += " AND componente = ?"
            params.append(componente)

        busca = self.busca_entry.get().strip()
        if busca:
            busca_lower = f"%{busca.lower()}%"
            condicoes = [
                "LOWER(habilidade) LIKE ?",
                "LOWER(objeto_conhecimento) LIKE ?",
                "LOWER(unidade_tematica) LIKE ?",
                "LOWER(codigo) LIKE ?"
            ]
            params.extend([busca_lower] * 4)
            if self.topicos_disponiveis:
                condicoes.append("EXISTS (SELECT 1 FROM topicos_habilidades t WHERE t.codigo = habilidades.codigo AND LOWER(t.topico) LIKE ?)")
                params.append(busca_lower)
            query += " AND (" + " OR ".join(condicoes) + ")"

        query += " ORDER BY etapa, ano, componente, codigo"

        try:
            self.cursor.execute(query, params)
            resultados = self.cursor.fetchall()
            if not resultados:
                # Tenta busca semântica como fallback
                self._executar_busca_semantica(busca, "Nenhum resultado textual encontrado. Buscando por similaridade semântica...")
            else:
                self._exibir_resultados(resultados)
        except sqlite3.Error as e:
            messagebox.showerror("Erro na consulta", str(e))

    def busca_semantica(self):
        """Chamada pelo botão 'Busca Inteligente' (força a busca semântica)."""
        busca = self.busca_entry.get().strip()
        if not busca:
            messagebox.showinfo("Aviso", "Digite um termo para a busca inteligente.")
            return
        self._executar_busca_semantica(busca, "Resultados da busca inteligente (similaridade semântica):")

    def _executar_busca_semantica(self, termo, mensagem_cabecalho):
        if not self.buscador_semantico or self.buscador_semantico.modelo is None:
            messagebox.showwarning("Aviso", "Busca semântica não disponível (modelo não carregado).")
            return
        self.resultado_text.configure(state='normal')
        self.resultado_text.delete(1.0, tk.END)
        self.habilidades_marcadas_pre_add.clear()
        self.resultado_label.config(text="Buscando similaridades...")

        def _processar():
            # extrai os filtros atuais
            ano = self.ano_var.get()
            if ano and ano != 'Todos':
                ano = int(ano)
            else:
                ano = None
            comp = self.componente_var.get()
            if comp == 'Todos':
                comp = None
            # sugestoes agora é uma lista de (codigo, score, tags)
            sugestoes = self.buscador_semantico.buscar(termo, filtro_ano=ano, filtro_componente=comp, top_n=5)
            self.root.after(0, lambda: self._exibir_resultados_semanticos(sugestoes, mensagem_cabecalho))

        threading.Thread(target=_processar, daemon=True).start()

    def _exibir_resultados_semanticos(self, sugestoes, mensagem_cabecalho):
        self.resultado_text.configure(state='normal')
        self.resultado_text.delete(1.0, tk.END)
        if not sugestoes:
            self.resultado_label.config(text="0 habilidades encontradas (busca semântica)")
            self.resultado_text.insert(tk.END, "\nNenhuma habilidade relevante encontrada pela IA.\n", 'habilidade')
            self.resultado_text.configure(state='disabled')
            return

        self.resultado_text.insert(tk.END, f"{mensagem_cabecalho}\n\n", 'componente')
        codigos_encontrados = [cod for cod, _, _ in sugestoes]
        placeholders = ','.join('?' * len(codigos_encontrados))
        query = f"SELECT codigo, etapa, ano, componente, unidade_tematica, objeto_conhecimento, habilidade FROM habilidades WHERE codigo IN ({placeholders})"
        self.cursor.execute(query, codigos_encontrados)
        resultados = self.cursor.fetchall()
        # Reordenar conforme a similaridade (já está ordenado, mas garantimos)
        mapa = {cod: score for cod, score, _ in sugestoes}
        resultados_ordenados = sorted(resultados, key=lambda r: mapa.get(r[0], 0), reverse=True)

        self._exibir_resultados(resultados_ordenados)

    def _exibir_resultados(self, resultados):
        self.resultado_label.config(text=f"{len(resultados)} habilidades encontradas")
        habilidades_ja_no_plano = list(self.lista_habilidades.get(0, tk.END))

        for i, row in enumerate(resultados):
            codigo, etapa, ano, componente, unidade, objeto, habilidade = row

            start_idx = self.resultado_text.index(tk.END)
            self.resultado_text.insert(tk.END, f"{codigo}", 'codigo')

            info_extra = []
            if etapa: info_extra.append(etapa)
            if ano: info_extra.append(f"{ano}º ano")
            if componente: info_extra.append(componente)
            self.resultado_text.insert(tk.END, f"  •  {' | '.join(info_extra)}\n", 'componente')

            if unidade: self.resultado_text.insert(tk.END, f"Unidade: {unidade}\n", 'tematica')
            if objeto: self.resultado_text.insert(tk.END, f"Objeto: {objeto}\n", 'tematica')
            self.resultado_text.insert(tk.END, f"{habilidade}\n", 'habilidade')
            end_idx = self.resultado_text.index(tk.END)

            tag_do_codigo = f"codigo_{codigo}"
            self.resultado_text.tag_add('clicavel', start_idx, end_idx)
            self.resultado_text.tag_add(tag_do_codigo, start_idx, end_idx)

            if codigo in habilidades_ja_no_plano:
                self.resultado_text.tag_configure(tag_do_codigo, background=self.colors["hover_green"])
            else:
                self.resultado_text.tag_configure(tag_do_codigo, background=self.colors["bg_card"])

            if i < len(resultados) - 1:
                self.resultado_text.insert(tk.END, "─" * 80 + "\n", 'separador')

        self.resultado_text.see(1.0)
        self.resultado_text.configure(state='disabled')

    def carregar_anos(self):
        self.cursor.execute("SELECT DISTINCT ano FROM habilidades WHERE ano IS NOT NULL ORDER BY ano")
        self.ano_combo['values'] = ['Todos'] + [str(row[0]) for row in self.cursor.fetchall()]
        self.ano_combo.current(0)

    def carregar_componentes(self):
        self.cursor.execute("SELECT DISTINCT componente FROM habilidades ORDER BY componente")
        self.componente_combo['values'] = ['Todos'] + [row[0] for row in self.cursor.fetchall()]
        self.componente_combo.current(0)

    def carregar_todos_codigos(self):
        self.cursor.execute("SELECT codigo FROM habilidades ORDER BY codigo")
        self.combo_manual['values'] = [row[0] for row in self.cursor.fetchall()]

    def on_etapa_change(self, event):
        etapa = self.etapa_var.get()
        if etapa == 'Todas':
            self.cursor.execute("SELECT DISTINCT ano FROM habilidades WHERE ano IS NOT NULL ORDER BY ano")
        else:
            self.cursor.execute("SELECT DISTINCT ano FROM habilidades WHERE etapa = ? AND ano IS NOT NULL ORDER BY ano", (etapa,))
        self.ano_combo['values'] = ['Todos'] + [str(row[0]) for row in self.cursor.fetchall()]
        self.ano_combo.current(0)

    def limpar_filtros(self):
        self.etapa_combo.current(2)
        self.ano_combo.current(0)
        self.componente_combo.current(0)
        self.busca_entry.delete(0, tk.END)
        self.resultado_text.configure(state='normal')
        self.resultado_text.delete(1.0, tk.END)
        self.habilidades_marcadas_pre_add.clear()
        self.resultado_label.config(text="0 habilidades encontradas")

    def remover_selecionadas(self):
        selecionadas = self.lista_habilidades.curselection()
        if not selecionadas: return
        for idx in reversed(selecionadas):
            codigo = self.lista_habilidades.get(idx)
            self.lista_habilidades.delete(idx)
            try:
                self.resultado_text.tag_configure(f"codigo_{codigo}", background=self.colors["bg_card"])
            except tk.TclError:
                pass
        self.update_auto_fields()

    def update_auto_fields(self):
        for txt in [self.txt_unidades, self.txt_objetos, self.txt_habilidades]:
            txt.delete('1.0', tk.END)
        codigos = list(self.lista_habilidades.get(0, tk.END))
        if not codigos: return
        placeholders = ','.join('?'*len(codigos))
        self.cursor.execute(f"SELECT codigo, unidade_tematica, objeto_conhecimento, habilidade FROM habilidades WHERE codigo IN ({placeholders})", codigos)
        rows = self.cursor.fetchall()
        unidades, objetos, habilidades = set(), set(), []
        for cod, un, obj, hab in rows:
            if un: unidades.add(un)
            if obj: objetos.add(obj)
            habilidades.append(f"{cod}: {hab}")
        if unidades: self.txt_unidades.insert('1.0', "\n".join(sorted(unidades)))
        if objetos: self.txt_objetos.insert('1.0', "\n".join(sorted(objetos)))
        if habilidades: self.txt_habilidades.insert('1.0', "\n\n".join(habilidades))

    def salvar_plano(self):
        codigos = list(self.lista_habilidades.get(0, tk.END))
        if not codigos:
            messagebox.showwarning("Aviso", "Adicione ao menos uma habilidade ao plano.")
            return
        titulo = simpledialog.askstring("Título do Plano", "Digite o nome ou tema da aula:")
        if not titulo: return
        campos_auto = json.dumps({
            "unidades": self.txt_unidades.get('1.0', 'end-1c'),
            "objetos": self.txt_objetos.get('1.0', 'end-1c'),
            "habilidades": self.txt_habilidades.get('1.0', 'end-1c')
        }, ensure_ascii=False)
        metodologia = self.txt_metodologia.get('1.0', 'end-1c')
        avaliacao = self.txt_avaliacao.get('1.0', 'end-1c')
        try:
            self.cursor.execute("""
                INSERT INTO planos_aula (titulo, habilidades_selecionadas, campos_auto, metodologia, avaliacao)
                VALUES (?, ?, ?, ?, ?)
            """, (titulo, json.dumps(codigos), campos_auto, metodologia, avaliacao))
            self.conn.commit()
            messagebox.showinfo("Sucesso", f"Plano '{titulo}' salvo com sucesso!")
            for txt in [self.txt_unidades, self.txt_objetos, self.txt_habilidades, self.txt_metodologia, self.txt_avaliacao]:
                txt.delete('1.0', tk.END)
            for codigo in codigos:
                try: self.resultado_text.tag_configure(f"codigo_{codigo}", background=self.colors["bg_card"])
                except tk.TclError: pass
            self.lista_habilidades.delete(0, tk.END)
            self.habilidades_marcadas_pre_add.clear()
        except sqlite3.Error as e:
            messagebox.showerror("Erro", str(e))

    def __del__(self):
        if hasattr(self, 'conn'):
            self.conn.close()


def main():
    root = tk.Tk()
    app = BNCCApp(root)
    root.mainloop()

if __name__ == "__main__":
    main()