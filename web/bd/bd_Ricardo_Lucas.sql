-- PI RICARDO e LUCAS
-- drop database loja_automotiva;

/********************************************************************/
-- CRIAÇÃO DO BANCO E TABELAS
/********************************************************************/
-- criar o banco se não existir
CREATE DATABASE IF NOT EXISTS loja_automotiva;
USE loja_automotiva;

CREATE TABLE Cliente(
    CPF_Cliente VARCHAR(11) PRIMARY KEY,
    Nome_Cliente VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    telefone VARCHAR(50) NOT NULL
);


CREATE TABLE Carro(
	id_Carro INT PRIMARY KEY auto_increment,
    Cod_Carro VARCHAR(8),
    Modelo_Carro VARCHAR(20) NOT NULL,
    Marca_Carro VARCHAR(20) NOT NULL,
    Ano_Carro INT NOT NULL,
    CPF_ClienteID VARCHAR(11), 
    FOREIGN KEY (CPF_ClienteID) REFERENCES Cliente(CPF_Cliente) ON DELETE CASCADE 
);


CREATE TABLE Servico(
	id_Servico INT PRIMARY KEY auto_increment,
	Cod_Servico VARCHAR(10),
    Nome_Servico VARCHAR(30) NOT NULL,
    Preco_servico DOUBLE NOT NULL,
    CPF_ClienteID VARCHAR(11),
    FOREIGN KEY (CPF_ClienteID) REFERENCES Cliente(CPF_Cliente) ON DELETE CASCADE
);

CREATE TABLE Procedimento(
	id_proc INT PRIMARY KEY auto_increment,
	Cod_procedimento VARCHAR(20),
    Tipo_procedimento VARCHAR(30) NOT NULL
);

CREATE TABLE Itens_Servico(
	id_itens INT PRIMARY KEY auto_increment,
	Data_Revisao DATE,
    id_Servico INT,
    id_proc INT,
    FOREIGN KEY (id_Servico) REFERENCES Servico(id_Servico) ON DELETE CASCADE,
    FOREIGN KEY (id_proc) REFERENCES Procedimento(id_proc) ON DELETE CASCADE
);


/********************************************************************/
-- RELATÓRIOS
/********************************************************************/
-- Relatório de clientes
SELECT Nome_Cliente, Email_Cliente, Fone_Cliente FROM Cliente;
select * from cliente;
  

