-- Criação da tabela de palavras-chave
CREATE TABLE IF NOT EXISTS topicos_habilidades (
    topico TEXT NOT NULL,
    codigo TEXT NOT NULL,
    PRIMARY KEY (topico, codigo),
    FOREIGN KEY (codigo) REFERENCES habilidades(codigo)
);

-- ============================================================
-- ASSOCIAÇÕES DE TÓPICOS PARA CADA HABILIDADE
-- (inclui o próprio objeto_conhecimento e termos amplos/sinônimos)
-- ============================================================

-- 1º ao 5º ano - Todos os campos
INSERT INTO topicos_habilidades (topico, codigo) VALUES
('Função social do texto', 'EF15LP01'),
('Leitura e produção de texto', 'EF15LP01'),
('Reconstrução das condições de produção', 'EF15LP01'),
('Estratégias de leitura', 'EF15LP02'),
('Antecipação de sentidos', 'EF15LP02'),
('Inferência', 'EF15LP02'),
('Localização de informações explícitas', 'EF15LP03'),
('Leitura de textos multissemióticos', 'EF15LP04'),
('Recursos gráfico-visuais', 'EF15LP04'),
('Planejamento de texto', 'EF15LP05'),
('Revisão de texto', 'EF15LP06'),
('Edição de texto', 'EF15LP07'),
('Tecnologia digital', 'EF15LP08'),
('Software de edição', 'EF15LP08'),
('Oralidade', 'EF15LP09'),
('Expressão oral', 'EF15LP09'),
('Escuta atenta', 'EF15LP10'),
('Conversação espontânea', 'EF15LP11'),
('Turnos de fala', 'EF15LP11'),
('Aspectos paralinguísticos', 'EF15LP12'),
('Comunicação não verbal', 'EF15LP12'),
('Finalidade da interação oral', 'EF15LP13');

-- 1º ao 5º ano - Campo da vida cotidiana
INSERT INTO topicos_habilidades (topico, codigo) VALUES
('História em quadrinhos', 'EF15LP14'),
('Tirinhas', 'EF15LP14'),
('Leitura de imagens', 'EF15LP14'),
('Narrativas visuais', 'EF15LP14');

-- 1º ao 5º ano - Campo artístico-literário
INSERT INTO topicos_habilidades (topico, codigo) VALUES
('Leitura literária', 'EF15LP15'),
('Formação do leitor', 'EF15LP15'),
('Texto literário', 'EF15LP15'),
('Contos', 'EF15LP16'),
('Leitura colaborativa', 'EF15LP16'),
('Poema visual', 'EF15LP17'),
('Ilustração e texto', 'EF15LP18'),
('Reconto oral', 'EF15LP19'),
('Contação de histórias', 'EF15LP19');

-- 1º e 2º anos - Todos os campos
INSERT INTO topicos_habilidades (topico, codigo) VALUES
('Decodificação', 'EF12LP01'),
('Fluência de leitura', 'EF12LP01'),
('Leitura de palavras', 'EF12LP01'),
('Busca de textos', 'EF12LP02'),
('Leitura compartilhada', 'EF12LP02'),
('Cópia de texto', 'EF12LP03'),
('Construção do sistema alfabético', 'EF12LP03');

-- 1º ano - Todos os campos
INSERT INTO topicos_habilidades (topico, codigo) VALUES
('Protocolos de leitura', 'EF01LP01'),
('Direção da leitura', 'EF01LP01'),
('Correspondência fonema-grafema', 'EF01LP02'),
('Escrita alfabética', 'EF01LP02'),
('Comparação de escritas', 'EF01LP03'),
('Alfabeto', 'EF01LP04'),
('Sinais gráficos', 'EF01LP04'),
('Sistema de escrita alfabética', 'EF01LP05'),
('Segmentação de sílabas', 'EF01LP06'),
('Consciência fonológica', 'EF01LP07'),
('Fonemas e letras', 'EF01LP07'),
('Relação som-escrita', 'EF01LP08'),
('Semelhanças sonoras', 'EF01LP09'),
('Nome das letras', 'EF01LP10'),
('Ordem alfabética', 'EF01LP10'),
('Letras imprensa e cursiva', 'EF01LP11'),
('Maiúsculas e minúsculas', 'EF01LP11'),
('Segmentação de palavras', 'EF01LP12'),
('Espaçamento entre palavras', 'EF01LP12'),
('Sílabas mediais e finais', 'EF01LP13'),
('Pontuação inicial', 'EF01LP14'),
('Ponto final, interrogação, exclamação', 'EF01LP14'),
('Sinônimos e antônimos', 'EF01LP15'),
('Sinonímia e antonímia', 'EF01LP15');

-- 2º ano - Todos os campos
INSERT INTO topicos_habilidades (topico, codigo) VALUES
('Grafia correta', 'EF02LP01'),
('Maiúsculas em início de frase', 'EF02LP01'),
('Segmentação de palavras em sílabas', 'EF02LP02'),
('Criação de palavras', 'EF02LP02'),
('Correspondências regulares diretas', 'EF02LP03'),
('Correspondências regulares contextuais', 'EF02LP03'),
('Estrutura silábica', 'EF02LP04'),
('Sílaba simples e complexa', 'EF02LP04'),
('Nasalidade', 'EF02LP05'),
('Til, m, n', 'EF02LP05'),
('Princípio acrofónico', 'EF02LP06'),
('Cursiva e imprensa', 'EF02LP07'),
('Segmentação de frases', 'EF02LP08'),
('Uso de pontuação', 'EF02LP09'),
('Sinônimos e antônimos com prefixo', 'EF02LP10'),
('Aumentativo e diminutivo', 'EF02LP11'),
('Sufixos -ão, -inho/-zinho', 'EF02LP11');

-- 1º e 2º anos - Campo da vida cotidiana
INSERT INTO topicos_habilidades (topico, codigo) VALUES
('Gêneros da vida cotidiana', 'EF12LP04'),
('Listas, agendas, convites', 'EF12LP04'),
('Planejamento de texto coletivo', 'EF12LP05'),
('Produção de texto compartilhada', 'EF12LP06'),
('Recados e avisos', 'EF12LP06');

-- 1º ano - Campo da vida cotidiana
INSERT INTO topicos_habilidades (topico, codigo) VALUES
('Quadrinhas, parlendas', 'EF01LP16'),
('Trava-línguas', 'EF01LP16'),
('Produção compartilhada de listas', 'EF01LP17'),
('Registro de cantigas', 'EF01LP18'),
('Recitar parlendas', 'EF01LP19'),
('Entoação adequada', 'EF01LP19'),
('Diagramação de gêneros', 'EF01LP20'),
('Formatação de texto', 'EF01LP20');

-- 2º ano - Campo da vida cotidiana
INSERT INTO topicos_habilidades (topico, codigo) VALUES
('Cantigas e canções', 'EF02LP12'),
('Bilhetes e cartas', 'EF02LP13'),
('Relato pessoal', 'EF02LP14'),
('Canção e ritmo', 'EF02LP15'),
('Formatação de bilhetes, cartas', 'EF02LP16'),
('Sequência temporal em relatos', 'EF02LP17');

-- 1º e 2º anos - Campo da vida pública
INSERT INTO topicos_habilidades (topico, codigo) VALUES
('Rimas e aliterações', 'EF12LP07'),
('Ritmo e melodia', 'EF12LP07'),
('Notícias para crianças', 'EF12LP08'),
('Fotolegendas', 'EF12LP08'),
('Anúncios publicitários', 'EF12LP09'),
('Campanhas de conscientização', 'EF12LP09'),
('Cartazes e regras', 'EF12LP10'),
('Escrita compartilhada de notícias', 'EF12LP11'),
('Produção de slogans', 'EF12LP12'),
('Planejamento de campanha oral', 'EF12LP13'),
('Formatação de gêneros jornalísticos', 'EF12LP14'),
('Composição de slogans', 'EF12LP15'),
('Formatação de anúncios', 'EF12LP16');

-- 1º ano - Campo da vida pública
INSERT INTO topicos_habilidades (topico, codigo) VALUES
('Escrita de regras e regulamentos', 'EF01LP21');

-- 2º ano - Campo da vida pública
INSERT INTO topicos_habilidades (topico, codigo) VALUES
('Cartazes e folhetos', 'EF02LP18'),
('Linguagem persuasiva', 'EF02LP18'),
('Notícias curtas para jornal falado', 'EF02LP19');

