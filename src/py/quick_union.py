seq = range(10)

def union(a, b):
	seq[root(a)] = root(b)
	print seq

def connected(a, b): 
	return root(a) == root(b)

def root(n):
	return n if seq[n] == n else root(seq[n])

union(4, 3)
union(3, 8)
union(6, 5)
union(9, 4)
union(2, 1)

print connected(8, 9)
print connected(5, 4)

union(5, 0)
union(7, 2)
union(6, 1)
union(7, 3)
