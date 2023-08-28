-- Query 7:
--From the weather table, fetch all the records when London had extremely cold temperature for 3 consecutive days or more.
--Note: Weather is considered to be extremely cold then its temperature is less than zero.
--Table Structure:
--drop table weather;
create table weather (
      id int,
      city varchar(50),
      temperature int,
      day date
);

delete from
      weather;

insert into
      weather
values
      (1, 'London', -1, CONVERT(DATE, '2023-08-26', 23)),
      (2, 'London', -2, CONVERT(DATE, '2021-01-02', 23)),
      (3, 'London', 4, CONVERT(DATE, '2021-01-03', 23)),
      (4, 'London', 1, CONVERT(DATE, '2021-01-04', 23)),
      (5, 'London', -2, CONVERT(DATE, '2021-01-05', 23)),
      (6, 'London', -5, CONVERT(DATE, '2021-01-06', 23)),
      (7, 'London', -7, CONVERT(DATE, '2021-01-07', 23)),
      (8, 'London', 5, CONVERT(DATE, '2021-01-08', 23))
select
      *
from
      weather;

--Solution:
select
      id,
      city,
      temperature,
      day
from
      (
            select
                  *,
                  case
                        when temperature < 0
                        and lead(temperature) over(
                              order by
                                    day
                        ) < 0
                        and lead(temperature, 2) over(
                              order by
                                    day
                        ) < 0 then 'Y'
                        when temperature < 0
                        and lead(temperature) over(
                              order by
                                    day
                        ) < 0
                        and lag(temperature) over(
                              order by
                                    day
                        ) < 0 then 'Y'
                        when temperature < 0
                        and lag(temperature) over(
                              order by
                                    day
                        ) < 0
                        and lag(temperature, 2) over(
                              order by
                                    day
                        ) < 0 then 'Y'
                  end as flag
            from
                  weather
      ) x
where
      x.flag = 'Y';

-------- Alternative Solution --------------------
WITH ConsecutiveColdDays AS (
      SELECT
            id,
            city,
            temperature,
            day,
            LAG(temperature) OVER (
                  PARTITION BY city
                  ORDER BY
                        day
            ) AS prev_temp,
            LEAD(temperature) OVER (
                  PARTITION BY city
                  ORDER BY
                        day
            ) AS next_temp
      FROM
            weather
)
SELECT
      id,
      city,
      temperature,
      day
FROM
      ConsecutiveColdDays
WHERE
      city = 'London'
      AND (
            (
                  temperature < 0
                  AND prev_temp < 0
                  AND next_temp < 0
            )
            OR (
                  temperature < 0
                  AND prev_temp < 0
            )
            OR (
                  temperature < 0
                  AND next_temp < 0
            )
      );