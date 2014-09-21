#include <stdio.h>

void select_sort(int* p, int size); 
void print_array(int* p, int size); 

int main()
{
	int a[9] = {7, 10, 5, 3, 8, 4, 2, 9, 6}; 

	printf("before sort: "); 
	print_array(a, 9); 

	select_sort(a, 9); 
	printf("after sort : "); 
	print_array(a, 9); 

	return 0; 
}

void select_sort(int* p, int size)
{
	for(int i = 0; i < size - 1; i++)
	{
		int min = i; 
		for(int j = i+1; j < size; j++)
		{
			if(p[j] < p[min])
				min = j;
		}
		if(min != i)
		{
			int tmp = p[i];
			p[i] = p[min];
			p[min] = tmp;
		}
	}
}

void print_array(int* p, int size)
{
	for(int i = 0; i < size; i++)
		printf("%d ", p[i]); 
	printf("\n"); 
} 

