# CID -- Classificação Internacional de Doenças

Os códigos da Classificação Internacional de Doenças estão presentes em diversos SIS, sendo um importante componente para a descrição de eventos de saúde como óbitos e internações. Este apêndice visa apresentar as principais características dessa classificação.

## Histórico

A Organização Mundial da Saúde (OMS), criada em 1948, passou a se responsabilizar pela manutenção e atualização da classificação de causas de óbito.

Uma descrição histórica da CID mais completa pode ser encontrada [neste documento](assets/cid/historyoficd.pdf).

## Estrutura

A CID segue uma estrutura hierárquica de capítulos, categorias e subcategorias, agrupando causas específicas seguindo em geral um ordenamento biológico vinculado aos órgãos e aparelhos do corpo humano.

Os capítulos são descritos por números romanos. Já as categorias, subcategorias e causas seguem um sistema de letras e números.

Exemplo: "Cólera devida a Vibrio cholerae 01, biótipo El Tor" na CID-10:

-  Capítulo I: Algumas doenças infecciosas e parasitárias
-  Categoria A00-B99: Doenças infecciosas intestinais
-  Subcategoria A00: Cólera
-  Código A00.1: Cólera El Tor

Você pode acessar e explorar o catálogo da CID-10 na tabela abaixo:

```{r}
#| message: false
#| warning: false
#| echo: false
library(readr)
library(dplyr)
library(DT)

cid10 <- read_csv2("assets/tabela_cid10.csv") |>
  select(-tipo) |>
  rename(
    `Capítulo` = capitulo,
    `Grupo` = grupo,
    `Código` = codigo,
    `Descrição` = descricao
  )

datatable(
  data = cid10,
  rownames = FALSE,
  options = list(
    language = list(
      url = "https://cdn.datatables.net/plug-ins/1.10.11/i18n/Portuguese.json"
    )
  )
)
```

Nos links a seguir, você pode consultar a hierarquia da CID-10 e CID-11 no Ministério da Saúde e na OMS:

-  [CID-10 no DataSUS](http://www2.datasus.gov.br/cid10/V2008/WebHelp/listacateg.htm)
-  [CID-10 na OMS](https://icd.who.int/browse10)
-  [CID-11 na OMS](https://icd.who.int/browse/2025-01/mms/pt)

## Edições da CID no Brasil

O DataSUS usou a CID-9 até 1995, passando a divulgar dados considerando a CID-10 à partir de 1996. 

O Ministério da Saúde [participou ativamente](https://www.gov.br/saude/pt-br/assuntos/noticias/2022/julho/ministerio-da-saude-coordena-traducao-do-novo-codigo-internacional-de-doencas-para-a-lingua-portuguesa) da construção da CID-11, que entrou em vigor globalmente em 2022.

::::: {.callout}
Atualmente, o DataSUS segue trabalhando com a CID-10 e estudando a transição dos SIS para a CID-11.
:::
