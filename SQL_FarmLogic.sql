IF DB_ID('FarmLogic') IS NOT NULL
BEGIN
    ALTER DATABASE FarmLogic SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE FarmLogic;
END;

CREATE DATABASE FarmLogic;

USE FarmLogic;

CREATE TABLE Fazenda (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    nome NVARCHAR(255) NOT NULL,
    localizacao NVARCHAR(255) NOT NULL,
    hectares DECIMAL(10,2)
);

CREATE TABLE Talhao (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Id_fazenda INT NOT NULL,
    nome NVARCHAR(50) NOT NULL,
    area DECIMAL(10,2),
    tipo_solo NVARCHAR(100),
    FOREIGN KEY (Id_fazenda) REFERENCES Fazenda(Id)
);

CREATE TABLE Cultura (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Id_fazenda INT NOT NULL,
    nome NVARCHAR(50) NOT NULL,
    ciclo_dias INT,
    produtividade_media DECIMAL(10,2),
    FOREIGN KEY (Id_fazenda) REFERENCES Fazenda(Id)
);

CREATE TABLE Plantio (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    data_plantio DATE,
    Id_talhao INT NOT NULL,
    Id_cultura INT NOT NULL,
    estimativa_colheita DATE,
    FOREIGN KEY (Id_talhao) REFERENCES Talhao(Id),
    FOREIGN KEY (Id_cultura) REFERENCES Cultura(Id)
);

CREATE TABLE Monitoramento_satelite (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Id_talhao INT NOT NULL,
    data_colheita DATE,
    indice_ndvi DECIMAL(5,2),
    umidade DECIMAL(5,2),
    temperatura DECIMAL(5,2),
    risco_climatico NVARCHAR(50),
    FOREIGN KEY (Id_talhao) REFERENCES Talhao(Id)
);

CREATE TABLE Previsao_tempo (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Id_talhao INT NOT NULL,
    data_previsao DATE,
    temperatura_max DECIMAL(5,2),
    temperatura_min DECIMAL(5,2),
    chuva_mm DECIMAL(5,2),
    probabilidade_chuva DECIMAL(5,2),
    FOREIGN KEY (Id_talhao) REFERENCES Talhao(Id)
);

CREATE TABLE Solo (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Id_talhao INT NOT NULL,
    data_analise DATE,
    ph DECIMAL(4,2),
    nitrogenio DECIMAL(8,2),
    fosforo DECIMAL(8,2),
    potassio DECIMAL(8,2),
    recomendacao NVARCHAR(MAX),
    FOREIGN KEY (Id_talhao) REFERENCES Talhao(Id)
);

CREATE TABLE Defensivos (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    nome NVARCHAR(255),
    tipo NVARCHAR(50),
    dose_recomendada DECIMAL(10,2)
);

CREATE TABLE Aplicacao_defensivos (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Id_plantio INT NOT NULL,
    Id_defensivos INT NOT NULL,
    data_aplicacao DATE,
    quantidade_aplicada DECIMAL(10,2),
    FOREIGN KEY (Id_plantio) REFERENCES Plantio(Id),
    FOREIGN KEY (Id_defensivos) REFERENCES Defensivos(Id)
);

CREATE TABLE Estimativa_colheita (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Id_plantio INT NOT NULL,
    data_estimativa DATE,
    produtividade_estimada DECIMAL(10,2),
    probabilidade_sucesso DECIMAL(5,2),
    data_prevista_colheita DATE,
    FOREIGN KEY (Id_plantio) REFERENCES Plantio(Id)
);

CREATE TABLE Colheita_real (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Id_plantio INT NOT NULL,
    data_colheita DATE,
    quantidade_real DECIMAL(10,2),
    qualidade_graos NVARCHAR(50),
    FOREIGN KEY (Id_plantio) REFERENCES Plantio(Id)
);

INSERT INTO Fazenda (nome, localizacao, hectares)
VALUES
('Fazenda Novo Horizonte', 'Uberlândia - MG', 450),
('Fazenda Luiz', 'Patrocínio - MG', 400),
('Fazenda Letreiro', 'Uberlândia - MG', 450),
('Fazenda Boa Vista', 'Goiânia - GO', 600),
('Fazenda Talismã', 'Jussara - GO', 800),
('Fazenda Terra Prometida', 'Palmas - TO', 670),
('Fazenda Embaixador', 'Alta Floresta - MT', 590);

