# SINAN -- Sistema de Informação de Agravos de Notificação

## Resumo

-  Ano de criação: 1993
-  Cobertura: Dimensões pública e privada do SUS
-  Unidade: Ficha de notificação
-  Divulgação de dados: mensal, com defasagem variada

## Histórico e organização

O SINAN é um instrumento fundamental para a vigilância epidemiológica nacional, sendo responsável por coletar, transmitir e disseminar dados sobre uma lista de doenças e agravos de saúde, cuja notificação é compulsória em todo território nacional. A [lista de doenças e agravos](https://www.gov.br/saude/pt-br/composicao/svsa/notificacao-compulsoria/lista-nacional-de-notificacao-compulsoria-de-doencas-agravos-e-eventos-de-saude-publica) é atualizada permanentemente, conforme mudanças no cenário epidemiológico nacional, contando atualmente com 57 doenças e agravos [@msPortaria33282022; @msPortaria4202022].

Interessante observar que esta lista inclui, além de doenças infecto-contagiosas, a notificação compulsória de acidentes de trabalho, acidentes por animais peçonhentos, eventos adversos de vacinação, casos de óbito infantil e materno e casos de violência doméstica, sexual e tentativas de suicídio, permitindo ao sistema de saúde monitorar rapidamente diversos tipos de eventos de saúde de interesse.

```{mermaid}
%%| fig-cap: "Fluxo de notificação do SINAN"
%%| label: fig-do

flowchart TD
cs[Caso suspeito] --> us[Unidade de Saúde]
us --> not[Notificação do caso suspeito]
not --> sms[Secretaria Municipal de Saúde]
sms --> ses[Secretaria Estadual de Saúde]
ses --> ms[Ministério da Saúde]
us --> aco[Acompanhamento do caso suspeito]
aco --> exam[Exames clínicos e laboratoriais]
exam --> diag[Diagnóstico do caso]
diag --> conf(Caso confirmado)
diag --> desc(Caso descartado)
diag --> incon(Caso inconclusivo)
conf --> atua[Atualização do caso suspeito]
desc --> atua
incon --> atua
atua --> sms
```

A estrutura do SINAN está sendo revisada com a implantação do projeto "e-SUS SINAN", visando o registro em tempo real das notificações do SINAN, em substituição aos sistemas SINAN NET e SINAN Online atualmente utilizados.

## Estrutura dos dados

O SINAN apresenta dados para *todos os casos suspeitos notificados*, independente do diagnóstico final. Desta forma, para se obter o total de casos *confirmados* para determinada doença ou agravo, deve-se filtrar os dados segundo o diagnóstico final.

Durante epidemias, observa-se no SINAN um aumento de casos notificados, que podem ou não serem confirmados posteriormente com o acompanhamento do caso.

::::: {.callout}
Uma possível utilidade para se manter o registro dos casos descartados é o cálculo do *Indicador de Positividade*, que avalia a proporção de casos confirmados dentre os casos notificados.

$$
pos = \frac{c_c}{c_c + c_d + c_i}
$$

Onde $c_c$ são casos confirmados, $c_d$ são casos descartados e $c_i$ são casos com diagnóstico inconclusivo.
:::


:::::: {.callout-note}
Dados de casos suspeitos reportados no SINAN podem apresentar diversas variáveis de datas e locais relativas a diferentes momentos do acompanhamento do caso. As datas mais comuns são: data de provavel infecção, data de notificação, data de digitação, data do(s) exames laboratoriai(s), data do diagnóstico final. Já as variáveis de localização mais comuns são: município/UF de provavel infecção, município/UF de residência e município/UF de notificação.

Para o acompanhamento epidemiológico, é mais usual a adoção da data de provavel infecção e município/UF de provavel infecção.

Casos onde o município/UF de provavel infeção é o mesmo que o de residência podem ser classificados como "autoctones", ou seja, a doença foi contraída no mesmo município/UF de residência do paciente. Já casos onde a município/UF de provavel infeção é diferente do município/UF de residência podem ser classificados como "alotoctones".
:::

Dada a diversidade de doenças e agravos cobertos pelo SINAN, arquivos de diferentes estruturas de dados são disponíveis, apresentados a seguir.

## Acesso aos dados

### TabNet

Os dados do SINAN podem ser acessados no sistema TabNet do DataSUS, na seção "Epidemiológicas e Morbidade".

-  [TabNet SINAN](https://datasus.saude.gov.br/informacoes-de-saude-tabnet/)

### TabWin

Para uso no TabWin, você irá precisar baixar no servidor de FTP do DataSUS, os arquivos de dados no formato DBC e os arquivos auxiliares para tabulação.

-  [TabWin - Transferência de arquivos](https://datasus.saude.gov.br/transferencia-de-arquivos/)

### R

Você pode usar o pacote [`{microdatasus}`](https://rfsaldanha.github.io/microdatasus/index.html).

```{r}
#| message: false
library(microdatasus)

sinan_raw <- fetch_datasus(
  year_start = 2017,
  year_end = 2017,
  information_system = "SINAN-DENGUE"
)

sinan_p <- process_sinan_dengue(sinan_raw)

sinan_p
```

### Python

Você pode usar a biblioteca PySUS.

-  [PySUS SINAN](https://pysus.readthedocs.io/en/latest/databases/SINAN.html)

### OpenDataSUS

O Ministério da Saúde disponibiliza arquivos atualizados no OpenDataSUS para as seguintes notificações:

-  [Dengue](https://opendatasus.saude.gov.br/dataset/arboviroses-dengue)
-  [Zika](https://opendatasus.saude.gov.br/dataset/arboviroses-zika-virus)
-  [Chikungunya](https://opendatasus.saude.gov.br/dataset/arboviroses-febre-de-chikungunya)
-  [Mpox](https://opendatasus.saude.gov.br/dataset/mpox)
-  [Febre Amarela](https://opendatasus.saude.gov.br/dataset/febre-amarela-em-humanos-e-primatas-nao-humanos)

### InfoDengue

O projeto InfoDengue, mantido pela FGV EMAp e Fiocruz, apresenta estimativas da incidência da Dengue a partir de dados do SINAN, usando técnicas de *nowcasting* para reduzir os efeitos do atraso de notificação. O acesso aos dados é possível por uma API.

-  [InfoDengue](https://info.dengue.mat.br)
-  [InfoDengue API](https://info.dengue.mat.br/services/)

## Bibliografia recomendada

### Documentos auxiliares

-  [Manual do Sistema](assets/sinan/manual_sinan.pdf)
-  [Manual de Normas e Rotinas](assets/sinan/manual_normas_rotinas_2ed.pdf)

### Videos

{{< video https://www.youtube.com/watch?v=czwBtHR8g7c >}}
