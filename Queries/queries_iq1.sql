\echo -- What team stats have the greatest effect on a team’s win loss percentage?

DROP VIEW IF EXISTS teamRank CASCADE;
DROP VIEW IF EXISTS topTeams CASCADE;
DROP VIEW IF EXISTS middleTeams CASCADE;
DROP VIEW IF EXISTS bottomTeams CASCADE;
DROP VIEW IF EXISTS avStats CASCADE;
DROP VIEW IF EXISTS "FG%rank" CASCADE;
DROP VIEW IF EXISTS "3P%rank" CASCADE;
DROP VIEW IF EXISTS rankedStats CASCADE;
DROP VIEW IF EXISTS differentials CASCADE;
DROP VIEW IF EXISTS avgDifferentials CASCADE;
DROP VIEW IF EXISTS leadingScorers CASCADE;
DROP VIEW IF EXISTS teamAge CASCADE;
DROP VIEW IF EXISTS teamAgeRank CASCADE;
DROP VIEW IF EXISTS ageDifferentials CASCADE;

\echo -------------------- Part (a) --------------------
\echo -- Teams ranked by W/L%
CREATE VIEW teamRank AS
SELECT *,
rank() OVER (ORDER BY "W/L%" DESC)
FROM Team
ORDER BY "W/L%" DESC;

\echo -- Top 10 teams by W/L%
CREATE VIEW topTeams AS
SELECT *
FROM teamRank
FETCH FIRST 10 ROWS ONLY;

\echo -- Middle 10 teams by W/L%
CREATE VIEW middleTeams AS
SELECT *
FROM teamRank
OFFSET 10 ROWS
FETCH FIRST 10 ROWS ONLY;

\echo -- Bottom 10 teams by W/L%
CREATE VIEW bottomTeams AS
SELECT *
FROM teamRank
OFFSET 20 ROWS
FETCH FIRST 10 ROWS ONLY;

\echo -------------------- Part (b) --------------------
\echo -- Compare average stats of topTeams and bottomTeams
CREATE VIEW avStats AS
(SELECT 'top' AS group, avg(wins) AS aWins, avg(losses) AS aLosses,
avg("W/L%") AS "aW/L%", avg(FG) AS aFG, avg(FGA) AS aFGA, avg("FG%") AS "aFG%",
avg("3P") AS "a3P", avg("3PA") AS "a3PA", avg("3P%") AS "a3P%",
avg("2P") AS "a2P", avg("2PA") AS "a2PA", avg("2P%") AS "a2P%",
avg(FT) AS aFT, avg(FTA) AS aFTA, avg("FT%") AS "aFT%",
avg(ORB) AS aORB, avg(DRB) AS aDRB, avg(TRB) AS aTRB,
avg(AST) AS aAST, avg(STL) AS aSTL, avg(BLK) AS aBLK,
avg(TOV) AS aTOV, avg(PF) AS aPF, avg(PTS) AS aPTS
FROM topTeams)
UNION
(SELECT 'bottom' AS group, avg(wins) AS aWins, avg(losses) AS aLosses,
avg("W/L%") AS "aW/L%", avg(FG) AS aFG, avg(FGA) AS aFGA, avg("FG%") AS "aFG%",
avg("3P") AS "a3P", avg("3PA") AS "a3PA", avg("3P%") AS "a3P%",
avg("2P") AS "a2P", avg("2PA") AS "a2PA", avg("2P%") AS "a2P%",
avg(FT) AS aFT, avg(FTA) AS aFTA, avg("FT%") AS "aFT%",
avg(ORB) AS aORB, avg(DRB) AS aDRB, avg(TRB) AS aTRB,
avg(AST) AS aAST, avg(STL) AS aSTL, avg(BLK) AS aBLK,
avg(TOV) AS aTOV, avg(PF) AS aPF, avg(PTS) AS aPTS
FROM bottomTeams);

\echo -------------------- Part (c) --------------------
\echo -- Teams ranked by FG%
CREATE VIEW "FG%rank" AS
SELECT tid, "FG%", rank,
rank() OVER (ORDER BY "FG%" DESC) AS "FG%rank"
FROM teamRank
ORDER BY "W/L%" DESC;

