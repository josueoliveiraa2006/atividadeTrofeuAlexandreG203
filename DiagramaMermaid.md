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