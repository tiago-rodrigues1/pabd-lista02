USE campeonato;

SELECT 
times.nome as Nome, 
times.estado as Estado, 
IFNULL(qtd_vitorias, 0) as Vitorias, 
IFNULL(qtd_derrotas, 0) as Derrotas,
IFNULL(qtd_empates, 0) as Empates
FROM times
LEFT JOIN
(
	SELECT vencedor, COUNT(vencedor) AS qtd_vitorias FROM (
		SELECT id, time1_id AS vencedor FROM partidas
		WHERE time1_gols > time2_gols
		UNION
		SELECT id, time2_id AS vencedor FROM partidas
		WHERE time1_gols < time2_gols
	) as vitorias
	GROUP BY vencedor
) AS Vitorias ON times.id = vencedor
LEFT JOIN (
		SELECT derrotado, COUNT(derrotado) AS qtd_derrotas FROM (
			SELECT id, time2_id AS derrotado FROM partidas
			WHERE time1_gols > time2_gols
			UNION
			SELECT id, time1_id AS derrotado FROM partidas
			WHERE time1_gols < time2_gols
	) AS derrotas
	GROUP BY derrotado
) AS Derrotas ON times.id = derrotado
LEFT JOIN (
	SELECT empatado, COUNT(empatado) AS qtd_empates FROM (
		SELECT id, time2_id AS empatado FROM partidas
		WHERE time1_gols = time2_gols
		UNION
		SELECT id, time1_id AS empatado FROM partidas
		WHERE time1_gols = time2_gols
	) AS empates
	GROUP BY empatado
) AS empates ON times.id = empatado;