\echo -- FG% ranks for topTeams
SELECT tid, "FG%", rank, "FG%rank"
FROM "FG%rank"
WHERE tid IN (SELECT tid FROM topTeams);

\echo -- FG% ranks for bottomTeams
SELECT tid, "FG%", rank, "FG%rank"
FROM "FG%rank"
WHERE tid IN (SELECT tid FROM bottomTeams);

\echo -- Teams ranked by 3P%
CREATE VIEW "3P%rank" AS
SELECT tid, "3P%", rank,
rank() OVER (ORDER BY "3P%" DESC) AS "3P%rank"
FROM teamRank
ORDER BY "W/L%" DESC;

\echo -- 3P% ranks for topTeams
SELECT tid, "3P%", rank, "3P%rank"
FROM "3P%rank"
WHERE tid IN (SELECT tid FROM topTeams);

\echo -- 3P% ranks for bottomTeams
SELECT tid, "3P%", rank, "3P%rank"
FROM "3P%rank"
WHERE tid IN (SELECT tid FROM bottomTeams);

\echo -------------------- Part (d) --------------------
\echo -- Ranks for all team stats
CREATE VIEW rankedStats AS
SELECT tid, rank,
rank() OVER (ORDER BY FG DESC) AS FGrank,
rank() OVER (ORDER BY FGA DESC) AS FGArank,
rank() OVER (ORDER BY "FG%" DESC) AS "FG%rank",
rank() OVER (ORDER BY "3P" DESC) AS "3Prank",
rank() OVER (ORDER BY "3PA" DESC) AS "3PArank",
rank() OVER (ORDER BY "3P%" DESC) AS "3P%rank",
rank() OVER (ORDER BY "2P" DESC) AS "2Prank",
rank() OVER (ORDER BY "2PA" DESC) AS "2PArank",
rank() OVER (ORDER BY "2P%" DESC) AS "2P%rank",
rank() OVER (ORDER BY FT DESC) AS FTrank,
rank() OVER (ORDER BY FTA DESC) AS FTArank,
rank() OVER (ORDER BY "FT%" DESC) AS "FT%rank",
rank() OVER (ORDER BY ORB DESC) AS ORBrank,
rank() OVER (ORDER BY DRB DESC) AS DRBrank,
rank() OVER (ORDER BY TRB DESC) AS TRBrank,
rank() OVER (ORDER BY AST DESC) AS ASTrank,
rank() OVER (ORDER BY STL DESC) AS STLrank,
rank() OVER (ORDER BY BLK DESC) AS BLKrank,
rank() OVER (ORDER BY TOV DESC) AS TOVrank,
rank() OVER (ORDER BY PF DESC) AS PFrank,
rank() OVER (ORDER BY PTS DESC) AS PTSrank
FROM teamRank
ORDER BY "W/L%" DESC;

\echo -- Differentials between W/L% ranking and stat ranking
CREATE VIEW differentials AS
SELECT tid, rank,
abs(FGrank - rank) AS dFGrank,
abs(FGArank - rank) AS dFGArank,
abs("FG%rank" - rank) AS "dFG%rank",
abs("3Prank" - rank) AS "d3Prank",
abs("3PArank" - rank) AS "d3PArank",
abs("3P%rank" - rank) AS "d3P%rank",
abs("2Prank" - rank) AS "d2Prank",
abs("2PArank" - rank) AS "d2PArank",
abs("2P%rank" - rank) AS "d2P%rank",
abs(FTrank - rank) AS dFTrank,
abs(FTArank - rank) AS dFTArank,
abs("FT%rank" - rank) AS "dFT%rank",
abs(ORBrank - rank) AS dORBrank,
abs(DRBrank - rank) AS dDRBrank,
abs(TRBrank - rank) AS dTRBrank,
abs(ASTrank - rank) AS dASTrank,
abs(STLrank - rank) AS dSTLrank,
abs(BLKrank - rank) AS dBLKrank,
abs(TOVrank - rank) AS dTOVrank,
abs(PFrank - rank) AS dPFrank,
abs(PTSrank - rank) AS dPTSrank
FROM rankedStats;