-- 1º e 2º anos - Campo das práticas de estudo e pesquisa
INSERT INTO topicos_habilidades (topico, codigo) VALUES
('Leitura de enunciados', 'EF12LP17'),
('Diagramas e entrevistas', 'EF12LP17');

-- 2º ano - Campo das práticas de estudo e pesquisa
INSERT INTO topicos_habilidades (topico, codigo) VALUES
('Função de textos de pesquisa', 'EF02LP20'),
('Pesquisa em ambientes digitais', 'EF02LP21'),
('Produção de relatos de experimentos', 'EF02LP22'),
('Registro de observação', 'EF02LP23'),
('Apresentação oral de experimentos', 'EF02LP24'),
('Formatação de entrevistas e verbetes', 'EF02LP25');

-- 1º ano - Campo das práticas de estudo e pesquisa
INSERT INTO topicos_habilidades (topico, codigo) VALUES
('Produção de diagramas e curiosidades', 'EF01LP22'),
('Planejamento de entrevista oral', 'EF01LP23'),
('Formatação de enunciados e diagramas', 'EF01LP24');

-- 1º e 2º anos - Campo artístico-literário
INSERT INTO topicos_habilidades (topico, codigo) VALUES
('Apreciação de poemas', 'EF12LP18'),
('Rimas e sonoridades', 'EF12LP18'),
('Reconhecimento de rimas', 'EF12LP19'),
('Comparações e sensações', 'EF12LP19');

-- 1º ano - Campo artístico-literário
INSERT INTO topicos_habilidades (topico, codigo) VALUES
('Recontagem de histórias', 'EF01LP25'),
('Elementos da narrativa', 'EF01LP26'),
('Personagens, enredo, tempo, espaço', 'EF01LP26');

-- 2º ano - Campo artístico-literário
INSERT INTO topicos_habilidades (topico, codigo) VALUES
('Leitura autônoma de textos literários', 'EF02LP26'),
('Reescrita de narrativas', 'EF02LP27'),
('Conflito gerador', 'EF02LP28'),
('Resolução de narrativa', 'EF02LP28'),
('Poema visual: formato e ilustração', 'EF02LP29');

-- ============================================================
-- 3º AO 5º ANO – TODOS OS CAMPOS E CAMPOS ESPECÍFICOS
-- ============================================================

-- 3º ao 5º - Todos os campos
INSERT INTO topicos_habilidades (topico, codigo) VALUES
('Fluência de leitura', 'EF35LP01'),
('Seleção de livros', 'EF35LP02'),
('Ideia central do texto', 'EF35LP03'),
('Inferência de informações', 'EF35LP04'),
('Inferir palavras pelo contexto', 'EF35LP05'),
('Relações entre partes do texto', 'EF35LP06'),
('Substituições lexicais e pronominais', 'EF35LP06'),
('Coesão referencial', 'EF35LP06'),
('Pontuação e ortografia na produção', 'EF35LP07'),
('Recursos de referenciação', 'EF35LP08'),
('Coesão pronominal', 'EF35LP08'),
('Paragrafação', 'EF35LP09'),
('Gêneros do discurso oral', 'EF35LP10'),
('Variação linguística', 'EF35LP11'),
('Preconceito linguístico', 'EF35LP11'),
('Uso do dicionário', 'EF35LP12'),
('Grafia irregular', 'EF35LP13'),
('Palavras com h inicial', 'EF35LP13'),
('Pronomes pessoais, possessivos, demonstrativos', 'EF35LP14'),
('Opinar e defender ponto de vista', 'EF35LP15'),
('Texto argumentativo inicial', 'EF35LP15');

-- 3º ao 5º - Campo da vida pública
INSERT INTO topicos_habilidades (topico, codigo) VALUES
('Formatação de notícias e cartas', 'EF35LP16');

-- 3º ao 5º - Campo das práticas de estudo e pesquisa
INSERT INTO topicos_habilidades (topico, codigo) VALUES
('Pesquisa escolar', 'EF35LP17'),
('Escuta de apresentações', 'EF35LP18'),
('Recuperar ideias principais', 'EF35LP19'),
('Exposição oral com recursos', 'EF35LP20');

-- 3º ao 5º - Campo artístico-literário
INSERT INTO topicos_habilidades (topico, codigo) VALUES
('Leitura literária autônoma', 'EF35LP21'),
('Diálogos em textos narrativos', 'EF35LP22'),
('Discurso direto e variedades', 'EF35LP22'),
('Apreciação de poemas', 'EF35LP23'),
('Rimas, aliterações, estrofes', 'EF35LP23'),
('Texto dramático', 'EF35LP24'),
('Marcadores de cena', 'EF35LP24'),
('Produção de narrativas ficcionais', 'EF35LP25'),
('Leitura de narrativas', 'EF35LP26'),
('Elementos da narrativa', 'EF35LP26'),
('Textos em versos', 'EF35LP27'),
('Declamação de poemas', 'EF35LP28'),
('Conflito e resolução em narrativas', 'EF35LP29'),
('Foco narrativo', 'EF35LP29'),
('Discurso direto e indireto', 'EF35LP30'),
('Figuras de linguagem em poemas', 'EF35LP31'),
('Metáfora', 'EF35LP31');

-- 3º ano - Todos os campos
INSERT INTO topicos_habilidades (topico, codigo) VALUES
('Correspondências regulares contextuais', 'EF03LP01'),
('c/qu; g/qu; r/rr; s/ss', 'EF03LP01'),
('Sílaba átona final', 'EF03LP01'),
('Dígrafos lh, nh, ch', 'EF03LP03'),
('Acento gráfico em monossílabos', 'EF03LP04'),
('Classificação de sílabas', 'EF03LP05'),
('Sílaba tônica', 'EF03LP06'),
('Classificação por tonicidade', 'EF03LP06'),
('Pontuação: ponto, interrogação, exclamação', 'EF03LP07'),
('Dois-pontos e travessão', 'EF03LP07'),
('Substantivos e verbos', 'EF03LP08'),
('Funções na oração', 'EF03LP08'),
('Adjetivos', 'EF03LP09'),
('Prefixos e sufixos', 'EF03LP10'),
('Formação de palavras', 'EF03LP10');

-- 3º ano - Campo da vida cotidiana
INSERT INTO topicos_habilidades (topico, codigo) VALUES
('Texto injuntivo', 'EF03LP11'),
('Receitas e instruções', 'EF03LP11'),
('Cartas pessoais e diários', 'EF03LP12'),
('Produção de cartas e diários', 'EF03LP13'),
('Produção de textos injuntivos', 'EF03LP14'),
('Receita em vídeo', 'EF03LP15'),
('Formatação de receitas', 'EF03LP16'),
('Formatação de cartas e diários', 'EF03LP17');

-- 3º ano - Campo da vida pública
INSERT INTO topicos_habilidades (topico, codigo) VALUES
('Cartas de leitor e reclamação', 'EF03LP18'),
('Recursos de persuasão', 'EF03LP19'),
('Propaganda infantil', 'EF03LP19'),
('Produção de cartas de leitor', 'EF03LP20'),
('Produção de anúncios', 'EF03LP21'),
('Telejornal infantil', 'EF03LP22'),
('Adjetivos em cartas de reclamação', 'EF03LP23');

-- 3º ano - Campo das práticas de estudo e pesquisa
INSERT INTO topicos_habilidades (topico, codigo) VALUES
('Relatos de observação', 'EF03LP24'),
('Produção de relatórios', 'EF03LP25'),
('Formatação de relatórios', 'EF03LP26');

-- 3º ano - Campo artístico-literário
INSERT INTO topicos_habilidades (topico, codigo) VALUES
('Cordel e repente', 'EF03LP27');

-- 4º ano - Todos os campos
INSERT INTO topicos_habilidades (topico, codigo) VALUES
('Ortografia: regras diretas e contextuais', 'EF04LP01'),
('Ditongos ai, ei, ou', 'EF04LP02'),
('Localização no dicionário', 'EF04LP03'),
('Acento em paroxítonas', 'EF04LP04'),
('Pontuação: vírgula, dois-pontos, travessão', 'EF04LP05'),
('Vocativo e aposto', 'EF04LP05'),
('Concordância verbal', 'EF04LP06'),
('Concordância nominal', 'EF04LP07'),
('Sufixos -agem, -oso, -eza, -izar', 'EF04LP08');

