## Predicting Flight Delays Project

This project was completed by:
- Josh Graham [jgraham91](https://github.com/jgraham91)
- Hugo Perdomo [hapl](https://github.com/hapl)

### Process

**Data review and extraction in PostgreSQL DB for Flights**
- Run multiple queries in PostgreSQL to explore the data structure and extract samples.
- Extracted 100K entries using the order random to reduce bias.
- For airports we pulled the geolocations of each airport on Flights database using the web page [OurAirports](https://ourairports.com/data/)

**Weather data extraction**
Extracting information for weather using the Meteostat library. This library has historic weather information based on information extracted from different well know weather [datasources](https://dev.meteostat.net/sources.html) such as NOAA and Canada environment. For more information go to [Meteostat website](https://meteostat.net/en/)


**Data cleaning**
After extracting the information 

***In progress**