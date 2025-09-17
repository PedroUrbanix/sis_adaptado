# SIH -- Sistema de Informações Hospitalares do SUS

## Resumo

-  Ano de criação: 1981
-  Cobertura: Dimensão pública do SUS
-  Unidade: Autorização de Internação Hospitalar (AIH)
-  Divulgação de dados: mensal, com até dois meses  de defasagem

## Histórico e organização


. Estas críticas verificam possíveis incompatibilidades entre idade, sexo, e capacidade declarada dos estabelecimentos de saúde frente aos procedimentos lançados na autorização, contribuindo para uma melhor qualidade dos dados do sistema [@pepeSistemaInformacoesHospitalares2009].

A cobertura do SIH se limita à esfera pública do SUS e sua rede conveniada. A

Este é um dos sistemas de informação de saúde que  recebe novos registros com maior frequência, junto com o Sistema de Informações Ambulatoriais (SIA). A análise destes dados requerem estratégias específicas para lidar com grandes bases de dados, utilizando, em geral, soluções de banco de dados relacionais que permitam um processamento analítico on-line (OLAP) eficiente.

## Estrutura dos dados

Confira o documento de [estrutura do SIH](assets/sih/IT_SIHSUS_1603.pdf), onde estão descritas as variáveis disponíveis.

### Prefixo dos arquivos

-  ER: AIH rejeitadas com código de erro
-  RD: AIH Reduzida
-  RJ: AIH rejeitadas
-  SP: serviços profissionais


## Acesso aos dados

### TabNet

Os dados do SIH podem ser acessados no sistema TabNet do DataSUS, na seção "Assistência à Saúde".

-  [TabNet SIH](https://datasus.saude.gov.br/acesso-a-informacao/morbidade-hospitalar-do-sus-sih-sus/)

### TabWin

Para uso no TabWin, você irá precisar baixar no servidor de FTP do DataSUS, os arquivos de dados no formato DBC e os arquivos auxiliares para tabulação.

-  [TabWin - Transferência de arquivos](https://datasus.saude.gov.br/transferencia-de-arquivos/)

### R

Você pode usar o pacote [`{microdatasus}`](https://rfsaldanha.github.io/microdatasus/index.html).






```{r}
#| message: false
library(microdatasus)

sih_raw <- fetch_datasus(
  year_start = 2021,
  month_start = 1,
  year_end = 2021,
  month_end = 2,
  uf = "AC",
  information_system = "SIH-RD"
)

sih_p <- process_sinasc(sih_raw)

sih_p
```






### Python

Você pode usar a biblioteca PySUS.

-  [PySUS SIH](https://pysus.readthedocs.io/en/latest/databases/SIH.html)

### PCDaS

Os dados do SIH estão disponíveis na PCDaS para acesso via *notebooks*.

-  [Dados SIH](https://pcdas.icict.fiocruz.br/conjunto-de-dados/sistema-de-informacoes-hospitalares-do-sus-sihsus/)

## Principais usos e indicadores

Segundo @OPAS2008, os dados do SIH são utilizados na construção de diversos indicadores de saúde. Pode-se destacar os seguintes indicadores:

-  Proporção de internações hospitalares (SUS) por grupos de causas
-  Proporção de internações hospitalares (SUS) por causas externas
-  Proporção de internações hospitalares (SUS) por afecções originadas no período perinatal
-  Valor médio pago por internação hospitalar no SUS (AIH)

Consulte o [livro da RIPSA](http://tabnet.datasus.gov.br/tabdata/livroidb/2ed/indicadores.pdf) para maiores detalhes sobre esses e outros indicadores.

## Bibliografia recomendada

### Documentos auxiliares

-  [Manual técnico do Sistema de Informação Hospitalar](assets/sih/07_0066_M.pdf)

### Vídeos






{{< video https://www.youtube.com/watch?v=uvp3swCFAro >}}










### Avaliação da qualidade dos dados

-  Artigo *Qualidade das bases de dados hospitalares no Brasil: alguns elementos* [@machadoQualidadeBasesDados2016]. Disponível [aqui](https://doi.org/10.1590/1980-5497201600030008).


