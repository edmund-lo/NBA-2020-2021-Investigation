DROP SCHEMA IF EXISTS Nba CASCADE;
CREATE SCHEMA Nba;
SET SEARCH_PATH TO Nba;

create domain Percentage as FLOAT 
	default null
	check (value>=0 and value <=1);

-- A team in the NBA in the 2020-2021 season
-- A tuple in this relation represents a team and 
-- its stats during the games the team played
CREATE Table Team (
	tID TEXT,
	city TEXT NOT NULL,
	name TEXT NOT NULL,
	wins INT NOT NULL,
	losses INT NOT NULL,
	"W/L%" Percentage NOT NULL,
	FG FLOAT NOT NULL,
	FGA FLOAT NOT NULL,
	"FG%" Percentage NOT NULL,
	"3P" FLOAT NOT NULL,
	"3PA" FLOAT NOT NULL,
	"3P%"	Percentage NOT NULL,
	"2P" FLOAT NOT NULL,
	"2PA" FLOAT NOT NULL,
	"2P%"	Percentage NOT NULL,
	FT FLOAT NOT NULL,
	FTA FLOAT NOT NULL,
	"FT%"	Percentage NOT NULL,
	ORB	FLOAT NOT NULL,
	DRB	FLOAT NOT NULL,
	TRB	FLOAT NOT NULL,
	AST	FLOAT NOT NULL,
	STL	FLOAT NOT NULL,
	BLK	FLOAT NOT NULL,
	TOV	FLOAT NOT NULL,
	PF FLOAT NOT NULL,
	PTS	FLOAT NOT NULL,
	PRIMARY KEY (tID)
);

-- A player in the NBA in the 2020-2021 season
-- A tuple in this relation represents a player
-- and their stats during the games they played
CREATE Table Player (
	pID INT,
	firstName TEXT NOT NULL,	
	lastName TEXT NOT NULL,	
	tID	TEXT NOT NULL,
	position TEXT NOT NULL,	
	age INT NOT NULL,
	G INT NOT NULL,
	GS INT NOT NULL,
	MP FLOAT NOT NULL,
	FG FLOAT NOT NULL,
	FGA FLOAT NOT NULL,
	"FG%" Percentage NOT NULL,
	"3P" FLOAT NOT NULL,
	"3PA" FLOAT NOT NULL,
	"3P%"	Percentage NOT NULL,
	"2P" FLOAT NOT NULL,
	"2PA" FLOAT NOT NULL,
	"2P%"	Percentage NOT NULL,
	"eFG%" Percentage NOT NULL,
	FT FLOAT NOT NULL,
	FTA FLOAT NOT NULL,
	"FT%"	Percentage NOT NULL,
	ORB	FLOAT NOT NULL,
	DRB	FLOAT NOT NULL,
	TRB	FLOAT NOT NULL,
	AST	FLOAT NOT NULL,
	STL	FLOAT NOT NULL,
	BLK	FLOAT NOT NULL,
	TOV	FLOAT NOT NULL,
	PF FLOAT NOT NULL,
	PTS FLOAT NOT NULL,
	PRIMARY KEY (pID),
	FOREIGN KEY (tID) REFERENCES Team(tID)
);

-- A game in the NBA in the 2020-2021 season
-- A tuple in this relation represents a game
-- with the scores of the teams who played
CREATE TABLE Game (
	gID		INT NOT NULL,
	date		DATE NOT NULL,
	tIDHome		TEXT,
	pointsHome	INT NOT NULL,
	tIDAway		TEXT,
	pointsAway	INT NOT NULL,
	PRIMARY KEY (gID),
	FOREIGN KEY (tIDHome) REFERENCES Team(tID),
	FOREIGN KEY (tIDAway) REFERENCES Team(tID)
);

-- A coach in the NBA in the 2020-2021 season
-- A tuple in this relation represents a coach
-- of a team and their stats.
CREATE TABLE Coach (
	cID		INT NOT NULL,
	firstName	TEXT NOT NULL,
	lastName	TEXT NOT NULL,
	tID		TEXT NOT NULL,
	seasonsFranch	INT NOT NULL,
	seasonsOverall	INT NOT NULL,
	regGames	INT NOT NULL,
	regWins		INT NOT NULL,
	regLosses	INT NOT NULL,
	playoffGames	INT NOT NULL,
	playoffWins	INT NOT NULL,
	playoffLosses	INT NOT NULL,
	PRIMARY KEY (cID),
	FOREIGN KEY (tID) REFERENCES Team(tID)
);
