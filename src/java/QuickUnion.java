public class QuickUnion
{
	private int[] seq = new int[10]; 

	public static void main(String[] args)
	{
		QuickUnion q = new QuickUnion(); 
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
			seq[i] = i; 
	}

	public int root(int n)
	{
		return seq[n] == n ? n: root(seq[n]); 
	}	

	public void setUnion(int p, int q)
	{ 
		int rp = root(p); 
		int rq = root(q); 

		seq[rp] = rq; 
	} 

	public boolean connected(int p, int q)
	{ 
		return root(p) == root(q); 
	}	
}

