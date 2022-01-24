-- Emannuelly Larissa Freitas de Melo - 119210167
-- Banco de Dados - Roteiro 01

-- Questão 1

-- Automóvel: placa, marca, modelo, ano, chassi;
-- Segurado: cpf, nome, telefone;
-- Perito: cpf, nome, telefone;
-- Oficina: cnpj, nome, endereço, telefone;
-- Seguro: id, marca, valor, placa_do_automovel, cpf_do_segurado, início_do_plano, fim_do_plano, cobertura;
-- Sinistro: id, endereço, tipo (acidente ou furto), id_seguro, data_e_hora;
-- Perícia: id, placa_do_automovel, id_sinistro, data_e_hora, descrição_do_dano, cpf_perito;
-- Reparo: id, id_seguro, custo, data_e_hora_inicial, data_e_hora_final, cnpj_da_oficina.

-- Questão 2
CREATE TABLE automovel(
 marca VARCHAR(20),
 modelo VARCHAR(20),
 ano INTEGER,
 placa CHAR(7),
 chassi CHAR(17)
);

CREATE TABLE segurado(
 nome VARCHAR(100),
 cpf CHAR(11),
 telefone CHAR(16)
);

CREATE TABLE perito(
 nome VARCHAR(100),
 cpf CHAR(11),
 telefone CHAR(16)
);

CREATE TABLE oficina(
 nome VARCHAR(50),
 cnpj CHAR(14),
 endereco VARCHAR(100),
 telefone CHAR(16)
);

CREATE TABLE seguro(
 id SERIAL,
 valor NUMERIC,
 placa_do_automovel CHAR(7),
 cpf_do_segurado CHAR(11),
 inicio_do_plano TIMESTAMP,
 fim_do_plano TIMESTAMP,
 cobertura TEXT
);

CREATE TABLE sinistro(
 id SERIAL,
 id_seguro SERIAL,
 endereco VARCHAR(100),
 data_e_hora TIMESTAMP,
-- O sinistro pode ser do tipo acidente ou do tipo furto.
 tipo VARCHAR(8)
);


CREATE TABLE pericia(
 id SERIAL,
 id_sinistro SERIAL,
 cpf_perito CHAR(11),
 placa_do_automovel CHAR(7),
 data_e_hora TIMESTAMP,
 descricao_do_dano TEXT
);

CREATE TABLE reparo(
 id SERIAL,
 id_seguro SERIAL,
 oficina_cnpj CHAR(14),
 custo NUMERIC,
 data_e_hora_inicial TIMESTAMP,
 data_e_hora_final TIMESTAMP
);

-- Questão 3
ALTER TABLE automovel ADD PRIMARY KEY(placa);
ALTER TABLE segurado ADD PRIMARY KEY(cpf);
ALTER TABLE perito ADD PRIMARY KEY(cpf);
ALTER TABLE oficina ADD PRIMARY KEY(cnpj);
ALTER TABLE seguro ADD PRIMARY KEY(id);
ALTER TABLE sinistro ADD PRIMARY KEY(id);
ALTER TABLE pericia ADD PRIMARY KEY(id);
ALTER TABLE reparo ADD PRIMARY KEY(id);

-- Questão 4
ALTER TABLE seguro ADD CONSTRAINT seguro_placa_do_automovel_fkey FOREIGN KEY(placa_do_automovel) REFERENCES automovel(placa);
ALTER TABLE seguro ADD CONSTRAINT seguro_cpf_do_segurado_fkey FOREIGN KEY(cpf_do_segurado) REFERENCES segurado(cpf);
ALTER TABLE sinistro ADD CONSTRAINT sinistro_id_seguro_fkey FOREIGN KEY(id_seguro)REFERENCES seguro(id);
ALTER TABLE pericia ADD CONSTRAINT pericia_cpf_perito_fkey FOREIGN KEY(cpf_perito)REFERENCES perito(cpf);
ALTER TABLE pericia ADD CONSTRAINT pericia_placa_do_automovel_fkey FOREIGN KEY(placa_do_automovel)REFERENCES automovel(placa);
ALTER TABLE pericia ADD CONSTRAINT pericia_id_sinistro_fkey FOREIGN KEY(id_sinistro)REFERENCES sinistro(id);
ALTER TABLE reparo ADD CONSTRAINT reparo_oficina_cnpj_fkey FOREIGN KEY(oficina_cnpj)REFERENCES oficina(cnpj);
ALTER TABLE reparo ADD CONSTRAINT reparo_id_seguro_fkey FOREIGN KEY(id_seguro)REFERENCES seguro(id);

-- Questão 5

-- Atributos adicionais: e-mail dos segurados, e-mail do perito, hora de abertura e de encerramento da oficina.
-- Os seguintes atributos de cada tabela poderiam ou deveriam ser NOT NULL, incluindo PRIMARY KEY e atributos do tipo SERIAL:
-- Automóvel:  placa, marca, modelo, ano, chassi;
-- Segurado: cpf, nome, telefone;
-- Perito: cpf, nome, telefone;
-- Oficina: cnpj, nome, endereço, telefone;
-- Seguro: id, marca, valor, início_do_plano, cobertura;
-- Sinistro: id, endereço, tipo, data_e_hora;
-- Perícia: id, data_e_hora, descrição_do_dano;
-- Reparo: id, custo, data_e_hora_início, data_e_hora_final.

