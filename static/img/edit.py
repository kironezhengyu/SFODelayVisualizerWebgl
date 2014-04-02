f = open('2014.json')
lines = f.readlines()
import random
seq = []
for i, line in enumerate(lines):
    if i % 3 == 0 and i != 0:

        seq.append(float(lines[i].replace(',', '')))


for i, line in enumerate(lines):
    if i % 3 == 0 and i != 0:
        lines[i] = str(random.choice(seq)) + ',' + '\n'

f = open('workfile', 'wr+')
for line in lines:
    f.write(str(line))
