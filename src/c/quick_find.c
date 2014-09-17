#include <stdio.h>

int seq[10]; 

void init_seq(); 
void print_seq(); 
void set_union(); 

int main()
{
	init_seq(); 

	set_union(4, 3); 
	set_union(3, 8); 
	set_union(6, 5); 
	set_union(9, 4); 

	printf("%d\n", connected(8, 9)); 
	printf("%d\n", connected(5, 9)); 

	set_union(5, 0); 
	set_union(7, 2); 
	set_union(6, 1); 
	set_union(7, 3); 

	printf("%d\n", connected(2, 3)); 
	return 0; 
} 

void set_union(int p, int q)
{
	int n = seq[q];
	for(int i = 0; i < 10; i++)
	{
		if(seq[i] == n)
			seq[i] = seq[p]; 
	}
}

int connected(int p, int q)
{ 
	return seq[p] == seq[q]; 
}

void init_seq()
{
	for(int i = 0; i < 10; i++)
		seq[i] = i; 
} 
