DROP VIEW IF EXISTS TopPlayers;
DROP VIEW IF EXISTS ExperiencedCoaches;

----------- (i) Coach experience on team success ---------------------------

SELECT avg(seasonsoverall) FROM coach WHERE playoffgames > 0;

SELECT avg(seasonsoverall) FROM coach WHERE playoffgames = 0;

SELECT avg(seasonsoverall) FROM coach WHERE tid in (SELECT tid FROM topteams);

SELECT avg(seasonsoverall) FROM coach WHERE tid in (SELECT tid FROM middleteams);

SELECT avg(seasonsoverall) FROM coach WHERE tid in (SELECT tid FROM bottomteams);

----------- (j) experience of coach and players-----------------------------

CREATE VIEW TopPlayers as (SELECT * FROM player ORDER BY PTS desc LIMIT 20);

SELECT avg(seasonsoverall) FROM coach WHERE tid in (SELECT tid FROM TopPlayers);

CREATE VIEW ExperiencedCoaches as (SELECT * FROM coach ORDER BY seasonsoverall desc LIMIT 10);

SELECT avg(pts) FROM player WHERE tid in (SELECT tid FROM experiencedcoaches);
