import sys
import json
args = sys.argv


for line in sys.stdin :
    try :
        line = line.strip()
        x = json.loads(line)
        parameter = x['features']['parameter']
        timestamp = str(x["timestamp"])

        if 'value_hrf' not in x['features'] :
            continue
        value = str(x['features']['value_hrf'])

        


    except Exception as e :
        sys.stdout.write('\t'.join(( "Failed", str(1), '\n')))
        continue
    sys.stdout.write('\t'.join((parameter, timestamp , value , '\n')))



    

