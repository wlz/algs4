#include <stdio.h>

void set_union(int *seq, int p, int q)
{ 
	int rp = root(seq, p); 
	int rq = root(seq, q); 

	seq[rp] = rq; 
}

int root(int *seq, int n)
{
	return seq[n] == n ? n:root(seq, seq[n]); 
}

int connected(int *seq, int p, int q)
{
	return root(seq, p)==root(seq, q); 
}

int main()
{
	int seq[10]; 
	for(int i = 0; i < 10; i++)
		seq[i] = i; 

	set_union(seq, 4, 3); 
	set_union(seq, 3, 8); 
	set_union(seq, 6, 5); 
	set_union(seq, 9, 4); 

	printf("%d\n", connected(seq, 8, 9)); 
	printf("%d\n", connected(seq, 5, 4)); 

	set_union(seq, 5, 0); 
	set_union(seq, 7, 2); 
	set_union(seq, 6, 1); 
	set_union(seq, 7, 3); 

	printf("%d\n", connected(seq, 2, 3)); 

	return 0; 
}



