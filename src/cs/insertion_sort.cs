using System; 

public class Program
{
	public static void Main()
	{
		int[] seq = new int[]{4, 5, 7, 1, 2, 9, 10, 3, 1}; 
		PrintSeq(seq); 
		InsertionSort(seq); 
		PrintSeq(seq); 
	}

	private static void PrintSeq(int[] seq)
	{
		for(int i = 0; i < seq.Length; i++)
			Console.Write(seq[i].ToString() + " "); 
		Console.WriteLine(); 
	}	

	private static void Swap(int[] seq, int i, int j)
	{
		int tmp = seq[i]; 
		seq[i] = seq[j]; 
		seq[j] = tmp; 
	}

	private static void InsertionSort(int[] seq)
	{
		for(int i = 0; i < seq.Length - 1; i++)
		{
			for(int j = i + 1; j > 0; j--)
			{
				if(seq[j] < seq[j - 1])
					Swap(seq, j, j - 1); 
			}
		}
	}
}



