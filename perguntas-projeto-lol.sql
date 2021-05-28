-- Diferen�a de ouro m�dia entre vermelhos e azuis
SELECT minuto, AVG(ouro)
FROM ouros
WHERE tipo = 'golddiff'
GROUP BY minuto;

-- Diferen�a de ouro m�dia entre vermelhos e azuis quando azuis ganham
SELECT minuto, AVG(ouro)
FROM ouros
WHERE tipo = 'golddiff' AND id_partida IN 
		(
	    SELECT id_partida 
			FROM infos_partida 
			WHERE resultado_azul IS TRUE
    )
GROUP BY minuto;

-- Criação de view semelhante a tabela mortes, mas com a rota do jogador em vez do seu username
CREATE VIEW mortes_rotas AS
    SELECT mortes.id_partida, x_pos, y_pos, tempo,
        CASE 
            WHEN sigla_azul || ' ' || jogador_cacador_azul = matador THEN 'Selva'
            WHEN sigla_azul || ' ' || jogador_atirador_azul = matador THEN 'Inferior'
            WHEN sigla_azul || ' ' || jogador_topo_azul = matador THEN 'Topo'
            WHEN sigla_azul || ' ' || jogador_meio_azul = matador THEN 'Meio'
            WHEN sigla_azul || ' ' || jogador_suporte_azul = matador THEN 'Suporte'
        END AS killer,
        CASE 
            WHEN sigla_azul || ' ' || jogador_cacador_azul = assist_1 THEN 'Selva'
            WHEN sigla_azul || ' ' || jogador_atirador_azul = assist_1 THEN 'Inferior'
            WHEN sigla_azul || ' ' || jogador_topo_azul = assist_1 THEN 'Topo'
            WHEN sigla_azul || ' ' || jogador_meio_azul = assist_1 THEN 'Meio'
            WHEN sigla_azul || ' ' || jogador_suporte_azul = assist_1 THEN 'Suporte'
        END AS assistant_1,
        CASE 
            WHEN sigla_azul || ' ' || jogador_cacador_azul = assist_2 THEN 'Selva'
            WHEN sigla_azul || ' ' || jogador_atirador_azul = assist_2 THEN 'Inferior'
            WHEN sigla_azul || ' ' || jogador_topo_azul = assist_2 THEN 'Topo'
            WHEN sigla_azul || ' ' || jogador_meio_azul = assist_2 THEN 'Meio'
            WHEN sigla_azul || ' ' || jogador_suporte_azul = assist_2 THEN 'Suporte'
        END AS assistant_2,
        CASE 
            WHEN sigla_azul || ' ' || jogador_cacador_azul = assist_3 THEN 'Selva'
            WHEN sigla_azul || ' ' || jogador_atirador_azul = assist_3 THEN 'Inferior'
            WHEN sigla_azul || ' ' || jogador_topo_azul = assist_3 THEN 'Topo'
            WHEN sigla_azul || ' ' || jogador_meio_azul = assist_3 THEN 'Meio'
            WHEN sigla_azul || ' ' || jogador_suporte_azul = assist_3 THEN 'Suporte'
        END AS assistant_3,
        CASE 
            WHEN sigla_azul || ' ' || jogador_cacador_azul = assist_4 THEN 'Selva'
            WHEN sigla_azul || ' ' || jogador_atirador_azul = assist_4 THEN 'Inferior'
            WHEN sigla_azul || ' ' || jogador_topo_azul = assist_4 THEN 'Topo'
            WHEN sigla_azul || ' ' || jogador_meio_azul = assist_4 THEN 'Meio'
            WHEN sigla_azul || ' ' || jogador_suporte_azul = assist_4 THEN 'Suporte'
        END AS assistant_4,
        CASE 
            WHEN sigla_vermelho || ' ' || jogador_cacador_vermelho = abatido THEN 'Selva'
            WHEN sigla_vermelho || ' ' || jogador_atirador_vermelho = abatido THEN 'Inferior'
            WHEN sigla_vermelho || ' ' || jogador_topo_vermelho = abatido THEN 'Topo'
            WHEN sigla_vermelho || ' ' || jogador_meio_vermelho = abatido THEN 'Meio'
            WHEN sigla_vermelho || ' ' || jogador_suporte_vermelho = abatido THEN 'Suporte'
        END AS red_victim
FROM infos_partida
INNER JOIN mortes ON infos_partida.id_partida = mortes.id_partida
WHERE equipe ILIKE 'bkills';

<<<<<<< HEAD

-- Dispersão de abates realizados pelo time azul quando ele venceu entre os minutos 0 e 10

SELECT x_pos, y_pos
FROM infos_partida
INNER JOIN mortes ON infos_partida.id_partida = mortes.id_partida
WHERE resultado_azul IS TRUE AND equipe ILIKE 'bkills' AND tempo BETWEEN 0 AND 10;

-- Dispersão de abates realizados pelo time azul quando ele venceu entre os minutos 10 e 20

SELECT x_pos, y_pos
FROM infos_partida
INNER JOIN mortes ON infos_partida.id_partida = mortes.id_partida
WHERE resultado_azul IS TRUE AND equipe ILIKE 'bkills' AND tempo BETWEEN 10 AND 20;

