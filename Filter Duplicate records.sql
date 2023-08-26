-- Query 1:

--Write a SQL query to fetch all the duplicate records from a table.

--Tables Structure:

--drop table users;
create table users
(
user_id int primary key,
user_name varchar(30) not null,
email varchar(50));

insert into users values
(7, 'Reshma', 'FFFF@gmail.com'),
(2, 'Reshma', 'reshma@gmail.com'),
(3, 'Farhana', 'farhana@gmail.com'),
(4, 'Robin', 'robin@gmail.com'),
(5, 'Robin', 'robin@gmail.com');

select * from users;

--Solution_1
SELECT USER_ID,USER_NAME,EMAIL FROM(
SELECT * ,
ROW_NUMBER() OVER(PARTITION BY USER_NAME ORDER BY USER_ID) AS RN
FROM USERS) X
WHERE X.RN>1 
ORDER BY USER_ID;


--Solution_2
WITH NumberedRows AS (
    SELECT *,
        ROW_NUMBER() OVER (PARTITION BY USER_NAME ORDER BY USER_ID) AS RN
    FROM USERS
)
SELECT USER_ID, USER_NAME, EMAIL
FROM NumberedRows O
WHERE RN > 1 ORDER BY USER_ID;



-- Solution_3
SELECT *
FROM users u
WHERE u.user_id NOT IN (
    SELECT MIN(user_id) AS ctid
    FROM users
    GROUP BY user_name
);




----------------------------------------------------------------------
-- SETTING SQL STATISTICS ON [ctr + m]
SET STATISTICS IO ON
SET STATISTICS TIME ON
GO
