-- Emannuelly Larissa Freitas de Melo - 119210167
-- Banco de Dados - Roteiro 03

-- Apagar o que tenho no bd
DROP OWNED BY CURRENT_USER;

-- O banco deve armazenar dados sobre: farmácias, funcionários, medicamentos, vendas, entregas e clientes.

-- Requisitos de 1 a 5 
CREATE TABLE farmacia(
 id SERIAL PRIMARY KEY,
 tipo CHAR(6) NOT NULL,
 gerente CHAR(11),
 func_gerente VARCHAR(20),
 nome VARCHAR(50) NOT NULL,
 bairro VARCHAR(50) UNIQUE,
 cidade VARCHAR(50) NOT NULL,
 estado ESTADOS_NORDESTE NOT NULL,
 CHECK(func_gerente IN('Administrador','Farmacêutico')),
 CHECK(tipo='S' or tipo='F')
);
--

ALTER TABLE farmacia ADD CONSTRAINT farmacia_gerente_func_gerente_fkey FOREIGN KEY(gerente, func_gerente) REFERENCES funcionario(cpf, funcao);

CREATE TABLE funcionario(
 cpf CHAR(11),
 nome VARCHAR(50) NOT NULL,
 farmacia_contratante SERIAL,
 funcao VARCHAR(20),
 CONSTRAINT funcionario_cpf_pkey PRIMARY KEY(cpf, funcao),
 CHECK(funcao IN('Farmacêutico', 'Vendedor', 'Entregador', 'Caixa', 'Administrador'))
);
ALTER TABLE funcionario ADD CONSTRAINT funcionario_farmacia_contratante_fkey FOREIGN KEY(farmacia_contratante)REFERENCES farmacia(id);
ALTER TABLE funcionario DROP CONSTRAINT funcionario_farmacia_contratante_fkey;
ALTER TABLE funcionario ALTER COLUMN farmacia_contratante DROP NOT NULL;

--

CREATE TABLE endereco(
 id SERIAL,
 cpf_cliente CHAR(11),
 tipo VARCHAR(10) NOT NULL,
 rua VARCHAR(100) NOT NULL,
 bairro VARCHAR(100) NOT NULL,
 numero INTEGER NOT NULL,
 cidade VARCHAR(50) NOT NULL,
 estado VARCHAR(20) NOT NULL, 
 CONSTRAINT endereco_pkey PRIMARY KEY(id),
 CONSTRAINT endereco_chk_endereco_valido CHECK(tipo IN('residência', 'trabalho', 'outro'))
);

ALTER TABLE endereco ADD CONSTRAINT endereco_cpf_cliente_fkey FOREIGN KEY(cpf_cliente)REFERENCES cliente(cpf);
ALTER TABLE endereco DROP CONSTRAINT endereco_pkey;
ALTER TABLE endereco ADD CONSTRAINT endereco_pkey PRIMARY KEY(id);
--

CREATE TABLE cliente(
 cpf CHAR(11) PRIMARY KEY,
 nome VARCHAR(50) NOT NULL,
 idade INTERVAL NOT NULL,
 CHECK(date_part('year',idade)>=18)
);


CREATE TABLE medicamento(
 id SERIAL,
 nome VARCHAR(100),
 peso VARCHAR(5),
 validade DATE,
 venda_com_receita BOOLEAN,
 CONSTRAINT medicamento_pkey PRIMARY KEY(id, venda_com_receita)
);

CREATE TABLE entrega(
 id SERIAL,
 medicamento SERIAL,
 id_endereco SERIAL NOT NULL, 
 cliente_cpf CHAR(11) NOT NULL,
 CONSTRAINT entrega_pkey PRIMARY KEY(id, medicamento),
 CONSTRAINT entrega_id_fkey FOREIGN KEY(id_endereco) REFERENCES endereco(id),
 CONSTRAINT entrega_cliente_fkey FOREIGN KEY(cliente_cpf) REFERENCES cliente(cpf)
);

--

CREATE TABLE venda(
 id SERIAL PRIMARY KEY,
 vendedor CHAR(11) NOT NULL,
 func_vendedor VARCHAR(50) NOT NULL,
 medicamento SERIAL NOT NULL,
 exclusiva_receita BOOLEAN NOT NULL,
 nome_cliente VARCHAR(50) NOT NULL,
 cpf_cadastrado CHAR(11),
 CONSTRAINT venda_vendedor_fkey FOREIGN KEY(vendedor, func_vendedor) REFERENCES funcionario(cpf, funcao),
 CONSTRAINT venda_medicamento_fkey FOREIGN KEY(medicamento, exclusiva_receita) REFERENCES medicamento(id, venda_com_receita),
 CONSTRAINT venda_cpf_cliente_fkey FOREIGN KEY(cpf_cliente) REFERENCES cliente(cpf),
 CHECK(not((exclusiva_receita is true)and(cpf_cliente is null))),
 CHECK(func_vendedor='Vendedor')
);

