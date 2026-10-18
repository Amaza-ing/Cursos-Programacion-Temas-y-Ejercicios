# **Topic 9: Advanced Functions and Modular Code in JavaScript**

## **1. Introduction**

Advanced functions in JavaScript let you write more efficient, reusable and modular code. In this topic, we'll explore advanced techniques such as higher-order functions, closures, currying and code modularization.

---

## **2. Higher-order functions**

A higher-order function is one that receives another function as a parameter or returns a function.

### **Example: `map()` as a higher-order function**

```js
const numbers = [1, 2, 3, 4];
const squaredNumbers = numbers.map((num) => num * num);
console.log(squaredNumbers); // Salida: [1, 4, 9, 16]
```

### **Example: a function that receives another function as an argument**

```js
function operate(a, b, operation) {
  return operation(a, b);
}

function add(x, y) {
  return x + y;
}

console.log(operate(5, 3, add)); // Salida: 8
```

---

## **3. Closures (nested functions with access to the outer scope)**

A closure is a function that remembers the scope in which it was created, which lets it access variables outside its own scope.

### **Closure example**

```js
function createCounter() {
  let count = 0;
  return function () {
    count++;
    return count;
  };
}

const counter = createCounter();
console.log(counter()); // Salida: 1
console.log(counter()); // Salida: 2
```

Here, `counter` remembers the variable `count` even though the outer function `createCounter` has finished running.

---

## **4. Currying**

Currying is a technique that transforms a function that receives multiple arguments into a series of functions that each receive a single argument.

### **Currying example**

```js
function multiply(a) {
  return function (b) {
    return a * b;
  };
}

const double = multiply(2);
console.log(double(5)); // Salida: 10
```

This allows greater reuse and composition of functions.

---

## **5. Pure functions and immutability**

A function is **pure** if:

1. Its output depends only on its inputs.
2. It doesn't modify external variables or the global state.

### **Pure function example**

```js
function sum(a, b) {
  return a + b;
}

console.log(sum(3, 4)); // Salida: 7
```

> **Note:** Avoid modifying mutable arrays or objects inside functions to preserve immutability.

---

## **6. Code modularization**

To make your code more reusable and easier to maintain, you can split it into modules using `export` and `import`.

### **Example of exporting in a `math.js` file**

```js
export function add(a, b) {
  return a + b;
}

export function subtract(a, b) {
  return a - b;
}
```

### **Example of importing in `main.js`**

```js
import { add, subtract } from "./math.js";

console.log(add(5, 3)); // Salida: 8
console.log(subtract(5, 3)); // Salida: 2
```

This lets you organize code into separate files to improve readability and maintainability.

---

## **7. Recursive functions**

A recursive function is one that calls itself until an exit condition is reached.

### **Factorial example with recursion**

```js
function factorial(n) {
  if (n === 0) return 1;
  return n * factorial(n - 1);
}

console.log(factorial(5)); // Salida: 120
```

> **Note:** Make sure to define an exit condition to avoid infinite loops.

---

## **8. Best practices**

- Use higher-order functions to make your code more reusable.
- Prefer pure functions to avoid side effects.
- Apply modularization by splitting the code into separate files.
- Use closures when you need data encapsulation.
- Use currying when it's useful to split functions into smaller calls.

---

## **9. Conclusion**

Mastering advanced functions in JavaScript lets you write cleaner, more modular and efficient code. By applying these techniques, you can improve the reusability and scalability of your programs.

In the next topic, we'll look at some special functions that can come in handy, such as `setTimeout()`, `setInterval()` and others.
