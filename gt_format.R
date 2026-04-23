#gt

library(gt)

# ============================================================
# Tema Padronizado para Tabelas {gt}
# ============================================================

#' Aplica a paleta Cubismo Geométrico e a tipografia Fira Sans
#' a objetos gerados pelo pacote gt.
#'
#' @param data Um objeto da classe gt_tbl
tema_tabela_livro <- function(data) {
  
  # Definição local das cores para manter a consistência com o preâmbulo
  cor_azul_cobalto <- "#0047AB"
  azul             <- "#2A75D3" # Contraste padrão
  cor_bege         <- "#D9CBB8"
  cor_texto_escuro <- "#1A1A1A"
  laranja_queimado <- "#A33B14"  # Primária - sobriedade e estrutura
  laranja_vibrante <- "#FF3B00"  # Destaque agudo
  laranja          <- "#F26D21"  # Apoio quente
  pessego          <- "#FFC299"  # Fundo suave / áreas
  creme            <- "#FDFBF7"  # Quase branco, para transições
  bege             <- "#D9CBB8"  # Linhas de grade e eixos
  
  data |>
    # Tipografia primária 
    opt_table_font(
      font = google_font("Fira Sans"),
      weight = 400
    ) |>
    tab_options(
      # Estrutura e alinhamento do cabeçalho
      heading.align = "left",
      heading.background.color = "transparent",
      heading.border.bottom.color = "transparent",
      
      # Linhas horizontais externas
      table.border.top.color = "transparent",
      table.border.bottom.color = "transparent",
      table.border.bottom.width = px(2),
      
      # Delimitadores do cabeçalho das colunas
      column_labels.border.top.color = laranja_queimado,
      column_labels.border.top.width = px(2),
      column_labels.border.bottom.color = laranja_queimado,
      column_labels.border.bottom.width = px(2),
      column_labels.font.weight = "bold",
      column_labels.background.color = pessego,
      
      # Linhas internas do corpo da tabela
      # A linha inferior do corpo já atua como a separação superior do rodapé
      table_body.border.bottom.color = laranja_queimado,
      table_body.border.bottom.width = px(2),
      table_body.hlines.width = px(0.5),
      
      # Estrutura das notas (sem linhas pesadas de divisão interna)
      source_notes.border.bottom.color = "transparent",
      source_notes.background.color = "transparent",
      
      # Cor base do texto da tabela e espaçamento
      table.font.color = cor_texto_escuro,
      data_row.padding = px(6)
    ) |>
    # Formatação do Título
    tab_style(
      style = cell_text(
        color = laranja_queimado,
        weight = "bold"
      ),
      locations = cells_title(groups = "title")
    ) |>
    # Formatação do Subtítulo
    tab_style(
      style = cell_text(
        color = laranja_queimado
      ),
      locations = cells_title(groups = "subtitle")
    ) |>
    # Formatação das Notas e Fontes
    tab_style(
      style = cell_text(
        color = cor_azul_cobalto,
        size = px(12)
      ),
      locations = list(
        cells_source_notes(),
        cells_footnotes()
      )
    )
}

mtcars[1:6, 1:5] |>
  gt(rownames_to_stub = TRUE) |>
  tab_header(
    title = "Desempenho de Veículos Selecionados",
    subtitle = "Consumo, número de cilindros e deslocamento volumétrico"
  ) |>
  tab_source_note(
    source_note = "Fonte: Motor Trend Car Road Tests (1974)."
  ) |>
  tab_footnote(
    footnote = "Milhas por galão norte-americano.",
    locations = cells_column_labels(columns = mpg)
  ) |>
  tema_tabela_livro()
