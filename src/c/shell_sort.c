#include <stdio.h>

void print_array(int* p, int size); 
void shell_sort(int* p, int size); 
void swap(int* p, int i, int j); 

int main()
{
    int a[15] = {7, 10, 5, 3, 8, 4, 2, 9, 6, 1, 12, 14, 2, 5, 15}; 

    print_array(a, 15); 
    shell_sort(a, 15); 
    print_array(a, 15); 

    return 0; 
}

void shell_sort(int* p, int size)
{
    int g[3] = {1, 4, 7}; 
    for(int i = 2; i >= 0; i--)
    {
        int h = g[i];
        for(int j = h; j < size; j++)
        { 
            for(int k = j; k >= h; k -= h)
            {
                if(p[k] < p[k-h])
                    swap(p, k, k-h);
            }
        }
    }
}

void print_array(int* p, int size)
{
    for(int i = 0; i < size; i++)
        printf("%d ", p[i]); 
    printf("\n"); 
}

void swap(int* p, int i, int j)
{
    int tmp = p[i]; 
    p[i] = p[j]; 
    p[j] = tmp; 
}
