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
    produtividade_media DECIMAL(10,2),
    id_fazenda INT,
    FOREIGN KEY (id_fazenda) REFERENCES Fazenda(Id)
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

--=======================
--INSERT CULTURA
INSERT INTO Cultura (id_fazenda, nome, ciclo_dias, produtividade_media)
VALUES
(2, 'Café', 210, 5.80),
(3, 'Café', 200, 5.50),
(4, 'Soja', 120, 3.50),
(5, 'Milho', 90, 4.90),
(6, 'Soja', 120, 3.60),
(7, 'Soja', 120, 3.50),
(8, 'Soja', 120, 3.70);

--INSERT PLANTIO
INSERT INTO Plantio (data_plantio, Id_talhao, Id_cultura, estimativa_colheita)
VALUES
('2024-01-15', 1, 1, '2024-08-12'),
('2024-01-20', 2, 1, '2024-08-18'),
('2024-02-01', 3, 2, '2024-09-30'),
('2024-02-10', 4, 3, '2024-06-10'),
('2024-02-15', 5, 4, '2024-05-15'),
('2024-02-20', 6, 5, '2024-06-20'),
('2024-02-25', 7, 6, '2024-06-30'),
('2024-03-01', 8, 7, '2024-07-01');

--INSERT MONITORAMENTO SATÉLITE
INSERT INTO Monitoramento_satelite (Id_talhao, data_colheita, indice_ndvi, umidade, temperatura, risco_climatico)
VALUES
(1, '2024-08-12', 0.75, 60.00, 25.00, 'Baixo'),
(2, '2024-08-18', 0.70, 58.00, 26.00, 'Médio'),
(3, '2024-09-30', 0.80, 65.00, 24.00, 'Baixo'),
(4, '2024-06-10', 0.65, 55.00, 28.00, 'Alto'),
(5, '2024-05-15', 0.60, 50.00, 30.00, 'Alto'),
(6, '2024-06-20', 0.78, 62.00, 27.00, 'Médio'),
(7, '2024-06-30', 0.82, 68.00, 23.00, 'Baixo'),
(8, '2024-07-01', 0.77, 63.00, 26.50, 'Médio');

--======================
--SELECT TABLE FAZENDA
SELECT *
FROM Fazenda;
--======================
--SELECT TABLE TALHÃO
SELECT *
FROM Talhao;

--SELECT TABLE CULTURA
SELECT * FROM Cultura;

--SELECT TABLE PLANTIO
SELECT * FROM Plantio;

--SELECT TABLE MONITORAMENTO SATÉLITE
SELECT * FROM Monitoramento_satelite;
--=====================
--UPDATE FAZENDA
UPDATE Fazenda
SET nome = 'Fazenda Talismã'
WHERE id =6;

--JOIN
SELECT c.nome, com.quantidade
FROM colheita col
JOIN plantio p ON col.id_plantio = p.id
JOIN cultura c ON p.id_cultura = c.id;

--GROUP BY
SELECT id_cultura, COUNT(*)
FROM Plantio
GROUP BY id_cultura;

--BETWEEN
SELECT * FROM plantio
WHERE data_plantio BETEWEEN '2024-01-01' AND '2024-02-29';

--LIKE

SELECT * FROM cultura WHERE nome LIKE '%so%';

--AND/OR
SELECT * FROM talhao WHERE area > 5 AND area < 200;

--IS NULL
SELECT * FROM colheita WHERE quantidade IS NOT NULL;

--JOINS
SELECT p.id, c.nome, t.nome
FROM plantio p
INNER JOIN cultura c ON p.id_cultura= c.id
INNER JOIN talhao t ON p.id_talhao=t.id


--UNION
SELECT nome FROM cultura
UNION
SELECT nome FROM defensivo;

--GROUP BY + COUNT
SELECT id_cultura, COUNT(*)
FROM plantio
GROUP BY id_cultura;

--HAVING
SELECT id_cultura, COUNT(*)
FROM plantio
GROUP BY id_cultura
HAVUNG COUNT(*) > 1;

