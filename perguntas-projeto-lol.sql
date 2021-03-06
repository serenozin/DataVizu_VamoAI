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

-- Total de ouro da equipe azul separado por função

SELECT 
    CASE 
        WHEN tipo = 'goldblueADC' THEN 'Inferior' 
        WHEN tipo = 'goldblueJungle' THEN 'Selva' 
        WHEN tipo = 'goldblueSupport' THEN 'Suporte'
        WHEN tipo = 'goldblueMiddle' THEN 'Meio'
        WHEN tipo = 'goldblueTop' THEN 'Topo'
    END AS rota,
    (sum(ouro)::NUMERIC(50, 2) / (SELECT sum(ouro) FROM ouros WHERE tipo IN ('goldblueADC','goldblueJungle','goldblueSupport','goldblueMiddle','goldblueTop'))) * 100 as total_ouro
FROM ouros
WHERE tipo in ('goldblueADC','goldblueJungle','goldblueSupport','goldblueMiddle','goldblueTop')
GROUP BY tipo
ORDER BY total_ouro DESC;

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

-- Dispersão de abates realizados pelo time azul quando ele venceu

SELECT x_pos, y_pos
FROM infos_partida
INNER JOIN mortes ON infos_partida.id_partida = mortes.id_partida
WHERE resultado_azul IS TRUE AND equipe ILIKE 'bkills';

-- Dispersão de abates realizados pelo time azul quando ele venceu 

SELECT x_pos, y_pos
FROM infos_partida
INNER JOIN mortes ON infos_partida.id_partida = mortes.id_partida
WHERE resultado_azul IS FALSE AND equipe ILIKE 'rkills';

-- Diferença de ouro média entre times quando azuis ganham no tempo de partida

SELECT minuto, AVG(ouro)
FROM ouros
WHERE tipo = 'golddiff' 
    AND id_partida IN 
        (
            SELECT id_partida FROM infos_partida 
            WHERE resultado_azul IS TRUE
        )
GROUP BY minuto;

-- Diferença de ouro média entre times quando vermelhos ganham no tempo de partida

SELECT minuto, AVG(ouro)
FROM ouros
WHERE tipo = 'golddiff' 
    AND id_partida IN 
        (
            SELECT id_partida FROM infos_partida 
            WHERE resultado_azul IS FALSE
        )
GROUP BY minuto;

-- Diferença de ouro média entre vermelhos e azuis nos tempos de partida

SELECT minuto, AVG(ouro)
FROM ouros
WHERE tipo = 'golddiff'
GROUP BY minuto;




>>>>>>> 54a6ef66a72f2a85a8a79aa8ecfd8ec46a26b2d2


--- Anos analisados 
select count(distinct ano)
from infos_partida

--- Tempo médio de chegada na estrutura e destruí - lá

select avg(tempo) , tipo
from estruturas 
where tipo is not null
group by tipo
order by avg(tempo) DESC


---Quantidade de Vitórias e Derrotas no geral.

select tabela1.Equipe, vitorias , derrotas
from (select Equipe , count(*) as derrotas
      from(
            select sigla_azul as Equipe
            from infos_partida
            where resultado_azul is false 
            union all
            select sigla_vermelho as Equipe
            from infos_partida
            where resultado_vermelho is false)
infos_partida
group by Equipe
order by derrotas desc) as tabela1
inner join (select Equipe , count(*) as vitorias
        from(
        select sigla_azul as Equipe
        from infos_partida
        where resultado_azul is true 
        union all
        select sigla_vermelho as Equipe
        from infos_partida
        where resultado_vermelho is true)
infos_partida
group by Equipe
order by vitorias desc) as tabela2
on tabela1.Equipe = tabela2.Equipe
order by vitorias desc
limit 40

--- Quantas partidas estão sendo analisdas e quais campeonatos 

SELECT liga, count(id_partida) as total
FROM infos_partida
group by liga
order by total desc;