-- 4º ano - Campo da vida cotidiana
INSERT INTO topicos_habilidades (topico, codigo) VALUES
('Boletos e faturas', 'EF04LP09'),
('Cartas de reclamação', 'EF04LP10'),
('Produção de cartas de reclamação', 'EF04LP11'),
('Tutoriais em vídeo', 'EF04LP12'),
('Formatação de instruções de jogos', 'EF04LP13');

-- 4º ano - Campo da vida pública
INSERT INTO topicos_habilidades (topico, codigo) VALUES
('Fatos em notícias', 'EF04LP14'),
('Distinção fato/opinião', 'EF04LP15'),
('Produção de notícias', 'EF04LP16'),
('Jornal radiofônico/televisivo', 'EF04LP17'),
('Entonação de âncoras', 'EF04LP18');

-- 4º ano - Campo das práticas de estudo e pesquisa
INSERT INTO topicos_habilidades (topico, codigo) VALUES
('Textos de divulgação científica', 'EF04LP19'),
('Gráficos e tabelas', 'EF04LP20'),
('Função de gráficos', 'EF04LP20'),
('Produção de textos de pesquisa', 'EF04LP21'),
('Produção de verbetes', 'EF04LP22'),
('Formatação de verbetes', 'EF04LP23'),
('Formatação de tabelas e gráficos', 'EF04LP24');

-- 4º ano - Campo artístico-literário
INSERT INTO topicos_habilidades (topico, codigo) VALUES
('Representação cênica', 'EF04LP25'),
('Poema concreto', 'EF04LP26'),
('Diagramação de letras', 'EF04LP26'),
('Marcadores de texto dramático', 'EF04LP27');

-- 5º ano - Todos os campos
INSERT INTO topicos_habilidades (topico, codigo) VALUES
('Ortografia: regulares contextuais e morfológicas', 'EF05LP01'),
('Palavras com correspondências irregulares', 'EF05LP01'),
('Polissemia', 'EF05LP02'),
('Acentuação completa', 'EF05LP03'),
('Vírgula, ponto e vírgula, dois-pontos', 'EF05LP04'),
('Reticências, aspas, parênteses', 'EF05LP04'),
('Tempos verbais do indicativo', 'EF05LP05'),
('Presente, passado e futuro', 'EF05LP05'),
('Flexão verbal', 'EF05LP06'),
('Conjunções e relações de sentido', 'EF05LP07'),
('Adição, oposição, tempo, causa', 'EF05LP07'),
('Palavras primitivas, derivadas e compostas', 'EF05LP08'),
('Prefixos e sufixos', 'EF05LP08');

-- 5º ano - Campo da vida cotidiana
INSERT INTO topicos_habilidades (topico, codigo) VALUES
('Regras de jogo', 'EF05LP09'),
('Anedotas e cartuns', 'EF05LP10'),
('Produção de anedotas e cartuns', 'EF05LP11'),
('Produção de regras de jogo', 'EF05LP12'),
('Resenha em vlog', 'EF05LP13'),
('Formatação de resenha crítica', 'EF05LP14');

-- 5º ano - Campo da vida pública
INSERT INTO topicos_habilidades (topico, codigo) VALUES
('Notícias e reportagens', 'EF05LP15'),
('Comparar mídias', 'EF05LP16'),
('Roteiro para reportagem digital', 'EF05LP17'),
('Vlog argumentativo', 'EF05LP18'),
('Argumentação oral', 'EF05LP19'),
('Análise de argumentos', 'EF05LP20'),
('Padrão entonacional de vloggers', 'EF05LP21');

-- 5º ano - Campo das práticas de estudo e pesquisa
INSERT INTO topicos_habilidades (topico, codigo) VALUES
('Verbetes de dicionário', 'EF05LP22'),
('Comparar gráficos e tabelas', 'EF05LP23'),
('Produção de texto com pesquisa', 'EF05LP24'),
('Produção de verbetes de dicionário', 'EF05LP25'),
('Normas de concordância e citações', 'EF05LP26'),
('Coesão pronominal e articuladores', 'EF05LP27');

-- 5º ano - Campo artístico-literário
INSERT INTO topicos_habilidades (topico, codigo) VALUES
('Ciberpoemas', 'EF05LP28'),
('Recursos multissemióticos digitais', 'EF05LP28');

-- ============================================================
-- 6º AO 9º ANO – CAMPO JORNALÍSTICO-MIDIÁTICO
-- ============================================================
INSERT INTO topicos_habilidades (topico, codigo) VALUES
('Liberdade de expressão', 'EF69LP01'),
('Discurso de ódio', 'EF69LP01'),
('Peças publicitárias', 'EF69LP02'),
('Campanhas publicitárias', 'EF69LP02'),
('Análise de notícias, reportagens, entrevistas', 'EF69LP03'),
('Humor e crítica em tirinhas, memes, charges', 'EF69LP03'),
('Persuasão em textos publicitários', 'EF69LP04'),
('Consumo consciente', 'EF69LP04'),
('Efeitos de humor e ironia', 'EF69LP05'),
('Multissemiose', 'EF69LP05'),
('Produção de gêneros jornalísticos', 'EF69LP06'),
('Papéis sociais na Web', 'EF69LP06'),
('Planejamento de texto', 'EF69LP07'),
('Revisão e edição', 'EF69LP08'),
('Campanha publicitária', 'EF69LP09'),
('Produção de notícias para rádio/TV/podcast', 'EF69LP10'),
('Análise de posicionamentos', 'EF69LP11'),
('Debate e discussão', 'EF69LP11'),
('Planejamento de textos orais', 'EF69LP12'),
('Elementos cinésicos e paralinguísticos', 'EF69LP12'),
('Busca de conclusões comuns', 'EF69LP13'),
('Formulação de perguntas', 'EF69LP14'),
('Contra-argumentos', 'EF69LP15'),
('Composição de gêneros jornalísticos', 'EF69LP16'),
('Pirâmide invertida', 'EF69LP16'),
('Recursos estilísticos e semióticos', 'EF69LP17'),
('Tratamento da informação', 'EF69LP17'),
('Operadores de conexão em argumentação', 'EF69LP18'),
('Efeitos de sentido em orais argumentativos', 'EF69LP19');

-- ============================================================
-- CAMPO DE ATUAÇÃO NA VIDA PÚBLICA – 6º AO 9º ANO
-- ============================================================
INSERT INTO topicos_habilidades (topico, codigo) VALUES
('Textos normativos e legais', 'EF69LP20'),
('Hierarquia de artigos', 'EF69LP20'),
('Participação social', 'EF69LP21'),
('Produção de textos reivindicatórios', 'EF69LP22'),
('Textos normativos escolares', 'EF69LP23'),
('Discussão de casos legais', 'EF69LP24'),
('Código de Defesa do Consumidor', 'EF69LP24'),
('ECA', 'EF69LP24'),
('Posicionamento em discussões', 'EF69LP25'),
('Tomar nota em debates', 'EF69LP26'),
('Forma composicional de textos políticos', 'EF69LP27'),
('Modalização deôntica e apreciativa', 'EF69LP28'),
('Modalizadores', 'EF69LP28');

-- ============================================================
-- CAMPO DAS PRÁTICAS DE ESTUDO E PESQUISA – 6º AO 9º ANO
-- ============================================================
INSERT INTO topicos_habilidades (topico, codigo) VALUES
('Gêneros de divulgação científica', 'EF69LP29'),
('Comparação de fontes', 'EF69LP30'),
('Hierarquização de proposições', 'EF69LP31'),
('Seleção de dados', 'EF69LP32'),
('Relação verbal com infográficos', 'EF69LP33'),
('Estratégias de estudo', 'EF69LP34'),
('Resumo e resenha', 'EF69LP34'),
('Produção de texto de divulgação científica', 'EF69LP35'),
('Revisão e edição de textos científicos', 'EF69LP36'),
('Roteiros para vídeos científicos', 'EF69LP37'),
('Planejamento de apresentações orais', 'EF69LP38'),
('Planejamento de entrevista', 'EF69LP39'),
('Construção composicional de seminários', 'EF69LP40'),
('Ferramentas de apoio a apresentações', 'EF69LP41'),
('Estrutura de textos de divulgação', 'EF69LP42'),
('Citações e paráfrases', 'EF69LP43'),
('Intertextualidade científica', 'EF69LP43');

