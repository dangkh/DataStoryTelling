import csv
import numpy as np
from datetime import datetime, timedelta

input_data = [('2017-08-30', 6.25),
('2019-11-30', 6),
('2020-03-17', 5),
('2020-05-12', 4.5),
('2021-04-30', 4),
('2021-07-09', 4),
]
dates_values = [(datetime.strptime(date_str, '%Y-%m-%d'), value) for date_str, value in input_data]

start_date = dates_values[0][0]
end_date = dates_values[-1][0]

# Create a dictionary to easily fetch the value for a specific date
date_value_dict = {date: value for date, value in dates_values}

full_dates = [start_date + timedelta(days=x) for x in range((end_date - start_date).days + 1)]

# Fill the list with corresponding values, using the previous non-missing value if missing
full_dates_values = []
previous_value = None
for date in full_dates:
    if date in date_value_dict:
        previous_value = date_value_dict[date]
    full_dates_values.append((date, previous_value))

output_file = 'full_dates_values.csv'
with open(output_file, mode='w', newline='') as file:
    writer = csv.writer(file)
    writer.writerow(['Date', 'Value'])  # Write header
    writer.writerows(full_dates_values)  # Write data