\echo -- Average differentials between W/L% ranking and stat ranking
CREATE VIEW avgDifferentials AS
SELECT avg(dFGrank) AS adFG, avg(dFGArank) AS adFGA,
avg("dFG%rank") AS "adFG%",
avg("d3Prank") AS "ad3P", avg("d3PArank") AS "ad3PA",
avg("d3P%rank") AS "ad3P%",
avg("d2Prank") AS "ad2P", avg("d2PArank") AS "ad2PA",
avg("d2P%rank") AS "ad2P%",
avg(dFTrank) AS adFT, avg(dFTArank) AS adFTA,
avg("dFT%rank") AS "adFT%",
avg(dORBrank) AS adORB, avg(dDRBrank) AS adDRB, avg(dTRBrank) AS adTRB,
avg(dASTrank) AS adAST, avg(dSTLrank) AS adSTL, avg(dBLKrank) AS adBLK,
avg(dTOVrank) AS adTOV, avg(dPFrank) AS adPF, avg(dPTSrank) AS adPTS
FROM differentials;

SELECT adFG, adFGA, "adFG%" from avgDifferentials;
SELECT "ad3P", "ad3PA", "ad3P%" from avgDifferentials;
SELECT "ad2P", "ad2PA", "ad2P%" from avgDifferentials;
SELECT adFT, adFTA, "adFT%" from avgDifferentials;
SELECT adORB, adDRB, adTRB from avgDifferentials;
SELECT adAST, adSTL, adBLK from avgDifferentials;
SELECT adTOV, adPF, adPTS from avgDifferentials;

\echo -- Smallest average differentials
\echo -- FG%, 3P%, PTS

\echo -------------------- Part (e) --------------------
\echo -- Players ranked by PTS per game
CREATE VIEW leadingScorers AS
SELECT pid, firstName, lastName, tid, PTS,
rank() OVER (ORDER BY PTS DESC) AS PTSrank
FROM Player
ORDER BY PTS DESC;

\echo -- Teams that have a leading scorer
SELECT tid, pid, firstName, lastName, PTS, PTSrank
FROM leadingScorers
WHERE PTSrank < 15;

\echo -- Leading scorers on topTeams
SELECT tid, pid, firstName, lastName, PTS, PTSrank
FROM leadingScorers
WHERE PTSrank < 15 AND tid in (SELECT tid FROM topTeams);

\echo -- Leading scorers on bottomTeams
SELECT tid, pid, firstName, lastName, PTS, PTSrank
FROM leadingScorers
WHERE PTSrank < 15 AND tid in (SELECT tid FROM bottomTeams);

\echo -- 8 of topTeams had a top 15 scorer
\echo -- Only 2 of bottomTeams had a top 15 scorer

\echo -------------------- Part (f) --------------------
\echo -- Average age of players on each team
CREATE VIEW teamAge AS
SELECT tid, avg(age) as aage
FROM Player
GROUP BY tid;

\echo -- Teams ranked by age from oldest to youngest
CREATE VIEW teamAgeRank AS
SELECT tid, aage,
rank() OVER (ORDER BY aage DESC) AS aagerank
FROM teamAge
ORDER BY aage DESC;

\echo -- Compare average age of top and bottom groups
(SELECT 'top' AS Group, avg(aage), avg(aagerank)
FROM teamAgeRank
WHERE tid IN (SELECT tid FROM topTeams))
UNION
(SELECT 'bottom' AS Group, avg(aage), avg(aagerank)
FROM teamAgeRank
WHERE tid IN (SELECT tid FROM bottomTeams));

\echo -- Differentials between W/L% ranking and age ranking
CREATE VIEW ageDifferentials AS
SELECT tid, rank,
abs(aagerank - rank) AS dAgerank
FROM rankedStats NATURAL JOIN teamAgeRank;

\echo -- Average differential between W/L% ranking and age ranking
SELECT avg(dAgerank) as adAge
FROM ageDifferentials;