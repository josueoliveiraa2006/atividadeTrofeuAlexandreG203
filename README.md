# 29º Troféu Alexandre Pussieldi 2025: Modelagem e Consultas

Modelo de dados relacional e consultas estatísticas para o **29º Troféu Alexandre Pussieldi 2025**, competição de natação das categorias de base (**Pré-Mirim** e **Mirim**) cujos resultados oficiais são publicados no sistema **FASE Aquática**.

O banco foi implementado em **PostgreSQL** e as consultas foram executadas no **pgAdmin**.

---

## Sumário

- [Estrutura do repositório](#estrutura-do-repositório)
- [Questão 1: Modelagem de dados (Mermaid)](#questão-1-modelagem-de-dados-mermaid)
- [Questão 2: O desafio do "prompt inverso"](#questão-2-o-desafio-do-prompt-inverso)
- [Como executar](#como-executar)
- [Regras de negócio](#regras-de-negócio)
- [Equipe](#equipe)

---

## Estrutura do repositório

| Arquivo | Conteúdo |
|---|---|
| [DiagramaMermaid.md](DiagramaMermaid.md) | Diagrama Entidade-Relacionamento em sintaxe Mermaid |
| [createTableAll.sql](createTableAll.sql) | Criação das 6 tabelas, com PK, FK, UK e `CHECK` |
| [populacaoBanco.sql](populacaoBanco.sql) | Carga de teste (clubes, categorias, etapas, atletas, provas e resultados) |
| [sp_quatro_de_migalhas.md](sp_quatro_de_migalhas.md) | Quadro de medalhas: log com a IA, correções e código final |
| [sp_atlas_e_cubos.md](sp_atlas_e_cubos.md) | Desempenho por equipe: log com a IA, correções e código final |

---

## Questão 1: Modelagem de dados (Mermaid)

A partir da análise do site do evento na FASE Aquática, o domínio foi dividido em seis entidades:

| Entidade | Descrição |
|---|---|
| **CLUBE** | Equipe à qual o atleta é filiado (nome, sigla, cidade, UF) |
| **CATEGORIA** | Faixa etária da competição (Pré-Mirim, Mirim), com idade mínima e máxima |
| **ETAPA** | Sessão da competição (dia, turno e horário de início) |
| **ATLETA** | Nadador inscrito, com data de nascimento, sexo e clube |
| **PROVA** | Evento disputado (número, distância, estilo, sexo, categoria e etapa) |
| **RESULTADO** | Participação de um atleta em uma prova (tempo, colocação, pontos, situação, série e raia) |

### Diagrama ER

> Diagrama editável no Mermaid: [abrir no mermaid.ai](https://mermaid.ai/app/projects/0df0bf7b-5765-475f-a83e-c23ddaddd173/diagrams/264ab31a-13da-497f-849b-d577de8d7ce9/share/invite/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkb2N1bWVudElEIjoiMjY0YWIzMWEtMTNkYS00OTdmLTg0OWItZDU3N2RlOGQ3Y2U5IiwiYWNjZXNzIjoiRWRpdCIsInB1cnBvc2UiOiJzaGFyZS1pbnZpdGUiLCJpYXQiOjE3OTMwNjUzOTQsImV4cCI6MTc5NTY1NzM5NH0.HnVl7XFsGEtJvP-pEUaLA0cfnsFnPJ7zWBGa8kELAyM?entryPoint=share-modal)

<!-- Imagem do diagrama: substituir o caminho abaixo pelo arquivo exportado -->
<!-- ![Diagrama ER](imagens/diagrama-er.png) -->

```mermaid
erDiagram
    CLUBE {
        serial  id_clube  PK
        varchar nome      "100, NOT NULL"
        varchar sigla     UK "15, NOT NULL"
        varchar cidade    "60, NOT NULL"
        char    estado    "2, NOT NULL"
    }

    CATEGORIA {
        serial  id_categoria PK
        varchar nome         UK "40, NOT NULL"
        int     idade_minima "NOT NULL, <= idade_maxima"
        int     idade_maxima "NOT NULL"
    }

    ETAPA {
        serial  id_etapa       PK
        int     numero_etapa   UK "NOT NULL"
        varchar nome           "60, NOT NULL"
        date    data_etapa     "NOT NULL"
        time    horario_inicio "NOT NULL"
    }

    ATLETA {
        serial  id_atleta       PK
        varchar nome            "100, NOT NULL"
        date    data_nascimento "NOT NULL"
        varchar sexo            "M ou F"
        int     id_clube        FK "NOT NULL"
    }

    PROVA {
        serial  id_prova     PK
        int     numero_prova UK "NOT NULL"
        int     distancia    "NOT NULL, > 0"
        varchar estilo       "30, NOT NULL"
        varchar sexo         "M, F ou Misto"
        int     id_categoria FK "NOT NULL"
        int     id_etapa     FK "NOT NULL"
    }

    RESULTADO {
        serial  id_resultado PK
        int     id_prova     FK "UK com id_atleta"
        int     id_atleta    FK "UK com id_prova"
        time    tempo_obtido "NULL"
        int     colocacao    "NULL"
        decimal pontuacao    "5,2 DEFAULT 0.00"
        varchar situacao     "30, DEFAULT Confirmado"
        int     numero_serie "NOT NULL"
        int     numero_raia  "NOT NULL"
    }

    CLUBE     ||..o{ ATLETA    : "possui"
    CATEGORIA ||..o{ PROVA     : "classifica"
    ETAPA     ||..o{ PROVA     : "agenda"
    PROVA     ||--o{ RESULTADO : "registra"
    ATLETA    ||--o{ RESULTADO : "obtém"
```

### Relacionamentos e cardinalidades

| Relacionamento | Cardinalidade | Linha | Justificativa |
|---|---|---|---|
| CLUBE → ATLETA | 1 : 0..N | tracejada (`..`), não identificador | Um clube pode ter vários atletas (ou nenhum inscrito). O atleta tem identidade própria (`id_atleta`); o clube é só um atributo dele. |
| CATEGORIA → PROVA | 1 : 0..N | tracejada (`..`), não identificador | Cada prova pertence a uma única categoria. A prova é identificada pelo próprio número. |
| ETAPA → PROVA | 1 : 0..N | tracejada (`..`), não identificador | Cada prova é disputada em uma etapa (sessão). |
| PROVA → RESULTADO | 1 : 0..N | sólida (`--`), identificador | O resultado só existe dentro de uma prova; a FK compõe a chave única `(id_prova, id_atleta)`. |
| ATLETA → RESULTADO | 1 : 0..N | sólida (`--`), identificador | O resultado só existe para um atleta; a FK compõe a mesma chave única. |

### Decisões de modelagem

- **RESULTADO como entidade associativa** entre PROVA e ATLETA (relação N:N). A restrição `UNIQUE (id_prova, id_atleta)` impede que um atleta tenha dois resultados na mesma prova.
- **Faixa etária guardada em CATEGORIA** (`idade_minima`, `idade_maxima`) em vez de fixa no código. Se a regra mudar, basta alterar um registro.
- **Data de nascimento em vez de idade**: a idade muda com o tempo; a categoria é calculada pelo **ano** de nascimento em relação ao ano do evento.
- **Medalha não é coluna**: ela é derivada de `colocacao` (1 = ouro, 2 = prata, 3 = bronze), o que evita dado redundante.
- **`tempo_obtido` e `colocacao` aceitam `NULL`** para representar atletas que não compareceram ou foram desclassificados; `situacao` registra o motivo.
- **`sexo` da prova aceita `Misto`**, prevendo revezamentos mistos, enquanto o atleta só pode ser `M` ou `F`.
- **Integridade referencial**: `ON DELETE RESTRICT` nas FKs de cadastro (não se apaga um clube com atletas) e `ON DELETE CASCADE` em `RESULTADO.id_prova` (apagar uma prova remove seus resultados).

---

## Questão 2: O desafio do "prompt inverso"

As duas consultas foram geradas inicialmente com IA e depois corrigidas. Como o PostgreSQL não permite que uma `PROCEDURE` devolva linhas, ambas foram implementadas como `FUNCTION ... RETURNS TABLE`, mantendo o prefixo `sp_` pedido no enunciado.

| Consulta | Objetivo | Documentação completa |
|---|---|---|
| `sp_quatro_de_migalhas` | Quadro de medalhas por clube e categoria (ouro, prata, bronze, total e posição) | [sp_quatro_de_migalhas.md](sp_quatro_de_migalhas.md) |
| `sp_atlas_e_cubos` | Desempenho por clube e categoria (atletas, provas, pódios, melhor e média de colocação) | [sp_atlas_e_cubos.md](sp_atlas_e_cubos.md) |

Cada documento contém o log da conversa com a IA, a versão gerada com erros, a tabela de correções, o código final comentado e o espaço para os prints da execução.

### Principais alucinações corrigidas

| Erro da IA | Correção aplicada |
|---|---|
| **Faixas etárias inventadas** (Pré-Mirim até 8; Mirim 9–10 ou 9–12) | Pré-Mirim **até 9 anos** e Mirim **10 a 11 anos**, lidas da tabela `CATEGORIA` |
| Idade calculada com `CURRENT_DATE` ou com o ano atual | Idade pelo ano do evento (2025) ou categoria tirada de `PROVA.id_categoria` |
| Código em T-SQL (SQL Server): `SET NOCOUNT ON`, `EXEC`, `GO` | Reescrito em PL/pgSQL / SQL para PostgreSQL |
| Colunas inexistentes (`ano_nascimento`, `idade_min`, `idade_max`) | Nomes reais do modelo (`data_nascimento`, `idade_minima`, `idade_maxima`) |
| Total de medalhas com `colocacao <= 4` | Apenas `colocacao IN (1, 2, 3)` |
| Pódio com `colocacao < 3` (bronze ficava de fora) | `colocacao BETWEEN 1 AND 3` |
| Quadro ordenado pelo total de medalhas | Critério olímpico com `RANK()`: ouro, depois prata, depois bronze |
| `COUNT` sem `DISTINCT` e `COALESCE(colocacao, 0)` na média | `COUNT(DISTINCT ...)` e `AVG` ignorando `NULL` |

---

## Como executar

> **Onde está o banco:** todo o banco (tabelas, carga de dados e funções) foi criado no database **G213** do servidor PostgreSQL da faculdade, no usuário `aluno33`. Mesmo sendo o grupo **G3**, usamos o G213 porque não conseguimos fazer login no database do nosso grupo.

Pré-requisitos: PostgreSQL e um cliente SQL (pgAdmin, DBeaver ou `psql`).

1. Crie um banco de dados vazio, por exemplo `trofeu_pussieldi`.
2. Execute [createTableAll.sql](createTableAll.sql) para criar as tabelas.
3. Execute [populacaoBanco.sql](populacaoBanco.sql) para carregar os dados de teste.
4. Copie o bloco `CREATE OR REPLACE FUNCTION` do código final de cada documento ([sp_quatro_de_migalhas.md](sp_quatro_de_migalhas.md) e [sp_atlas_e_cubos.md](sp_atlas_e_cubos.md)) e execute-o.
5. Rode as consultas:

```sql
-- Quadro de medalhas (todas as categorias ou filtrado)
SELECT * FROM sp_quatro_de_migalhas();
SELECT * FROM sp_quatro_de_migalhas('Pré-Mirim');
SELECT * FROM sp_quatro_de_migalhas('Mirim');

-- Desempenho por equipe
SELECT * FROM sp_atlas_e_cubos(2025);
```

Com `psql`, os passos 2 e 3 ficam assim:

```bash
psql -d trofeu_pussieldi -f createTableAll.sql
psql -d trofeu_pussieldi -f populacaoBanco.sql
```

### Dados de teste

A carga em [populacaoBanco.sql](populacaoBanco.sql) segue a estrutura do evento, mas **atletas, tempos e datas são fictícios**:

| Tabela | Registros |
|---|---|
| CLUBE | 6 clubes de Sergipe |
| CATEGORIA | 2 (Pré-Mirim e Mirim) |
| ETAPA | 4 etapas em 2 dias (28 e 29/03/2025) |
| ATLETA | 40 (10 por categoria e sexo) |
| PROVA | 16 (25 m no Pré-Mirim, 50 m no Mirim; livre, costas, peito e borboleta; feminino e masculino) |
| RESULTADO | 147, incluindo 9 desclassificações e 5 não comparecimentos |

Pontuação por prova: 1º = 9, 2º = 7, 3º = 6, 4º = 5, 5º = 4, 6º = 3, 7º = 2, 8º = 1.

O final do script traz consultas de conferência comentadas, como a que verifica se algum atleta está fora da faixa etária ou do sexo da prova (deve retornar 0 linhas).

---

## Regras de negócio

- **Pré-Mirim:** até 9 anos (nascidos em 2016 e 2017).
- **Mirim:** 10 e 11 anos (nascidos em 2014 e 2015).
- **Cálculo da idade:** `ano do evento - ano de nascimento`, como é praxe na natação, sem considerar o dia do aniversário.
- **Medalhas:** apenas 1º, 2º e 3º lugares. Desclassificados e ausentes ficam com `colocacao` nula e não entram no quadro.
- **Ordem do quadro de medalhas:** mais ouros; em caso de empate, mais pratas; persistindo, mais bronzes.

---

## Equipe

| Integrante | Contribuição |
|---|---|
| Josué Mateus das Chagas Oliveira | Script de criação das tabelas ([createTableAll.sql](createTableAll.sql)) |
| Thallis | Carga de dados de teste ([populacaoBanco.sql](populacaoBanco.sql)) |
| Théo | `sp_quatro_de_migalhas` |
| Ana Karoline Lopes Leite (Karol) | `sp_atlas_e_cubos` |
