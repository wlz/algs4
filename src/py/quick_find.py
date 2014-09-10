cnt = 10
seq = range(cnt) 

def union(a,b):
	#print 'union:'+str(a)+str(b)
	aid = seq[a]
	bid = seq[b]
	for i in range(len(seq)):
		if seq[i] == bid:
			seq[i] = aid
	print seq


def connected(a,b):
	return True if seq[a]==seq[b] else False

union(4,3)
union(3,8)
union(6,5)
union(9,4)
union(2,1)

print connected(0,7)
print connected(8,9)

union(5,0)
union(7,2)
union(6,1)
union(1,0)

print connected(0,7)
