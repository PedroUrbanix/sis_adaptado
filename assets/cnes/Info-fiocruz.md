# CNES na PCDaS — documentação técnica (markdown)

> **Fonte:** Plataforma de Ciência de Dados aplicada à Saúde (PCDaS/Fiocruz).
> **Página-base:** Conjunto de dados **“Cadastro Nacional de Estabelecimentos de Saúde – CNES”** (seção **Documentação**).
> **Acesso:** 16/set/2025.

---

## 1) Visão geral

A PCDaS disponibiliza o **CNES** (Cadastro Nacional de Estabelecimentos de Saúde) como um **índice Elasticsearch** com **registros individuais de estabelecimentos**, mantido com **atualização mensal**. A página do conjunto de dados centraliza a **documentação do processo ETL** e o **dicionário de variáveis** utilizados na plataforma. ([pcdas.icict.fiocruz.br][1])

* **Finalidade**: consulta analítica via buscas (filtros por campos do dicionário) e integração com outras fontes.
* **Origem primária**: dados oficiais do **DATASUS/CNES**; a PCDaS agrega, padroniza e indexa para consumo. ([pcdas.icict.fiocruz.br][1])

---

## 2) Escopo, periodicidade e cobertura

* **Unidade**: estabelecimento de saúde (CNES).
* **Periodicidade**: **mensal** (o índice ES é atualizado mensalmente). ([pcdas.icict.fiocruz.br][2])
* **Cobertura**: registros individuais dos estabelecimentos do território nacional, conforme a base CNES do DATASUS. (O escopo é o mesmo do CNES; detalhes oficiais de missão/escopo no portal CNES). ([estabelecimentos.datasus.gov.br][3])

> Observação: a PCDaS publica **notas de atualização** (ex.: marcos temporais como “dados até jan/2024” em notícias e páginas do grupo Estabelecimentos), úteis para checar o último mês efetivamente disponível no índice. ([pcdas.icict.fiocruz.br][4])

---

## 3) Processo **ETL** (conforme a PCDaS)

A página de documentação do conjunto de dados descreve que aplica um **ETL (Extract–Transform–Load)** ao CNES **para indexação** na PCDaS. Ao nível público, a documentação afirma o **ETL geral**; os **passos finos de transformação** (campo a campo) não estão totalmente detalhados na página. ([pcdas.icict.fiocruz.br][1])

### 3.1 Extract (extração)

* **Fonte**: arquivos oficiais do **CNES/DATASUS**.
* **Canais de origem**: não são enumerados na documentação PCDaS (ex.: pastas FTP/nomes de arquivos). **Não informado**; usar a documentação oficial do CNES/DATASUS quando precisar rastrear a origem (layouts/arquivos). ([CNES][5])

### 3.2 Transform (transformação)

* **Harmonização**: a PCDaS “reúne” os dados e **publica um dicionário de variáveis**, o que implica padronização de nomes/tipos e eventuais junções internas. A página **não** detalha, item a item, renomeações, regras de limpeza e deduplicações. **Não informado**. ([pcdas.icict.fiocruz.br][1])

### 3.3 Load (carga)

* **Destino**: **Elasticsearch** (um **índice** com os registros).
* **Frequência**: **mensal**.
* **Detalhes operacionais** (versionamento do índice, rotação/alias): **não informados** na documentação pública. ([pcdas.icict.fiocruz.br][2])

---

## 4) Dicionário de variáveis (PCDaS)

A PCDaS disponibiliza um **“Dicionário de variáveis” do CNES** (como o índice expõe os campos). Esse dicionário pode **diferir em nomes/códigos** do layout bruto do CNES, pois reflete a **camada de padronização** da PCDaS para consulta. Para análises que exijam reprodutibilidade “bit a bit” com o bruto, **compare** sempre com os **cadernos de layout oficiais do CNES**. ([pcdas.icict.fiocruz.br][1])