--- Quanto tempo, geralmente, dura uma partida?
SELECT duracao_jogo, count(id_partida)::numeric(10,2) / (SELECT COUNT(*) FROM infos_partida) * 100 as porcentagem
FROM infos_partida
GROUP BY duracao_jogo


---Duração do Jogo mais rápido.

select duracao_jogo
from infos_partida
order by duracao_jogo asc
limit 1 

--- Duração do jogo mais longo 
select MAX(duracao_jogo)
from infos_partida


----Torres destruídas de acordo com a rota
select 
    CASE 
        WHEN rota = 'MID_LANE' THEN 'Meio'
        WHEN rota = 'BOT_LANE' THEN 'Inferior'
        WHEN rota = 'TOP_LANE' THEN 'Topo'
    END AS rota,
    count(rota)::NUMERIC(50,2) / (SELECT COUNT(*) FROM estruturas where rota is not null) * 100 AS total_rota
from estruturas
where rota is not null
group by rota
order by total_rota DESC;


---Total de inibidores destruídos por rota
select 
    CASE 
        WHEN rota = 'MID_LANE' THEN 'Meio'
        WHEN rota = 'BOT_LANE' THEN 'Inferior'
        WHEN rota = 'TOP_LANE' THEN 'Topo'
    END AS rota,
    count(rota)::NUMERIC(50,2) / (SELECT COUNT(*) FROM estruturas where rota is not null and tipo ilike 'inhibitor') * 100 as total_rota
from estruturas
where rota is not null and tipo ilike 'inhibitor'
group by rota
order by total_rota DESC;


-- -- Quantidade de partidas analisadas

SELECT COUNT(*) FROM infos_partida; 


-- Quantidade de anos analisados 

select count(distinct ano)
from infos_partida

-- Quantidade de equipes 

select count(distinct(equipe))
from(
     select distinct(sigla_azul) as equipe
     from infos_partida
     union 
     select distinct(sigla_vermelho) as equipe 
     from infos_partida)
infos_partida

-- Quantidade de ligas 

select count(distinct(liga))
from infos_partida 

-- Quantidade de mortes

select count(abatido)
from mortes
where abatido is not null 

- Top 20 dos campeões mais banidos

select personagem, count(*) as contagem
from( select personagem_1 as personagem 
      from personagens_banidos 
      union all 
      select personagem_2 as personagem 
      from personagens_banidos 
      union all 
      select personagem_3 as personagem 
      from personagens_banidos
      union all
      select personagem_4 as personagem
      from personagens_banidos
      union all
      select personagem_5 as personagem 
      from personagens_banidos) 
personagens_banidos 
where personagem is not null
group by personagem
order by contagem desc
limit 20


-- Top 15 campeões mais escolhidos sem distinção de função 

SELECT personagem, COUNT(personagem) as contagem
from (
    SELECT personagem_topo_azul AS personagem 
    FROM infos_partida 
    
    UNION ALL 
    
    SELECT personagem_topo_vermelho AS personagem
    FROM infos_partida 
    
    UNION ALL 
    
    SELECT personagem_cacador_azul AS personagem
    FROM infos_partida 
    
    UNION ALL 
    
    SELECT personagem_cacador_vermelho AS personagem
    FROM infos_partida 
    
    UNION ALL 
    
    SELECT personagem_meio_azul AS personagem
    FROM infos_partida 
    
    UNION ALL 
    
    SELECT personagem_meio_vermelho AS personagem
    FROM infos_partida
    
    UNION ALL
    
    SELECT personagem_atirador_azul AS personagem
    FROM infos_partida 
    
    UNION ALL 
    
    SELECT personagem_atirador_vermelho AS personagem
    FROM infos_partida 
    
    UNION ALL 
    
    SELECT personagem_suporte_azul AS personagem
    FROM infos_partida 
    
    UNION ALL 
    
    SELECT personagem_suporte_vermelho AS personagem
    FROM infos_partida 
)
infos_partida
group by personagem
order by contagem desc
limit 15;
