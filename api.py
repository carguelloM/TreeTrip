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
    session["points"] = []
    session["distance_travelled"] = -1

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
    d = get_total_distance(session["gps_coords"])
    session["distance_travelled"] = d
    data = {
        'distance': d
    }
    response = jsonify(data)
    response.status_code = 200
    return response

if __name__ == "__main__":
    app.run(host="0.0.0.0", debug=True)






