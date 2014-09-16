#include <stdio.h>

void print_seq(int *, int); 
void set_union(int *seq, int p, int q)
{ 
	int rp = root(seq, p); 
	int rq = root(seq, q); 

	seq[rp] = rq; 

	print_seq(seq, 10); 
}

int root(int *seq, int n)
{
	if(seq[n] == n)
		return n; 
	else
		return root(seq, seq[n]); 
}

int connected(int *seq, int p, int q)
{
	return root(seq, p)==root(seq, q); 
}

void print_seq(int *p, int size)
{
	for(int i = 0; i < size; i++) 
		//		printf("%d ", p[i]); 
		printf("%d ", *(p + i)); 
	printf("\n"); 
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

	printf("%d\n", connected(seq, 5, 4)); 

	return 0; 
}