-- ============================================================
-- CAMPO ARTÍSTICO-LITERÁRIO – 6º AO 9º ANO
-- ============================================================
INSERT INTO topicos_habilidades (topico, codigo) VALUES
('Valores em textos literários', 'EF69LP44'),
('Resenha crítica e sinopse', 'EF69LP45'),
('Práticas de compartilhamento literário', 'EF69LP46'),
('Club de leitura', 'EF69LP46'),
('Análise de narrativas ficcionais', 'EF69LP47'),
('Foco narrativo', 'EF69LP47'),
('Recursos expressivos em poemas', 'EF69LP48'),
('Figuras de linguagem', 'EF69LP48'),
('Interesse por leitura desafiadora', 'EF69LP49'),
('Adaptação de textos para teatro', 'EF69LP50'),
('Engajamento em produção literária', 'EF69LP51'),
('Representação de cenas', 'EF69LP52'),
('Leitura em voz alta', 'EF69LP53'),
('Recursos paralinguísticos e cinésicos', 'EF69LP54'),
('Variação linguística na literatura', 'EF69LP54');

-- ============================================================
-- TODOS OS CAMPOS – 6º E 7º ANOS (habilidades compostas)
-- ============================================================
INSERT INTO topicos_habilidades (topico, codigo) VALUES
('Variação linguística, norma-padrão', 'EF69LP55'),
('Preconceito linguístico', 'EF69LP55'),
('Uso consciente da norma-padrão', 'EF69LP56');

-- ============================================================
-- 6º E 7º ANOS – CAMPO JORNALÍSTICO-MIDIÁTICO (específicas)
-- ============================================================
INSERT INTO topicos_habilidades (topico, codigo) VALUES
('Parcialidade e imparcialidade', 'EF06LP01'),
('Centralidade da notícia', 'EF06LP02'),
('Propostas editoriais', 'EF07LP01'),
('Comparação de notícias', 'EF07LP02'),
('Hipertexto', 'EF67LP01'),
('Espaço do leitor', 'EF67LP02'),
('Confiabilidade de fontes', 'EF67LP03'),
('Distinção fato/opinião', 'EF67LP04'),
('Tese e argumentos', 'EF67LP05'),
('Seleção lexical e hierarquização', 'EF67LP06'),
('Recursos persuasivos', 'EF67LP07'),
('Imagens em notícias', 'EF67LP08'),
('Planejamento de notícia', 'EF67LP09'),
('Produção de notícia impressa e digital', 'EF67LP10'),
('Planejamento de resenhas e vlogs', 'EF67LP11'),
('Produção de resenha crítica', 'EF67LP12'),
('Produção de texto publicitário', 'EF67LP13'),
('Planejamento de entrevista oral', 'EF67LP14');

-- ============================================================
-- 6º E 7º ANOS – CAMPO DE ATUAÇÃO NA VIDA PÚBLICA
-- ============================================================
INSERT INTO topicos_habilidades (topico, codigo) VALUES
('Leitura de artigos legais', 'EF67LP15'),
('Código Nacional de Trânsito', 'EF67LP15'),
('Canais de reclamação', 'EF67LP16'),
('Carta de solicitação e reclamação', 'EF67LP17'),
('Pertinência da solicitação', 'EF67LP18'),
('Levantamento de problemas comunitários', 'EF67LP19');

-- ============================================================
-- 6º E 7º ANOS – CAMPO DAS PRÁTICAS DE ESTUDO E PESQUISA
-- ============================================================
INSERT INTO topicos_habilidades (topico, codigo) VALUES
('Pesquisa com recorte definido', 'EF67LP20'),
('Divulgação de pesquisas', 'EF67LP21'),
('Produção de resumos', 'EF67LP22'),
('Respeito aos turnos de fala', 'EF67LP23'),
('Conversação espontânea', 'EF67LP23'),
('Tomada de nota', 'EF67LP24'),
('Organização tópica', 'EF67LP25'),
('Hipertexto em divulgação científica', 'EF67LP26');

-- ============================================================
-- 6º E 7º ANOS – CAMPO ARTÍSTICO-LITERÁRIO
-- ============================================================
INSERT INTO topicos_habilidades (topico, codigo) VALUES
('Relação entre textos', 'EF67LP27'),
('Intertextualidade', 'EF67LP27'),
('Leitura autônoma de gêneros diversos', 'EF67LP28'),
('Contos, lendas, romances', 'EF67LP28'),
('Elementos do texto dramático', 'EF67LP29'),
('Produção de narrativas ficcionais', 'EF67LP30'),
('Produção de poemas', 'EF67LP31');

-- ============================================================
-- 6º E 7º ANOS – TODOS OS CAMPOS (gramática e coesão)
-- ============================================================
INSERT INTO topicos_habilidades (topico, codigo) VALUES
('Ortografia', 'EF67LP32'),
('Pontuação', 'EF67LP33'),
('Antônimos com prefixos', 'EF67LP34'),
('Palavras derivadas e compostas', 'EF67LP35'),
('Série sinonímica', 'EF06LP03'),
('Flexão de substantivos e adjetivos', 'EF06LP04'),
('Modos verbais e efeitos de sentido', 'EF06LP05'),
('Concordância nominal e verbal', 'EF06LP06'),
('Período composto por coordenação', 'EF06LP07'),
('Oração como unidade', 'EF06LP08'),
('Períodos simples e compostos', 'EF06LP09'),
('Sintagmas nominais e verbais', 'EF06LP10'),
('Uso de tempos verbais e concordância', 'EF06LP11'),
('Coesão referencial e sequencial', 'EF06LP12'),
('Formação de palavras por prefixos e sufixos', 'EF07LP03'),
('Verbo como núcleo da oração', 'EF07LP04'),
('Verbos transitivos e intransitivos', 'EF07LP05'),
('Transitividade verbal', 'EF07LP05'),
('Verbo transitivo direto e indireto', 'EF07LP05'),
('Predicação verbal', 'EF07LP05'),
('Concordância nominal e verbal (7º)', 'EF07LP06'),
('Estrutura básica da oração', 'EF07LP07'),
('Sujeito, predicado, objeto direto e indireto', 'EF07LP07'),
('Adjetivos e substantivos', 'EF07LP08'),
('Advérbios e locuções adverbiais', 'EF07LP09'),
('Produção textual com gramática', 'EF07LP10'),
('Período composto e conjunções adversativas', 'EF07LP11'),
('Coesão por substituição lexical/pronominal', 'EF07LP12'),
('Relações de coesão', 'EF07LP13'),
('Modalização e argumentatividade', 'EF07LP14'),
('Coesão referencial e sequencial (produção)', 'EF67LP36'),
('Sequências textuais', 'EF67LP37'),
('Figuras de linguagem: comparação, metáfora, etc.', 'EF67LP38');

-- ============================================================
-- 8º E 9º ANOS – CAMPO JORNALÍSTICO-MIDIÁTICO
-- ============================================================
INSERT INTO topicos_habilidades (topico, codigo) VALUES
('Interesses do campo jornalístico', 'EF89LP01'),
('Cultura digital', 'EF89LP02'),
('Meme, gif, comentário', 'EF89LP02'),
('Posicionamento crítico', 'EF89LP03'),
('Artigo de opinião', 'EF89LP03'),
('Teses e argumentos implícitos', 'EF89LP04'),
('Apropriação textual', 'EF89LP05'),
('Recursos persuasivos avançados', 'EF89LP06'),
('Análise de imagens em movimento', 'EF89LP07'),
('Planejamento de reportagem', 'EF89LP08'),
('Produção de reportagem impressa e digital', 'EF89LP09'),
('Planejamento de artigo de opinião', 'EF89LP10'),
('Produção de campanha publicitária', 'EF89LP11'),
('Debate regrado', 'EF89LP12'),
('Planejamento de debate', 'EF89LP12'),
('Entrevista oral com edição', 'EF89LP13'),
('Análise de movimentos argumentativos', 'EF89LP14'),
('Operadores argumentativos', 'EF89LP15'),
('Modalização em textos noticiosos', 'EF89LP16');

