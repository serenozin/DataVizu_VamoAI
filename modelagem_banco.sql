CREATE TABLE infos_partida(
		liga VARCHAR(15),
		ano VARCHAR(4),
		temporada VARCHAR(10),
		tipo_torneio VARCHAR(30),
		
		sigla_azul VARCHAR(7),
		resultado_azul BOOLEAN, 
		resultado_vermelho BOOLEAN, 
		sigla_vermelho VARCHAR(7), 
		duracao_jogo INT, 
		
		jogador_topo_azul VARCHAR(20),
		personagem_topo_azul VARCHAR(20),
		jogador_cacador_azul VARCHAR(20),
		personagem_cacador_azul VARCHAR(20),
		jogador_meio_azul VARCHAR(20),
		personagem_meio_azul VARCHAR(20),
		jogador_atirador_azul VARCHAR(20),
		personagem_atirador_azul VARCHAR(20),
		jogador_suporte_azul VARCHAR(20),
		personagem_suporte_azul VARCHAR(20),
		
		jogador_topo_vermelho VARCHAR(20),
		personagem_topo_vermelho VARCHAR(20),
		jogador_cacador_vermelho VARCHAR(20),
		personagem_cacador_vermelho VARCHAR(20),
		jogador_meio_vermelho VARCHAR(20),
		personagem_meio_vermelho VARCHAR(20),
		jogador_atirador_vermelho VARCHAR(20),
		personagem_atirador_vermelho VARCHAR(20),
		jogador_suporte_vermelho VARCHAR(20),
		personagem_suporte_vermelho VARCHAR(20),
		id_partida VARCHAR(110) PRIMARY KEY 
);
CREATE TABLE ouros
(
	id_partida VARCHAR(110),
	tipo VARCHAR(50),
	ouro INT,
	minuto INT,
	FOREIGN KEY(id_partida) 
	REFERENCES infos_partida(id_partida)
);
CREATE TABLE mortes(
    id_partida VARCHAR(110),
    equipe VARCHAR(110),
    tempo NUMERIC(10,5),
    abatido VARCHAR(110),
    matador varchar(110),
    assist_1 VARCHAR(110),
    assist_2 VARCHAR(110),
    assist_3 VARCHAR(110),
    assist_4 VARCHAR(110),
    x_pos VARCHAR(255),
    y_pos VARCHAR(255),
		FOREIGN KEY(id_partida) 
		REFERENCES infos_partida(id_partida)
);
CREATE TABLE estruturas(
    id_partida VARCHAR(110),
    equipe VARCHAR(255),
    tempo NUMERIC(10,5),
    rota VARCHAR(110),
    tipo VARCHAR(110),
		FOREIGN KEY(id_partida) 
		REFERENCES infos_partida(id_partida)
);
CREATE TABLE personagens_banidos(
		id_partida VARCHAR(110),
		equipe VARCHAR(25),
		personagem_1 VARCHAR(25),
		personagem_2 VARCHAR(25),
		personagem_3 VARCHAR(25),
		personagem_4 VARCHAR(25),
		personagem_5 VARCHAR(25),
		FOREIGN KEY(id_partida) 
		REFERENCES infos_partida(id_partida)
);
CREATE TABLE monstros(
		id_partida VARCHAR(110),
		equipe VARCHAR(25),
		tempo NUMERIC(5,3),
		tipo VARCHAR(15),
		FOREIGN KEY(id_partida) 
		REFERENCES infos_partida(id_partida)
);