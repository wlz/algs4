var stack = []; 
var point = 0;

function push(val) { 
    stack[point++] = val;
}

function pop() {
    return stack[--point];
}

function is_empty() {
    return point == 0;
}

push("to");
push("be");
push("or");
push("not");
push("to");

console.log(pop());

push("be");

console.log(pop());
console.log(pop());

push("that");

console.log(pop());
console.log(pop());
console.log(pop());

console.log("\n");
push("is");
