def insertion_sort(s): 
	for i in range(len(seq)): 
		min = i
		for j in range(i, len(seq)):
			if seq[j] < seq[min]:
				min = j
		swap(i, min)

def swap(i, j):
	tmp = seq[i]
	seq[i] = seq[j]
	seq[j] = tmp

seq = [7, 10, 5, 3, 8, 4, 2, 9, 6]
insertion_sort(seq)
print seq

