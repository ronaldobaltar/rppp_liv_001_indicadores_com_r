# ============================================================
#  tema_livro.R
#  Tema ggplot2 e paletas (Versão Minimalista - Cubismo Geométrico)
# ============================================================

library(ggplot2)

# ============================================================
# 1. PALETA BASE DA MARCA
# ============================================================

cores_livro <- list(
  laranja_queimado = "#A33B14",  # Primária - sobriedade e estrutura
  laranja_vibrante = "#FF3B00",  # Destaque agudo
  laranja          = "#F26D21",  # Apoio quente
  pessego          = "#FFC299",  # Fundo suave / áreas
  creme            = "#FDFBF7",  # Quase branco, para transições
  bege             = "#D9CBB8",  # Linhas de grade e eixos
  branco           = "#FFFFFF",  # Fundo principal
  azul             = "#2A75D3",  # Contraste padrão
  ciano            = "#00C4D9",  # Contraste luminoso
  azul_cobalto     = "#0047AB",  # Ênfase fria e profunda
  texto_escuro     = "#1A1A1A"   # Preto legível (off-black)
)

# ============================================================
# 2. PALETAS DISCRETAS (qualitativas)
# ============================================================

#' Paleta qualitativa principal
#' Alterna entre tons quentes (laranjas) e frios (azuis/ciano) para contraste.
paleta_qualitativa <- c(
  cores_livro$laranja_queimado,
  cores_livro$azul_cobalto,
  cores_livro$laranja_vibrante,
  cores_livro$ciano,
  cores_livro$azul,
  cores_livro$laranja,
  cores_livro$pessego,
  cores_livro$bege
)

#' Paleta análoga — gradação de quentes.
paleta_analogica <- c(
  cores_livro$laranja_queimado,
  cores_livro$laranja_vibrante,
  cores_livro$laranja,
  cores_livro$pessego,
  cores_livro$bege
)

#' Paleta bicolor — comparações diretas.
paleta_binaria <- c(
  cores_livro$laranja_vibrante,
  cores_livro$azul_cobalto
)

# ============================================================
# 3. GRADIENTES CONTÍNUOS
# ============================================================

#' Sequencial: Creme puro -> Laranja Queimado
grad_sequencial <- c(cores_livro$creme, cores_livro$laranja_queimado)

#' Divergente: Azul Cobalto <-> Branco <-> Laranja Vibrante
grad_divergente <- c(
  cores_livro$azul_cobalto,
  cores_livro$branco,
  cores_livro$laranja_vibrante
)

# ============================================================
# 4. FUNÇÕES DE ESCALA ggplot2
# ============================================================

scale_color_livro <- function(palette = "qualitativa", ...) {
  pal <- switch(palette,
    qualitativa = paleta_qualitativa,
    analogica   = paleta_analogica,
    binaria     = paleta_binaria,
    stop("Paleta inválida.")
  )
  ggplot2::scale_color_manual(values = pal, ...)
}

scale_fill_livro <- function(palette = "qualitativa", ...) {
  pal <- switch(palette,
    qualitativa = paleta_qualitativa,
    analogica   = paleta_analogica,
    binaria     = paleta_binaria,
    stop("Paleta inválida.")
  )
  ggplot2::scale_fill_manual(values = pal, ...)
}

scale_color_livro_seq <- function(...) {
  ggplot2::scale_color_gradient(low = grad_sequencial[1], high = grad_sequencial[2], ...)
}

scale_fill_livro_seq <- function(...) {
  ggplot2::scale_fill_gradient(low = grad_sequencial[1], high = grad_sequencial[2], ...)
}

scale_color_livro_div <- function(midpoint = 0, ...) {
  ggplot2::scale_color_gradient2(
    low = grad_divergente[1], mid = grad_divergente[2], high = grad_divergente[3],
    midpoint = midpoint, ...
  )
}

scale_fill_livro_div <- function(midpoint = 0, ...) {
  ggplot2::scale_fill_gradient2(
    low = grad_divergente[1], mid = grad_divergente[2], high = grad_divergente[3],
    midpoint = midpoint, ...
  )
}

# ============================================================
# 5. TEMA ggplot2 MINIMALISTA
# ============================================================

