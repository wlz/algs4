public class ArrayStack
{
	public String[] stack = new String[10];
	public int p = 0;

	public static void main(String[] args)
	{ 
		ArrayStack p = new ArrayStack();

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

	public void push(String s)
	{
		stack[p++] = s;
	}

	public String pop()
	{
		return stack[--p];
	}

	public boolean isEmpty()
	{
		return p == 0;
	} 
}