INSERT INTO Talhao (Id_fazenda, nome, area, tipo_solo)
VALUES
(1, 'Talhão Sul', 150.00, 'Latossolo Vermelho-Amarelo'),
(1, 'Talhão Leste', 100.00, 'Latossolo Vermelho-Amarelo'),
(1, 'Talhão Norte', 100.00, 'Latossolo Vermelho-Amarelo'),
(1, 'Talhão Oeste', 100.00, 'Latossolo Vermelho-Amarelo'),

(2, 'Talhão Sul', 100.00, 'Latossolo Vermelho-Amarelo'),
(2, 'Talhão Norte', 50.00, 'Latossolo Vermelho'),
(2, 'Talhão Nordeste', 50.00, 'Latossolo Vermelho'),
(2, 'Talhão Central', 70.00, 'Latossolo Vermelho'),
(2, 'Talhão Leste', 65.00, 'Latossolo Vermelho-Amarelo'),
(2, 'Talhão Oeste', 65.00, 'Latossolo Vermelho-Amarelo'),

(3, 'Talhão Norte', 100.00, 'Latossolo Vermelho'),
(3, 'Talhão Leste', 100.00, 'Latossolo Vermelho'),
(3, 'Talhão Sul', 100.00, 'Latossolo Vermelho-Amarelo'),
(3, 'Talhão Oeste', 100.00, 'Latossolo Vermelho-Amarelo'),

(4, 'Talhão Sul', 100.00, 'Latossolo Vermelho-Amarelo'),
(4, 'Talhão Sudeste', 150.00, 'Latossolo Vermelho-Amarelo'),
(4, 'Talhão Norte', 150.00, 'Latossolo Vermelho-Amarelo'),
(4, 'Talhão Oeste', 100.00, 'Latossolo Vermelho-Amarelo'),
(4, 'Talhão Central', 100.00, 'Latossolo Vermelho-Amarelo'),

(5, 'Talhão Sul', 200.00, 'Latossolo Vermelho'),
(5, 'Talhão Norte', 200.00, 'Latossolo Vermelho'),
(5, 'Talhão Leste', 200.00, 'Latossolo Vermelho'),
(5, 'Talhão Oeste', 200.00, 'Latossolo Vermelho'),

(6, 'Talhão Sul', 150.00, 'Neossolos Quartzarenicos'),
(6, 'Talhão Norte', 150.00, 'Neossolos Quartzarenicos'),
(6, 'Talhão Leste', 150.00, 'Neossolos Quartzarenicos'),
(6, 'Talhão Oeste', 150.00, 'Neossolos Quartzarenicos'),
(6, 'Talhão Central', 70.00, 'Neossolos Quartzarenicos'),

(7, 'Talhão Sul', 150.00, 'Argissolo Vermelho-Amarelo'),
(7, 'Talhão Norte', 150.00, 'Argissolo Vermelho-Amarelo'),
(7, 'Talhão Leste', 150.00, 'Argissolo Vermelho-Amarelo'),
(7, 'Talhão Oeste', 140.00, 'Argissolo Vermelho-Amarelo');

INSERT INTO Cultura (Id_fazenda, nome, ciclo_dias, produtividade_media)
VALUES
(1, 'Café', 210, 5.80),
(2, 'Café', 200, 5.50),
(3, 'Soja', 120, 3.50),
(4, 'Milho', 90, 4.90),
(5, 'Soja', 120, 3.60),
(6, 'Soja', 120, 3.50),
(7, 'Soja', 120, 3.70);

INSERT INTO Plantio (data_plantio, Id_talhao, Id_cultura, estimativa_colheita)
VALUES
('2024-01-15', 1, 1, '2024-08-12'),
('2024-01-20', 2, 1, '2024-08-18'),
('2024-02-01', 5, 2, '2024-09-30'),
('2024-02-10', 11, 3, '2024-06-10'),
('2024-02-15', 15, 4, '2024-05-15'),
('2024-02-20', 20, 5, '2024-06-20'),
('2024-02-25', 24, 6, '2024-06-30'),
('2024-03-01', 29, 7, '2024-07-01');

