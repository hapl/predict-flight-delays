SELECT fl_date, mkt_unique_carrier, 
branded_code_share, mkt_carrier, 
mkt_carrier_fl_num, op_unique_carrier, 
tail_num, op_carrier_fl_num, origin_airport_id, 
origin, origin_city_name, dest_airport_id, dest, 
dest_city_name, crs_dep_time, dep_time, dep_delay, 
taxi_out, wheels_off, wheels_on, taxi_in, crs_arr_time, 
arr_time, arr_delay, cancelled, cancellation_code, diverted, 
dup, crs_elapsed_time, actual_elapsed_time, air_time, 
flights, distance, carrier_delay, weather_delay, 
nas_delay, security_delay, late_aircraft_delay, 
first_dep_time, total_add_gtime, longest_add_gtime, no_name
	FROM flights
	ORDER BY random()
	LIMIT 100000;
--
/*Get all the airports and codes from the flights table*/
--\\COPY (
SELECT ARP.airport_id,ARP.iata_code,ARP.city
FROM
(
SELECT origin_airport_id as "airport_id", origin as "iata_code", origin_city_name as "city"
	FROM flights
	GROUP BY origin_airport_id, origin, origin_city_name
UNION ALL	
SELECT dest_airport_id, dest, dest_city_name
	FROM flights
	GROUP BY dest_airport_id, dest, dest_city_name
) ARP
GROUP BY ARP.airport_id,ARP.iata_code,ARP.city
--/*
--TO '/Users/hugo/Library/CloudStorage/OneDrive-Personal/DATA_Science/Bootcamp/W7/mid-term-project-I/data/raw/airports.csv' WITH (FORMAT csv, HEADER)	
select extract(year from TO_DATE(fl_date, 'YYYY-MM-DD')) AS "year1", count(fl_date)  from flights where weather_delay <> 0
GROUP BY extract(year from TO_DATE(fl_date, 'YYYY-MM-DD'))
LIMIT 100;

SELECT w.fl_date, 
 w.mkt_unique_carrier, 
 w.tail_num, 
 w.op_carrier_fl_num, 
 w.origin_airport_id, 
 w.origin, 
 w.origin_city_name, 
 w.dest_airport_id,
 w.dest, 
 w.dest_city_name, 
 w.weather_delay_r
 FROM
(SELECT fl_date, 
 mkt_unique_carrier, 
 tail_num, 
 op_carrier_fl_num, 
 origin_airport_id, 
 origin, 
 origin_city_name, 
 dest_airport_id,
 dest, 
 dest_city_name, 
 MAX(weather_delay) as "weather_delay_r"
from flights 
where weather_delay > 45
GROUP BY
 fl_date, 
 mkt_unique_carrier, 
 tail_num, 
 op_carrier_fl_num, 
 origin_airport_id, 
 origin, 
 origin_city_name, 
 dest_airport_id,
 dest, 
 dest_city_name
) AS w
ORDER by weather_delay_r desc
LIMIT 200;
--ORDER BY random()
--LIMIT 100;


