using System;

public class Program
{
    private static int[] seq = new int[10];

	public static void Main()
    { 
        Init();
        Console.WriteLine(Select(5));    
    }

    private static int Select(int k)
    {
        int lo = 0, hi = seq.Length - 1;
        while(true)
        {
            if(lo >= hi)
                break;
            int j = Partition(lo, hi);
            if(j > k)
                hi = j - 1;
            else if(j < k)
                lo = j + 1;
            else
                return seq[k];
        }

        return seq[k];
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
}