ALTER TABLE venda RENAME COLUMN cpf_cliente TO cpf_cadastrado;


-- Requisitos de 11 a 12
-- Restrição que não permite apagar um funcionário vinculado a uma venda

ALTER TABLE venda ADD CONSTRAINT funcionario_vendedor_fkey FOREIGN KEY(vendedor, func_vendedor) REFERENCES funcionario(cpf, funcao) ON DELETE RESTRICT;

ALTER TABLE venda ADD CONSTRAINT medicamento_medicamento_fkey FOREIGN KEY(medicamento, exclusiva_receita) REFERENCES medicamento(id, venda_com_receita) ON DELETE RESTRICT;

-- Requisitos 13 e 14
-- A 13 está no escorpo da tabela cliente e a 14 na tabela farmácia

-- Requisitos 15
-- Não permitir mais de uma sede

ALTER TABLE farmacia ADD CONSTRAINT farmacia_unica_sede_excl EXCLUDE USING gist(tipo WITH=)WHERE(tipo='S');

-- Requisitos 16
-- Está no escorpo de farmácia

-- Requisitos 17
-- No escorpo de venda

-- Requisitos 18
-- No escorpo de venda

-- Requisitos 19 

CREATE TYPE ESTADOS_NORDESTE AS ENUM('Paraíba', 'Bahia', 'Alagoas', 'Pernambuco', 'Ceará', 'Piauí', 'Maranhão', 'Rio Grande do Norte', 'Sergipe');

-- COMANDOS ADICIONAIS
--
-- DEVEM SER EXECUTADOS COM SUCESSO

-- Adicionando Funcionários
INSERT INTO funcionario VALUES('98765432111', 'José da Silva', 1, 'Administrador');
INSERT INTO funcionario VALUES('98765432112', 'Watson da Silva', 2, 'Vendedor');
INSERT INTO funcionario VALUES('98765432113', 'Sherlock da Silva', 2, 'Farmacêutico');
INSERT INTO funcionario VALUES('98765432190', 'José da Silva', null, 'Administrador');

-- Adicionando dados da farmácia
INSERT INTO farmacia VALUES(1, 'S', '98765432111', 'Administrador', 'Melhor Farmácia', 'Cruzeiro', 'Campina Grande', 'Paraíba' );
INSERT INTO farmacia VALUES(2, 'F', '98765432113', 'Farmacêutico', 'Melhor Cura Farmácia', 'Catolé', 'Campina Grande', 'Paraíba');

-- Adicionando Endereço
INSERT INTO endereco VALUES(1, '32333233280' , 'residência', 'Rua de casa', 'Bairro de casa', '10', 'Campina Grande' ,'Paraíba');

-- Adicionando Cliente
INSERT INTO cliente VALUES('32333233280', 'Manu Freitas', age(timestamp '2000-10-08'));

-- Adicionando Medicamentos
INSERT INTO medicamento VALUES(1, 'dipirona', '500mg', '2021-08-01', false);
INSERT INTO medicamento VALUES(2, 'somalgin cardio', '100mg', '2021-08-01', true);

-- Adicionando Entrega
INSERT INTO entrega VALUES(1, 1, 1, '32333233280');

-- Adicionando Venda
INSERT INTO venda VALUES(1, '98765432112', 'Vendedor', 1, false, 'Ana Freitas', null);

-- DEVEM DAR ERRO

-- Deve retornar erro pois só há uma sede, que já existe
-- ERROR:  conflicting key value violates exclusion constraint "farmacia_unica_sede_excl"
-- DETAIL:  Key (tipo)=(S     ) conflicts with existing key (tipo)=(S     ).
INSERT INTO farmacia VALUES(10, 'S', '98765432130', 'Administrador', 'Melhor Farmácia 2', 'Liberdade', 'Campina Grande', 'Paraíba');