-- ============================================================
-- 8º E 9º ANOS – CAMPO DE ATUAÇÃO NA VIDA PÚBLICA
-- ============================================================
INSERT INTO topicos_habilidades (topico, codigo) VALUES
('Declaração dos Direitos Humanos', 'EF89LP17'),
('Constituição Federal', 'EF89LP17'),
('Canais de participação digital', 'EF89LP18'),
('Carta aberta e abaixo-assinado', 'EF89LP19'),
('Petição on-line', 'EF89LP19'),
('Comparação de propostas políticas', 'EF89LP20'),
('Pesquisa de opinião e enquetes', 'EF89LP21'),
('Negociação em discussões', 'EF89LP22'),
('Força dos argumentos', 'EF89LP23');

-- ============================================================
-- 8º E 9º ANOS – CAMPO DAS PRÁTICAS DE ESTUDO E PESQUISA
-- ============================================================
INSERT INTO topicos_habilidades (topico, codigo) VALUES
('Pesquisa com fontes confiáveis', 'EF89LP24'),
('Divulgação de pesquisa em vídeos/vlogs', 'EF89LP25'),
('Produção de resenhas com vozes', 'EF89LP26'),
('Participação oral qualificada', 'EF89LP27'),
('Tomar nota de videoaulas', 'EF89LP28'),
('Progressão temática', 'EF89LP29'),
('Retomadas anafóricas', 'EF89LP29'),
('Hipertexto e hiperlinks', 'EF89LP30'),
('Modalização epistêmica', 'EF89LP31');

-- ============================================================
-- 8º E 9º ANOS – CAMPO ARTÍSTICO-LITERÁRIO
-- ============================================================
INSERT INTO topicos_habilidades (topico, codigo) VALUES
('Intertextualidade artística', 'EF89LP32'),
('Paródia, paráfrase, pastiche', 'EF89LP32'),
('Leitura autônoma de gêneros contemporâneos', 'EF89LP33'),
('Miniconto, ficção científica', 'EF89LP33'),
('Texto dramático em outras mídias', 'EF89LP34'),
('Produção de contos e crônicas', 'EF89LP35'),
('Paródia de poemas', 'EF89LP36'),
('Ciberpoema e haicai', 'EF89LP36');

-- ============================================================
-- 8º E 9º ANOS – TODOS OS CAMPOS (gramática)
-- ============================================================
INSERT INTO topicos_habilidades (topico, codigo) VALUES
('Figuras de linguagem avançadas', 'EF89LP37'),
('Ironia, eufemismo, antítese', 'EF89LP37'),
('Editorias de jornais', 'EF08LP01'),
('Checagem de fatos', 'EF08LP02'),
('Produção de artigo de opinião', 'EF08LP03'),
('Ortografia e regências na produção', 'EF08LP04'),
('Formação de palavras por composição', 'EF08LP05'),
('Termos constitutivos da oração', 'EF08LP06'),
('Sujeito e complementos', 'EF08LP06'),
('Complemento direto e indireto', 'EF08LP07'),
('Transitividade verbal - complementos', 'EF08LP07'),
('Voz ativa e passiva', 'EF08LP08'),
('Agente da passiva', 'EF08LP08'),
('Adjuntos adnominais', 'EF08LP09'),
('Modificadores do substantivo', 'EF08LP09'),
('Advérbios e adjuntos adverbiais', 'EF08LP10'),
('Coordenação e subordinação', 'EF08LP11'),
('Orações subordinadas', 'EF08LP12'),
('Conjunções e coesão', 'EF08LP13'),
('Coesão sequencial', 'EF08LP13'),
('Produção textual com coesão e discurso', 'EF08LP14'),
('Pronome relativo e referência', 'EF08LP15'),
('Modalizadores e argumentatividade', 'EF08LP16'),
('Fake news e checagem', 'EF09LP01'),
('Cobertura da imprensa', 'EF09LP02'),
('Artigo de opinião com tipos de argumentos', 'EF09LP03'),
('Sintaxe complexa', 'EF09LP04'),
('Verbo de ligação e predicativo', 'EF09LP05'),
('Verbos de ligação: ser, estar, ficar', 'EF09LP06'),
('Regência verbal e nominal', 'EF09LP07'),
('Conjunções coordenativas e subordinativas', 'EF09LP08'),
('Orações adjetivas restritivas e explicativas', 'EF09LP09'),
('Colocação pronominal', 'EF09LP10'),
('Coesão sequencial avançada', 'EF09LP11'),
('Estrangeirismos', 'EF09LP12');

-- ============================================================
-- ENSINO MÉDIO – TODOS OS CAMPOS / CAMPOS ESPECÍFICOS
-- ============================================================
INSERT INTO topicos_habilidades (topico, codigo) VALUES
('Condições de produção do texto', 'EM13LP01'),
('Relações entre partes do texto', 'EM13LP02'),
('Intertextualidade e interdiscursividade', 'EM13LP03'),
('Citações e paráfrases', 'EM13LP04'),
('Análise de argumentação', 'EM13LP05'),
('Efeitos de sentido', 'EM13LP06'),
('Modalização', 'EM13LP07'),
('Sintaxe do português', 'EM13LP08'),
('Gramática tradicional e de uso', 'EM13LP09'),
('Variação linguística aprofundada', 'EM13LP10'),
('Curadoria de informação', 'EM13LP11'),
('Seleção de fontes confiáveis', 'EM13LP12'),
('Elementos sonoros', 'EM13LP13'),
('Análise de imagens e performances', 'EM13LP14'),
('Produção de textos escritos e multissemióticos', 'EM13LP15'),
('Análise e produção de textos orais', 'EM13LP16'),
('Roteiros para vídeos e mídias', 'EM17LP17'),
('Softwares de edição', 'EM13LP18'),
('Textos de apresentação pessoal', 'EM13LP19'),
('Compartilhamento cultural', 'EM13LP20'),
('Playlists comentadas', 'EM13LP21'),
('Registros de profissões', 'EM13LP22'),
('Análise de discursos políticos', 'EM13LP23'),
('Participação social não institucional', 'EM13LP24'),
('Participação em reuniões e debates', 'EM13LP25'),
('Textos legais e direitos', 'EM13LP26'),
('Engajamento em problemas coletivos', 'EM13LP27'),
('Organização de estudos', 'EM13LP28'),
('Resumo e resenha acadêmica', 'EM13LP29'),
('Realização de pesquisas', 'EM13LP30'),
('Compreensão de textos científicos', 'EM13LP31'),
('Comparação de informações', 'EM13LP32'),
('Instrumentos de coleta de dados', 'EM13LP33'),
('Produção de textos de divulgação', 'EM13LP34'),
('Apresentações orais com ferramentas', 'EM13LP35'),
('Interesses do jornalismo', 'EM13LP36'),
('Projetos editoriais', 'EM13LP37'),
('Parcialidade e imparcialidade', 'EM13LP38'),
('Checagem de fatos', 'EM13LP39'),
('Fenômeno da pós-verdade', 'EM13LP40'),
('Curadoria e efeito bolha', 'EM13LP41'),
('Cobertura da mídia e curadoria', 'EM13LP42'),
('Produção ética em redes sociais', 'EM13LP43'),
('Publicidade contemporânea', 'EM13LP44'),
('Produção de gêneros jornalísticos e culturais', 'EM13LP45'),
('Compartilhamento de leituras literárias', 'EM13LP46'),
('Participação em eventos culturais', 'EM13LP47'),
('Literatura brasileira e cânone', 'EM13LP48'),
('Gêneros literários', 'EM13LP49'),
('Intertextualidade literária', 'EM13LP50'),
('Acervo pessoal', 'EM13LP51'),
('Análise de obras literárias', 'EM13LP52'),
('Resenhas culturais', 'EM13LP53'),
('Criação de obras autorais', 'EM13LP54');

-- ============================================================
-- 1. CRIAÇÃO DA TABELA (CASO NÃO EXISTA)
-- ============================================================
CREATE TABLE IF NOT EXISTS topicos_habilidades (
    topico TEXT NOT NULL,
    codigo TEXT NOT NULL,
    PRIMARY KEY (topico, codigo),
    FOREIGN KEY (codigo) REFERENCES habilidades(codigo)
);

-- ============================================================
-- 2. INSERÇÕES ADICIONAIS DE TÓPICOS E SINÔNIMOS 
-- (Usando OR IGNORE para evitar duplicações)
-- ============================================================

