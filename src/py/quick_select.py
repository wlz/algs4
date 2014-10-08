from random import randrange

def quick_select(seq, k):
    lo = 0; hi = len(seq) - 1
    while True:
        if lo >= hi:
            break
        j = partition(seq, lo, hi)
        if j > k:
            hi = j - 1
        elif j < k:
            lo = j + 1
        else:
            return seq[k] 
    return seq[k]

def partition(seq, lo, hi):
    i = lo + 1; j = hi
    while True:
        while seq[i] < seq[lo]:
            i = i + 1
            if i == hi: break
        while seq[j] > seq[lo]:
            j = j - 1
            if j == lo: break 
        if i >= j:
            break
        seq[i], seq[j] = seq[j], seq[i]
    seq[lo], seq[j] = seq[j], seq[lo] 
    return j

def shuffle(seq):
    for i in range(1, len(seq)):
        rnd = randrange(i)
        seq[i], seq[rnd] = seq[rnd], seq[i] 
    return seq

seq = shuffle(range(10)) 
print quick_select(seq, 3)
