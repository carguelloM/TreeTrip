#!/usr/bin/env python3
from math import radians, cos, sin, sqrt, atan2, ceil
import pandas as pd
import requests

CAR_MAKE_ENDPOINT = "https://www.carboninterface.com/api/v1/vehicle_makes"
ESTIMATES_ENDPOINT = "https://www.carboninterface.com/api/v1/estimates"

def get_token():
    with open("token") as f:
        token = f.readline()
    return token


def get_dist_between_two_points(coord1, coord2):
    R = 6371  # earth radius in kilometers

    lat1, lon1 = coord1
    lat2, lon2 = coord2

    dlat = radians(lat2 - lat1)
    dlon = radians(lon2 - lon1)

    a = sin(dlat/2) ** 2 + cos(radians(lat1)) * cos(radians(lat2)) * sin(dlon/2) ** 2
    c = 2 * atan2(sqrt(a), sqrt(1-a))

    distance = R * c

    return distance

#Given a list of GPS coordinates calculate
#total distance travelled.
def get_total_distance(gps_coords):
    total_distance = 0
    for i in range(len(gps_coords) - 1):
        dist = get_dist_between_two_points(gps_coords[i + 1, gps_coords[i]])
        total_distance += abs(dist)

    return total_distance

def get_make_id(make):
    headers = {"Authorization": "Bearer " + get_token(),
               "Content-Type": "application/json"}

    response = requests.get(CAR_MAKE_ENDPOINT, headers=headers)

    filtered_elements = [e for e in response.json() if e["data"]["attributes"]["name"].lower() == make.lower()]
    return filtered_elements[0]["data"]["id"]


def get_car_id(year, make, model):

    make_id = get_make_id(make)

    headers = {"Authorization": "Bearer " + get_token(),
               "Content-Type": "application/json"}

    response = requests.get(CAR_MAKE_ENDPOINT + "/" + str(make_id) + "/vehicle_models",
                            headers=headers)

    filtered_elements = [e for e in response.json() if e["data"]["attributes"]["name"].lower() == model.lower()
                         and str(e["data"]["attributes"]["year"]) == str(year)
                         and e["data"]["attributes"]["vehicle_make"].lower() == make.lower()]
    return filtered_elements[0]["data"]["id"]

def calculate_emissions(distance, year, make, model):
    headers = {"Authorization": "Bearer " + get_token(),
               "Content-Type": "application/json"}

    car_id = get_car_id(year=year, make=make, model=model)

    data = {
        "type": "vehicle",
        "distance_unit": "km",
        "distance_value": distance,
        "vehicle_model_id": car_id
    }

    response = requests.post(ESTIMATES_ENDPOINT, json=data,
                             headers=headers)

    return response.json()["data"]["attributes"]["carbon_kg"]

# Find the tree species closest to the given coordinate
def find_closest_tree(lat, lon):
    df = pd.read_csv('tree_db.csv')
    distances = []
    for index, row in df.iterrows():
        dist = get_dist_between_two_points((lat, lon), (row['Lat'], row['Long']))
        distances.append((dist, row['Tree']))
    distances.sort()
    return distances[0][1]

def calculate_num_trees(car_emissions, emis_per_tree=10):
    return ceil(car_emissions/emis_per_tree)

if __name__ == "__main__":
    print(find_closest_tree(43.71, -72))


