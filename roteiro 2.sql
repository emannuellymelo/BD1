-- Emannuelly Larissa Freitas de Melo - 119210167
-- Banco de Dados - Roteiro 02

-- Questão 1
CREATE TABLE tarefas(
 id SERIAL,
 nome_tarefa TEXT,
 cpf_trabalhador CHAR(11),
 concluidas INTEGER,
 alguma_coisa CHAR(1)
);

INSERT INTO tarefas VALUES(2147483646, 'limpar chão do corredor central', '98765432111', 0, 'F');
INSERT INTO tarefas VALUES(2147483647, 'limpar janelas da sala 203', '98765432122', 1, 'F');
ALTER TABLE tarefas ALTER COLUMN id DROP NOT NULL;
INSERT INTO tarefas VALUES(null,null,null,null,null);
-- Erros que devem acontecer
INSERT INTO tarefas VALUES(2147483644, 'limpar chão do corredor superior', '987654323211', 0, 'F');
INSERT INTO tarefas VALUES(2147483643, 'limpar chão do corredor superior', '98765432321', 0, 'FF');

-- Questão 2
-- Conserto de erro "Erro de integer out of range"
ALTER TABLE tarefas ALTER COLUMN id TYPE BIGINT;
INSERT INTO tarefas VALUES(2147483648, 'limpar portas do térreo', '32323232955', 4, 'A');

-- Questão 3
ALTER TABLE tarefas ADD CONSTRAINT tarefas_chk_concluidas_validas CHECK(concluidas<32768);
-- Erros que devem acontecer
INSERT INTO tarefas VALUES(2147483649, 'limpar portas da entrada principal', '32322525199', 32768, 'A');
INSERT INTO tarefas VALUES(2147483650, 'limpar janelas da entrada principal', '32333233288', 32769, 'A');
-- Sucessos
INSERT INTO tarefas VALUES(2147483651, 'limpar portas do 1o andar', '32323232911', 32767, 'A');
INSERT INTO tarefas VALUES(2147483652, 'limpar portas do 2o andar', '32323232911', 32766, 'A');

-- Questão 4
-- Comandos que dão erro
ALTER TABLE tarefas ALTER COLUMN id SET NOT NULL;
ALTER TABLE tarefas ALTER COLUMN nome_tarefa SET NOT NULL;
ALTER TABLE tarefas ALTER COLUMN cpf_trabalhador SET NOT NULL;
ALTER TABLE tarefas ALTER COLUMN concluidas SET NOT NULL;
ALTER TABLE tarefas ALTER COLUMN alguma_coisa SET NOT NULL;

ALTER TABLE tarefas RENAME COLUMN nome_tarefa TO descricao;
ALTER TABLE tarefas RENAME COLUMN cpf_trabalhador TO func_resp_cpf;
ALTER TABLE tarefas RENAME COLUMN concluidas TO prioridade;
ALTER TABLE tarefas RENAME COLUMN alguma_coisa TO status;
-- Removendo as tuplas nulas
DELETE FROM tarefas WHERE id IS NULL;
DELETE FROM tarefas WHERE descricao IS NULL;
DELETE FROM tarefas WHERE func_resp_cpf IS NULL;
DELETE FROM tarefas WHERE prioridade IS NULL;
DELETE FROM tarefas WHERE status IS NULL;
-- Execução com sucesso após remover elementos nulos
ALTER TABLE tarefas ALTER COLUMN id SET NOT NULL;
ALTER TABLE tarefas ALTER COLUMN descricao SET NOT NULL;
ALTER TABLE tarefas ALTER COLUMN func_resp_cpf SET NOT NULL;
ALTER TABLE tarefas ALTER COLUMN prioridade SET NOT NULL;
ALTER TABLE tarefas ALTER COLUMN status SET NOT NULL;