theme_livro <- function(base_size = 10, base_family = "Fira Sans") {
  
  half <- base_size / 2
  
  ggplot2::theme_minimal(
    base_size   = base_size,
    base_family = base_family
  ) %+replace% ggplot2::theme(
    
    # ----- Fundo Branco Absoluto -----
    plot.background  = ggplot2::element_rect(fill = cores_livro$branco, color = NA),
    panel.background = ggplot2::element_rect(fill = cores_livro$branco, color = NA),
    
    # ----- Grade Minimalista -----
    # Apenas linhas maiores em bege muito suave
    panel.grid.major = ggplot2::element_line(color = cores_livro$creme, linewidth = 0.4),
    panel.grid.minor = ggplot2::element_blank(),
    
    # ----- Eixos -----
    axis.line  = ggplot2::element_line(color = cores_livro$bege, linewidth = 0.4),
    axis.ticks = ggplot2::element_line(color = cores_livro$bege, linewidth = 0.4),
    axis.text  = ggplot2::element_text(
      color  = cores_livro$texto_escuro,
      size   = ggplot2::rel(0.85)
    ),
    axis.title = ggplot2::element_text(
      color  = cores_livro$texto_escuro,
      size   = ggplot2::rel(0.90)
    ),
    axis.title.x = ggplot2::element_text(margin = ggplot2::margin(t = half)),
    axis.title.y = ggplot2::element_text(margin = ggplot2::margin(r = half), angle = 90),
    
    # ----- Títulos -----
    plot.title = ggplot2::element_text(
      color  = cores_livro$laranja_queimado,
      face   = "bold",
      size   = ggplot2::rel(1.15),
      hjust  = 0,
      margin = ggplot2::margin(b = half)
    ),
    plot.subtitle = ggplot2::element_text(
      color  = cores_livro$azul_cobalto,
      size   = ggplot2::rel(0.95),
      hjust  = 0,
      margin = ggplot2::margin(b = half)
    ),
    plot.caption = ggplot2::element_text(
      color  = cores_livro$bege, # Tom discreto para notas
      size   = ggplot2::rel(0.75),
      hjust  = 1,
      margin = ggplot2::margin(t = half)
    ),
    plot.title.position   = "plot",
    plot.caption.position = "plot",
    
    # ----- Legenda -----
    legend.position   = "bottom",
    legend.background = ggplot2::element_blank(),
    legend.key        = ggplot2::element_blank(),
    legend.title      = ggplot2::element_text(
      color = cores_livro$texto_escuro,
      face  = "bold",
      size  = ggplot2::rel(0.95)
    ),
    legend.text       = ggplot2::element_text(
      color = cores_livro$texto_escuro,
      size  = ggplot2::rel(0.95)
    ),
    legend.key.size   = ggplot2::unit(0.5, "lines"),
    
    # ----- Facetas (Minimalista) -----
    strip.background = ggplot2::element_blank(), # Fundo removido
    strip.text = ggplot2::element_text(
      color  = cores_livro$laranja_queimado,
      face   = "bold",
      size   = ggplot2::rel(0.95),
      margin = ggplot2::margin(b = half)
    ),
    
    # ----- Margens -----
    plot.margin = ggplot2::margin(t = half, r = half, b = half, l = half),
    
    complete = TRUE
  )
}

# ============================================================
# 6. ATIVAR COMO PADRÃO GLOBAL
# ============================================================

definir_tema_livro <- function(familia_fonte = "Fira Sans", tamanho_base = 10) {
  
  # Lógica para garantir fallback em PDFs via LaTeX compilados pelo Quarto/Knitr
  if (isTRUE(getOption("knitr.in.progress")) && knitr::is_latex_output()) {
    familia_fonte <- "" 
  }
  
  ggplot2::theme_set(
    theme_livro(base_size = tamanho_base, base_family = familia_fonte)
  )
  
  # Atualização dos geoms baseados na nova paleta
  ggplot2::update_geom_defaults("point", list(
    color = cores_livro$laranja_vibrante,
    size  = 2
  ))
  ggplot2::update_geom_defaults("line", list(
    color     = cores_livro$azul_cobalto,
    linewidth = 0.8
  ))
  ggplot2::update_geom_defaults("bar", list(
    fill  = cores_livro$laranja_queimado,
    color = NA
  ))
  ggplot2::update_geom_defaults("col", list(
    fill  = cores_livro$laranja_queimado,
    color = NA
  ))
  ggplot2::update_geom_defaults("area", list(
    fill  = cores_livro$pessego,
    color = NA
  ))
  ggplot2::update_geom_defaults("smooth", list(
    color = cores_livro$bege,
    fill  = "#eaacb0" #pêssego avermelhado mais claro
  ))
  ggplot2::update_geom_defaults("text", list(
    color  = cores_livro$texto_escuro,
    family = familia_fonte
  ))
  ggplot2::update_geom_defaults("label", list(
    color  = cores_livro$texto_escuro,
    fill   = cores_livro$branco,
    family = familia_fonte
  ))
  
  invisible(NULL)
}


# ============================================================
# Tema Padronizado para Tabelas {gt}
# ============================================================

library(gt)

#' Aplica a paleta do livro e a tipografia Fira Sans
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
      # Fonte
      table.font.size = px(12),
      heading.title.font.size = px(14),
      heading.subtitle.font.size = px(12),
      # source_notes.font.size = px(9)
      # Estrutura e alinhamento do cabeçalho
      heading.align = "left",
      heading.background.color = cor_bege,
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