--BETWEEN
SELECT * FROM plantio
WHERE data_plantio BETWEEN '2024-01-01' AND '2024-12-31';

--EXISTS
SELECT * FROM cultura c
WHERE EXISTS(
SELECT 1 FROM plantio p WHERE p.id_cultura=c.id
);

--NOT EXISTS
SELECT * FROM cultura c
WHERE NOT EXISTS (
    SELECT 1 FROM plantio p WHERE p.id_cultura = c.id
);

--VIEW
CREATE VIEW vw_colheita AS
SELECT c.nome, col.quantidade
FROM colheita col
JOIN plantio p ON col.id_plantio = p.id
JOIN cultura c ON p.id_cultura = c.id;
-- ==========================================
-- DELETE
-- ==========================================
DELETE FROM Defensivos
WHERE Id = 999;

-- ==========================================
-- SELECT TOP
-- ==========================================
SELECT TOP 5 *
FROM Talhao;

-- ==========================================
-- OR
-- ==========================================
SELECT *
FROM Talhao
WHERE area > 150
OR tipo_solo = 'Latossolo Vermelho';

-- ==========================================
-- NOT
-- ==========================================
SELECT *
FROM Cultura
WHERE NOT nome = 'Soja';

-- ==========================================
-- IS NULL
-- ==========================================
SELECT *
FROM Solo
WHERE recomendacao IS NULL;

-- ==========================================
-- IS NOT NULL
-- ==========================================
SELECT *
FROM Solo
WHERE recomendacao IS NOT NULL;

-- ==========================================
-- IN
-- ==========================================
SELECT *
FROM Cultura
WHERE nome IN ('Soja','Milho');

-- ==========================================
-- NOT IN
-- ==========================================
SELECT *
FROM Cultura
WHERE nome NOT IN ('Soja');

-- ==========================================
-- UNION ALL
-- ==========================================
SELECT nome
FROM Cultura

UNION ALL

SELECT nome
FROM Defensivos;

-- ==========================================
-- EXCEPT
-- ==========================================
SELECT nome
FROM Cultura

EXCEPT

SELECT nome
FROM Defensivos;

-- ==========================================
-- INTERSECT
-- ==========================================
SELECT nome
FROM Cultura

INTERSECT

SELECT nome
FROM Defensivos;

-- ==========================================
-- LEFT JOIN
-- ==========================================
SELECT
f.nome AS Fazenda,
t.nome AS Talhao

FROM Fazenda f

LEFT JOIN Talhao t
ON f.Id = t.id_fazenda;

-- ==========================================
-- RIGHT JOIN
-- ==========================================
SELECT
f.nome AS Fazenda,
t.nome AS Talhao

FROM Fazenda f

RIGHT JOIN Talhao t
ON f.Id = t.id_fazenda;

-- ==========================================
-- SUM
-- ==========================================
SELECT
SUM(produtividade_media) AS Soma_Produtividade
FROM Cultura;

-- ==========================================
-- AVG
-- ==========================================
SELECT
AVG(produtividade_media) AS Media_Produtividade
FROM Cultura;

-- ==========================================
-- MAX
-- ==========================================
SELECT
MAX(produtividade_media) AS Maior_Produtividade
FROM Cultura;

-- ==========================================
-- MIN
-- ==========================================
SELECT
MIN(produtividade_media) AS Menor_Produtividade
FROM Cultura;

-- ==========================================
-- VIEW NOVA
-- ==========================================
CREATE VIEW vw_Plantios AS

SELECT

p.id,
c.nome AS Cultura,
t.nome AS Talhao,
p.data_plantio,
p.estimativa_colheita

FROM Plantio p

INNER JOIN Cultura c
ON p.Id_cultura = c.id

INNER JOIN Talhao t
ON p.Id_talhao = t.id;

-- ==========================================
-- CONSULTA DA VIEW
-- ==========================================
SELECT *
FROM vw_Plantios;
