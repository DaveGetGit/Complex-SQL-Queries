/* Write an SQL query to display the correct message (meaningful message) from the input
comments_and_translation table. */

--drop table comments_and_translations;
create table comments_and_translations
(
	id				int,
	comment			varchar(100),
	translation		varchar(100)
);

insert into comments_and_translations values
(1, 'very good', null),
(2, 'good', null),
(3, 'bad', null),
(4, 'ordinary', null),
(5, 'cdcdcdcd', 'very bad'),
(6, 'excellent', null),
(7, 'ababab', 'not satisfied'),
(8, 'satisfied', null),
(9, 'aabbaabb', 'extraordinary'),
(10, 'ccddccbb', 'medium');
commit;

select * from comments_and_translations where translation is not null;


SELECT 
      CASE WHEN translation IS NOT NULL THEN translation
	  ELSE comment
	  END AS MYRESULT 
FROM comments_and_translations


	SELECT 
	      id,
		  COALESCE(TRANSLATION,COMMENT)
	FROM COMMENTS_AND_TRANSLATIONS















	DROP TABLE source;
CREATE TABLE source
    (
        id      int,
        name    varchar(1)
    );

DROP TABLE target;
CREATE TABLE target
    (
        id      int,
        name    varchar(1)
    );

INSERT INTO source VALUES (1, 'A');
INSERT INTO source VALUES (2, 'B');
INSERT INTO source VALUES (3, 'C');
INSERT INTO source VALUES (4, 'D');

INSERT INTO target VALUES (1, 'A');
INSERT INTO target VALUES (2, 'B');
INSERT INTO target VALUES (4, 'X');
INSERT INTO target VALUES (5, 'F');

COMMIT;

SELECT * FROM SOURCE
SELECT * FROM TARGET

SELECT ID, 'ONLY IN SOURCE' AS MESSAGE FROM source WHERE ID NOT IN (SELECT ID FROM target)
UNION
SELECT ID , 'ONLY IN TARGET' AS MESSAGE FROM TARGET WHERE ID NOT IN (SELECT ID FROM SOURCE)
UNION
SELECT SOURCE.ID , 'MISMATCH' AS MESSAGE FROM SOURCE INNER JOIN TARGET ON SOURCE.ID=TARGET.ID WHERE SOURCE.NAME <> TARGET.NAME


SELECT 
    COALESCE(s.ID, t.ID) AS ID,
    CASE
        WHEN s.ID IS NOT NULL AND t.ID IS NULL THEN 'ONLY IN SOURCE'
        WHEN t.ID IS NOT NULL AND s.ID IS NULL THEN 'ONLY IN TARGET'
        WHEN s.NAME <> t.NAME THEN 'MISMATCH'
    END AS MESSAGE
FROM 
    source s
FULL JOIN 
    target t ON s.ID = t.ID
WHERE 
    s.ID IS NULL OR t.ID IS NULL OR s.NAME <> t.NAME;

SET STATISTICS IO ON
SET STATISTICS TIME ON

select 

case when t.id is null then s.id

	 when s.id is null then t.id

	 when (s.id=t.id and s.name <> t.name) then s.id

end as id

,case when t.id is null then 'New in source'

	 when s.id is null then 'New in target'

	 when (s.id=t.id and s.name <> t.name) then 'Mismatch'

 end as id

from source s

full join target t on t.id=s.id

where t.id is null

or s.id is null

or (s.id=t.id and s.name <> t.name)



/* There are 10 IPL team. write an sql query such that each team play with every other team just once. */

drop table teams;
create table teams
    (
        team_code       varchar(10),
        team_name       varchar(40)
    );

insert into teams values ('RCB', 'Royal Challengers Bangalore');
insert into teams values ('MI', 'Mumbai Indians');
insert into teams values ('CSK', 'Chennai Super Kings');
insert into teams values ('DC', 'Delhi Capitals');
insert into teams values ('RR', 'Rajasthan Royals');
insert into teams values ('SRH', 'Sunrisers Hyderbad');
insert into teams values ('PBKS', 'Punjab Kings');
insert into teams values ('KKR', 'Kolkata Knight Riders');
insert into teams values ('GT', 'Gujarat Titans');
insert into teams values ('LSG', 'Lucknow Super Giants');
commit;


WITH MATCHES AS (
SELECT ROW_NUMBER() OVER(ORDER BY TEAM_CODE) AS ID, TEAM_CODE,TEAM_NAME FROM TEAMS T)
SELECT TEAM.TEAM_NAME AS TEAM ,OPPONENT.TEAM_NAME AS OPPONENT
FROM MATCHES TEAM JOIN MATCHES OPPONENT ON TEAM.ID < OPPONENT.ID
 EXCEPT
 (SELECT
    t1.Team_Name AS Team1,
    t2.Team_Name AS Team2
FROM
    Teams t1
JOIN
    Teams t2 ON t1.Team_Name < t2.Team_Name)


SELECT TEAM1.TEAM_NAME,OPPONENT.TEAM_NAME FROM TEAMS TEAM1 JOIN TEAMS OPPONENT 
ON TEAM1.TEAM_NAME <> OPPONENT.TEAM_NAME ;





WITH MATCHES AS (
    SELECT
        ROW_NUMBER() OVER (ORDER BY TEAM_CODE) AS ID,
        TEAM_CODE,
        TEAM_NAME
    FROM TEAMS
)
SELECT
    TEAM.TEAM_NAME AS TEAM,
    OPPONENT.TEAM_NAME AS OPPONENT
FROM MATCHES TEAM
JOIN MATCHES OPPONENT ON TEAM.ID <> OPPONENT.ID
ORDER BY TEAM.TEAM_NAME, OPPONENT.TEAM_NAME;



















