WITH bicycle_rentals AS(
    SELECT
        CAST(COUNT(starttime) AS NUMERIC) as num_trips,
        EXTRACT(DATE from starttime) as trip_date,
        EXTRACT(YEAR from starttime) as year
    FROM `bigquery-public-data.new_york_citibike.citibike_trips`
    GROUP BY trip_date,year
),
week_end AS (
    SELECT
        case when (EXTRACT(DAYOFWEEK from starttime)) in (1,7) Then true else false end as weekend,
        EXTRACT(DATE from starttime) as trip_date,
        EXTRACT(YEAR from starttime) as year
    FROM `bigquery-public-data.new_york_citibike.citibike_trips`
    GROUP BY trip_date,year,weekend
)

SELECT
   we.year,
   we.weekend,
  ROUND(AVG(bk.num_trips)) AS num_trips
FROM bicycle_rentals AS bk
    JOIN week_end AS we ON we.trip_date = bk.trip_date
GROUP BY we.year,we.weekend
order by we.year,we.weekend desc
