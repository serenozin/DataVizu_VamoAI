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