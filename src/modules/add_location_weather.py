import pandas as pd
import numpy as np


def add_location(df,airports_ids):
    result = pd.merge(df,airports_ids, left_on = 'origin_airport_id', right_on='airport_id' )
    return result 
def add_weather(df,weather_airports):
    if 'fldate' not in df:
        df['fl_date'] = '01'+'-'+ df['day'].astype(str) +'-'+'2020'
    
    df['fl_date'] = df['fl_date'].astype('datetime64')
    weather_airports['fl_date'] = weather_airports['fl_date'].astype('datetime64')
    results = pd.merge(df,weather_airports, on =['Key','fl_date'], how ='left')
    results.drop_duplicates(inplace=True)
    return results  