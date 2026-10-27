CREATE TABLE CLUBE (
    id_clube SERIAL,
    nome VARCHAR(100) NOT NULL,
    sigla VARCHAR(15) NOT NULL,
    cidade VARCHAR(60) NOT NULL,
    estado CHAR(2) NOT NULL,
    CONSTRAINT pk_clube PRIMARY KEY (id_clube),
    CONSTRAINT uk_clube_sigla UNIQUE (sigla)
);

CREATE TABLE CATEGORIA (
    id_categoria SERIAL,
    nome VARCHAR(40) NOT NULL,
    idade_minima INT NOT NULL,
    idade_maxima INT NOT NULL,
    CONSTRAINT pk_categoria PRIMARY KEY (id_categoria),
    CONSTRAINT uk_categoria_nome UNIQUE (nome),
    CONSTRAINT chk_faixa_etaria CHECK (idade_minima <= idade_maxima)
);

CREATE TABLE ETAPA (
    id_etapa SERIAL,
    numero_etapa INT NOT NULL,
    nome VARCHAR(60) NOT NULL,
    data_etapa DATE NOT NULL,
    horario_inicio TIME NOT NULL,
    CONSTRAINT pk_etapa PRIMARY KEY (id_etapa),
    CONSTRAINT uk_numero_etapa UNIQUE (numero_etapa)
);

CREATE TABLE ATLETA (
    id_atleta SERIAL,
    nome VARCHAR(100) NOT NULL,
    data_nascimento DATE NOT NULL,
    sexo VARCHAR(1) NOT NULL,
    id_clube INT NOT NULL,
    CONSTRAINT pk_atleta PRIMARY KEY (id_atleta),
    CONSTRAINT chk_atleta_sexo CHECK (sexo IN ('M', 'F')),
    CONSTRAINT fk_atleta_clube FOREIGN KEY (id_clube) 
        REFERENCES CLUBE(id_clube)
        ON UPDATE CASCADE 
        ON DELETE RESTRICT
);

CREATE TABLE PROVA (
    id_prova SERIAL,
    numero_prova INT NOT NULL,
    distancia INT NOT NULL,
    estilo VARCHAR(30) NOT NULL,
    sexo VARCHAR(10) NOT NULL,
    id_categoria INT NOT NULL,
    id_etapa INT NOT NULL,
    CONSTRAINT pk_prova PRIMARY KEY (id_prova),
    CONSTRAINT uk_numero_prova UNIQUE (numero_prova),
    CONSTRAINT chk_prova_sexo CHECK (sexo IN ('M', 'F', 'Misto')),
    CONSTRAINT fk_prova_categoria FOREIGN KEY (id_categoria) 
        REFERENCES CATEGORIA(id_categoria)
        ON UPDATE CASCADE 
        ON DELETE RESTRICT,
    CONSTRAINT fk_prova_etapa FOREIGN KEY (id_etapa) 
        REFERENCES ETAPA(id_etapa)
        ON UPDATE CASCADE 
        ON DELETE RESTRICT,
    CONSTRAINT chk_distancia CHECK (distancia > 0)
);

CREATE TABLE RESULTADO (
    id_resultado SERIAL,
    id_prova INT NOT NULL,
    id_atleta INT NOT NULL,
    tempo_obtido TIME NULL,
    colocacao INT NULL,
    pontuacao DECIMAL(5,2) DEFAULT 0.00,
    situacao VARCHAR(30) NOT NULL DEFAULT 'Confirmado',
    numero_serie INT NOT NULL,
    numero_raia INT NOT NULL,
    CONSTRAINT pk_resultado PRIMARY KEY (id_resultado),
    CONSTRAINT uk_prova_atleta UNIQUE (id_prova, id_atleta),
    CONSTRAINT fk_resultado_prova FOREIGN KEY (id_prova) 
        REFERENCES PROVA(id_prova)
        ON UPDATE CASCADE 
        ON DELETE CASCADE,
    CONSTRAINT fk_resultado_atleta FOREIGN KEY (id_atleta) 
        REFERENCES ATLETA(id_atleta)
        ON UPDATE CASCADE 
        ON DELETE RESTRICT
);