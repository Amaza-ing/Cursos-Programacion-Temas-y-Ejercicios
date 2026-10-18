# **Exercises - Topic 4: Functions in JavaScript**

Below you will find 6 practical exercises on using functions in JavaScript.

Try to solve them before consulting the solution.

---

### **Exercise 1: Create a simple function**

Create a function called `showMsg` that receives an `msg` parameter and displays the message "Message: [msg]!" in the console.

<details><summary>Show solution</summary>

```js
function showMsg(msg) {
  console.log(`Mensaje: ${msg}!`);
}

showMsg("Hola a todos"); // Salida: Mensaje: Hola a todos!
```

</details>

---

### **Exercise 2: Function that returns a value**

Create a function called `sum` that takes two numbers as parameters and returns their sum.

<details><summary>Show solution</summary>

```js
function sum(a, b) {
  return a + b;
}

const result = sum(5, 7);
console.log(result); // Salida: 12
```

</details>

---

### **Exercise 3: Function with default values**

Create a function called `greetUser` that receives an `name` parameter and has a default value of "Guest" if no name is provided.

<details><summary>Show solution</summary>

```js
function greetUser(name = "Invitado") {
  console.log(`¡Hola, ${name}!`);
}

greetUser(); // Salida: ¡Hola, Invitado!
greetUser("Carlos"); // Salida: ¡Hola, Carlos!
```

</details>

---

### **Exercise 4: Arrow function**

Convert the following function to an arrow function:

```js
function multiply(a, b) {
  return a * b;
}
```

<details><summary>Show solution</summary>

```js
const multiply = (a, b) => {
  return a * b;
};

// O en su versión reducida:

const multiply = (a, b) => a * b;

console.log(multiply(3, 4)); // Salida: 12
```

</details>

---

### **Exercise 5: Function that uses rest parameters**

Create a function called `multiplyAll` that accepts an indefinite number of arguments and returns their multiplication.

<details><summary>Show solution</summary>

```js
function multiplyAll(...numbers) {
  let result = 1;

  for (number of numbers) {
    result *= number;
  }
  return result;
}

console.log(multiplyAll(1, 2, 3, 4)); // Salida: 24
```

</details>

---

### **Exercise 6: Higher order function**

Create a function called `applyOperation` that receives two numbers and a callback function. The function must apply the callback to both numbers.

**Example:**

```js
function add(a, b) {
  return a + b;
}

function subtract(a, b) {
  return a - b;
}

applyOperation(5, 3, add); // Salida: 8
applyOperation(5, 3, subtract); // Salida: 2
```

<details><summary>Show solution</summary>

```js
function applyOperation(a, b, operation) {
  console.log(operation(a, b));
}

function add(a, b) {
  return a + b;
}

function subtract(a, b) {
  return a - b;
}

applyOperation(5, 3, add); // Salida: 8
applyOperation(5, 3, subtract); // Salida: 2
```

</details>
