import pandas as pd
import numpy as np


def add_location(df,airports_ids):
    result = pd.merge(df,airports_ids, left_on = 'origin_airport_id', right_on='airport_id' )
    return result 
def add_weather(df,weather_airports):
    results = pd.merge(df,weather_airports, left_on =['Key','date'], right_on=['Key','fl_date'])
    return results  