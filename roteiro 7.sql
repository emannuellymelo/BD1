-- Emannuelly Larissa Freitas de Melo - 119210167
-- Banco de Dados - Roteiro 07

-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-09-04 22:19:53.328

-- tables
-- Table: game
CREATE TABLE game (
    id serial  NOT NULL,
    team1_name varchar(50)  NOT NULL,
    team2_name varchar(50)  NOT NULL,
    result_team1 int  NOT NULL,
    result_team2 int  NOT NULL,
    date date  NOT NULL,
    location varchar(50)  NOT NULL,
    CONSTRAINT game_pk PRIMARY KEY (id)
);

-- Table: player
CREATE TABLE player (
    cpf char(11)  NOT NULL,
    name varchar(50)  NOT NULL,
    age interval  NOT NULL,
    weigth int  NOT NULL,
    height int  NOT NULL,
    contact varchar(50)  NOT NULL,
    CONSTRAINT player_pk PRIMARY KEY (cpf)
);

-- Table: plays_for
CREATE TABLE plays_for (
    player_cpf char(11)  NOT NULL,
    team_name varchar(10)  NOT NULL,
    start_date date  NOT NULL,
    CONSTRAINT plays_for_pk PRIMARY KEY (player_cpf,team_name)
);

-- Table: plays_in
CREATE TABLE plays_in (
    player_cpf char(11)  NOT NULL,
    game_id serial  NOT NULL,
    player_position varchar(20)  NOT NULL,
    CONSTRAINT plays_in_pk PRIMARY KEY (player_cpf,game_id,player_position)
);

-- Table: team
CREATE TABLE team (
    name varchar(50)  NOT NULL,
    coach varchar(50)  NOT NULL,
    country varchar(50)  NOT NULL,
    state varchar(50)  NOT NULL,
    city varchar(50)  NOT NULL,
    CONSTRAINT team_pk PRIMARY KEY (name)
);

-- foreign keys
-- Reference: Game_team1 (table: game)
ALTER TABLE game ADD CONSTRAINT Game_team1
    FOREIGN KEY (team2_name)
    REFERENCES team (name)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Game_team2 (table: game)
ALTER TABLE game ADD CONSTRAINT Game_team2
    FOREIGN KEY (team1_name)
    REFERENCES team (name)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: plays_for_player (table: plays_for)
ALTER TABLE plays_for ADD CONSTRAINT plays_for_player
    FOREIGN KEY (player_cpf)
    REFERENCES player (cpf)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: plays_for_team (table: plays_for)
ALTER TABLE plays_for ADD CONSTRAINT plays_for_team
    FOREIGN KEY (team_name)
    REFERENCES team (name)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: plays_in_player (table: plays_in)
ALTER TABLE plays_in ADD CONSTRAINT plays_in_player
    FOREIGN KEY (player_cpf)
    REFERENCES player (cpf)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: plays_on_Game (table: plays_in)
