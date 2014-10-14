#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define N 100

static int seq[N];

void gen_data();
void swap(int p, int q);
void print();

void heap_sort();
void sink(int k, int n);

int main()
{
    gen_data();
    heap_sort();
    print();

    return 0;
}

void heap_sort()
{ 
    for(int i = N / 2 - 1; i >= 0; i--)
        sink(i, N);

    int cnt = N - 1;
    while(cnt > 0)
    {
        swap(0, cnt);
        sink(0, cnt--);
    }
}

void sink(int k, int n)
{ 
    while(k * 2 + 1 <= n - 1)
    { 
        int j = k * 2 + 1;
        if(j + 1 <= n - 1 && seq[j + 1] > seq[j])
            j++;
        if(seq[k] > seq[j]) break;
        swap(j, k);

        k = j;
    }
}

void gen_data()
{
    for(int i = 0; i < N; i++)
        seq[i] = i;
    srand(time(NULL));
    for(int i = 1; i < N; i++)
    {
        int r = rand() % i;
        swap(i, r);
    }
}

void print()
{
    for(int i = 0; i < N; i++)
        printf("%d ", seq[i]); 
    printf("\n"); 
}

void swap(int p, int q)
{
    int t = seq[p];
    seq[p] = seq[q];
    seq[q] = t;
}
