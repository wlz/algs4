#include <stdio.h>

int seq[10]; 

void init_seq(); 
void print_seq(); 
void set_union(); 

int main()
{
	init_seq(); 
	set_union(1, 2); 
	printf("%d\n", connected(1, 2)); 
	return 0; 
} 

void set_union(int p, int q)
{
	for(int i = 0; i < 10; i++)
	{
		if(seq[i] == seq[q])
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