---

## 5) Acesso aos dados (como consultar)

* **Tutorial oficial (R)**: a PCDaS oferece um **tutorial CNES** mostrando **como consultar o índice no Elasticsearch** (via R). O tutorial reforça que os dados “estão em um índice ES, atualizado mensalmente”. ([pcdas.icict.fiocruz.br][6])
* **Conexão PCDaS (R)**: o pacote **`pcdasindi`** (R) documenta a função `pcdas_connect()` para estabelecer conexão ao ES da PCDaS (credenciais obtidas na própria plataforma da Fiocruz). ([rdrr.io][7])

> Dica: combine **filtros por CNES**, **UF/município (IBGE 6)** e **competência (AAAAMM)** quando presentes, para recortes estáveis no tempo/território.

---

## 6) Integrações e chaves

* **`CNES`** (7 dígitos): identifica estabelecimentos e permite cruzar com produção (SIH/SIA) e infraestrutura (leitos, equipamentos) nas bases DATASUS.
* **`CODUFMUN`/IBGE (6 dígitos)**: integração territorial (município).
* **`COMPETENCIA`** (AAAAMM): temporalidade mensal.
  As integrações e chaves seguem a prática CNES/DATASUS; layouts oficiais no portal do CNES. ([CNES][5])

---

## 7) Limitações e cuidados

* **ETL parcial publicado**: a PCDaS descreve o **macroprocesso** (ETL e índice ES), mas **não** detalha transformações campo a campo; para auditoria fina, mantenha rastreabilidade para os **layouts oficiais CNES**. ([pcdas.icict.fiocruz.br][1])
* **Atualidade**: mesmo com rotina mensal, valide **qual competência** está indexada no momento (consulte notícias/avisos ou o próprio índice). ([pcdas.icict.fiocruz.br][4])
* **Diferenças de nomenclatura**: o **dicionário PCDaS** pode divergir do bruto; documente mapeamentos caso precise reprocessar a partir do **FTP do DATASUS**. ([pcdas.icict.fiocruz.br][1])

---

## 8) Reprodutibilidade (boas práticas)

1. **Fixe a data de extração** e a **competência** analisada.
2. **Salve a consulta** (query ES) e a **versão dos pacotes** usados (R/Python).
3. **Guarde o dicionário** (snapshot) referenciado, com **link e data de acesso**. ([pcdas.icict.fiocruz.br][1])

---

## 9) Exemplo de consulta (R, esqueleto)

> Exemplo orientativo (adapte conforme o tutorial PCDaS e sua autenticação ao ES).

```r
# instalar/usar pacotes recomendados no tutorial
# install.packages("elastic")  # pacote base para ES
library(elastic)

# 1) Conexão ao cluster ES da PCDaS (credenciais conforme instruções da plataforma)
# (Exemplo genérico; use host, user e pwd fornecidos pela PCDaS)
conn <- connect(
  host = "SEU_HOST_ES",
  port = 9200,
  user = "SEU_USUARIO",
  pwd  = "SUA_SENHA",
  transport_schema = "https"
)

# 2) Nome do índice (conforme documentação PCDaS do CNES)
idx <- "pcdas-cnes"  # ilustrativo; ver página/tutorias para o nome exato do índice

# 3) Consulta simples: por município (IBGE) e competência
qry <- list(
  query = list(
    bool = list(
      must = list(
        list(term = list(codufmun = "410940")),  # Londrina/PR (exemplo IBGE 6 sem dígito verificador)
        list(term = list(competencia = "202507"))
      )
    )
  ),
  size = 1000
)

res <- Search(conn, index = idx, body = qry)
# res$hits$hits contém os documentos; use purrr/jsonlite para organizar em data.frame
```

* Estrutura e abordagem compatíveis com o **tutorial da PCDaS** para R/Elasticsearch (ajuste nomes de campos segundo o **dicionário PCDaS** do CNES). ([pcdas.icict.fiocruz.br][6])