INSERT INTO Monitoramento_satelite 
(Id_talhao, data_colheita, indice_ndvi, umidade, temperatura, risco_climatico)
VALUES
(1, '2024-08-12', 0.75, 60.00, 25.00, 'Baixo'),
(2, '2024-08-18', 0.70, 58.00, 26.00, 'Médio'),
(5, '2024-09-30', 0.80, 65.00, 24.00, 'Baixo'),
(11, '2024-06-10', 0.65, 55.00, 28.00, 'Alto'),
(15, '2024-05-15', 0.60, 50.00, 30.00, 'Alto'),
(20, '2024-06-20', 0.78, 62.00, 27.00, 'Médio'),
(24, '2024-06-30', 0.82, 68.00, 23.00, 'Baixo'),
(29, '2024-07-01', 0.77, 63.00, 26.50, 'Médio');

INSERT INTO Previsao_tempo
(Id_talhao, data_previsao, temperatura_max, temperatura_min, chuva_mm, probabilidade_chuva)
VALUES
(1, '2024-01-10', 31.00, 20.00, 12.50, 70.00),
(5, '2024-01-25', 29.00, 19.00, 8.00, 55.00),
(11, '2024-02-05', 34.00, 22.00, 3.00, 20.00),
(15, '2024-02-10', 33.00, 21.00, 5.00, 30.00);

INSERT INTO Solo
(Id_talhao, data_analise, ph, nitrogenio, fosforo, potassio, recomendacao)
VALUES
(1, '2024-01-05', 6.20, 35.00, 18.00, 120.00, 'Solo adequado para café'),
(5, '2024-01-25', 5.80, 28.00, 15.00, 100.00, 'Aplicar correção de acidez'),
(11, '2024-02-01', 6.00, 30.00, 20.00, 110.00, 'Solo adequado para soja'),
(15, '2024-02-08', 6.50, 40.00, 25.00, 130.00, 'Solo adequado para milho');

INSERT INTO Defensivos (nome, tipo, dose_recomendada)
VALUES
('Glifosato', 'Herbicida', 2.50),
('Mancozebe', 'Fungicida', 1.80),
('Imidacloprido', 'Inseticida', 0.75);

INSERT INTO Aplicacao_defensivos
(Id_plantio, Id_defensivos, data_aplicacao, quantidade_aplicada)
VALUES
(1, 1, '2024-02-01', 2.50),
(2, 2, '2024-02-10', 1.80),
(3, 3, '2024-03-01', 0.75);

INSERT INTO Estimativa_colheita
(Id_plantio, data_estimativa, produtividade_estimada, probabilidade_sucesso, data_prevista_colheita)
VALUES
(1, '2024-05-01', 5.70, 85.00, '2024-08-12'),
(2, '2024-05-10', 5.40, 82.00, '2024-08-18'),
(3, '2024-06-01', 5.20, 80.00, '2024-09-30'),
(4, '2024-04-15', 3.50, 78.00, '2024-06-10');

INSERT INTO Colheita_real
(Id_plantio, data_colheita, quantidade_real, qualidade_graos)
VALUES
(1, '2024-08-12', 5.60, 'Alta'),
(2, '2024-08-18', 5.30, 'Alta'),
(3, '2024-09-30', 5.10, 'Média'),
(4, '2024-06-10', 3.45, 'Boa'),
(5, '2024-05-15', 4.75, 'Excelente'),
(6, '2024-06-20', 3.55, 'Boa'),
(7, '2024-06-30', 3.40, 'Excelente'),
(8, '2024-07-01', 3.60, 'Boa');

UPDATE Cultura
SET produtividade_media = 3.80
WHERE Id = 3;

DELETE FROM Defensivos
WHERE Id = 3;