-- Alfabetização, Fonética e Fonologia (1º ao 5º ano)
INSERT OR IGNORE INTO topicos_habilidades (topico, codigo) VALUES
('Consciência fonêmica', 'EF01LP07'),
('Escrita espontânea', 'EF01LP02'),
('Ditado', 'EF01LP02'),
('Letra maiúscula e minúscula', 'EF01LP11'),
('Encontros consonantais', 'EF02LP04'),
('Substantivo próprio', 'EF02LP01'),
('Grau do substantivo', 'EF02LP11'),
('Uso do C e QU', 'EF03LP01'),
('Uso do G e GU', 'EF03LP01'),
('Uso do R e RR', 'EF03LP01'),
('Uso do S e SS', 'EF03LP01'),
('Encontros vocálicos', 'EF03LP02'),
('Hiato', 'EF03LP02'),
('Dígrafos consonantais', 'EF03LP03'),
('Acentuação de oxítonas', 'EF03LP04'),
('Acentuação de monossílabos', 'EF03LP04'),
('Monossílaba, dissílaba, trissílaba, polissílaba', 'EF03LP05'),
('Oxítonas, paroxítonas e proparoxítonas', 'EF03LP06'),
('Discurso direto e indireto', 'EF04LP05'),
('Enumeração', 'EF04LP05'),
('Modo indicativo', 'EF05LP05');

-- Morfologia e Classes de Palavras (6º ao 9º ano)
INSERT OR IGNORE INTO topicos_habilidades (topico, codigo) VALUES
('Grau do adjetivo', 'EF06LP04'),
('Modo imperativo', 'EF06LP04'),
('Modo subjuntivo', 'EF06LP04'),
('Tempos e modos verbais', 'EF06LP05'),
('Conjunções coordenativas', 'EF06LP07'),
('Orações coordenadas assindéticas', 'EF06LP07'),
('Verbos regulares e irregulares', 'EF06LP11'),
('Pronome relativo', 'EF09LP09'),
('Colocação pronominal', 'EF09LP10'),
('Próclise, ênclise e mesóclise', 'EF09LP10');

-- Sintaxe Tradicional (7º ao 9º ano)
INSERT OR IGNORE INTO topicos_habilidades (topico, codigo) VALUES
('Verbo intransitivo', 'EF07LP05'),
('Verbo transitivo direto', 'EF07LP05'),
('Verbo transitivo indireto', 'EF07LP05'),
('Predicação verbal', 'EF07LP05'),
('Objeto direto', 'EF07LP07'),
('Objeto indireto', 'EF07LP07'),
('Predicado verbal', 'EF07LP07'),
('Predicado nominal', 'EF07LP07'),
('Locução adjetiva', 'EF07LP08'),
('Locução adverbial', 'EF07LP09'),
('Sujeito simples e composto', 'EF08LP06'),
('Termos essenciais da oração', 'EF08LP06'),
('Regência verbal', 'EF08LP07'),
('Adjunto adnominal', 'EF08LP09'),
('Adjunto adverbial', 'EF08LP10'),
('Oração principal', 'EF08LP11'),
('Orações subordinadas adverbiais', 'EF08LP12'),
('Orações subordinadas substantivas', 'EF08LP12'),
('Conjunção integrante', 'EF08LP12'),
('Predicativo do sujeito', 'EF09LP05'),
('Verbos de estado', 'EF09LP06'),
('Regência nominal', 'EF09LP07'),
('Crase', 'EF09LP07'),
('Pronome relativo QUE', 'EF09LP09'),
('Uso da vírgula nas orações adjetivas', 'EF09LP09');

-- Estilística, Literatura e Redação (Ensino Fundamental II e Médio)
INSERT OR IGNORE INTO topicos_habilidades (topico, codigo) VALUES
('Voz passiva sintética', 'EF08LP08'),
('Voz passiva analítica', 'EF08LP08'),
('Elipse', 'EF89LP37'),
('Zeugma', 'EF89LP37'),
('Pleonasmo', 'EF89LP37'),
('Silepse', 'EF89LP37'),
('Anacoluto', 'EF89LP37'),
('Gêneros digitais', 'EF69LP05'),
('Linguagem mista', 'EF69LP05'),
('Dialeto e socioleto', 'EF69LP55'),
('Norma culta', 'EF69LP56'),
('Tese e contra-argumentação', 'EM13LP05'),
('Coerência e coesão', 'EM13LP02'),
('Impessoalidade', 'EM13LP07'),
('Ordem direta e indireta', 'EM13LP08'),
('Gramática normativa', 'EM13LP09'),
('Literatura africana', 'EM13LP52'),
('Literatura indígena', 'EM13LP52'),
('Literatura latino-americana', 'EM13LP52'),
('Escolas literárias', 'EM13LP48'),
('Romantismo, Realismo, Modernismo', 'EM13LP48'),
('Paródia e Pastiche', 'EM13LP50'),
('Edição de vídeo', 'EM13LP18'),
('Podcast e Vlog', 'EM13LP17');

-- ============================================================
-- SINTAXE DO PERÍODO COMPOSTO (As Orações)
-- ============================================================
INSERT OR IGNORE INTO topicos_habilidades (topico, codigo) VALUES
('Oração Subordinada Adjetiva', 'EF09LP09'),
('Oração Subordinada Adjetiva Restritiva', 'EF09LP09'),
('Oração Subordinada Adjetiva Explicativa', 'EF09LP09'),
('Oração Subordinada Adverbial', 'EF08LP12'),
('Orações Adverbiais Causais', 'EF08LP12'),
('Orações Adverbiais Condicionais', 'EF08LP12'),
('Orações Adverbiais Concessivas', 'EF08LP12'),
('Orações Adverbiais Temporais', 'EF08LP12'),
('Orações Adverbiais Finais', 'EF08LP12'),
('Orações Adverbiais Proporcionais', 'EF08LP12'),
('Oração Subordinada Substantiva', 'EF08LP12'),
('Oração Subordinada Substantiva Objetiva Direta', 'EF08LP12'),
('Oração Subordinada Substantiva Subjetiva', 'EF08LP12'),
('Oração Subordinada Substantiva Completiva Nominal', 'EF08LP12'),
('Orações Reduzidas', 'EF09LP04'),
('Oração Coordenada', 'EF08LP11'),
('Oração Coordenada Sindética', 'EF08LP11'),
('Oração Coordenada Assindética', 'EF08LP11'),
('Oração Coordenada Aditiva', 'EF07LP11'),
('Oração Coordenada Adversativa', 'EF07LP11'),
('Oração Coordenada Conclusiva', 'EF08LP11'),
('Oração Coordenada Explicativa', 'EF08LP11'),
('Conjunções Subordinativas', 'EF09LP08'),
('Conjunções Coordenativas', 'EF09LP08');

-- ============================================================
-- SINTAXE DO PERÍODO SIMPLES
-- ============================================================
INSERT OR IGNORE INTO topicos_habilidades (topico, codigo) VALUES
('Sujeito Simples', 'EF08LP06'),
('Sujeito Composto', 'EF08LP06'),
('Sujeito Oculto', 'EF08LP06'),
('Sujeito Desinencial', 'EF08LP06'),
('Sujeito Indeterminado', 'EF08LP06'),
('Oração sem Sujeito', 'EF08LP06'),
('Sujeito Inexistente', 'EF08LP06'),
('Predicado Verbal', 'EF07LP07'),
('Predicado Nominal', 'EF07LP07'),
('Predicado Verbo-Nominal', 'EF07LP07'),
('Complemento Nominal', 'EF08LP09'),
('Aposto', 'EF04LP05'),
('Vocativo', 'EF04LP05');

-- ============================================================
-- MORFOLOGIA (Classes de Palavras)
-- ============================================================
INSERT OR IGNORE INTO topicos_habilidades (topico, codigo) VALUES
('Classes de palavras', 'EF06LP04'),
('Substantivo', 'EF06LP04'),
('Adjetivo', 'EF06LP04'),
('Artigo', 'EF08LP09'),
('Numeral', 'EF08LP09'),
('Pronome Pessoal', 'EF35LP14'),
('Pronome Possessivo', 'EF35LP14'),
('Pronome Demonstrativo', 'EF35LP14'),
('Pronome Indefinido', 'EF69LP20'),
('Pronome de Tratamento', 'EF15LP11'),
('Advérbio', 'EF07LP09'),
('Preposição', 'EF08LP13'),
('Conjunção', 'EF05LP07'),
('Interjeição', 'EF69LP19'),
('Formas Nominais do Verbo', 'EF06LP05'),
('Infinitivo', 'EF06LP05'),
('Gerúndio', 'EF06LP05'),
('Particípio', 'EF06LP05');

