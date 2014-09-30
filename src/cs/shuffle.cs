using System;

public class Program
{
    public static void Main()
    {
        int[] seq = new int[] { 9, 1, 2, 6, 8, 4, 5, 7, 0, 3 };
        Shuffle(seq);
        PrintSeq(seq);
    } 

    private static void PrintSeq(int[] seq)
    {
        for(int i = 0; i < seq.Length; i++)
            Console.Write(seq[i] + " ");    
        Console.WriteLine();
    }

    private static void Shuffle(int[] seq)
    {
        Random rnd = new Random();

        for(int i = 1; i < seq.Length; i++)
        {
            int r = rnd.Next(i);

            int tmp = seq[i];
            seq[i] = seq[r];
            seq[r] = tmp;
        }
    }
}
