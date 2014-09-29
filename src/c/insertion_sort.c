#include <stdio.h>

void swap(int* p, int i, int j); 
void print_array(int* p, int size); 
void insertion_sort(int* p, int size); 

int main()
{
    int a[9] = {7, 10, 5, 3, 8, 4, 2, 9, 6}; 

    printf("before : ");
    print_array(a, 9); 

    insertion_sort(a, 9);
    printf("after  : ");
    print_array(a, 9); 

    return 0; 
}

void insertion_sort(int* p, int size)
{
    for(int i = 0; i < size; i++)
    {
        for(int j = i + 1; j > 0; j--)
        {
            if(p[j] < p[j - 1])
                swap(p, j, j - 1); 
        }
    }
}

void swap(int* p, int i, int j)
{
    int tmp = p[i]; 
    p[i] = p[j]; 
    p[j] = tmp; 
}

void print_array(int* p, int size)
{
    for(int i = 0; i < size; i++)
        printf("%d ", p[i]); 
    printf("\n"); 
} 
