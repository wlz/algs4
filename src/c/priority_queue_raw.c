#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define N 100

static int seq[N]; 
static int pq[N];
int cnt = 0;

void init();
void swap(int* seq, int p, int q);
void print();

void insert(int key);
int del_min();
int size();
int is_empty();

void select_largest_m(int m);

int main()
{
    init(); 
    select_largest_m(10);

    return 0;
}

void select_largest_m(int m)
{
    for(int i = 0; i < N; i++)
    {
        insert(seq[i]);
        if(size() > m)
            del_min();
    }

    for(int i = 0; i < m; i++)
        printf("%d ", pq[i]);
}

int size()
{
    return cnt;
}

void insert(int key)
{ 
    pq[cnt++] = key;
}

int del_min()
{ 
    int min = 0;
    for(int i = 0; i < cnt; i++)
        if(pq[i] < pq[min]) min = i;

    swap(pq, min, cnt - 1);
    pq[cnt - 1] = 0;
    
    return pq[cnt--];
}

void init()
{
    for(int i = 0; i < N; i++)
        seq[i] = i;
    srand(time(NULL));
    for(int i = 1; i < N; i++)
    {
        int r = rand() % i;
        swap(seq, i, r);
    }
}

void swap(int* seq, int p, int q)
{
    int t = seq[p];
    seq[p] = seq[q];
    seq[q] = p;
}
