# SIM -- Sistema de Informação sobre Mortalidade

## Resumo

-  Ano de criação: 1975
-  Cobertura: Dimensões pública e privada do SUS
-  Unidade: Declaração de Óbito (DO)
-  Divulgação de dados: anual, com um ano de defasagem

## Histórico e organização


Mais informações sobre o preenchimento dos dados do SIM estão disponíveis no [manual de preenchimento](assets/sim/declaracao-obito-manual-instrucoes-preenchimento.pdf), disponibilizado pelo Ministério da Saúde.

Um histórico mais aprofundado sobre a construção e evolução do SIM está disponível [neste documento](assets/sim/INTRO.pdf).

## Estrutura dos dados

Confira o documento de [estrutura do SIM](assets/sim/Estrutura_SIM_para_CD.pdf), onde estão descritas as variáveis disponíveis.

### Prefixo dos arquivos
-  DO: Declarações de óbito
-  DOEXT: Declarações de óbitos por causas externas
-  DOFET: Declarações de óbitos fetais
-  DOINF: Declarações de óbitos infantis
-  DOMAT: Declarações de óbitos maternos
-  DOREXT: Mortalidade de residentes no exterior

## Acesso aos dados

### TabNet

Os dados do SIM podem ser acessados no sistema TabNet do DataSUS, na seção de Estatísticas Vitais.

-  [TabNet SIM](https://datasus.saude.gov.br/mortalidade-desde-1996-pela-cid-10)

### TabWin

Para uso no TabWin, você irá precisar baixar no servidor de FTP do DataSUS, os arquivos de dados no formato DBC e os arquivos auxiliares para tabulação.

-  [TabWin - Transferência de arquivos](https://datasus.saude.gov.br/transferencia-de-arquivos/)

### R

Você pode usar o pacote [`{microdatasus}`](https://rfsaldanha.github.io/microdatasus/index.html).

```{r}
#| message: false
library(microdatasus)

sim_raw <- fetch_datasus(
  year_start = 2021,
  year_end = 2021,
  uf = "AC",
  information_system = "SIM-DO"
)

sim_p <- process_sim(sim_raw)

sim_p
```

### Python

Você pode usar a biblioteca PySUS.

-  [PySUS SIM](https://pysus.readthedocs.io/en/latest/databases/SIM.html)

### PCDaS

Os dados do SIM estão disponíveis na PCDaS para acesso via *notebooks*.

-  [Dados SIM](https://pcdas.icict.fiocruz.br/conjunto-de-dados/sistema-de-informacoes-de-mortalidade-sim/)
-  [Dados SIM-DOFET](https://pcdas.icict.fiocruz.br/conjunto-de-dados/sistema-de-informacao-sobre-mortalidade-declaracao-de-obitos-fetais-sim-dofet/)

### Outras formas

Dados em formato CSV estão sendo disponibilizados no site OpenDataSUS, mantido pelo DataSUS, incluindo versões de dados preliminares do ano corrente.

-  [OpenDataSUS - SIM](https://opendatasus.saude.gov.br/dataset/sim)

## Principais usos e indicadores

Segundo @OPAS2008, os dados do SIM são utilizados na construção de diversos indicadores de mortalidade. Pode-se destacar os seguintes indicadores:

-  Taxa de mortalidade infantil
-  Taxas de mortalidade neonatal precoce e tardia, pós-neonatal e perinatal
-  Taxa de mortalidade em menores de cinco anos
-  Razão de mortalidade materna
-  Mortalidade proporcional por grupos de causas

Consulte o [livro da RIPSA](http://tabnet.datasus.gov.br/tabdata/livroidb/2ed/indicadores.pdf) para maiores detalhes sobre esses e outros indicadores.

## Bibliografia recomendada

### Documentos auxiliares

-  [Histórico do SIM](assets/sim/INTRO.pdf)
-  [Estrutura do SIM](assets/sim/Estrutura_SIM_para_CD.pdf)
-  [Manual de preenchimento da Declaração de Óbito](assets/sim/declaracao-obito-manual-instrucoes-preenchimento.pdf)
-  [A Declaração de Óbito: documento necessário e importante](assets/sim/a-declaracao-de-obito-documento-necessario-e-importante.pdf)

### Vídeos

{{< video https://www.youtube.com/watch?v=I_wFPYkDbF8 >}}

{{< video https://www.youtube.com/watch?v=DuyB5bsz7yM >}}

### Avaliação da qualidade dos dados

-  Artigo *Qualidade dos registros de ocupação das doenças associadas ao asbesto no sistema de informação sobre mortalidade, Brasil* [@cavalcanteQualidadeDosRegistros2023]. Disponível [aqui](https://doi.org/10.1590/1414-462X202331040547).
-  Artigo *Análise da qualidade das estatísticas vitais brasileiras: a experiência de implantação do SIM e do SINASC*. [@jorgeAnaliseQualidadeEstatisticas2007]. Disponível [aqui](https://doi.org/10.1590/S1413-81232007000300014).
-  Artigo *Avaliação da qualidade do Sistema Brasileiro de Informações sobre Mortalidade (SIM): uma scoping review*. [@reboucasAvaliacaoQualidadeSistema2025]. Disponível [aqui](https://doi.org/10.1590/1413-81232025301.08462023).