-- ============================================================
-- FIGURAS DE LINGUAGEM E ESTILÍSTICA
-- ============================================================
INSERT OR IGNORE INTO topicos_habilidades (topico, codigo) VALUES
('Figuras de Linguagem', 'EF67LP38'),
('Metáfora', 'EF67LP38'),
('Comparação', 'EF67LP38'),
('Símile', 'EF67LP38'),
('Metonímia', 'EF67LP38'),
('Personificação', 'EF67LP38'),
('Prosopopeia', 'EF67LP38'),
('Hipérbole', 'EF67LP38'),
('Eufemismo', 'EF89LP37'),
('Ironia', 'EF89LP37'),
('Antítese', 'EF89LP37'),
('Paradoxo', 'EF89LP37'),
('Catacrese', 'EF67LP38'),
('Sinestesia', 'EF67LP38'),
('Perífrase', 'EF67LP38'),
('Gradação', 'EF89LP37'),
('Hipérbato', 'EF89LP37'),
('Inversão Sintática', 'EM13LP08'),
('Aliteração', 'EF89LP37'),
('Assonância', 'EF89LP37'),
('Onomatopeia', 'EF69LP54');

-- ============================================================
-- TIPOLOGIA TEXTUAL (Diferente de Gênero Textual)
-- ============================================================
INSERT OR IGNORE INTO topicos_habilidades (topico, codigo) VALUES
('Tipologia Textual', 'EF67LP37'),
('Tipo Narrativo', 'EF67LP30'),
('Narração', 'EF67LP30'),
('Tipo Descritivo', 'EF67LP37'),
('Descrição', 'EF67LP37'),
('Tipo Dissertativo', 'EM13LP05'),
('Dissertação', 'EM13LP05'),
('Tipo Argumentativo', 'EM13LP05'),
('Argumentação', 'EM13LP05'),
('Tipo Injuntivo', 'EF03LP14'),
('Injunção', 'EF03LP14'),
('Texto Prescritivo', 'EF67LP37');

-- ============================================================
-- topicos2.sql – Complemento de tópicos normativos e escolares
-- (Fonologia, Morfologia, Sintaxe, Figuras, Tipologias etc.)
-- ============================================================

-- FONOLOGIA E ORTOGRAFIA
INSERT OR IGNORE INTO topicos_habilidades (topico, codigo) VALUES
('Encontros consonantais', 'EF03LP02'),
('Ditongo, tritongo e hiato', 'EF03LP02'),
('Classificação dos fonemas', 'EF01LP07'),
('Vogais, semivogais e consoantes', 'EF01LP07'),
('Nasalização (m, n, til)', 'EF02LP05'),
('Acentuação gráfica', 'EF05LP03'),
('Uso dos porquês', 'EF04LP01'),
('Translineação', 'EF01LP06');

-- MORFOLOGIA – CLASSES DE PALAVRAS E ESTRUTURA
INSERT OR IGNORE INTO topicos_habilidades (topico, codigo) VALUES
('Radical e desinências', 'EF07LP03'),
('Vogal temática', 'EF07LP03'),
('Flexão de gênero', 'EF06LP04'),
('Flexão de número', 'EF06LP04'),
('Flexão de grau', 'EF06LP04'),
('Classificação dos advérbios', 'EF07LP09'),
('Preposições essenciais e acidentais', 'EF08LP13'),
('Conjunções integrantes', 'EF08LP12'),
('Conjunções adverbiais', 'EF08LP12'),
('Derivação prefixal e sufixal', 'EF07LP03'),
('Derivação parassintética', 'EF07LP03'),
('Composição por aglutinação e justaposição', 'EF08LP05'),
('Palavras primitivas e derivadas', 'EF05LP08');

-- SINTAXE – TERMOS E ORAÇÕES
INSERT OR IGNORE INTO topicos_habilidades (topico, codigo) VALUES
('Termos acessórios da oração', 'EF08LP06'),
('Análise sintática', 'EF08LP06'),
('Sujeito indeterminado', 'EF08LP06'),
('Índice de indeterminação do sujeito', 'EF08LP06'),
('Oração subordinada substantiva subjetiva', 'EF08LP12'),
('Oração subordinada substantiva objetiva direta', 'EF08LP12'),
('Oração subordinada substantiva objetiva indireta', 'EF08LP12'),
('Oração subordinada substantiva completiva nominal', 'EF08LP12'),
('Oração subordinada substantiva predicativa', 'EF08LP12'),
('Oração subordinada substantiva apositiva', 'EF08LP12'),
('Orações reduzidas de infinitivo', 'EF09LP04'),
('Orações reduzidas de gerúndio', 'EF09LP04'),
('Orações reduzidas de particípio', 'EF09LP04'),
('Voz reflexiva', 'EF08LP08'),
('Sujeito paciente', 'EF08LP08'),
('Objeto direto preposicionado', 'EF08LP07'),
('Adjunto adverbial de negação', 'EF08LP10'),
('Adjunto adverbial de tempo', 'EF08LP10'),
('Adjunto adverbial de modo', 'EF08LP10'),
('Adjunto adverbial de lugar', 'EF08LP10'),
('Adjunto adverbial de causa', 'EF08LP10'),
('Adjunto adverbial de finalidade', 'EF08LP10');

-- FIGURAS DE LINGUAGEM (complemento)
INSERT OR IGNORE INTO topicos_habilidades (topico, codigo) VALUES
('Polissíndeto', 'EF89LP37'),
('Assíndeto', 'EF89LP37'),
('Anáfora (figura de linguagem)', 'EF89LP37'),
('Antonomásia', 'EF89LP37'),
('Oxímoro', 'EF89LP37'),
('Paronomásia', 'EF89LP37'),
('Hipálage', 'EF89LP37'),
('Sinédoque', 'EF67LP38'),
('Apóstrofe (figura)', 'EF89LP37');

-- TIPOLOGIA E GÊNEROS TEXTUAIS
INSERT OR IGNORE INTO topicos_habilidades (topico, codigo) VALUES
('Tipo expositivo', 'EF04LP19'),
('Texto expositivo', 'EF04LP19'),
('Exposição de ideias', 'EF35LP20'),
('Texto explicativo', 'EM13LP31'),
('Tipo dialogal', 'EF35LP22'),
('Diálogo', 'EF35LP22'),
('Texto conversacional', 'EF35LP10');

-- SEMÂNTICA, COESÃO E COERÊNCIA
INSERT OR IGNORE INTO topicos_habilidades (topico, codigo) VALUES
('Homônimos e parônimos', 'EF06LP12'),
('Homonímia', 'EF06LP12'),
('Paronímia', 'EF06LP12'),
('Sinonímia, antonímia e homonímia', 'EF06LP12'),
('Coesão lexical', 'EF35LP08'),
('Coesão por elipse', 'EF67LP36'),
('Coerência textual', 'EM13LP02'),
('Progressão temática e paragrafação', 'EF35LP09'),
('Marcadores temporais', 'EF02LP17'),
('Operadores argumentativos', 'EF89LP15');

-- ============================================================
-- topicos2.sql – PLURAIS E VARIAÇÕES dos tópicos gramaticais
-- (Execute após o topicos.sql original ou após o BD_completo.sql)
-- ============================================================

INSERT OR IGNORE INTO topicos_habilidades (topico, codigo) VALUES

