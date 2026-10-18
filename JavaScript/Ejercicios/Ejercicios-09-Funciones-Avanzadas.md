# **Exercises - Topic 9: Advanced Functions in JavaScript**

Below you'll find 5 practical exercises on advanced functions in JavaScript.

Try to solve them before looking at the solution.

---

### **Exercise 1: Higher-Order Function**

Create a function called `applyOperation` that takes two numbers and a function as parameters. The function must apply the given operation to the two numbers.

<details><summary>Show solution</summary>

```js
function applyOperation(a, b, operation) {
  return operation(a, b);
}

function add(x, y) {
  return x + y;
}

function multiply(x, y) {
  return x * y;
}

console.log(applyOperation(5, 3, add)); // Salida: 8
console.log(applyOperation(5, 3, multiply)); // Salida: 15
```

</details>

---

### **Exercise 2: Closure**

Create a function `createMultiplier` that accepts a number as an argument and returns another function that multiplies any number by the given number.

<details><summary>Show solution</summary>

```js
function createMultiplier(factor) {
  return function (number) {
    return number * factor;
  };
}

const double = createMultiplier(2);
console.log(double(5)); // Salida: 10
```

</details>

---

### **Exercise 3: Currying**

Convert the `sum` function into a curried function that lets you add numbers in separate calls.

<details><summary>Show solution</summary>

```js
function sum(a) {
  return function (b) {
    return a + b;
  };
}

const addFive = sum(5);
console.log(addFive(3)); // Salida: 8
```

</details>

---

### **Exercise 4: Modularization with `import` and `export`**

Create a module `math.js` that exports two functions (`add` and `subtract`). Then, import them and use them in another file.

<details><summary>Show solution</summary>

**math.js**

```js
export function add(a, b) {
  return a + b;
}

export function subtract(a, b) {
  return a - b;
}
```

**main.js**

```js
import { add, subtract } from "./math.js";

console.log(add(10, 5)); // Salida: 15
console.log(subtract(10, 5)); // Salida: 5
```

</details>

---

### **Exercise 5: Recursion**

Create a recursive function `factorial` that calculates the factorial of a number.

<details><summary>Show solution</summary>

```js
function factorial(n) {
  if (n === 0) return 1;
  return n * factorial(n - 1);
}

console.log(factorial(5)); // Salida: 120
```

</details>
