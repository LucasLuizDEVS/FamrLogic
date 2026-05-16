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



-- ==========================
--INSERT
-- ==========================
INSERT INTO Fazenda (nome, localizacao, hectares)
VALUES
('Fazenda Novo Horizonte', 'Uberlândia - MG', 450),
('Fazenda Luiz', 'patrocínio - MG', 400),
('Fazenda Letreiro', 'Uberlândia - MG', 450),
('Fazenda Boa Vista', 'Goiania - GO', 600),
('Fazenda talismã', 'Jussara - GO', 800),
('Fazenda Terra Prometida', 'Palmas - TO', 670),
('Fazenda Embaixador', 'Alta Floresta - MT', 590);

INSERT INTO Talhao (id_fazenda, nome, area, tipo_solo)
VALUES
(2, 'Talhão Sul', 150.00, 'Latossolo Vermelho-Amarelo'),
(2, 'Talhão Leste', 100.00, 'Latossolo Vermelho-Amarelo'),
(2, 'Talhão Norte', 100.00, 'Latossolo Vermelho-Amarelo'),
(2, 'Talhão Oeste', 100.00, 'Latossolo Vermelho-Amarelo'),
--===========================
--FAZENDA LUIZ
(3, 'Talhão Sul', 100.00, 'Latossolo Vermelho-Amarelo'),
(3, 'Talhão Norte', 50.00, 'Latossolo Vermelho'),
(3, 'Talhão Nordeste', 50.00, 'Latossolo Vermelho'),
(3, 'Talhão Central', 70.00, 'Latossolo Vermelho'),
(3, 'Talhão Leste', 65.00, 'Latossolo Vermelho-Amarelo'),
(3, 'Talhão Oeste', 65.00, 'Latossolo Vermelho-Amarelo'),
--===========================
--FAZENDA LETREIRO
(4, 'Talhão Norte', 100.00, 'Latossolo Vermelho'),
(4, 'Talhão leste', 100.00, 'Latossolo Vermelho'),
(4, 'Talhão Sul', 100.00, 'Latossolo Vermelho-Amarelo'),
(4, 'Talhão oeste', 100.00, 'Latossolo Vermelho-Amarelo'),
--===========================
--FAZENDA BOA VISTA 
(5, 'Talhão Sul', 100.00, 'Latossolo Vermelho-Amarelo'),
(5, 'Talhão Suldeste', 150.00, 'Latossolo Vermelho-Amarelo'),
(5, 'Talhão Norte', 150.00, 'Latossolo Vermelho-Amarelo'),
(5, 'Talhão Oeste', 100.00, 'Latossolo Vermelho-Amarelo'),
(5, 'Talhão Central', 100.00, 'Latossolo Vermelho-Amarelo'),
--===========================
--FAZENDA TALISMÃ
(6, 'Talhão Sul', 200.00, 'Latossolo Vermelho'),
(6, 'Talhão Norte', 200.00, 'Latossolo Vermelho'),
(6, 'Talhão Leste', 200.00, 'Latossolo Vermelho'),
(6, 'Talhão Oeste', 200.00, 'Latossolo Vermelho'),
--===========================
--FAZENDA TERRA PROMETIDA
(7, 'Talhão Sul', 150.00, 'Neossolos Quartzarenicos'),
(7, 'Talhão Norte', 150.00, 'Neossolos Quartzarenicoso'),
(7, 'Talhão Leste', 150.00, 'Neossolos Quartzarenicos'),
(7, 'Talhão Oeste', 150.00, 'Neossolos Quartzarenicos'),
(7, 'Talhão Central', 70.00, 'Neossolos Quartzarenicos'),
--===========================
--FAZENDA EMBAIXADOR
(8, 'Talhão Sul', 150.00, 'Argissolo Vermelho-Amarelo'),
(8, 'Talhão Norte', 150.00, 'Argissolo Vermelho-Amarelo'),
(8, 'Talhão Leste', 150.00, 'Argissolo Vermelho-Amarelo'),
(8, 'Talhão Oeste', 140.00, 'Argissolo Vermelho-Amareloo');


--======================
--SELECT TABLE FAZENDA
SELECT *
FROM Fazenda;
--======================
--SELECT TABLE TALHÃO
SELECT *
FROM Talhao;



--=====================
--UPDATE FAZENDA
UPDATE Fazenda
SET nome = 'Fazenda Talismã'
WHERE id =6;
