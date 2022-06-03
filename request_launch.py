print("Script Launched 1")

import pandas as pd

print("Script Launched 2")

# Webpage url                                                                                                               
url = 'https://en.wikipedia.org/wiki/History_of_Python'

# Extract tables
dfs = pd.read_html(url)

# Get first table                                                                                                           
df = dfs[0]

# Extract columns                                                                                                           
df2 = df[['Version','Release date']]
print(df2)