from __future__ import print_function
import json
import sys
from operator import add

from pyspark.sql import SparkSession
from datetime import *


inputLoc = sys.argv[1] 
outputLoc = sys.argv[2]
minVal = float(sys.argv[3]) 
maxVal = float(sys.argv[4]) 
parameter_name = sys.argv[5] 

def mapper(record) :

    try :
        record =  json.loads(record)
        parameter = str(record['features']['parameter'])
        
        if "value_hrf" not in record['features']  :
            return None

        if not(minVal <= float(record['features']["value_hrf"]) <= maxVal) :
            node = str(record['features']['node_id'])
            latitude = record['latitude']
            longitude = record['longitude']
            geohash = record['geohash']

            return ( node +  ", (" + str(latitude) +","+str(longitude) + "), "  + str(geohash) , float(record['features']["value_hrf"])) 

        return None

        
    except Exception as e :
        return str(e)

if __name__ == "__main__":
    spark = SparkSession\
        .builder\
        .appName("OutlierDetection")\
        .getOrCreate()

    lines = spark.read.text(inputLoc).rdd.map(lambda r: r[0])

        
    counts = lines.map(lambda x: mapper(x) ) \
                .filter(lambda x : x != None) \
                .groupByKey() \
                .map(lambda x : (x[0], set(sorted(list(x[1]))) ) ) 

    counts.saveAsTextFile(outputLoc)
    spark.stop()


      