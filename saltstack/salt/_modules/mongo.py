#!/usr/bin/python
# coding=utf-8
import codecs
import sys

"""
This module will restart rabbimq docker instances in the spesified environement
"""
import salt.utils
import logging
try:
    from pymongo import MongoClient
    from pymongo import TEXT
    HAS_PYMONGO = True
except ImportError:
    HAS_PYMONGO = False


log = logging.getLogger(__name__)

__virtualname__ = "mongo"

def __virtual__():
    log.debug("Checking if docker is available")
    if not HAS_PYMONGO:
        log.debug("Pymongo is not available, please install this with pip install pymongo before trying again")
        return False
    log.debug("pymongo is awailable ")
    return __virtualname__

def _read_file(path):
    with codecs.open(path, "r", encoding="UTF-8") as fs:
        while True:
            data = fs.readline()
            if data:
                yield data
            else:
                break

def import_data(filepath="/home/vagrant/countries/NO.txt", mongodb_url="mongodb://localhost:27017"):
    """
    Import the adress data into mongodb

    CLI Example:
        salt '*' mongo.import_data /usr/data/EN.txt
    """
    client = MongoClient(mongodb_url)
    db = client.demo
    address_col = db.address

    #Delete collection if present
    print("Dropping collection of addresses")
    address_col.delete_many({})

    #Create compound indices for full text search
    address_col.create_index([
        ("country_code", TEXT),
        ("postal_code", TEXT),
        ("place_name", TEXT),
        ("admin_name1", TEXT),
        ("admin_name2", TEXT),
        ("admin_name3", TEXT),
    ])


    # Split line on the tab character since this is the delimiter.
    for line in _read_file(filepath):
        parts = line.split("\t")
        if parts and len(parts) >= 12:
            address = {
                "country_code": parts[0],
                "postal_code": parts[1],
                "place_name": parts[2],
                "admin_name1": parts[3],
                "admin_code1": parts[4],
                "admin_name2": parts[5],
                "admin_code2": parts[6],
                "admin_name3": parts[7],
                "admin_code3": parts[8],
                "latitude": parts[9],
                "longitude": parts[10],
                "accuracy": parts[11].strip()
            }
            address_col.insert(address)
        else:
            log.error("Element has to few parts to parse")

    return "Done importing all data"
