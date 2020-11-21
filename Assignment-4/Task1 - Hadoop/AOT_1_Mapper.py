import sys
import json
args = sys.argv


for line in sys.stdin :
    try :
        #x = json.loads("{ \"features\" : { \"parameter\" : \"test\" } }")
        line = line.strip()
        x = json.loads(line)
        parameter = x['features']['parameter']
    except Exception as e :
        sys.stdout.write('\t'.join(( "Failed", str(1), '\n')))
        continue
    sys.stdout.write('\t'.join((parameter, str(1), '\n')))



    

