-- -- TO EXTRACT A MONTHS WORTH OF FLIGHT DATA
-- select *
-- from flights 
-- where TO_CHAR(DATE(fl_date), 'yyyy') = '2019'
-- 	AND TO_CHAR(DATE(fl_date), 'mm') = '12'

-- -- TO EXTRACT A MONTHS WORTH OF DELAY DATA
-- select fl_date, dep_delay
-- from flights 
-- where TO_CHAR(DATE(fl_date), 'yyyy') = '2019'
-- 	AND TO_CHAR(DATE(fl_date), 'mm') = '12'
-- 	AND dep_delay IS NOT NULL

-- -- AVERAGE FLIGHT DELAY MINUTES PER MONTH
-- select TO_CHAR(DATE(fl_date), 'yyyy') as year, 
-- 	TO_CHAR(DATE(fl_date), 'mm') as month, 
-- 	round(cast(avg(dep_delay) as numeric),2) as avg_departure_delay,
-- 	round(cast(avg(arr_delay) as numeric),2) as avg_arrival_delay,
-- 	count(*) as flights_per_month
-- from flights
-- group by year, month




-- select TO_CHAR(DATE(fl_date), 'yyyy') as year, 
-- 	TO_CHAR(DATE(fl_date), 'mm') as month,
-- 	case
-- 		when (dep_delay - arr_delay) > 0 then 'Time Saved In Air'
-- 		when (dep_delay - arr_delay) < 0 then 'Time Lost In Air'
-- 		else 'Time Neutral'
-- 	end as flight_outcome,
-- 	COUNT(*) as no_of_flights,
-- 	round(cast(AVG(dep_delay - arr_delay) as numeric),2) as avg_time_saved_in_air	
-- from flights
-- where arr_delay is not null
-- and dep_delay is not null
-- group by year, month, flight_outcome


-- -- TASK 5:What is the average percentage of delays that is already created before departure? 
-- -- (aka are arrival delays caused by departure delays?) 
-- -- Are airlines able to lower the delay during the flights?

-- select case
-- 		when dep_delay < 0 then 'Early Departure'
-- 		when dep_delay = 0 or dep_delay is Null then 'On Time Departure'
-- 		when dep_delay > 0 then 'Late Departure'
-- 	end as departure_status,
-- 	case		
-- 		when arr_delay < 0 then 'Early Arrival'
-- 		when arr_delay = 0 or arr_delay is Null then 'On Time Arrival'
-- 		when arr_delay > 0 then 'Late Arrival'
-- 	end as arrival_status,
-- 	COUNT(*) as no_of_flights,
-- 	ROUND(100.0 * COUNT(*) / (select count(*) from flights), 2) as Percent_Breakdown,
-- 	ROUND(cast(avg(dep_delay) as numeric),2) as avg_dep_delay,
--  	ROUND(cast(avg(arr_delay) as numeric),2) as avg_arr_delay,
-- 	ROUND(cast(AVG(dep_delay - arr_delay) as numeric),2) as avg_time_saved_in_air
-- from flights
-- group by departure_status, arrival_status
-- order by no_of_flights desc




--TASK 6 HOW MANY STATES COVER 50% OF US AIR TRAFFIC


-- with CTE as
-- (select right(origin_city_name, 2) as state,
-- 	COUNT(*) as no_of_flights,
-- 	ROUND(100.0* COUNT(*) / (select count(*) from flights),2) as percent_of_air_traffic
-- 	from flights
--  	group by state
-- )

-- select state,
-- 	no_of_flights,
-- 	percent_of_air_traffic,
-- 	SUM(percent_of_air_traffic) 
-- 	over (order by percent_of_air_traffic desc, state) as running_total
-- from CTE 
-- group by state, no_of_flights, percent_of_air_traffic
-- order by percent_of_air_traffic DESC





-- TASK 9 MOST POPULAR AIRPORTS

-- select origin_city_name, 
-- 	count(*) as total_flights_18_19
-- from flights 
-- group by origin_city_name
-- order by total_flights_18_19 desc
-- limit 10

-- select origin_city_name,
-- 	sum(departures_performed) as total_flights_15_19 
-- from passengers
-- group by origin_city_name
-- order by total_flights_15_19 desc
-- limit 10 



-- EXPORT RANDOM FLIGHT DATA FOR MODEL CREATION



SELECT op_carrier_fl_num,
	op_unique_carrier,
	origin_airport_id,
	dest_airport_id,
	distance,
	CONCAT(origin_airport_id,'-',dest_airport_id) as route,
	CAST(TO_CHAR(DATE(fl_date), 'mm') as INT) as month,
	CAST(TO_CHAR(DATE(fl_date), 'dd') as INT) as day,
	CAST(fl_date as date),
	arr_delay
from flights
ORDER BY random()
LIMIT 100000