-- Questão 5
ALTER TABLE tarefas ADD PRIMARY KEY (id);
INSERT INTO tarefas VALUES(2147483653, 'limpar portas do 1o andar', '32323232911', 2, 'A');
INSERT INTO tarefas VALUES(2147483653, 'aparar a grama da área frontal', '32323232911', 3, 'A');

-- Questão 6
-- a)
-- Constraint
ALTER TABLE tarefas ADD CONSTRAINT tarefas_chk_func_resp_cpf_valido CHECK(LENGTH(func_resp_cpf)=11);
-- Teste mais dígitos de cpf
INSERT INTO tarefas VALUES(2147483657, 'limpar portas do 3o andar', '323232329117', 2, 'A');
-- Teste menos dígitos de cpf
INSERT INTO tarefas VALUES(2147483658, 'limpar portas do 4o andar', '3232323291', 3, 'A');
-- b)
-- Seleção dos elementos com valores desatualizados para monitorar quais elementos devem ser atualizados
SELECT id, status FROM tarefas WHERE status='A';
SELECT id, status FROM tarefas WHERE status='R';
SELECT id, status FROM tarefas WHERE status='F';
-- Update dados anteriores
UPDATE tarefas SET status='P' WHERE status='A';
UPDATE tarefas SET status='C' WHERE status='F';
-- Restrição
ALTER TABLE tarefas ADD CONSTRAINT tarefas_chk_status_valido CHECK(status='P' or status='E' or status='C');

-- Questão 7
-- Atualizar prioridade maior que 5
UPDATE tarefas SET prioridade=5 WHERE prioridade>5;
-- Restrição para prioridade
ALTER TABLE tarefas ADD CONSTRAINT tarefas_chk_prioridade_valida CHECK(prioridade>=0 and prioridade<=5);

-- Questão 8
CREATE TABLE funcionario(
 cpf CHAR(11) PRIMARY KEY,
 data_nasc CHAR(10) NOT NULL,
 superior_cpf CHAR(11) REFERENCES funcionario(cpf),
 nome VARCHAR(100) NOT NULL,
 funcao VARCHAR(11) NOT NULL,
 nivel CHAR(1) NOT NULL,
 CHECK(funcao='LIMPEZA' or funcao='SUP_LIMPEZA'),
 CHECK(not(funcao='LIMPEZA' and superior_cpf is null)),
 CHECK(nivel='J' or nivel='P' or nivel='S')
);

-- Devem funcionar
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf)VALUES('12345678911','1980-05-07','Pedro da Silva','SUP_LIMPEZA','S',null);
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf)VALUES('12345678912','1980-03-08','Jose da Silva', 'LIMPEZA', 'J', '12345678911');

-- Não deve funcionar
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf)VALUES('12345678913','1980-04-09','joao da Silva','LIMPEZA', 'J', null);

-- Questão 9
-- Sucessos
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf)VALUES('12345678913','1980-05-07','Joao da Silva','SUP_LIMPEZA','S',null);
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf)VALUES('12345678914','1980-06-10','Joana da Silva','SUP_LIMPEZA','P',null);
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf)VALUES('12345678915','1980-07-07','Juliana da Silva','LIMPEZA','J', 12345678913);
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf)VALUES('12345678916','1980-10-08','Jailton da Silva','LIMPEZA','J', 12345678914);
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf)VALUES('12345678917','1980-05-09','Paulo da Silva','LIMPEZA','P', 12345678914);
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf)VALUES('12345678918','1980-05-03','Fabio da Silva','LIMPEZA','S', '12345678913');
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf)VALUES('12345678919','1980-08-07','Charles da Silva','SUP_LIMPEZA','S',null);
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf)VALUES('12345678920','1980-09-27','Chico da Silva','SUP_LIMPEZA','S',null);
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf)VALUES('12345678921','1980-03-01','Tiago da Silva','LIMPEZA','J', '12345678913');
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf)VALUES('12345678922','1980-04-07','Fabiana da Silva','SUP_LIMPEZA','S',null);

