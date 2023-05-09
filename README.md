## Predicting Flight Delays Project

This project was completed by:
- Josh Graham [jgraham91](https://github.com/jgraham91)
- Hugo Perdomo [hapl](https://github.com/hapl)

### Process

**Data review and extraction in PostgreSQL DB for Flights**

- Run multiple queries in PostgreSQL to explore the data structure and extract samples.
- Extracted 100K entries using the order random to reduce bias.
- For airports, we pulled the geolocations of each airport on the Flights database using the web page [OurAirports](https://ourairports.com/data/).

**Weather data extraction**

Extracting information for weather using the Meteostat library. This library has historical weather information based on information extracted from different well know weather [datasources](https://dev.meteostat.net/sources.html) such as NOAA and Environment Canada. For more information, go to [Meteostat website](https://meteostat.net/en/).

**Data cleaning and Feature Engineering**

- After extracting the information from the database, we review the data quality, and clean/transform null values to get better accuracy with the models.
- The latitude and longitude were added to the original data.
- Label encoding was used to transform the carrier code.

For more information on this topic, go to the [exploratory analysis notebook](src/modules/Exploratory_Analysis.ipynb)

**Model Evaluation and Predictions**

- Tested different regression models to find the one that gave us the best results.
- We did hyperparameter tuning to optimize the models.
- The models tested were:
    - Linear Regression, including Lasso and Ridge
    - XGBoost Regressor
    - Tested Random Forest Classifier (after transforming delay time as labels).
- Created pickles to save our models and avoid running every time we wanted to evaluate results; those can be found [here](data/pickles)

For more details on this topic, go to the [modeling notebook](src/modules/modeling.ipynb)

### Results

The model evaluation results are located [here](src/tests)

### Challenges

- Running tuning in some models was CPU intensive.
- Weather information was limited, but we found the Meteostat API that helped us achieve what we needed.

