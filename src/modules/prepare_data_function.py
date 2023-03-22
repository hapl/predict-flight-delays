

def prepare_data_flights(df):
    import pandas as pd
    import numpy as np
    
    df.drop(columns=['branded_code_share','mkt_carrier'], inplace=True) #these are the same value as mkt_unique_carrier
    df.drop(columns=['mkt_carrier_fl_num'], inplace=True) ##is the same value as op_carrier_fl_num
    df.drop(columns=['origin_airport_id', 'dest_airport_id'], inplace=True) #using airport codes instead 'origin' and 'dest'
    df.drop(columns=['dup', 'flights'], inplace=True) # have the same values
    df.drop(columns=['no_name'], inplace=True) ##columns not documented on dataset provided by LHL

    df[['city_orig','state_orig']] = df['origin_city_name'].str.split(', ', expand=True)  #split city and name of origin
    df[['city_dest','state_dest']] = df['dest_city_name'].str.split(', ', expand=True)  #split city and name of origin
    df.drop(columns=['origin_city_name','dest_city_name'], inplace=True) #using new city and state columns instead
    
#change datetime columns and rename columns for easier understanding
    df['fl_date'] = df['fl_date'].astype('datetime64[ns]')
    df.rename(columns={'fl_date': 'FlightDate'}, inplace=True) 
    df['FlightDay'] = pd.DatetimeIndex(df['FlightDate']).day
    df['FlightMonth'] = pd.DatetimeIndex(df['FlightDate']).month
    df['FlightYear'] = pd.DatetimeIndex(df['FlightDate']).year

    df['crs_dep_time'] = pd.to_datetime(df['crs_dep_time'], unit='m', errors='coerce').dt.strftime("%H:%M")
    df['crs_arr_time'] = pd.to_datetime(df['crs_arr_time'], unit='m', errors='coerce').dt.strftime("%H:%M")
    df['dep_time'] = pd.to_datetime(df['dep_time'], unit='m', errors='coerce').dt.strftime("%H:%M")
    df.rename(columns={'dep_time': 'ActualDeparture'}, inplace=True) 
    df.rename(columns={'crs_dep_time': 'DepartureTime','crs_arr_time': 'ArrivalTime'}, inplace=True) 
    df.rename(columns={'crs_elapsed_time': 'ElapsedTimeFlight,'}, inplace=True)
    df.rename(columns={'crs_elapsed_time': 'ElapsepTimeScheduled'}, inplace=True)
    df.rename(columns={'mkt_unique_carrier': 'UniqueMarketingCarrierCode'}, inplace=True)
    df.rename(columns={'op_unique_carrier': 'UniqueScheduledOperatingCarrierCode'}, inplace=True)
    df.rename(columns={'op_carrier_fl_num': 'FlightNumber'}, inplace=True)
    df.rename(columns={'tail_num': 'TailNumber'}, inplace=True) 
    df.rename(columns={'origin': 'OriginIATA'}, inplace=True) 
    df.rename(columns={'dest': 'DestinationIATA'}, inplace=True) 
    df.rename(columns={'distance': 'DistanceAirports'}, inplace=True)
    df.rename(columns={'air_time': 'FlightTime'}, inplace=True)
    df.rename(columns={'dep_delay': 'Delay_Departure'}, inplace=True)  
    
    df.rename(columns={'city_dest':'DestinationCity','state_dest':'DestinationState','city_orig':'OriginCity','state_orig':'OriginState'}, inplace=True)
    df.rename(columns={'carrier_delay':'Delay_Carrier','weather_delay':'Delay_Weather','nas_delay':'Delay_NationalAirSystem','security_delay':'Delay_Security','late_aircraft_delay':'Delay_LateAircraft'}, inplace=True)

    return df