-- Dispersão de abates realizados pelo time azul quando ele venceu entre os minutos 20 e 40

SELECT *
FROM infos_partida
INNER JOIN mortes ON infos_partida.id_partida = mortes.id_partida
WHERE resultado_azul IS TRUE AND equipe ILIKE 'bkills' AND tempo BETWEEN 20 AND 40;
=======
-- Os jogadores da rota da selva matam mais jogadores de quais rotas inimigas?
SELECT red_victim, COUNT(red_victim)::NUMERIC(10,2) / (SELECT COUNT(*) FROM mortes_rotas WHERE killer = 'Selva' AND red_victim IS NOT NULL) * 100 as percent
FROM mortes_rotas
WHERE killer = 'Selva' AND red_victim IS NOT NULL
GROUP BY red_victim
ORDER BY percent DESC;

-- Os jogadores da rota de cima matam mais jogadores de quais rotas inimigas?

SELECT red_victim, COUNT(red_victim)::NUMERIC(10,2) / (SELECT COUNT(*) FROM mortes_rotas WHERE killer = 'Topo' AND red_victim IS NOT NULL) * 100 as percent
FROM mortes_rotas
WHERE killer = 'Topo' AND red_victim IS NOT NULL
GROUP BY red_victim
ORDER BY percent DESC;

-- Os jogadores da rota do meio matam mais jogadores de quais rotas inimigas?
SELECT red_victim, COUNT(red_victim)::NUMERIC(10,2) / (SELECT COUNT(*) FROM mortes_rotas WHERE killer = 'Meio' AND red_victim IS NOT NULL) * 100 as percent
FROM mortes_rotas
WHERE killer = 'Meio' AND red_victim IS NOT NULL
GROUP BY red_victim
ORDER BY percent DESC;

-- Os jogadores da rota inferior matam mais jogadores de quais rotas inimigas?
SELECT red_victim, COUNT(red_victim)::NUMERIC(10,2) / (SELECT COUNT(*) FROM mortes_rotas WHERE killer = 'Inferior' AND red_victim IS NOT NULL) * 100 as percent
FROM mortes_rotas
WHERE killer = 'Inferior' AND red_victim IS NOT NULL
GROUP BY red_victim
ORDER BY percent DESC;

-- Os jogadores de suporte matam mais jogadores de quais rotas inimigas?
SELECT red_victim, COUNT(red_victim)::NUMERIC(10,2) / (SELECT COUNT(*) FROM mortes_rotas WHERE killer = 'Suporte' AND red_victim IS NOT NULL) * 100 as percent
FROM mortes_rotas
WHERE killer = 'Suporte' AND red_victim IS NOT NULL
GROUP BY red_victim
ORDER BY percent DESC;

-- Os jogadores de quais rotas matam mais?
SELECT killer, COUNT(killer)::NUMERIC(10,2) / (SELECT COUNT(*) FROM mortes_rotas) * 100 AS percent
FROM mortes_rotas
WHERE killer IS NOT NULL
GROUP BY killer
ORDER BY percent DESC;

-- Os jogadores de quais rotas ajudam a matar mais? - assistente 1
SELECT assistant_1, COUNT(assistant_1)::NUMERIC(10,2) / (SELECT COUNT(*) FROM mortes_rotas WHERE assistant_1 IS NOT NULL) * 100 AS percent
FROM mortes_rotas
WHERE assistant_1 IS NOT NULL
GROUP BY assistant_1
ORDER BY percent DESC;

-- Os jogadores de quais rotas ajudam a matar mais? - assistente 2
SELECT assistant_2, COUNT(assistant_2)::NUMERIC(50,2) / (SELECT COUNT(*) FROM mortes_rotas WHERE assistant_2 IS NOT NULL) * 100 AS percent
FROM mortes_rotas
WHERE assistant_2 IS NOT NULL
GROUP BY assistant_2
ORDER BY percent DESC;

-- Os jogadores de quais rotas ajudam a matar mais? - assistente 3
SELECT assistant_3, COUNT(assistant_3)::NUMERIC(10,2) / (SELECT COUNT(*) FROM mortes_rotas WHERE assistant_3 IS NOT NULL) * 100 AS percent
FROM mortes_rotas
WHERE assistant_3 IS NOT NULL
GROUP BY assistant_3
ORDER BY percent DESC;

-- Os jogadores de quais rotas ajudam a matar mais? - assistente 4
SELECT assistant_4, COUNT(assistant_4)::NUMERIC(100,2) / (SELECT COUNT(*) FROM mortes_rotas WHERE assistant_4 IS NOT NULL) * 100 AS percent
FROM mortes_rotas
WHERE assistant_4 IS NOT NULL
GROUP BY assistant_4
ORDER BY percent DESC;

-- percentil 99 da duração da partida
SELECT percentile_disc(0.99) within group (order by duracao_jogo)
FROM infos_partida;



>>>>>>> 54a6ef66a72f2a85a8a79aa8ecfd8ec46a26b2d2
