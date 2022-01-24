-- Emannuelly Larissa Freitas de Melo - 119210167
-- Banco de Dados - Roteiro 07

-- Quantidade de jogos por jogadora
SELECT cpf, COUNT(y.game_id) AS qtd_Jogos FROM player AS p LEFT OUTER JOIN plays_in AS y ON p.cpf = y.player_cpf GROUP BY(p.cpf) ORDER BY COUNT(y.game_id);

-- Média de altura de jogadoras por jogo
SELECT y.game_id AS id_jogo, AVG(p.height) AS media_altura FROM player AS p JOIN plays_in AS y ON (p.cpf = y.player_cpf) GROUP BY y.game_id;

-- Idade média de jogadoras por time
SELECT f.team_name AS time, AVG(p.age) AS media_idade_jogadoras FROM player AS p JOIN plays_for AS f ON (p.cpf = f.player_cpf) GROUP BY f.team_name;