ALTER TABLE plays_in ADD CONSTRAINT plays_on_Game
    FOREIGN KEY (game_id)
    REFERENCES game (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- End of file.

-- Popular jogo e equipes de Handebol

-- player
-- Time 1
INSERT INTO player VALUES('98765432111', 'Adriana Silva', age(timestamp '2000-10-01'), 60, 165, '3322-9977');
INSERT INTO player VALUES('98765432112', 'Marina Silva', age(timestamp '2000-09-01'), 61, 165, '3322-9978');
INSERT INTO player VALUES('98765432113', 'Paula Araujo', age(timestamp '2000-10-02'), 62, 166, '3322-9979');
INSERT INTO player VALUES('98765432114', 'Bianca da Silva', age(timestamp '2000-10-20'), 60, 166, '3322-9980');
INSERT INTO player VALUES('98765432115', 'Gabriella Soares', age(timestamp '2000-10-03'), 63, 168, '3322-9981');
INSERT INTO player VALUES('98765432116', 'Fabiana Oliveira', age(timestamp '2000-05-01'), 62, 167, '3322-9982');
INSERT INTO player VALUES('98765432117', 'Karla Queiroz', age(timestamp '2000-02-09'), 60, 165, '3322-9983');
INSERT INTO player VALUES('98765432118', 'Rafaella Paiva', age(timestamp '2000-10-01'), 60, 165, '3322-9984');
INSERT INTO player VALUES('98765432119', 'Marina Castro', age(timestamp '1999-12-31'), 61, 167, '3322-9985');
INSERT INTO player VALUES('98765432120', 'Lais Paiva', age(timestamp '2000-10-04'), 55, 159, '3322-9986');

-- Time 2
INSERT INTO player VALUES('98765472111', 'Carla Silva', age(timestamp '2000-10-06'), 61, 165, '3322-9877');
INSERT INTO player VALUES('98765472112', 'Lara Barbosa', age(timestamp '2000-09-05'), 62, 165, '3322-9878');
INSERT INTO player VALUES('98765472113', 'Liz Bela', age(timestamp '2000-10-01'), 63, 166, '3322-9879');
INSERT INTO player VALUES('98765472114', 'Patrícia Freitas', age(timestamp '2000-02-20'), 64, 166, '3322-9880');
INSERT INTO player VALUES('98765472115', 'Yona Brito', age(timestamp '2000-10-04'), 65, 168, '3322-9881');
INSERT INTO player VALUES('98765472116', 'Jade Oliveira', age(timestamp '2000-05-06'), 63, 167, '3322-9882');
INSERT INTO player VALUES('98765472117', 'Dayane dos Santos', age(timestamp '2000-02-27'), 61, 165, '3322-9883');
INSERT INTO player VALUES('98765472118', 'Jurema Lima', age(timestamp '2000-03-01'), 62, 165, '3322-9884');
INSERT INTO player VALUES('98765472119', 'Beatriz Souza', age(timestamp '1999-08-12'), 63, 167, '3322-9885');
INSERT INTO player VALUES('98765472120', 'Hiane Borges', age(timestamp '2000-10-02'), 56, 159, '3322-9886');

-- Time 3
INSERT INTO player VALUES('98765492111', 'Hayley Williams', age(timestamp '2000-10-07'), 60, 166, '3422-9977');
INSERT INTO player VALUES('98765492112', 'Lana del Rey', age(timestamp '2000-09-08'), 61, 166, '3422-9978');
INSERT INTO player VALUES('98765492113', 'Amy Lee', age(timestamp '2000-11-02'), 62, 167, '3422-9979');
INSERT INTO player VALUES('98765492114', 'Zendaya Coleman', age(timestamp '2000-11-10'), 60, 167, '3422-9980');
INSERT INTO player VALUES('98765492115', 'Emannuelly Freitas', age(timestamp '2000-08-10'), 67, 170, '3422-9981');
INSERT INTO player VALUES('98765492116', 'Luiza Silva', age(timestamp '2000-07-01'), 62, 168, '3422-9982');
INSERT INTO player VALUES('98765492117', 'Carolina Queiroz', age(timestamp '2000-07-09'), 60, 166, '3422-9983');
INSERT INTO player VALUES('98765492118', 'Karine Paiva', age(timestamp '2000-11-01'), 60, 166, '3422-9984');
INSERT INTO player VALUES('98765492119', 'Keyla Souza', age(timestamp '1999-11-30'), 61, 168, '3422-9985');
INSERT INTO player VALUES('98765492120', 'Izabella Ribeiro', age(timestamp '2000-11-13'), 55, 160, '3422-9986');

-- Time 4
INSERT INTO player VALUES('98765422111', 'Tais Nunes', age(timestamp '2000-07-01'), 61, 166, '3372-9977');
INSERT INTO player VALUES('98765422112', 'Juliana Silva', age(timestamp '2000-07-07'), 62, 166, '3372-9978');
INSERT INTO player VALUES('98765422113', 'Bruna Santos', age(timestamp '2000-11-02'), 63, 167, '3372-9979');
INSERT INTO player VALUES('98765422114', 'Cristiana Felix', age(timestamp '2000-11-10'), 62, 167, '3372-9980');
INSERT INTO player VALUES('98765422115', 'Olivia Soares', age(timestamp '2000-06-03'), 64, 169, '3372-9981');
INSERT INTO player VALUES('98765422116', 'Jaciane Oliveira', age(timestamp '2000-06-01'), 63, 168, '3372-9982');
INSERT INTO player VALUES('98765422117', 'Linda Flores', age(timestamp '2000-04-09'), 61, 166, '3372-9983');
INSERT INTO player VALUES('98765422118', 'Rosa Diaz', age(timestamp '2000-04-01'), 61, 166, '3372-9984');
INSERT INTO player VALUES('98765422119', 'Gina Linetti', age(timestamp '1999-01-12'), 62, 168, '3372-9985');
INSERT INTO player VALUES('98765422120', 'Amy Santiago', age(timestamp '2000-01-04'), 56, 160, '3372-9986');

-- team
INSERT INTO team VALUES('Azul','Joana Chaves', 'Brasil', 'Paraíba', 'Campina Grande');
INSERT INTO team VALUES('Amarelo','Sabrina Souto', 'Brasil', 'Paraíba', 'João Pessoa');
INSERT INTO team VALUES('Vermelho','Lucia Vilar', 'Brasil', 'Pernambuco', 'Recife');
INSERT INTO team VALUES('Verde','Giselle Feitosa', 'Brasil', 'Ceará', 'Fortaleza');

-- plays_for
-- Time 1
INSERT INTO plays_for VALUES('98765432111', 'Azul', '2020-10-08');
INSERT INTO plays_for VALUES('98765432112', 'Azul', '2020-10-08');
INSERT INTO plays_for VALUES('98765432113', 'Azul', '2020-10-08');
INSERT INTO plays_for VALUES('98765432114', 'Azul', '2020-10-08');
INSERT INTO plays_for VALUES('98765432115', 'Azul', '2020-10-08');
INSERT INTO plays_for VALUES('98765432116', 'Azul', '2020-10-08');
INSERT INTO plays_for VALUES('98765432117', 'Azul', '2020-10-08');
INSERT INTO plays_for VALUES('98765432118', 'Azul', '2020-10-08');
INSERT INTO plays_for VALUES('98765432119', 'Azul', '2020-10-08');
INSERT INTO plays_for VALUES('98765432120', 'Azul', '2020-10-08');

-- Time 2
INSERT INTO plays_for VALUES('98765472111', 'Amarelo', '2020-10-06');
INSERT INTO plays_for VALUES('98765472112', 'Amarelo', '2020-10-06');
INSERT INTO plays_for VALUES('98765472113', 'Amarelo', '2020-10-06');
INSERT INTO plays_for VALUES('98765472114', 'Amarelo', '2020-10-06');
INSERT INTO plays_for VALUES('98765472115', 'Amarelo', '2020-10-06');
INSERT INTO plays_for VALUES('98765472116', 'Amarelo', '2020-10-06');
INSERT INTO plays_for VALUES('98765472117', 'Amarelo', '2020-10-06');
INSERT INTO plays_for VALUES('98765472118', 'Amarelo', '2020-10-06');
INSERT INTO plays_for VALUES('98765472119', 'Amarelo', '2020-10-06');
INSERT INTO plays_for VALUES('98765472120', 'Amarelo', '2020-10-06');

-- Time 3
INSERT INTO plays_for VALUES('98765492111', 'Vermelho', '2020-10-07');
INSERT INTO plays_for VALUES('98765492112', 'Vermelho', '2020-10-07');
INSERT INTO plays_for VALUES('98765492113', 'Vermelho', '2020-10-07');
INSERT INTO plays_for VALUES('98765492114', 'Vermelho', '2020-10-07');
INSERT INTO plays_for VALUES('98765492115', 'Vermelho', '2020-10-07');
INSERT INTO plays_for VALUES('98765492116', 'Vermelho', '2020-10-07');
INSERT INTO plays_for VALUES('98765492117', 'Vermelho', '2020-10-07');
INSERT INTO plays_for VALUES('98765492118', 'Vermelho', '2020-10-07');
INSERT INTO plays_for VALUES('98765492119', 'Vermelho', '2020-10-07');
INSERT INTO plays_for VALUES('98765492120', 'Vermelho', '2020-10-07');

-- Time 4
INSERT INTO plays_for VALUES('98765422111', 'Verde', '2020-10-04');
INSERT INTO plays_for VALUES('98765422112', 'Verde', '2020-10-04');
INSERT INTO plays_for VALUES('98765422113', 'Verde', '2020-10-04');
INSERT INTO plays_for VALUES('98765422114', 'Verde', '2020-10-04');
INSERT INTO plays_for VALUES('98765422115', 'Verde', '2020-10-04');
INSERT INTO plays_for VALUES('98765422116', 'Verde', '2020-10-04');
INSERT INTO plays_for VALUES('98765422117', 'Verde', '2020-10-04');
INSERT INTO plays_for VALUES('98765422118', 'Verde', '2020-10-04');
INSERT INTO plays_for VALUES('98765422119', 'Verde', '2020-10-04');
INSERT INTO plays_for VALUES('98765422120', 'Verde', '2020-10-04');

-- game
INSERT INTO game VALUES(1, 'Azul', 'Amarelo', 7, 4, '2021/09/02', 'Quadra do Catolé');
INSERT INTO game VALUES(2, 'Vermelho', 'Verde', 10, 5, '2021/09/04', 'Quadra da Liberdade');

-- plays_in
-- Time 1
INSERT INTO plays_in VALUES('98765432111', 1, 'goleira');
INSERT INTO plays_in VALUES('98765432112', 1, 'armadora central');
INSERT INTO plays_in VALUES('98765432113', 1, 'meia esquerda');
INSERT INTO plays_in VALUES('98765432114', 1, 'meia direita');
INSERT INTO plays_in VALUES('98765432115', 1, 'ponta');
INSERT INTO plays_in VALUES('98765432116', 1, 'ponta');
INSERT INTO plays_in VALUES('98765432117', 1, 'pivô');

-- Time 2
INSERT INTO plays_in VALUES('98765472111', 1, 'goleira');
INSERT INTO plays_in VALUES('98765472112', 1, 'armadora central');
INSERT INTO plays_in VALUES('98765472113', 1, 'meia esquerda');
INSERT INTO plays_in VALUES('98765472114', 1, 'meia direita');
INSERT INTO plays_in VALUES('98765472115', 1, 'ponta');
INSERT INTO plays_in VALUES('98765472116', 1, 'ponta');
INSERT INTO plays_in VALUES('98765472117', 1, 'pivô');

-- Time 3
INSERT INTO plays_in VALUES('98765492111', 2, 'goleira');
INSERT INTO plays_in VALUES('98765492112', 2, 'armadora central');
INSERT INTO plays_in VALUES('98765492113', 2, 'meia esquerda');
INSERT INTO plays_in VALUES('98765492114', 2, 'meia direita');
INSERT INTO plays_in VALUES('98765492115', 2, 'ponta');
INSERT INTO plays_in VALUES('98765492116', 2, 'ponta');
INSERT INTO plays_in VALUES('98765492117', 2, 'pivô');

-- Time 4
INSERT INTO plays_in VALUES('98765422111', 2, 'goleira');
INSERT INTO plays_in VALUES('98765422112', 2, 'armadora central');
INSERT INTO plays_in VALUES('98765422113', 2, 'meia esquerda');
INSERT INTO plays_in VALUES('98765422114', 2, 'meia direita');
INSERT INTO plays_in VALUES('98765422115', 2, 'ponta');
INSERT INTO plays_in VALUES('98765422116', 2, 'ponta');
INSERT INTO plays_in VALUES('98765422117', 2, 'pivô');