-- Deve retornar erro pois gerentes só podem ser farmacêuticos ou administradores
-- ERROR:  new row for relation "farmacia" violates check constraint "farmacia_func_gerente_check"
-- DETAIL:  Failing row contains (3, F     , 98765432112, Vendedor, Melhor Cura Farmácia, Liberdade, Campina Grande, Paraíba).
INSERT INTO farmacia VALUES(3, 'F', '98765432112', 'Vendedor', 'Melhor Cura Farmácia', 'Liberdade', 'Campina Grande', 'Paraíba');

-- Deve retornar erro pois entregas são destinadas à clientes cadastrados
-- ERROR:  insert or update on table "entrega" violates foreign key constraint "entrega_cliente_fkey"
-- DETAIL:  Key (cliente_cpf)=(32333233279) is not present in table "cliente".
INSERT INTO entrega VALUES(2, 1, 1, '32333233279');

-- Deve retornar erro pois a entrega não possui um id de endereço válido
-- ERROR:  insert or update on table "entrega" violates foreign key constraint "entrega_id_fkey"
-- DETAIL:  Key (id_endereco)=(5) is not present in table "endereco".
INSERT INTO entrega VALUES(2, 1, 5, '32333233280');

-- Deve retornar erro pois a entrega não possui um tipo de endereço válido
-- ERROR:  new row for relation "endereco" violates check constraint "endereco_chk_endereco_valido"
-- DETAIL:  Failing row contains (3, 32333233287, praia, Rua da praia, Bairro da praia, 12, João Pessoa, Paraíba).
INSERT INTO endereco VALUES(3, '32333233287' , 'praia', 'Rua da praia', 'Bairro da praia', '12', 'João Pessoa' ,'Paraíba');

-- Deve retornar erro pois não é válido vender um medicamento com receita para um cliente não cadastrado
-- ERROR:  new row for relation "venda" violates check constraint "venda_check"
-- DETAIL:  Failing row contains (2, 98765432112, Vendedor, 2, t, Ana Freitas, null).
INSERT INTO venda VALUES(2, '98765432112', 'Vendedor', 2, true, 'Ana Freitas', null);

-- Deve ocorrer um erro ao tentar deletar um funcionário relacionado a uma venda
-- ERROR:  update or delete on table "funcionario" violates foreign key constraint "venda_vendedor_fkey" on table "venda"
-- DETAIL:  Key (cpf, funcao)=(98765432112, Vendedor) is still referenced from table "venda".
DELETE FROM funcionario WHERE cpf='98765432112';

-- Deve ocorrer um erro ao tentar deletar um medicamento relacionado a uma venda
-- ERROR:  update or delete on table "medicamento" violates foreign key constraint "venda_medicamento_fkey" on table "venda"
-- DETAIL:  Key (id, venda_com_receita)=(1, f) is still referenced from table "venda".
DELETE FROM medicamento WHERE id=1;

-- Deve ocorrer um erro ao tentar adicionar um cliente menor de 18 anos
-- ERROR:  new row for relation "cliente" violates check constraint "cliente_idade_check"
-- DETAIL:  Failing row contains (32333233279, Larissa Freitas, 10 years 9 mons 9 days).
INSERT INTO cliente VALUES('32333233279', 'Larissa Freitas', age(timestamp '2010-10-08'));

-- Deve ocorrer um erro pois um mesmo bairro não pode ter mais de uma farmácia
-- ERROR:  duplicate key value violates unique constraint "farmacia_bairro_key"
-- DETAIL:  Key (bairro)=(Cruzeiro) already exists.
INSERT INTO farmacia VALUES(3, 'F', '98765432190', 'Administrador', 'Melhor Cura Farmácia', 'Cruzeiro', 'Campina Grande', 'Paraíba');

-- Deve retornar erro ao tentar atribuir uma venda a um funcionário que não é vendedor
-- ERROR:  new row for relation "venda" violates check constraint "venda_func_vendedor_check"
-- DETAIL:  Failing row contains (2, 98765432113, Farmacêutico, 1, f, Ana Freitas, null).
INSERT INTO venda VALUES(2, '98765432113', 'Farmacêutico', 1, false, 'Ana Freitas', null);

-- Deve retornar erro pois a farmácia deve ser cadastrada apenas em estados do Nordeste
-- ERROR:  invalid input value for enum estados_nordeste: "São Paulo"
-- LINE 1: ...'Melhor Cura Farmácia', 'Pinheiros', 'São Paulo', 'São Paulo...
--                                                              ^
INSERT INTO farmacia VALUES(7, 'F', '98765432130', 'Administrador', 'Melhor Cura Farmácia', 'Pinheiros', 'São Paulo', 'São Paulo');
