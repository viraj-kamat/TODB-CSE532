from __future__ import print_function
import json
import sys
from operator import add

from pyspark.sql import SparkSession


def mapper(record) :

    try :
        record =  json.loads(record)
        parameter = str(record['features']['parameter'])
        return parameter.split(" ")
    except Exception as e :
        return None

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: wordcount <file>", file=sys.stderr)
        sys.exit(-1)

    spark = SparkSession\
        .builder\
        .appName("Count")\
        .getOrCreate()

    lines = spark.read.text(sys.argv[1]).rdd.map(lambda r: r[0])
    counts = lines.flatMap(lambda x: mapper(x)) \
                   .filter(lambda x: x != None) \
                   .map(lambda x: (x, 1)) \
                   .reduceByKey(add)
    #output = counts.collect()
    
    #for word,count in output :
        #print("{0} : {1}".format(word,str(count)))
    
    #output.saveAsTextFile(sys.argv[2]+"/result.txt")
    counts.saveAsTextFile(sys.argv[2])

    spark.stop()