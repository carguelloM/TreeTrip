#!/usr/bin/env python3
from flask import Flask, request, jsonify, make_response, session
from flask_session import Session
from utils import *
import datetime

app = Flask(__name__)
app.config["SESSION_PERMANENT"] = False
app.config["SESSION_TYPE"] = "filesystem"
app.config["DEBUG"] = True
Session(app)


@app.route("/test", methods=["GET"])
def test():
    return "phuc"

@app.route("/get_stats_test", methods=["GET"])
def get_stats_test():
    data = {
        "amount_of_trees": 2,
        "tree": "red-maple",
        "emissions": 20,
        "distance": 100
    }
    response = jsonify(data)
    response.status_code = 200
    return response


@app.route("/start_session", methods=["POST"])
def start_session():

    #Create an empty list to store GPS points
    session["gps_coords"] = []
    session["distance"] = None
    session["emissions"] = None
    session["tree"] = None
    session["amount_of_trees"] = None
    session["in_motion"] = True
    session["last_message_time"] = None

    req = request.get_json()

    session["year"] = req["year"]
    session["make"] = req["make"]
    session["model"] = req["model"]

    print(session["year"], session["make"], session["model"])

    response = make_response("Success")
    response.status_code = 200
    return response

@app.route("/store_point", methods=["POST"])
def store_point():
    # if session["last_message_time"] == None:
    #     session["last_message_time"] = request.
    # t = request.time
    req = request.get_json()
    t = req["timestamp"]
    lat = req["latitude"]
    long = req["longitude"]

    print(lat, long)

    #do a check to see if car is still
    try:
        last_coords = session["gps_coords"][-1]

        d = get_dist_between_two_points(last_coords, (lat, long))

        if d > 0.1:
            status_code = 200
        else:
            status_code = 208
    except:
        status_code = 200


    session["gps_coords"].append((lat, long))
    print(type(session["gps_coords"]), session["gps_coords"])

    response = make_response("Success")
    response.status_code = status_code
    return response

@app.route("/get_distance_travelled", methods=["GET"])
def return_distance():
    set_distance()
    data = {
        'distance': session["distance_travelled"]
    }
    response = jsonify(data)
    response.status_code = 200
    return response

@app.route("/get_carbon_emissions", methods=["GET"])
def get_carbon_emissions():
    set_carbon_emissions()
    data = {
        "emissions": session["emissions"]
    }

    response = jsonify(data)
    response.status_code = 200
    return response

@app.route("/get_tree", methods=["GET"])
def get_tree():
    set_tree()
    data = {
        "tree": session["tree"]
    }

    response = jsonify(data)
    response.status_code = 200
    return response

@app.route("/get_amount_of_trees", methods=["GET"])
def get_amount_of_trees():
    set_amt_of_trees()

    data = {
        "amount_of_trees": session["amount_of_trees"]
    }

    response = jsonify(data)
    response.status_code = 200
    return response


@app.route("/get_stats", methods=["GET"])
def get_stats():
    try:
        set_distance()
    except Exception as e:
        print("Error in Distance Calc", e)
        session["distance"] = 2

    try:
        set_carbon_emissions()
    except Exception as e:
        print("Error in tree", e)
        session["emissions"] = 0.3

    try:
        set_amt_of_trees()
    except Exception as e:
        print("Tree amt error", e)
        session["amount_of_trees"] = 3

    try:
        set_tree()
    except Exception as e:
        print("Tree type error", e)
        session["tree"] = "maple-cedar"


    print(session["distance"], session["emissions"], session["amount_of_trees"])


    data = {
        "amount_of_trees": session["amount_of_trees"],
        "tree": session["tree"],
        "emissions": session["emissions"],
        "distance": session["distance"]
    }

    response = jsonify(data)
    response.status_code = 200
    return response


def set_distance():
    session["distance"] = get_total_distance(session["gps_coords"])

def set_carbon_emissions():
    distance = get_total_distance(session["gps_coords"])
    session["emissions"] = calculate_emissions(distance=distance,
                                               make=session["make"],
                                               model=session["model"],
                                               year=session["year"])

def set_tree():
    end_lat, end_long = session["gps_coords"][-1]
    session["tree"] = find_closest_tree(end_lat, end_long)

def set_amt_of_trees():
    session["amount_of_trees"] = calculate_num_trees(session["emissions"])


if __name__ == "__main__":
    app.run(host="0.0.0.0", debug=True)






