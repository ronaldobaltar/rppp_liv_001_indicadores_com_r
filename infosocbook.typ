// =========================
// CONFIGURAÇÃO BÁSICA
// =========================

#set text(
  lang: "pt",
  region: "BR",
  size: 11pt,
  font: "Times New Roman"
)

#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 3cm, right: 2cm),
)

// =========================
// CORES
// =========================

#let terra = rgb("#8B4513")
#let terra-claro = rgb("#F3E5D8")

// =========================
// HEADER / FOOTER (SEGURO)
// =========================

// NÃO usamos heading aqui (instável no Quarto)
// apenas número de página

#set page(
  header: context {
    align(right)[]
  },
  footer: context {
    align(center)[counter(page).display()]
  }
)

// =========================
// PARTES (LEVEL 0)
// =========================

#show heading.where(level: 0): it => {
  pagebreak()

  align(center)[
    block(
      fill: terra,
      inset: 20pt,
      radius: 6pt,
    )[
      text(fill: white, size: 18pt, weight: "bold")[
        it.body
      ]
    ]
  ]

  pagebreak()
}

// =========================
// CAPÍTULOS (LEVEL 1)
// =========================

#show heading.where(level: 1): it => {
  let n = counter(heading).at(it.location())

  block(
    fill: terra-claro,
    inset: 14pt,
    radius: 6pt,
    spacing: 1.2em,
  )[
    text(fill: terra, weight: "bold", size: 16pt)[
      "Capítulo " + str(n)
    ]

    linebreak()

    text(weight: "bold", size: 14pt)[it.body]
  ]
}

// =========================
// SEÇÕES (LEVEL 2)
// =========================

#show heading.where(level: 2): it => {
  let n = counter(heading).at(it.location())

  block[
    text(fill: terra, weight: "bold")[
      str(n) + " " + it.body
    ]
  ]
}