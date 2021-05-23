-- Diferença de ouro média entre vermelhos e azuis
SELECT minuto, AVG(ouro)
FROM ouros
WHERE tipo = 'golddiff'
GROUP BY minuto;

-- Diferença de ouro média entre vermelhos e azuis quando azuis ganham
SELECT minuto, AVG(ouro)
FROM ouros
WHERE tipo = 'golddiff' AND id_partida IN 
		(
	    SELECT id_partida 
			FROM infos_partida 
			WHERE resultado_azul IS TRUE
    )
GROUP BY minuto;