-- =====================
-- SINTAXE DO PERÍODO COMPOSTO – PLURAIS
-- =====================
('Orações Subordinadas Adjetivas', 'EF09LP09'),
('Orações Subordinadas Adjetivas', 'EF69LP54'),   -- EF69LP54 menciona “orações subordinadas adjetivas etc.”
('Orações Subordinadas Adjetivas Restritivas', 'EF09LP09'),
('Orações Subordinadas Adjetivas Explicativas', 'EF09LP09'),
('Orações Subordinadas Adverbiais', 'EF08LP12'),
('Orações Subordinadas Adverbiais Causais', 'EF08LP12'),
('Orações Subordinadas Adverbiais Condicionais', 'EF08LP12'),
('Orações Subordinadas Adverbiais Concessivas', 'EF08LP12'),
('Orações Subordinadas Adverbiais Temporais', 'EF08LP12'),
('Orações Subordinadas Adverbiais Finais', 'EF08LP12'),
('Orações Subordinadas Adverbiais Proporcionais', 'EF08LP12'),
('Orações Subordinadas Substantivas', 'EF08LP12'),
('Orações Subordinadas Substantivas Subjetivas', 'EF08LP12'),
('Orações Subordinadas Substantivas Objetivas Diretas', 'EF08LP12'),
('Orações Subordinadas Substantivas Objetivas Indiretas', 'EF08LP12'),
('Orações Subordinadas Substantivas Completivas Nominais', 'EF08LP12'),
('Orações Subordinadas Substantivas Predicativas', 'EF08LP12'),
('Orações Subordinadas Substantivas Apositivas', 'EF08LP12'),
('Orações Reduzidas', 'EF09LP04'),
('Orações Reduzidas de Infinitivo', 'EF09LP04'),
('Orações Reduzidas de Gerúndio', 'EF09LP04'),
('Orações Reduzidas de Particípio', 'EF09LP04'),
('Orações Coordenadas', 'EF08LP11'),
('Orações Coordenadas Sindéticas', 'EF08LP11'),
('Orações Coordenadas Assindéticas', 'EF08LP11'),
('Orações Coordenadas Aditivas', 'EF07LP11'),
('Orações Coordenadas Adversativas', 'EF07LP11'),
('Orações Coordenadas Conclusivas', 'EF08LP11'),
('Orações Coordenadas Explicativas', 'EF08LP11'),

-- =====================
-- SINTAXE DO PERÍODO SIMPLES – PLURAIS
-- =====================
('Termos Essenciais da Oração', 'EF08LP06'),
('Termos Integrantes da Oração', 'EF08LP07'),
('Termos Acessórios da Oração', 'EF08LP09'),
('Sujeitos Indeterminados', 'EF08LP06'),
('Orações sem Sujeito', 'EF08LP06'),
('Predicados Verbais', 'EF07LP07'),
('Predicados Nominais', 'EF07LP07'),
('Predicados Verbo-Nominais', 'EF07LP07'),
('Objetos Diretos', 'EF07LP07'),
('Objetos Indiretos', 'EF07LP07'),
('Complementos Nominais', 'EF08LP09'),
('Adjuntos Adnominais', 'EF08LP09'),
('Adjuntos Adverbiais', 'EF08LP10'),
('Adjuntos Adverbiais de Tempo', 'EF08LP10'),
('Adjuntos Adverbiais de Modo', 'EF08LP10'),
('Adjuntos Adverbiais de Lugar', 'EF08LP10'),
('Adjuntos Adverbiais de Causa', 'EF08LP10'),
('Adjuntos Adverbiais de Finalidade', 'EF08LP10'),
('Apostos', 'EF04LP05'),
('Vocativos', 'EF04LP05'),

-- =====================
-- MORFOLOGIA – CLASSES E FLEXÕES – PLURAIS
-- =====================
('Substantivos', 'EF06LP04'),
('Adjetivos', 'EF06LP04'),
('Artigos', 'EF08LP09'),
('Numerais', 'EF08LP09'),
('Pronomes', 'EF35LP14'),
('Pronomes Pessoais', 'EF35LP14'),
('Pronomes Possessivos', 'EF35LP14'),
('Pronomes Demonstrativos', 'EF35LP14'),
('Pronomes Indefinidos', 'EF69LP20'),
('Pronomes de Tratamento', 'EF15LP11'),
('Advérbios', 'EF07LP09'),
('Locuções Adverbiais', 'EF07LP09'),
('Preposições', 'EF08LP13'),
('Conjunções', 'EF05LP07'),
('Conjunções Coordenativas', 'EF09LP08'),
('Conjunções Subordinativas', 'EF09LP08'),
('Interjeições', 'EF69LP19'),
('Verbos', 'EF06LP04'),
('Verbos de Ligação', 'EF09LP06'),
('Formas Nominais do Verbo', 'EF06LP05'),
('Infinitivos', 'EF06LP05'),
('Gerúndios', 'EF06LP05'),
('Particípios', 'EF06LP05'),
('Radicais e Desinências', 'EF07LP03'),
('Vogais Temáticas', 'EF07LP03'),

-- =====================
-- FIGURAS DE LINGUAGEM – PLURAIS E VARIAÇÕES
-- =====================
('Figuras de Linguagem', 'EF67LP38'),
('Figuras de Linguagem', 'EF69LP54'),
('Figuras de Palavras', 'EF67LP38'),
('Metáforas', 'EF67LP38'),
('Comparações', 'EF67LP38'),
('Símiles', 'EF67LP38'),
('Metonímias', 'EF67LP38'),
('Personificações', 'EF67LP38'),
('Prosopopeias', 'EF67LP38'),
('Hipérboles', 'EF67LP38'),
('Eufemismos', 'EF89LP37'),
('Ironias', 'EF89LP37'),
('Antíteses', 'EF89LP37'),
('Paradoxos', 'EF89LP37'),
('Catacreses', 'EF67LP38'),
('Sinestesias', 'EF67LP38'),
('Perífrases', 'EF67LP38'),
('Gradações', 'EF89LP37'),
('Aliterações', 'EF89LP37'),
('Assonâncias', 'EF89LP37'),
('Onomatopeias', 'EF69LP54'),
('Polissíndetos', 'EF89LP37'),
('Assíndetos', 'EF89LP37'),
('Anáforas (figura)', 'EF89LP37'),
('Oxímoros', 'EF89LP37'),

-- =====================
-- TIPOLOGIAS TEXTUAIS – PLURAIS
-- =====================
('Tipologias Textuais', 'EF67LP37'),
('Textos Narrativos', 'EF67LP30'),
('Textos Descritivos', 'EF67LP37'),
('Textos Dissertativos', 'EM13LP05'),
('Textos Argumentativos', 'EM13LP05'),
('Textos Injuntivos', 'EF03LP14'),
('Textos Prescritivos', 'EF67LP37'),
('Textos Expositivos', 'EF04LP19'),

-- =====================
-- SEMÂNTICA E COESÃO – PLURAIS
-- =====================
('Homônimos', 'EF06LP12'),
('Parônimos', 'EF06LP12'),
('Sinônimos', 'EF01LP15'),
('Antônimos', 'EF01LP15'),
('Operadores Argumentativos', 'EF89LP15');

-- ============================================================
-- SEMÂNTICA, VÍCIOS DE LINGUAGEM E ORTOGRAFIA PRÁTICA
-- ============================================================
INSERT OR IGNORE INTO topicos_habilidades (topico, codigo) VALUES
('Ambiguidade', 'EF69LP05'),
('Duplo Sentido', 'EF69LP05'),
('Homônimos', 'EF06LP12'),
('Homonímia', 'EF06LP12'),
('Parônimos', 'EF06LP12'),
('Paronímia', 'EF06LP12'),
('Hiperônimos', 'EF67LP36'),
('Hipônimos', 'EF67LP36'),
('Uso dos Porquês', 'EF67LP32'),
('Mal com U e Mal com L', 'EF67LP32'),
('Mas e Mais', 'EF07LP11'),
('Onde e Aonde', 'EF67LP32'),
('Ortoépia', 'EF69LP55'),
('Prosódia', 'EF69LP55'),
('Cacofonia', 'EF69LP56');

-- ============================================================
-- TEORIA DA COMUNICAÇÃO E FUNÇÕES DA LINGUAGEM (Jakobson)
-- ============================================================
INSERT OR IGNORE INTO topicos_habilidades (topico, codigo) VALUES
('Funções da Linguagem', 'EM13LP01'),
('Função Emotiva', 'EM13LP01'),
('Função Referencial', 'EM13LP01'),
('Função Apelativa', 'EM13LP01'),
('Função Conativa', 'EM13LP01'),
('Função Poética', 'EM13LP06'),
('Função Fática', 'EM13LP01'),
('Função Metalinguística', 'EM13LP01'),
('Metalinguagem', 'EM13LP01'),
('Elementos da Comunicação', 'EM13LP01'),
('Emissor e Receptor', 'EM13LP01');

-- ============================================================
-- LITERATURA CLÁSSICA (Gêneros Literários Antigos)
-- ============================================================
INSERT OR IGNORE INTO topicos_habilidades (topico, codigo) VALUES
('Gêneros Literários', 'EM13LP49'),
('Gênero Épico', 'EM13LP49'),
('Epopeia', 'EM13LP49'),
('Gênero Lírico', 'EM13LP49'),
('Gênero Dramático', 'EM13LP49'),
('Tragédia e Comédia', 'EM13LP49');