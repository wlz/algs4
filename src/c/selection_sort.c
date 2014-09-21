#include <stdio.h>

void select_sort(int* p, int size); 
void print_array(int* p, int size); 

int main()
{
	int a[10] = {3, 4, 5, 1, 2, 9, 6, 7, 8, 0}; 

	printf("before sort: "); 
	print_array(a, 10); 

	select_sort(a, 10); 
	printf("after sort : "); 
	print_array(a, 10); 

	return 0; 
}

void select_sort(int* p, int size)
{
	for(int i = 0; i < size - 1; i++)
	{
		int min = i + 1; 
		for(int j = i + 2; j < size; j++)
		{ 
			if(p[j] < p[min])
				min = j; 
		} 
		if(p[min] < p[i])
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
