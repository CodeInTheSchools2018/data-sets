# Parking Citation Data
# https://data.baltimorecity.gov/Transportation/Parking-Citations/n4ma-fj3m

# https://data.baltimorecity.gov/resource/2ddy-2uzt.csv

import requests
import io
import pandas as pd

url = "https://data.baltimorecity.gov/resource/2ddy-2uzt.csv?$limit=600000&$where=violdate between '2017-01-01T00:00:00' and '2017-12-31T23:59:59'"
headers = { "X-App-Token": "qq0tU1zDfSVSOkTotw3ckcfHK" }

data = requests.get(url,headers=headers)

df = pd.read_csv(io.StringIO(data.text))
#current_year_mask = (pd.to_datetime(df['violdate']) > '2017-1-1 00:00:00') & (pd.to_datetime(df['violdate']) <= '2017-12-31 23:59:59')

#df.loc[current_year_mask].to_csv('out.csv',index=False)
df.to_csv('out.csv')