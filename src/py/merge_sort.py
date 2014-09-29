seq = [ 9, 1, 3, 5, 2, 4, 7, 6, 8, 0 ]

def sort(seq):
    aux = []
    merge_sort(seq, aux, 0, len(seq) - 1)

def merge_sort(seq, aux, lo, hi):
    if lo >= hi:
        return
    mid = lo + (hi - lo) / 2

    merge_sort(seq, aux, 0, mid)
    merge_sort(seq, aux, mid + 1, hi)

    merge(seq, aux, lo, mid, hi)

def merge(seq, aux, lo, mid, hi): 
    aux = seq[:]
    j = lo; k = mid + 1
    for i in range(lo, hi + 1):
        if j > mid:
            seq[i] = aux[k]; k += 1
        elif k > hi:
            seq[i] = aux[j]; j += 1
        elif aux[j] <= aux[k]:
            seq[i] = aux[j]; j += 1
        else:
            seq[i] = aux[k]; k += 1

sort(seq)
print seq
