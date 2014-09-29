from random import randrange

seq = [6, 1, 2, 4, 9, 3, 0, 5, 8, 7]

def shuffle(seq):
    for i in range(1, len(seq)):
        ran = randrange(i)
        seq[i], seq[ran] = seq[ran], seq[i]

shuffle(seq)
print seq 
