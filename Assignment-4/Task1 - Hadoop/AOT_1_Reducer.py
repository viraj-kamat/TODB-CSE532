import sys

current_parameter = None
current_count = 0
parameter = None

for line in sys.stdin:
    line = line.strip()
    parameter, count = line.split('\t', 1)

    try:
        count = int(count)
    except ValueError:
        continue


    if current_parameter == parameter:
        current_count += count
    else:
        if current_parameter:
            sys.stdout.write('%s\t%s\n' % (current_parameter, current_count))
        current_count = count
        current_parameter = parameter

if current_parameter == parameter:
    sys.stdout.write('%s\t%s\t' % (current_parameter, current_count))