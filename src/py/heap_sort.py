from random import randrange

def gen_data():
    seq = range(10)
    for i in range(1, 10):
        r = randrange(i)
        seq[i], seq[r] = seq[r], seq[i]
    return seq

def heap_sort(seq):
    for i in range((len(seq) - 1)/ 2, -1, -1):
        sink(seq, i, len(seq))

    cnt = len(seq)
    while cnt > 0:
        seq[0], seq[cnt - 1] = seq[cnt - 1], seq[0]
        cnt = cnt - 1
        sink(seq, 0, cnt)

def sink(seq, k, n):
    while (k + 1) * 2 - 1 < n:
        j = (k + 1) * 2 - 1
        if j < n - 1 and seq[j] < seq[j + 1]:
            j = j + 1
        if seq[k] > seq[j]: 
            break
        seq[j], seq[k] = seq[k], seq[j]
        k = j

seq = gen_data()
heap_sort(seq)

print seq
