#include <stdlib.h>
#include <stdio.h>
#include <time.h>

#define N 100

static int seq[N];
static int pq[N];

int cnt = 0;

void init();
void swap(int* seq, int p, int q);

void insert(int key);
int del_max();
int size();

void swim(int k);
void sink(int k);

void select_smallest_m(int m);

int main()
{
    init();
    select_smallest_m(20);

    return 0;
}

void select_smallest_m(int m)
{
    for(int i = 0; i < N; i++)
    {
        insert(seq[i]);
        if(size() > m)
            del_max();
    }

    for(int i = 0; i < m; i++)
        printf("%d ", pq[i]); 
    printf("\n"); 
}

int size()
{
    return cnt;
}

void insert(int key)
{ 
    pq[++cnt] = key;
    swim(cnt); 
}

int del_max()
{ 
    int max = pq[1];
    swap(pq, 1, cnt--);
    sink(1);
    pq[cnt + 1] = 0;
    return max;
}

void swim(int k)
{ 
    while(k > 1 && pq[k / 2] < pq[k])
    {
        swap(pq, k, k / 2);
        k = k / 2;
    }
}

void sink(int k)
{ 
    while(k * 2 <= cnt)
    {
        int j = k * 2;
        if(j < cnt && pq[j] < pq[j + 1]) j++;
        if(pq[k] >= pq[j]) break;
        swap(pq, k, j);
        k = j;
    }
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
    seq[q] = t;
}
