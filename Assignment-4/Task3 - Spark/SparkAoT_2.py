from __future__ import print_function
import json
import sys
from operator import add

from pyspark.sql import SparkSession
from datetime import *

if len(sys.argv) != 7 :
    print("Usage <input> <output> <start-date> <end-date> <mode> <parameter>")
else :    
    start_date = datetime.strptime(sys.argv[3],"%Y-%m-%d")
    end_date = datetime.strptime(sys.argv[4],"%Y-%m-%d")
    mode = sys.argv[5]
    parameter_name = sys.argv[6]

def mapper(record) :

    try :
        record =  json.loads(record)
        parameter = str(record['features']['parameter'])
        
        timestamp = str(record["timestamp"])
        timestamp = int(timestamp)/1000
        actual_date = datetime.fromtimestamp(timestamp)
        
        if "value_hrf" not in record['features'] or not(start_date  <= actual_date <=  end_date) :
            return ("None",0)
            
        return (parameter,float(record['features']["value_hrf"]))

        
    except Exception as e :
        return None

if __name__ == "__main__":



    spark = SparkSession\
        .builder\
        .appName("PythonWordCount")\
        .getOrCreate()

    lines = spark.read.text(sys.argv[1]).rdd.map(lambda r: r[0])
    counts = lines.map(lambda x: mapper(x) ) \
                   .filter(lambda x : x[0] == parameter_name)

    if mode == 'avg' :               
        counts = counts.aggregateByKey((0,0), lambda a,b: (a[0] + b,    a[1] + 1), lambda a,b: (a[0] + b[0], a[1] + b[1])) \
        .mapValues(lambda v: v[0]/v[1]) 
    elif mode == 'max' :
        counts = counts.reduceByKey(max)
    elif mode == 'min' :
        counts = counts.reduceByKey(min)
    
    #output.saveAsTextFile(sys.argv[2]+"/result.txt")
    counts.saveAsTextFile(sys.argv[2])

    spark.stop()  