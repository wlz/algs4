#include <stdio.h>

void print_seq(int* p, int sz); 
void set_union(int* id, int* sz, int p, int q); 
int connected(int* id, int p , int q); 
int root(int* id, int n); 

int main()
{ 
	int id[10]; 
	int sz[10]; 

	for(int i = 0; i < 10; i++)
		id[i] = i; 
	for(int i = 0; i < 10; i++)
		sz[i] = 1; 

	set_union(id, sz, 4, 3); 
	set_union(id, sz, 3, 8); 
	set_union(id, sz, 6, 5); 
	set_union(id, sz, 9, 4); 

	printf("%d\n", connected(id, 8, 9)); 
	printf("%d\n", connected(id, 5, 4)); 

	set_union(id, sz, 5, 0); 
	set_union(id, sz, 7, 2); 
	set_union(id, sz, 6, 1); 
	set_union(id, sz, 7, 3); 

	printf("%d\n", connected(id, 5, 4)); 
	return 0; 
}

void print_seq(int* p, int sz)
{
	for(int i = 0; i < sz; i++)
		printf("%d ", *(p + i)); 	

	printf("\n"); 	
} 

void set_union(int* id, int* sz, int p, int q) 
{
	int rp = root(id, p); 
	int rq = root(id, q); 

	if(sz[rp] < sz[rq])
	{
		id[rq] = id[rp]; 
		sz[rp]++; 
	}
	else
	{
		id[rp] = id[rq]; 
		sz[rq]++; 
	}
	print_seq(sz, 10); 
}

int connected(int* id, int p, int q) 
{
	return root(id, p) == root(id, q); 
}

int root(int* id, int n)
{ 
	if(id[n] == n)
		return n; 
	else
		return root(id, id[n]); 
} 
