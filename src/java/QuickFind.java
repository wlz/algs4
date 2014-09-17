public class QuickFind
{
	private int[] arr = new int[10]; 

	public static void main(String[] args)
	{
		QuickFind q = new QuickFind(); 
		q.init(); 

		q.setUnion(4, 3); 
		q.setUnion(3, 8); 
		q.setUnion(6, 5); 
		q.setUnion(9, 4); 

		System.out.println(q.connected(8, 9)); 
		System.out.println(q.connected(5, 4)); 

		q.setUnion(5, 0); 
		q.setUnion(7, 2); 
		q.setUnion(6, 1); 
		q.setUnion(7, 3); 

		System.out.println(q.connected(2, 3)); 
	}

	public void init()
	{
		for(int i = 0; i < 10; i++)
			arr[i] = i; 
	}

	public void setUnion(int p, int q)
	{ 
		for(int i = 0; i < 10; i++)
		{
			if(arr[i] == arr[q])
				arr[i] = arr[p]; 
		}
	}

	public boolean connected(int p, int q)
	{
		return arr[p] == arr[q]; 
	}
}
