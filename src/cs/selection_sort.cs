using System; 

public class Program
{
	public static void Main()
	{
		int[] seq = new int[]{6, 9, 2, 1, 7, 10, 3, 8}; 

		PrintSeq(seq);
		SelectionSort(seq);
		PrintSeq(seq); 
	}

	private static void SelectionSort(int[] seq)
	{ 
		for(int i = 0; i < seq.Length - 1; i++)
		{
			int min = i;
			for(int j = i + 1; j < seq.Length; j++)
			{
				if(seq[j] < seq[min])
					min = j; 
			}
			Swap(seq, i, min);
		}
	}

	private static void Swap(int[] seq, int i, int j)
	{
		int tmp = seq[i];
		seq[i] = seq[j];
		seq[j] = tmp;
	}

	private static void PrintSeq(int[] seq)
	{
		for(int i = 0; i < seq.Length; i++)
			Console.Write(seq[i].ToString() + " ");

		Console.WriteLine();
	}	
} 
