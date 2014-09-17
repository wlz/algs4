public class LnkStack
{
	public static void main(String[] args)
	{
		LnkStack ls = new LnkStack();
		ls.run();
	}

	public void run()
	{
		Stack p = new Stack();

		p.push("to"); 
		p.push("be"); 
		p.push("or"); 
		p.push("not"); 
		p.push("to"); 

		System.out.println(p.pop()); 

		p.push("be"); 

		System.out.println(p.pop()); 
		System.out.println(p.pop()); 

		p.push("that"); 

		System.out.println(p.pop()); 
		System.out.println(p.pop()); 
		System.out.println(p.pop()); 

		p.push("is"); 
	}

	public class Node
	{
		public String str; 
		public Node last; 

		public Node(String s, Node n)
		{
			str = s; 
			last = n; 
		}
	}

	public class Stack
	{
		private Node first;
		private Node current;

		public void push(String s)
		{
			if(first == null)
			{
				first = new Node(s, null);
				current = first;
			}
			else
			{
				Node n = new Node(s, current);
				current = n;
			} 
		}

		public String pop()
		{
			String s = current.str;
			current = current.last;
			return s;
		}

		public boolean isEmpty()
		{
			return current.last == null;
		}
	} 
}


