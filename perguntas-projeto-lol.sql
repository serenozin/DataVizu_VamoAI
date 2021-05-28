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
            WHEN sigla_azul || ' ' || jogador_cacador_azul = matador THEN 'Jungle'
            WHEN sigla_azul || ' ' || jogador_atirador_azul = matador THEN 'Bottom'
            WHEN sigla_azul || ' ' || jogador_topo_azul = matador THEN 'Top'
            WHEN sigla_azul || ' ' || jogador_meio_azul = matador THEN 'Middle'
            WHEN sigla_azul || ' ' || jogador_suporte_azul = matador THEN 'Support'
        END AS killer,
        CASE 
            WHEN sigla_azul || ' ' || jogador_cacador_azul = assist_1 THEN 'Jungle'
            WHEN sigla_azul || ' ' || jogador_atirador_azul = assist_1 THEN 'Bottom'
            WHEN sigla_azul || ' ' || jogador_topo_azul = assist_1 THEN 'Top'
            WHEN sigla_azul || ' ' || jogador_meio_azul = assist_1 THEN 'Middle'
            WHEN sigla_azul || ' ' || jogador_suporte_azul = assist_1 THEN 'Support'
        END AS assistant_1,
        CASE 
            WHEN sigla_azul || ' ' || jogador_cacador_azul = assist_2 THEN 'Jungle'
            WHEN sigla_azul || ' ' || jogador_atirador_azul = assist_2 THEN 'Bottom'
            WHEN sigla_azul || ' ' || jogador_topo_azul = assist_2 THEN 'Top'
            WHEN sigla_azul || ' ' || jogador_meio_azul = assist_2 THEN 'Middle'
            WHEN sigla_azul || ' ' || jogador_suporte_azul = assist_2 THEN 'Support'
        END AS assistant_2,
        CASE 
            WHEN sigla_azul || ' ' || jogador_cacador_azul = assist_3 THEN 'Jungle'
            WHEN sigla_azul || ' ' || jogador_atirador_azul = assist_3 THEN 'Bottom'
            WHEN sigla_azul || ' ' || jogador_topo_azul = assist_3 THEN 'Top'
            WHEN sigla_azul || ' ' || jogador_meio_azul = assist_3 THEN 'Middle'
            WHEN sigla_azul || ' ' || jogador_suporte_azul = assist_3 THEN 'Support'
        END AS assistant_3,
        CASE 
            WHEN sigla_azul || ' ' || jogador_cacador_azul = assist_4 THEN 'Jungle'
            WHEN sigla_azul || ' ' || jogador_atirador_azul = assist_4 THEN 'Bottom'
            WHEN sigla_azul || ' ' || jogador_topo_azul = assist_4 THEN 'Top'
            WHEN sigla_azul || ' ' || jogador_meio_azul = assist_4 THEN 'Middle'
            WHEN sigla_azul || ' ' || jogador_suporte_azul = assist_4 THEN 'Support'
        END AS assistant_4,
        CASE 
            WHEN sigla_vermelho || ' ' || jogador_cacador_vermelho = abatido THEN 'Jungle'
            WHEN sigla_vermelho || ' ' || jogador_atirador_vermelho = abatido THEN 'Bottom'
            WHEN sigla_vermelho || ' ' || jogador_topo_vermelho = abatido THEN 'Top'
            WHEN sigla_vermelho || ' ' || jogador_meio_vermelho = abatido THEN 'Middle'
            WHEN sigla_vermelho || ' ' || jogador_suporte_vermelho = abatido THEN 'Support'
        END AS red_victim
FROM infos_partida
INNER JOIN mortes ON infos_partida.id_partida = mortes.id_partida
WHERE equipe ILIKE 'bkills';