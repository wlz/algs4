using System;

public class Program
{
    static int[] seq = new int[10];

	public static void Main()
	{
        Init();
        QuickSort();
        PrintSeq();
	}

    private static void Init()
    {
        for(int i = 0; i < seq.Length; i++)
            seq[i] = i;

        Random rnd = new Random();

        for(int i = 1; i < seq.Length; i++)
        {
            int r = rnd.Next(i);
            Swap(r, i);
        }
    }

    private static void PrintSeq()
    {
        for(int i = 0; i < seq.Length; i++)
            Console.Write(seq[i] + " ");    
        Console.WriteLine();    
    }

    private static void Swap(int p, int q)
    {
        int t = seq[p];
        seq[p] = seq[q];
        seq[q] = t;
    } 

    private static int Partition(int lo, int hi)
    {
        int i = lo, j = hi + 1;

        while(true)
        {
            while(seq[++i] < seq[lo])
                if(i == hi) break;
            while(seq[--j] > seq[lo])
                if(j == lo) break;

            if(i >= j) break;
            Swap(i, j); 
        }
        Swap(lo, j);
        return j;
    }

    private static void QuickSort()
    {
        QuickSort(0, seq.Length - 1);
    }

    private static void QuickSort(int lo, int hi)
    {
        if(lo >= hi)
            return;
        int j = Partition(lo, hi);
        QuickSort(lo, j - 1);
        QuickSort(j + 1, hi);
    }
} 
