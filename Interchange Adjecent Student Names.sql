-- Query 6:
--From the students table, write a SQL query to interchange the adjacent student names.
--Note: If there are no adjacent student then the student name should stay the same.
--Table Structure:
--drop table students;
create table students (
    id int primary key,
    student_name varchar(50) not null
);

insert into
    students
values
    (1, 'James'),
    (2, 'Michael'),
    (3, 'George'),
    (4, 'Stewart'),
    (5, 'Robin');

select
    *
from
    students;

--Solution:
select
    id,
    student_name,
    case
        when id % 2 <> 0 then lead(student_name, 1, student_name) over(
            order by
                id
        )
        when id % 2 = 0 then lag(student_name) over(
            order by
                id
        )
    end as new_student_name
from
    students;

WITH InterchangedStudents AS (
    SELECT
        s1.id AS id1,
        s1.student_name AS name1,
        s2.id AS id2,
        s2.student_name AS name2,
        ROW_NUMBER() OVER (
            ORDER BY
                s1.id
        ) AS row_num
    FROM
        students s1
        LEFT JOIN students s2 ON s1.id = s2.id - 1
)
SELECT
    NAME1,
    CASE
        WHEN id2 IS NOT NULL THEN name2
        ELSE name1
    END AS student_name
FROM
    InterchangedStudents
ORDER BY
    row_num;

--------- NOT THE SOLUTION JUST DIFFERENT CHALLENGE-----------------
SELECT
    id,
    student_name,
    COALESCE(
        LEAD(student_name) OVER (
            ORDER BY
                id
        ),
        student_name
    ) AS new_student_name
FROM
    students
ORDER BY
    id;