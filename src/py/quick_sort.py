from random import randrange

def partition(seq, lo, hi):
    i = lo + 1; j = hi 
    while True:
        while seq[i] < seq[lo]:
            if(i == hi):
                break
            i = i + 1

        while seq[j] > seq[lo]:
            if(j == lo):
                break
            j = j - 1 
        if i >= j:
            break
        seq[i], seq[j] = seq[j], seq[i] 
    seq[lo], seq[j] = seq[j], seq[lo]

    return j 

def quick_sort(seq, lo, hi):
    if lo >= hi:
        return
    j = partition(seq, lo, hi)
    quick_sort(seq, lo, j - 1)
    quick_sort(seq, j + 1, hi)

def sort(seq):
    quick_sort(seq, 0, len(seq) - 1)

def shuffle(seq):
    for i in range(1, len(seq)):
        ran = randrange(i)
        seq[i], seq[ran] = seq[ran], seq[i]

def init(seq):
    for i in range(10):
        seq.append(i)
    shuffle(seq)

seq = []
init(seq)
sort(seq)

print seq

