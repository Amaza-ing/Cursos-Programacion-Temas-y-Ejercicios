# **Topic 9: Advanced Functions and Modular Code in JavaScript**

## **1. Introduction**

Advanced features in JavaScript allow you to write more efficient, reusable, and modular code. In this topic we will explore advanced techniques such as higher order functions, closures, currying and code modularization.

---

## **2. Higher Order Functions**

A higher order function is one that receives another function as a parameter or returns a function.

### **Example: `map()` as a higher order function**

```js
const numbers = [1, 2, 3, 4];
const squaredNumbers = numbers.map((num) => num * num);
console.log(squaredNumbers); // Salida: [1, 4, 9, 16]
```

### **Example: Function that receives another function as an argument**

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

## **3. Closures (Nested Functions with Access to the External Scope)**

A closure is a function that remembers the scope in which it was created, allowing access to variables outside its own scope.

### **Closure Example**

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

Here, `counter` remembers the variable `count` even though the external function `createCounter` has finished executing.

---

## **4. Currying**

Currying is a technique that transforms a function that receives multiple arguments into a series of functions that receive a single argument at a time.

### **Currying Example**

```js
function multiply(a) {
  return function (b) {
    return a * b;
  };
}

const double = multiply(2);
console.log(double(5)); // Salida: 10
```

This allows for greater reuse and composition of functions.

---

## **5. Pure Functions and Immutability**

A function is **pure** if:

1. Your output only depends on your inputs.
2. It does not modify external variables or the global state.

### **Pure Function Example**

```js
function sum(a, b) {
  return a + b;
}

console.log(sum(3, 4)); // Salida: 7
```

> **Note:** Avoid modifying arrays or mutable objects within functions to maintain immutability.

---

## **6. Code Modularization**

To make the code more reusable and maintainable, it can be divided into modules using `export` and `import`.

### **Example of Exporting to an `math.js` File**

```js
export function add(a, b) {
  return a + b;
}

export function subtract(a, b) {
  return a - b;
}
```

### **Example of Import in `main.js`**

```js
import { add, subtract } from "./math.js";

console.log(add(5, 3)); // Salida: 8
console.log(subtract(5, 3)); // Salida: 2
```

This allows code to be organized into separate files to improve readability and maintainability.

---

## **7. Recursive Functions**

A recursive function is one that calls itself until an exit condition is reached.

### **Example of Factorial with Recursion**

```js
function factorial(n) {
  if (n === 0) return 1;
  return n * factorial(n - 1);
}

console.log(factorial(5)); // Salida: 120
```

> **Note:** Make sure to define an exit condition to avoid infinite loops.

---

## **8. Good Practices**

- Use higher order functions to improve code reusability.
- Pure functions are preferable to avoid side effects.
- Apply modularization by dividing the code into separate files.
- Use closures when you need data encapsulation.
- Use currying when it is useful to split functions into smaller calls.

---

## **9. Conclusion**

Mastering advanced functions in JavaScript allows you to write cleaner, more modular and efficient code. By applying these techniques, you can improve the reusability and scalability of your programs.

In the next topic we will see some special functions that may be useful, such as `setTimeout()`, `setInterval()` and others.
