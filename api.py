#!/usr/bin/env python3
from flask import Flask, request, jsonify, make_response, session
from flask_session import Session
from utils import *

app = Flask(__name__)
app.config["SESSION_PERMANENT"] = False
app.config["SESSION_TYPE"] = "filesystem"
app.config["DEBUG"] = True
Session(app)


@app.route("/test", methods=["GET"])
def test():
    return "phuc"

@app.route("/start_session", methods=["POST"])
def start_session():

    #Create an empty list to store GPS points
    session["gps_coords"] = []
    session["distance_travelled"] = None
    session["emissions"] = None
    session["tree"] = None
    session["amount_of_trees"] = None

    session["year"] = request.form.get("year")
    session["make"] = request.form.get("make")
    session["model"] = request.form.get("model")

    print(session["make"], session["year"], session["model"])

    response = make_response()
    response.status_code = 200
    return response

@app.route("/store_point", methods=["POST"])
def store_point():
    lat = request.form.get("latitude")
    long = request.form.get("longitude")

    session["gps_coords"].append((lat, long))

    response = make_response()
    response.status_code = 200
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
    set_distance()
    set_carbon_emissions()
    set_tree()
    set_amt_of_trees()

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
    session["distance_travelled"] = get_total_distance(session["gps_coords"])

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






