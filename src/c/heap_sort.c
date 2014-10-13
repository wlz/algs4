#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define N 100

static int seq[N];

void init();
void print();
void swap(int p, int q);

void heap_sort();
void sink(int k, int n);

int main()
{
    init();
    print();

    heap_sort();
    print();
    return 0;
}

void heap_sort()
{
    for(int k = N / 2; k >= 1; k--)
        sink(k, N); 
    int cnt = N;
    while(cnt > 1)
    {
        swap(1, cnt);
        sink(1, --cnt);
    }
}

void sink(int k, int n)
{
    while(k * 2 <= n)
    {
        int j = k * 2;
        if(j < n && seq[j] < seq[j + 1]) j++;
        if(seq[k] > seq[j]) break;
        swap(k, j);

        k = j;
    }
}

void init()
{
    for(int i = 1; i <= N; i++)
        seq[i] = i;
    srand(time(NULL));
    for(int i = 2; i <= N; i++)
    {
        int r = rand() % (i - 1) + 1;
        swap(i, r);
    }
}

void print()
{
    for(int i = 1; i <= N; i++)
        printf("%d ", seq[i]); 
    printf("\n"); 
}

void swap(int p, int q)
{
    int t = seq[p];
    seq[p] = seq[q];
    seq[q] = t;
} 