-- Questão 6
-- Remoção de tabelas com prioridade para as que possuem FOREIGN KEY, o que permite que sempre exista referência à tabela de origem dessa chave.
DROP TABLE reparo;
DROP TABLE pericia;
DROP TABLE sinistro;
DROP TABLE seguro;
DROP TABLE oficina;
DROP TABLE perito;
DROP TABLE segurado;
DROP TABLE automovel;

-- Questões 7 e 8
CREATE TABLE automovel(
 marca VARCHAR(20) NOT NULL,
 ano INTEGER NOT NULL,
 placa CHAR(7) PRIMARY KEY,
 chassi CHAR(17) NOT NULL
);

CREATE TABLE segurado(
 nome VARCHAR(100) NOT NULL,
 cpf CHAR(11) PRIMARY KEY,
 telefone CHAR(16) NOT NULL
);

CREATE TABLE perito(
 nome VARCHAR(100) NOT NULL,
 cpf CHAR(11) PRIMARY KEY,
 telefone CHAR(16) NOT NULL
);


CREATE TABLE oficina(
 nome VARCHAR(50) NOT NULL,
 cnpj CHAR(14) PRIMARY KEY,
 endereco VARCHAR(100) NOT NULL,
 telefone CHAR(16) NOT NULL
);

CREATE TABLE seguro(
 id SERIAL PRIMARY KEY,
 valor NUMERIC NOT NULL,
 placa_do_automovel CHAR(7) REFERENCES automovel(placa),
 cpf_do_segurado CHAR(11) REFERENCES segurado(cpf),
 inicio_do_plano TIMESTAMP NOT NULL,
 fim_do_plano TIMESTAMP,
 cobertura TEXT NOT NULL
);

CREATE TABLE sinistro(
 id SERIAL PRIMARY KEY,
 id_seguro SERIAL REFERENCES seguro(id),
 endereco VARCHAR(100) NOT NULL,
 data_e_hora TIMESTAMP NOT NULL,
 tipo VARCHAR(8) NOT NULL
);


CREATE TABLE pericia(
 id SERIAL PRIMARY KEY,
 placa_do_automovel CHAR(7) REFERENCES automovel(placa),
 cpf_perito CHAR(11) REFERENCES perito (cpf),
 data_e_hora TIMESTAMP NOT NULL,
 descricao_do_dano TEXT NOT NULL
);

CREATE TABLE reparo(
 id SERIAL PRIMARY KEY,
 id_seguro SERIAL REFERENCES seguro(id),
 oficina_cnpj CHAR(14) REFERENCES oficina(cnpj),
 custo NUMERIC NOT NULL,
 data_e_hora_inicial TIMESTAMP NOT NULL,
 data_e_hora_final TIMESTAMP NOT NULL
);

-- Questão 9
DROP TABLE reparo;
DROP TABLE pericia;
DROP TABLE sinistro;
DROP TABLE seguro;
DROP TABLE oficina;
DROP TABLE perito;
DROP TABLE segurado;
DROP TABLE automovel;

-- Questão 10
-- Adição da tabela "Franquia", que se trata do valor estipulado no contrato do seguro que deve ser pago pelo segurado para o reparo decorrente de um sinistro. 
CREATE TABLE automovel(
 marca VARCHAR(20) NOT NULL,
 ano INTEGER NOT NULL,
 placa CHAR(7) PRIMARY KEY,
 chassi CHAR(17) NOT NULL
);

CREATE TABLE segurado(
 nome VARCHAR(100) NOT NULL,
 cpf CHAR(11) PRIMARY KEY,
 telefone CHAR(16) NOT NULL
);

CREATE TABLE perito(
 nome VARCHAR(100) NOT NULL,
 cpf CHAR(11) PRIMARY KEY,
 telefone CHAR(16) NOT NULL
);


CREATE TABLE oficina(
 nome VARCHAR(50) NOT NULL,
 cnpj CHAR(14) PRIMARY KEY,
 endereco VARCHAR(100) NOT NULL,
 telefone CHAR(16) NOT NULL
);

CREATE TABLE seguro(
 id SERIAL PRIMARY KEY,
 valor NUMERIC NOT NULL,
 placa_do_automovel CHAR(7) REFERENCES automovel(placa),
 cpf_do_segurado CHAR(11) REFERENCES segurado(cpf),
 inicio_do_plano TIMESTAMP NOT NULL,
 fim_do_plano TIMESTAMP,
 cobertura TEXT NOT NULL
);

CREATE TABLE franquia(
 id SERIAL PRIMARY KEY,
 id_seguro SERIAL REFERENCES seguro(id),
 valor NUMERIC NOT NULL
);

CREATE TABLE sinistro(
 id SERIAL PRIMARY KEY,
 id_seguro SERIAL REFERENCES seguro(id),
 endereco VARCHAR(100) NOT NULL,
 data_e_hora TIMESTAMP NOT NULL,
 tipo VARCHAR(8) NOT NULL
);


CREATE TABLE pericia(
 id SERIAL PRIMARY KEY,
 placa_do_automovel CHAR(7) REFERENCES automovel(placa),
 cpf_perito CHAR(11) REFERENCES perito (cpf),
 data_e_hora TIMESTAMP NOT NULL,
 descricao_do_dano TEXT NOT NULL
);

CREATE TABLE reparo(
 id SERIAL PRIMARY KEY,
 id_seguro SERIAL REFERENCES seguro(id),
 oficina_cnpj CHAR(14) REFERENCES oficina(cnpj),
 custo NUMERIC NOT NULL,
 data_e_hora_inicial TIMESTAMP NOT NULL,
 data_e_hora_final TIMESTAMP NOT NULL
);



