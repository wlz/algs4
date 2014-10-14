using System;

public class Program
{
	public static void Main()
	{ 
        int[] seq = GenData(10);
        HeapSort(seq);
        Print(seq);
	}

    private static void HeapSort(int[] seq)
    { 
        for(int i = seq.Length / 2 - 1; i >= 0; i--)
            Sink(seq, i, seq.Length);
        int cnt = seq.Length - 1;
        while(cnt >= 0)
        {
            Swap(seq, 0, cnt);
            Sink(seq, 0, cnt--);
        }
    }

    private static void Sink(int[] seq, int k, int n)
    { 
        while(k * 2 + 1 <= n - 1)
        {
            int j = k * 2 + 1;
            if(j + 1 <= n - 1 && seq[j] < seq[j + 1]) j++;
            if(seq[k] > seq[j]) break;
            Swap(seq, j, k);

            k = j;
        }
    }

    private static int[] GenData(int size)
    {
        int[] seq = new int[size];
        for(int i = 0; i < seq.Length; i++)
            seq[i] = i;

        Random rand = new Random();
        for(int i = 1; i < seq.Length; i++)
        {
            int r = rand.Next(i);
            Swap(seq, i, r);
        }

        return seq; 
    }

    private static void Swap(int[] seq, int p, int q)
    {
        int t = seq[p];
        seq[p] = seq[q];
        seq[q] = t;
    }

    private static void Print(int[] seq)
    {
        for(int i = 0; i < seq.Length; i++)
            Console.Write(seq[i] + " ");
        Console.WriteLine();
    }
}

