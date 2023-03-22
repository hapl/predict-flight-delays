SELECT 
seats, 
passengers, 
distance,
unique_carrier,  
year, 
month, 
class
FROM passengers
WHERE year in (2018,2019)
ORDER BY random()
	LIMIT 100000;