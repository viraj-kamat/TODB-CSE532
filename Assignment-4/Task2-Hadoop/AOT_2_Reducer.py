import sys
from datetime import *



#try :

current_count = 0

start_date = datetime.strptime(sys.argv[1],"%Y-%m-%d")
end_date = datetime.strptime(sys.argv[2],"%Y-%m-%d")
mode = sys.argv[3]
parameter_name = sys.argv[4]  

minVal = 2**31 -1
maxVal = -2**31
aggregate = 0 


for line in sys.stdin: 
    try :
        line = line.strip()
        parameter, timestamp, value = line.split('\t')

        timestamp = int(timestamp)/1000
        actual_date = datetime.fromtimestamp(timestamp)
        value = float(value)

        if (parameter != parameter_name) or not(start_date  <= actual_date <=  end_date) :
            continue

        current_count += 1
        minVal = min([minVal,value])
        maxVal = max([maxVal,value])
        aggregate += value
        #sys.stdout.write('%s\t%s\t%s\t%s\t%s\t' % (parameter_name, mode, sys.argv[0], sys.argv[1], str(current_count)   ))
    except Exception as e :
        sys.stdout.write(str(e)+" \n")



output = None
if mode == "min" :
    output = minVal
elif mode == "max" :
    output = maxVal
elif mode == "avg" :
    output = aggregate/current_count


sys.stdout.write('%s\t%s\t%s\t%s\t%s\t' % (parameter_name, mode, str(start_date), str(end_date), str(output)   ))

#except Exception as e :
    #sys.stdout.write(str(e))