EXEC('
CREATE VIEW vw_colheita AS
SELECT
    c.nome AS Cultura,
    col.quantidade_real
FROM Colheita_real col
INNER JOIN Plantio p ON col.Id_plantio = p.Id
INNER JOIN Cultura c ON p.Id_cultura = c.Id
');

EXEC('
CREATE VIEW vw_Plantios AS
SELECT
    p.Id,
    c.nome AS Cultura,
    t.nome AS Talhao,
    p.data_plantio,
    p.estimativa_colheita
FROM Plantio p
INNER JOIN Cultura c ON p.Id_cultura = c.Id
INNER JOIN Talhao t ON p.Id_talhao = t.Id
');

SELECT * FROM Fazenda;
SELECT * FROM Talhao;
SELECT * FROM Cultura;
SELECT * FROM Plantio;
SELECT * FROM Monitoramento_satelite;
SELECT * FROM Colheita_real;

SELECT
    c.nome AS Cultura,
    col.quantidade_real
FROM Colheita_real col
INNER JOIN Plantio p ON col.Id_plantio = p.Id
INNER JOIN Cultura c ON p.Id_cultura = c.Id;

SELECT Id_cultura, COUNT(*) AS quantidade
FROM Plantio
GROUP BY Id_cultura;

SELECT *
FROM Plantio
WHERE data_plantio BETWEEN '2024-01-01' AND '2024-02-29';

SELECT *
FROM Cultura
WHERE nome LIKE '%so%';

SELECT *
FROM Talhao
WHERE area > 5 AND area < 200;

SELECT *
FROM Colheita_real
WHERE quantidade_real IS NOT NULL;

SELECT
    p.Id,
    c.nome AS Cultura,
    t.nome AS Talhao
FROM Plantio p
INNER JOIN Cultura c ON p.Id_cultura = c.Id
INNER JOIN Talhao t ON p.Id_talhao = t.Id;

SELECT
    Nome,
    Tipo,
    COUNT(*) AS QTD
FROM
(
    SELECT nome, 'CULTURA' AS Tipo
    FROM Cultura

    UNION

    SELECT nome, 'DEFENSIVOS' AS Tipo
    FROM Defensivos
) AS Dados
GROUP BY Nome, Tipo;

SELECT Id_cultura, COUNT(*) AS quantidade
FROM Plantio
GROUP BY Id_cultura
HAVING COUNT(*) > 1;

SELECT *
FROM Cultura c
WHERE EXISTS (
    SELECT 1
    FROM Plantio p
    WHERE p.Id_cultura = c.Id
);

SELECT *
FROM Cultura c
WHERE NOT EXISTS (
    SELECT 1
    FROM Plantio p
    WHERE p.Id_cultura = c.Id
);

SELECT TOP 5 *
FROM Talhao;

SELECT *
FROM Talhao
WHERE area > 150
OR tipo_solo = 'Latossolo Vermelho';

SELECT *
FROM Cultura
WHERE NOT nome = 'Soja';

SELECT *
FROM Solo
WHERE recomendacao IS NULL;

SELECT *
FROM Solo
WHERE recomendacao IS NOT NULL;

SELECT *
FROM Cultura
WHERE nome IN ('Soja', 'Milho');

SELECT *
FROM Cultura
WHERE nome NOT IN ('Soja');

SELECT
    Nome,
    Tipo,
    COUNT(*) AS QTD
FROM
(
    SELECT nome, 'CULTURA' AS Tipo
    FROM Cultura

    UNION ALL

    SELECT nome, 'DEFENSIVOS' AS Tipo
    FROM Defensivos
) AS Dados
GROUP BY Nome, Tipo;

SELECT nome
FROM Cultura
EXCEPT
SELECT nome
FROM Defensivos;

SELECT nome
FROM Cultura
INTERSECT
SELECT nome
FROM Defensivos;

SELECT
    f.nome AS Fazenda,
    t.nome AS Talhao
FROM Fazenda f
LEFT JOIN Talhao t ON f.Id = t.Id_fazenda;

SELECT
    f.nome AS Fazenda,
    t.nome AS Talhao
FROM Fazenda f
RIGHT JOIN Talhao t ON f.Id = t.Id_fazenda;

SELECT SUM(produtividade_media) AS Soma_Produtividade
FROM Cultura;

SELECT AVG(produtividade_media) AS Media_Produtividade
FROM Cultura;

SELECT MAX(produtividade_media) AS Maior_Produtividade
FROM Cultura;

SELECT MIN(produtividade_media) AS Menor_Produtividade
FROM Cultura;

SELECT *
FROM vw_colheita;

SELECT *
FROM vw_Plantios;