---

## 10) Referências oficiais (links úteis)

* **PCDaS — CNES (Conjunto de dados + Documentação ETL + Dicionário)**: página do dataset, com links para documentação e dicionário. ([pcdas.icict.fiocruz.br][1])
* **PCDaS — Tutorial CNES (R + Elasticsearch)**: notebook/tutorial em HTML no site (mostra acesso ao índice e atualização mensal). ([pcdas.icict.fiocruz.br][6])
* **PCDaS — Catálogo de conjuntos de dados** (visão geral): lista de grupos e coleções (inclui CNES). ([pcdas.icict.fiocruz.br][8])
* **R — `pcdasindi::pcdas_connect()`** (doc pública): função para conexão ao ES da PCDaS (credenciais informadas pela plataforma). ([rdrr.io][7])
* **CNES — Portal oficial (documentação e layouts)**: cadernos de layout, glossários, documentação do CNES. ([CNES][5])

---

## 11) Apêndice — relação com o bruto (DATASUS/CNES)

Para replicar localmente um pipeline semelhante ao da PCDaS (opcional):

1. **Coleta** no **FTP do DATASUS** (CNES por grupos/UF/competência; arquivos **.dbc**).
2. **Conversão** **DBC → DBF → Parquet** e padronização de chaves (`CNES`, `CODUFMUN`/IBGE, `COMPETENCIA`).
3. **Curadoria** (aplicar dicionários oficiais CNES e domínios; checar duplicidades por competência).
4. **Indexação** em mecanismo de busca (ES) ou **data warehouse** para consumo.
5. **Mapeamento** de nomes/códigos para o **dicionário PCDaS**, quando necessário para reproduzir análises que combinem ambos. (Layouts oficiais: ver portal CNES). ([CNES][5])

---

### Notas finais

* Onde o conteúdo **não** estava explícito na página da PCDaS (ex.: caminhos de origem no FTP, nomes exatos de índices, transformações campo a campo), marquei como **“Não informado”** e apontei as fontes oficiais adequadas para suprir a lacuna (layouts CNES; tutorial PCDaS).

---

**FIM**

[1]: https://pcdas.icict.fiocruz.br/conjunto-de-dados/cadastro-nacional-de-estabelecimentos-de-saude/?utm_source=chatgpt.com "Cadastro Nacional de Estabelecimentos de Saúde – CNES | PCDaS"
[2]: https://pcdas.icict.fiocruz.br/tutoriais/tutorial-cnes/?utm_source=chatgpt.com "Cadastro Nacional de Estabelecimentos de Saúde – CNES | PCDaS"
[3]: https://estabelecimentos.datasus.gov.br/pages/sobre/institucional.jsp?utm_source=chatgpt.com "Cadastro Nacional de Estabelecimentos de Saúde - DATASUS"
[4]: https://pcdas.icict.fiocruz.br/grupo/estabelecimentos-de-saude/?utm_source=chatgpt.com "Estabelecimentos de Saúde | Grupos | PCDaS"
[5]: https://cnes.datasus.gov.br/pages/downloads/documentacao.jsp?utm_source=chatgpt.com "Cadastro Nacional de Estabelecimentos de Saúde - DATASUS"
[6]: https://pcdas.icict.fiocruz.br/wp-content/uploads/2021/11/Tutorial_CNES.html?utm_source=chatgpt.com "Tutorial_CNES - Oswaldo Cruz Foundation"
[7]: https://rdrr.io/github/bigdata-icict/pcdasindi/man/pcdas_connect.html?utm_source=chatgpt.com "pcdas_connect: Creates a connection to the PCDaS ElasticSearch cluster ..."
[8]: https://pcdas.icict.fiocruz.br/conjunto-de-dados/?utm_source=chatgpt.com "Conjuntos de Dados | PCDaS"