-- Erros
-- CPF já cadastrado
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf)VALUES('12345678913','1980-05-07','Joao da Silva','SUP_LIMPEZA','S',null);
-- Nível inexistente
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf)VALUES('12345678923','1980-06-10','Joana da Silva','SUP_LIMPEZA','a',null);
-- Nível existente em letra minúscula
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf)VALUES('12345678924','1980-07-07','Juliana da Silva','LIMPEZA','j', 12345678913);
-- Funcionário de limpeza sem superior
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf)VALUES('12345678925','1980-10-08','Jailton da Silva','LIMPEZA','J', null);
-- Função inexistente
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf)VALUES('12345678926','1980-05-09','Paulo da Silva','LIMPEZ','P', 12345678914);
-- Função existente em letra minúscula
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf)VALUES('12345678927','1980-05-03','Fabio da Silva','limpeza','S', '12345678913');
-- Função inexistente
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf)VALUES('12345678928','1980-08-07','Charles da Silva','SUPLIMPEZA','S',null);
-- Função existente em letra minúscula
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf)VALUES('12345678929','1980-09-27','Chico da Silva','sup_limpeza','S',null);
-- Valor nulo para cpf
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf)VALUES(null,'1980-03-01','Tiago da Silva','LIMPEZA','J', '12345678913');
-- Valor nulo para data de nascimento
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf)VALUES('12345678931',null,'Fabiana da Silva','SUP_LIMPEZA','S',null);

-- Questão 10
-- Opção 1
-- Menor CPF: '32323232911'
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf)VALUES('32323232955','1980-05-07','Maria da Silva','SUP_LIMPEZA','J', null);
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf)VALUES('32323232911','1980-05-07','Joao da Silva','SUP_LIMPEZA','S', null);
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf)VALUES('98765432111','1980-09-08','Zé da Silva','SUP_LIMPEZA','P', null);
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf)VALUES('98765432122','1980-10-08','Paula da Silva','SUP_LIMPEZA','P', null);
ALTER TABLE tarefas ADD CONSTRAINT tarefas_func_resp_cpf_fkey FOREIGN KEY(func_resp_cpf) REFERENCES funcionario(cpf) ON DELETE CASCADE;
DELETE FROM funcionario WHERE cpf='32323232911';
-- Opção 2
-- CPF com tarefa a ser realizada:
ALTER TABLE tarefas DROP CONSTRAINT tarefas_func_resp_cpf_fkey;
ALTER TABLE tarefas ADD CONSTRAINT tarefas_func_resp_cpf_fkey FOREIGN KEY(func_resp_cpf) REFERENCES funcionario(cpf) ON DELETE RESTRICT;
DELETE FROM funcionario WHERE cpf='32323232955';
-- Erro:
--ERROR:  update or delete on table "funcionario" violates foreign key constraint "tarefas_func_resp_cpf_fkey" on table "tarefas"
--DETAIL:  Key (cpf)=(32323232955) is still referenced from table "tarefas".

-- Questão 11
ALTER TABLE tarefas ALTER COLUMN func_resp_cpf DROP NOT NULL;
ALTER TABLE tarefas ADD CONSTRAINT tarefas_chk_func_resp_cpf_valida CHECK(not(func_resp_cpf is null and status='C')and(not(func_resp_cpf is null and status='E')));
ALTER TABLE tarefas DROP CONSTRAINT tarefas_func_resp_cpf_fkey;
ALTER TABLE tarefas ADD CONSTRAINT tarefas_func_resp_cpf_fkey FOREIGN KEY(func_resp_cpf) REFERENCES funcionario(cpf) ON DELETE SET NULL;
-- Complementar tarefas com status distintos
INSERT INTO tarefas VALUES(2147483659, 'limpar portas do 1o andar', '32323232955', 2, 'E');
INSERT INTO tarefas VALUES(2147483660, 'limpar portas do 2o andar', '32323232955', 3, 'C');
DELETE FROM funcionario WHERE cpf='32323232955';


