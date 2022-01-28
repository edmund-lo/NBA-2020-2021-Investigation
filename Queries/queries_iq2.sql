----- (g) Average points for top players of each statistic ------

SELECT avg(pts) FROM player;

SELECT avg(pts) FROM (SELECT * FROM player ORDER BY "pts" desc limit 20) x;

SELECT avg(pts) as "mp_avg" FROM (SELECT * FROM player ORDER BY "mp" desc limit 20) x;

SELECT avg(pts) as "fg_avg" FROM (SELECT * FROM player ORDER BY "fg" desc limit 20) x;

SELECT avg(pts) as "fga_avg" FROM (SELECT * FROM player ORDER BY "fga" desc limit 20) x;

SELECT avg(pts) as "FG%_avg" FROM (SELECT * FROM player ORDER BY "FG%" desc limit 20) x;

SELECT avg(pts) as "3P_avg" FROM (SELECT * FROM player ORDER BY "3P" desc limit 20) x;

SELECT avg(pts) as "3PA_avg" FROM (SELECT * FROM player ORDER BY "3PA" desc limit 20) x;

SELECT avg(pts) as "3P%_avg" FROM (SELECT * FROM player ORDER BY "3P%" desc limit 20) x;

SELECT avg(pts) as "2P_avg" FROM (SELECT * FROM player ORDER BY "2P" desc limit 20) x;

SELECT avg(pts) as "2PA_avg" FROM (SELECT * FROM player ORDER BY "2PA" desc limit 20) x;

SELECT avg(pts) as "2P%_avg" FROM (SELECT * FROM player ORDER BY "2P%" desc limit 20) x;

SELECT avg(pts) as "eFG%_avg" FROM (SELECT * FROM player ORDER BY "eFG%" desc limit 20) x;

SELECT avg(pts) as "ft_avg" FROM (SELECT * FROM player ORDER BY "ft" desc limit 20) x;

SELECT avg(pts) as "fta_avg" FROM (SELECT * FROM player ORDER BY "fta" desc limit 20) x;

SELECT avg(pts) as "FT%_avg" FROM (SELECT * FROM player ORDER BY "FT%" desc limit 20) x;

SELECT avg(pts) as "orb_avg" FROM (SELECT * FROM player ORDER BY "orb" desc limit 20) x;

SELECT avg(pts) as "drb_avg" FROM (SELECT * FROM player ORDER BY "drb" desc limit 20) x;

SELECT avg(pts) as "trb_avg" FROM (SELECT * FROM player ORDER BY "trb" desc limit 20) x;

SELECT avg(pts) as "ast_avg" FROM (SELECT * FROM player ORDER BY "ast" desc limit 20) x;

SELECT avg(pts) as "stl_avg" FROM (SELECT * FROM player ORDER BY "stl" desc limit 20) x;

SELECT avg(pts) as "blk_avg" FROM (SELECT * FROM player ORDER BY "blk" desc limit 20) x;

SELECT avg(pts) as "tov_avg" FROM (SELECT * FROM player ORDER BY "tov" desc limit 20) x;

SELECT avg(pts) as "pf_avg" FROM (SELECT * FROM player ORDER BY "pf" desc limit 20) x;

------ (h) Attempts vs Accuracy ------------------------------

SELECT avg("2PA") FROM player;

SELECT avg("2PA") FROM (SELECT * FROM player ORDER BY "2P%" desc limit 20) x;

SELECT avg("fga") FROM player;

SELECT avg("fga") FROM (SELECT * FROM player ORDER BY "FG%" desc limit 20) x;
