CREATE DATABASE FarmLogic;
GO

USE FarmLogic;
GO

-- ==========================
-- FAZENDA
-- ==========================
CREATE TABLE Fazenda(
    Id INT PRIMARY KEY IDENTITY(1,1),
    nome VARCHAR(255) NOT NULL,
    localizacao VARCHAR(255) NOT NULL,
    hectares DECIMAL(10,2)
);

-- ==========================
-- TALHÃO
-- ==========================
CREATE TABLE Talhao(
    id INT PRIMARY KEY IDENTITY(1,1),
    id_fazenda INT,
    nome VARCHAR(50) NOT NULL,
    area DECIMAL(10,2),
    tipo_solo VARCHAR(50),

    FOREIGN KEY (id_fazenda) REFERENCES Fazenda(Id)
);

-- ==========================
-- CULTURA
-- ==========================
CREATE TABLE Cultura(
    id INT PRIMARY KEY IDENTITY(1,1),
    nome VARCHAR(50) NOT NULL,
    ciclo_dias INT,
    produtividade_media DECIMAL(10,2)
);

-- ==========================
-- PLANTIO
-- ==========================
CREATE TABLE Plantio(
    id INT PRIMARY KEY IDENTITY(1,1),
    data_plantio DATE,
    Id_talhao INT,
    Id_cultura INT,
    estimativa_colheita DATE,

    FOREIGN KEY (Id_talhao) REFERENCES Talhao(id),
    FOREIGN KEY (Id_cultura) REFERENCES Cultura(id)
);

-- ==========================
-- MONITORAMENTO SATÉLITE
-- ==========================
CREATE TABLE Monitoramento_satelite(
    Id INT PRIMARY KEY IDENTITY(1,1),
    Id_talhao INT,
    data_colheita DATE,
    indice_ndvi DECIMAL(5,2),
    umidade DECIMAL(5,2),
    temperatura DECIMAL(5,2),
    risco_climatico VARCHAR(50),

    FOREIGN KEY (Id_talhao) REFERENCES Talhao(id)
);

-- ==========================
-- PREVISÃO DO TEMPO
-- ==========================
CREATE TABLE Previsao_tempo(
    Id INT PRIMARY KEY IDENTITY(1,1),
    id_talhao INT,
    data_previsao DATE,
    temperatura_max DECIMAL(5,2),
    temperatura_min DECIMAL(5,2),
    chuva_mm DECIMAL(5,2),
    probabilidade_chuva DECIMAL(5,2),

    FOREIGN KEY (id_talhao) REFERENCES Talhao(id)
);

-- ==========================
-- SOLO
-- ==========================
CREATE TABLE Solo(
    Id INT PRIMARY KEY IDENTITY(1,1),
    Id_talhao INT,
    data_analise DATE,
    ph DECIMAL(4,2),
    nitrogenio DECIMAL(8,2),
    fosforo DECIMAL(8,2),
    potassio DECIMAL(8,2),
    recomendacao TEXT,

    FOREIGN KEY (Id_talhao) REFERENCES Talhao(id)
);

-- ==========================
-- DEFENSIVOS
-- ==========================
CREATE TABLE Defensivos(
    Id INT PRIMARY KEY IDENTITY(1,1),
    nome VARCHAR(255),
    tipo VARCHAR(50),
    dose_recomendada DECIMAL(10,2)
);

-- ==========================
-- APLICAÇÃO
-- ==========================
CREATE TABLE Aplicacao_defensivos(
    Id INT PRIMARY KEY IDENTITY(1,1),
    Id_plantio INT,
    Id_defensivos INT,
    data_aplicacao DATE,
    quantidade_aplicada DECIMAL(10,2),

    FOREIGN KEY (Id_plantio) REFERENCES Plantio(id),
    FOREIGN KEY (Id_defensivos) REFERENCES Defensivos(Id)
);

-- ==========================
-- ESTIMATIVA DE COLHEITA
-- ==========================
CREATE TABLE Estimativa_colheita(
    Id INT PRIMARY KEY IDENTITY(1,1),
    Id_plantio INT,
    data_estimativa DATE,
    produtividade_estimada DECIMAL(10,2),
    probabilidade_sucesso DECIMAL(5,2),
    data_prevista_colheita DATE,

    FOREIGN KEY (Id_plantio) REFERENCES Plantio(id)
);

-- ==========================
-- COLHEITA REAL
-- ==========================
CREATE TABLE Colheita_real(
    Id INT PRIMARY KEY IDENTITY(1,1),
    Id_plantio INT,
    data_colheita DATE,
    quantidade_real DECIMAL(10,2),
    qualidade_graos VARCHAR(50),

    FOREIGN KEY (Id_plantio) REFERENCES Plantio(id)
);