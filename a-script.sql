USE campeonato;

SELECT
(
	SELECT nome FROM times where time1_id = times.id
)	as 'Time 1', 
time1_gols as 'Time 1 Gols',
time2_gols as 'Time 2 Gols',
(
	SELECT nome FROM times where time2_id = times.id
)	as 'Time 2' 
FROM partidas
ORDER BY partidas.id;