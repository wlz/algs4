import java.util.Random;

public class HeapSort
{
    public static void main(String[] args)
    { 
        int[] seq = genData(10);
        heapSort(seq); 
        print(seq);
    } 

    private static void heapSort(int[] seq)
    { 
        for(int i = seq.length / 2 - 1; i >= 0; i--)
            sink(seq, i, seq.length);
        int cnt = seq.length - 1;
        while(cnt > 0)
        {
            swap(seq, 0, cnt);
            sink(seq, 0, cnt--);
        }
    }

    private static void sink(int[] seq, int k, int n)
    { 
        while(k * 2 + 1 <= n - 1)
        {
            int j = k * 2 + 1;
            if(j + 1 <= n - 1 && seq[j] < seq[j + 1]) j++;
            if(seq[k] > seq[j]) break;
            swap(seq, j, k);

            k = j;
        }
    }

    private static int[] genData(int size)
    {
        int[] seq = new int[size];
        for(int i = 0; i < size; i++)
            seq[i] = i;
        Random rand = new Random(); 
        for(int i = 1; i < size; i++)
        {
            int r = rand.nextInt(i);
            swap(seq, i, r);
        }
        return seq;
    }

    private static void swap(int[] seq, int p, int q)
    {
        int t = seq[p];
        seq[p] = seq[q];
        seq[q] = t;
    }

    private static void print(int[] seq)
    {
        for(int i = 0; i < seq.length; i++)
            System.out.print(seq[i] + " ");   
        System.out.println(); 
    }
} 
