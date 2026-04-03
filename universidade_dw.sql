-- Criando o banco de dados para o modelo dimensional
CREATE DATABASE IF NOT EXISTS universidade_dw;
USE universidade_dw;

-- 1. Tabela Dimensão: Professor (Foco da análise)
CREATE TABLE Dim_Professor (
    sk_professor INT PRIMARY KEY AUTO_INCREMENT,
    idProfessor INT, -- ID vindo do sistema relacional
    nome_professor VARCHAR(100)
);

-- 2. Tabela Dimensão: Departamento
CREATE TABLE Dim_Departamento (
    sk_departamento INT PRIMARY KEY AUTO_INCREMENT,
    idDepartamento INT,
    nome_depto VARCHAR(45),
    campus VARCHAR(45)
);

-- 3. Tabela Dimensão: Disciplina
CREATE TABLE Dim_Disciplina (
    sk_disciplina INT PRIMARY KEY AUTO_INCREMENT,
    idDisciplina INT,
    nome_disciplina VARCHAR(45)
);

-- 4. Tabela Dimensão: Curso
CREATE TABLE Dim_Curso (
    sk_curso INT PRIMARY KEY AUTO_INCREMENT,
    idCurso INT,
    nome_curso VARCHAR(45)
);

-- 5. Tabela Dimensão: Data (Necessária conforme requisito)
-- Criada para compensar a falta de datas no modelo original
CREATE TABLE Dim_Data (
    sk_data INT PRIMARY KEY AUTO_INCREMENT,
    data_completa DATE,
    ano INT,
    semestre INT,
    mes INT,
    trimestre INT
);

-- 6. Tabela Fato: Fato_Professor
-- Centraliza as métricas pedidas: horas, disciplinas e cursos
CREATE TABLE Fato_Professor (
    sk_professor INT,
    sk_departamento INT,
    sk_disciplina INT,
    sk_curso INT,
    sk_data INT,
    
    -- Métricas (Fatos)
    qtde_horas_professor INT,
    qtde_disciplinas INT,
    qtde_cursos INT,
    
    -- Chaves Estrangeiras para conectar o Star Schema
    CONSTRAINT fk_dim_professor FOREIGN KEY (sk_professor) REFERENCES Dim_Professor(sk_professor),
    CONSTRAINT fk_dim_depto FOREIGN KEY (sk_departamento) REFERENCES Dim_Departamento(sk_departamento),
    CONSTRAINT fk_dim_disciplina FOREIGN KEY (sk_disciplina) REFERENCES Dim_Disciplina(sk_disciplina),
    CONSTRAINT fk_dim_curso FOREIGN KEY (sk_curso) REFERENCES Dim_Curso(sk_curso),
    CONSTRAINT fk_dim_data FOREIGN KEY (sk_data) REFERENCES Dim_Data(sk_data)
);