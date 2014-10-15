from random import randrange

def gen_data(n):
    seq = range(n)
    for i in range(1, len(seq)):
        r = randrange(i)
        seq[i], seq[r] = seq[r], seq[i] 
    return seq

def select_min_items(seq, m):
    pq = []
    for i in range(len(seq)):
        insert(pq, seq[i])
        if len(pq) > m:
            del_max(pq)
    return pq

def insert(pq, key):
    pq.append(key)
    swim(pq, len(pq) - 1)

def del_max(pq):
    m = pq[0]
    pq[0] = pq[-1]
    pq.pop()
    sink(pq, 0)
    return m

def swim(pq, k): 
    while (k - 1) / 2 >= 0:
        if pq[k] < pq[(k - 1) / 2]: break
        pq[k], pq[(k - 1) / 2] = pq[(k - 1) / 2], pq[k]

        k = (k - 1) / 2

def sink(pq, k):
    while k * 2 + 1 <= len(pq) - 1:
        j = k * 2 + 1
        if j + 1 <= len(pq) - 1 and pq[j] < pq[j + 1]: j = j + 1
        if pq[k] > pq[j]: break
        pq[j], pq[k] = pq[k], pq[j]

        k = j

seq = gen_data(100)
print select_min_items(seq, 10)
