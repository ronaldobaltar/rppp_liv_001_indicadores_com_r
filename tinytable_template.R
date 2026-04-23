#tinytable

library(tinytable)

# ============================================================
# Tema Padronizado para Tabelas {tinytable}
# ============================================================
tema_tabela_livro_tt <- function(data,
                                 titulo,
                                 subtitulo    = NULL,
                                 nota_fonte   = NULL,
                                 notas_rodape = NULL) {
  
  laranja_queimado <- "#A33B14"
  pessego          <- "#FFC299"
  cor_azul_cobalto <- "#0047AB"
  cor_texto_escuro <- "#1A1A1A"
  
  n <- nrow(data)
  
  # tinytable não possui campo subtitle separado:
  # o subtítulo é concatenado ao caption com quebra de linha
  caption <- titulo
  if (!is.null(subtitulo)) {
    caption <- paste0(titulo, "\n\n*", subtitulo, "*")
  }
  
  # As notas aparecem no tfoot — rodapé primeiro, fonte por último
  notes <- c(notas_rodape, nota_fonte)
  
  tt(
    data,
    caption = caption,
    notes   = if (length(notes) > 0) notes else NULL
  ) |>
    
    # ── 1. Cabeçalho das colunas ──────────────────────────────
    style_tt(
      i          = 0,
      background = pessego,
      bold       = TRUE,
      line       = "tb",          # bordas acima e abaixo do cabeçalho
      line_color = laranja_queimado,
      line_width = 0.1            # mm em LaTeX, px em HTML
    ) |>
    
    # ── 2. Corpo da tabela ────────────────────────────────────
    style_tt(
      i     = 1:n,
      color = cor_texto_escuro
    ) |>
    
    # ── 3. Borda inferior do corpo ────────────────────────────
    style_tt(
      i          = n,
      line       = "b",
      line_color = laranja_queimado,
      line_width = 0.1
    ) |>
    
    # ── 4. CSS global — HTML / EPUB ───────────────────────────
    # Fonte Fira Sans, cor do caption e cor das notas de rodapé
    style_tt(
      bootstrap_css_rule = "
        @import url('https://fonts.googleapis.com/css2?family=Fira+Sans:wght@400;700&display=swap');

        .tinytable {
          font-family: 'Fira Sans', sans-serif;
          color: #1A1A1A;
        }
        .tinytable caption {
          color: #A33B14;
          font-weight: bold;
          text-align: left;
          padding-bottom: 4px;
        }
        .tinytable tfoot td {
          color: #0047AB !important;
          font-size: 0.85em;
        }
      "
    )
}

# A marca de rodapé na coluna é adicionada diretamente ao nome
dados <- mtcars[1:6, 1:5]
colnames(dados)[colnames(dados) == "mpg"] <- "mpg¹"

dados |>
  tema_tabela_livro_tt(
    titulo       = "Desempenho de Veículos Selecionados",
    subtitulo    = "Consumo, número de cilindros e deslocamento volumétrico",
    nota_fonte   = "Fonte: Motor Trend Car Road Tests (1974).",
    notas_rodape = "¹ Milhas por galão norte-americano."
  )
