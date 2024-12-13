import requests
import pandas as pd
import mysql.connector

DATA_URLS = [
    'https://example.com/path/to/data1.csv',
    'https://example.com/path/to/data2.csv'
]
RAW_FILENAMES = ['downloaded_data1.csv', 'downloaded_data2.csv']
PROCESSED_FILENAMES = ['processed_data1.csv', 'processed_data2.csv']

def process_url(url, raw_filename, processed_filename):
    response = requests.get(url)
    response.raise_for_status()
    
    file = open(raw_filename, 'wb')
    file.write(response.content)
    file.close()
    print(f"Downloaded data to {raw_filename}")

    data = pd.read_csv(raw_filename)
    data.dropna(inplace=True)
    data['timestamp'] = pd.to_datetime(data['timestamp'])

    data.to_csv(processed_filename, index=False)
    print(f"Processed data saved to {processed_filename}")
    mydb = mysql.connector.connect(
        host="localhost",
        user="myuser",
        password="mypass",
        database="mydatabase"
    )

    sql = "INSERT INTO test_vehicle_data (delivery_date, vehicle_name, test_track_name, mileage, duration) VALUES (%s, %s, %s, %s, %s)"

    for i, row in data.iterrows():
        val = (row['delivery_date'], row['vehicle_name'], row['test_track_name'], row['mileage'], row['duration'])
        mycursor = mydb.cursor()  
        mycursor.execute(sql, val)

    mydb.commit()
    print(f"Processed data saved to database.")


def main():
    for url, raw_filename, processed_filename in zip(DATA_URLS, RAW_FILENAMES, PROCESSED_FILENAMES):
        process_url(url, raw_filename, processed_filename)

if __name__ == "__main__":
    main()