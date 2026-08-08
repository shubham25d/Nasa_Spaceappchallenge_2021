"""
By Terry Zhang in Team mystic coders
"""

import io
import pandas
from datetime import date

import requests


def download_csv(feature, time, location):

    today_date = date.today().strftime('%Y%m%d')
    this_month = date.today().strftime('%Y%m')
    this_year = date.today().strftime('%Y')
    d1 = False
    d2 = False

    if feature == "CurrentMonth":
        parameters = 'ALLSKY_SFC_SW_DWN,ALLSKY_NKT'
        # ALLSKY_SFC_SW_DWN and/or ALLSKY_NKT
        time[0] = this_month+'01'
        time[1] = today_date
        filename1 = "current_month_nasa.csv"
        d1 = True


    elif feature == "CurrentYear":
        parameters = 'ALLSKY_SFC_SW_DWN,ALLSKY_NKT'
        time[0] = this_year + '0101'
        time[1] = today_date
        filename1 = "current_year_nasa.csv"
        d1 = True

    elif feature == "CompareMonth_yoursolarpanels":
        print('Please upload two csv files contain your daily solar system output that have at least 1 month in length')

    elif feature == "CompareYear_yoursolarpanels":
        print('Please upload two csv files contain your daily solar system output that have at least 1 year in length')

    elif feature == "CompareMonth":
        parameters = 'ALLSKY_SFC_SW_DWN,ALLSKY_NKT'
        filename1 = "compare_month_1.csv"
        filename2 = "compare_month_2.csv"
        d1 = True
        d2 = True

    elif feature == "CompareYear":
        parameters = 'ALLSKY_SFC_SW_DWN,ALLSKY_NKT'
        filename1 = "compare_year_1.csv"
        filename2 = "compare_year_2.csv"
        d1 = True
        d2 = True

    elif feature == "forecast solar irradiance":
        parameters = 'ALLSKY_SFC_SW_DWN'
        time[0] = str((int(this_year) - 6)) + today_date[4:]
        time[1] = today_date
        filename1 = "forecast_nasa.csv"
        d1 = True

    elif feature == "forecast your solar system output":
        print('Please upload one csv files contain your daily solar system output that have at least 1 year in length')

    else:
        print('feature unavailable')


    if len(location) >= 2 and len(time) >= 2 and d1 == True:
        latitude1 = location[0]
        longitude1 = location[1]

        time_start_1 = time[0]
        time_end_1 = time[1]
        request1 = rf'https://power.larc.nasa.gov/api/temporal/daily/point?parameters={parameters}&community=RE&longit\
        ude={longitude1}&latitude={latitude1}&format=CSV&start={time_start_1}&end={time_end_1}'
        print(request1)
        response1 = requests.get(url=request1, verify=True, timeout=30.00).content
        index1 = response1.decode('utf-8').index("YEAR")
        print(index1)
        response1E = response1[index1:]
        result1 = pandas.read_csv(io.StringIO(response1E.decode('utf-8')))
        result1.to_csv(filename1)
        print(1)

    if len(location) == 4 and len(time) == 4 and d2 == True:
        latitude2 = location[2]
        longitude2 = location[3]

        time_start_2 = time[2]
        time_end_2 = time[3]

        request2 = rf'https://power.larc.nasa.gov/api/temporal/daily/point?parameters={parameters}&community=RE&long\
        itude={longitude2}&latitude={latitude2}&format=CSV&start={time_start_2}&end={time_end_2}'
        response2 = requests.get(url=request2, verify=True, timeout=30.00).content
        print(response2)
        index2 = response2.decode('utf-8').index("YEAR")
        response2E = response2[index2:]
        result2 = pandas.read_csv(io.StringIO(response2E.decode('utf-8')))

        result2.to_csv(filename2)
        print(2)







def main():
    #DEFAULT TIME
    start_time_1 = None
    start_time_2 = None
    end_time_1 = None
    end_time_2 = None
    # YYYYMMDD

    #DEFAULT LOCATIONS
    latitude1 = None
    longitude1 = None
    latitude2 = None
    longitude2 = None
    # xx.xxxx

    #CURRENT MONTH
    # start_time_1 = None
    # start_time_2 = None
    # end_time_1 = None
    # end_time_2 = None
    # latitude1 = str(39.9373)
    # longitude1 = str(-83.0485)
    # latitude2 = None
    # longitude2 = None

    #CURRENT YEAR
    # start_time_1 = None
    # start_time_2 = None
    # end_time_1 = None
    # end_time_2 = None
    # latitude1 = str(39.9373)
    # longitude1 = str(-83.0485)
    # latitude2 = None
    # longitude2 = None

    #COMPARE MONTH
    # start_time_1 = '20150101'
    # start_time_2 = '20210401'
    # end_time_1 = '20150131'
    # end_time_2 = '20210430'
    # latitude1 = str(39.9373)
    # longitude1 = str(-83.0485)
    # latitude2 = str(10.9373)
    # longitude2 = str(-50.0485)


    #COMPARE YEAR
    # start_time_1 = '20150101'
    # start_time_2 = '20200101'
    # end_time_1 = '20151231'
    # end_time_2 = '20201231'
    # latitude1 = str(39.9373)
    # longitude1 = str(-83.0485)
    # latitude2 = str(10.9373)
    # longitude2 = str(-50.0485)

    #FORECAST SOLAR IRRADIANCE
    # start_time_1 = None
    # start_time_2 = None
    # end_time_1 = None
    # end_time_2 = None
    # latitude1 = str(39.9373)
    # longitude1 = str(-83.0485)
    # latitude2 = None
    # longitude2 = None


    times = [start_time_1,end_time_1,start_time_2,end_time_2]
    locations = [latitude1, longitude1, latitude2, longitude2]

    feature = 'CurrentMonth'
    """
    CurrentMonth - Compare your daily solar system output in kw-day or mean kw-hour(x24) to ALLSKY_SFC_SW_DWN and ALLSKY_NKT daily data for a month
    
    CurrentYear - Compare your daily solar system output in kw-day or mean kw-hour(x24) to ALLSKY_SFC_SW_DWN and ALLSKY_NKT daily data for a Year
    
    CompareMonth_yoursolarpanels - Compare your one month of daily solar system output in kw-day to another month of daily solar system output in kw-day
    
    CompareYear_yoursolarpanels - Compare your one year of daily solar system output in kw-day to another year of daily solar system output in kw-day
    
    CompareMonth - Compare one month of ALLSKY_SFC_SW_DWN and ALLSKY_NKT daily data to another month of ALLSKY_SFC_SW_DWN and ALLSKY_NKT daily data
    
    CompareYear - Compare one year of ALLSKY_SFC_SW_DWN and ALLSKY_NKT daily data to another year of ALLSKY_SFC_SW_DWN and ALLSKY_NKT daily data
    
    forecast solar irradiance - forecast the solar irradiance(ALLSKY_SFC_SW_DWN) for next year in your selected location
    
    forecast your solar system output - forecast the your solar system output for next year in kw-day or mean kw-hour(x24)

    """

    download_csv(feature, times, locations)

    print(f'{feature} finish')

main()