def insertion_sort(s):
    for i in range(len(s)):
        for j in range(i, 0, -1):
            if s[j] < s[j - 1]:
                swap(j, j - 1) 

def swap(i, j):
        tmp = seq[i]
        seq[i] = seq[j]
        seq[j] = tmp

seq = [7, 10, 5, 3, 8, 4, 2, 9, 6]
insertion_sort(seq)
print seq 
