#include <stdio.h>

int val[10]; 
int loc_val = 0; 

char op[10]; 
int loc_op = 0; 

void push_val(int val); 
int pop_val(); 

void push_op(char op); 
char pop_op(); 

int main()
{
    char* exp = "(1+((2+3)*(4*5)))";

    while(*(exp++) != '\0')
    {
        if(*exp == '(' || *exp == '\0')
            continue;
        else if(*exp == '+' || *exp == '*')
            push_op(*exp);
        else if(*exp == ')')
        {
            int val1 = pop_val();
            int val2 = pop_val();
            char op = pop_op();
            int val;

            if(op == '+')
                val = val1 + val2;
            else if(op == '*')
                val = val1 * val2;

            push_val(val);
        }
        else
        { 
            int v = (int)*exp - 48;
            push_val(v);
        } 
    }

    printf("%d\n", pop_val()); 
    return 0; 
}

void push_val(int v)
{
    val[loc_val++] = v;
}

int pop_val()
{
    return val[--loc_val]; 
}

void push_op(char o)
{
    op[loc_op++] = o;
}

char pop_op()
{
    return op[--loc_op]; 
}

