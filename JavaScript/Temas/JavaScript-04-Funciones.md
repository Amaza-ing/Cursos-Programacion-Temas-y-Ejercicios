# **Topic 4: Functions in JavaScript**

## **1. Introduction to functions**

Functions are reusable blocks of code designed to perform a specific task. They help us structure and modularize the code, improving readability and maintainability.

In JavaScript, functions are first-class citizens, meaning they can be assigned to variables, passed as arguments, and returned from other functions.

---

## **2. Function declaration**

Functions have to be declared, that is, you write what they do, somewhere in the code, but that doesn't mean they'll run straight away.
When you declare a function, you specify its name, the arguments it needs and the logic it will apply.

To run a function, you have to call it from another line of code, which should come after the function declaration.
When you call a function, you have to pass it the arguments it needs.

When you name a function, the name should be as explicit as possible and written in camelCase.

### **Example:**

```js
function sayHello() {
  console.log("Hello!");
}

sayHello(); // Respuesta en consola: Hello!
```

Functions can take no parameters, as in the previous example, or take one or more:

```js
function saySomething(str) {
  console.log(str);
}

saySomething("Qué tal?"); // Respuesta en consola: Qué tal?
```

Functions can apply their internal logic directly without returning anything, as in the previous example, or they can return a value using the reserved word `return`:

```js
function sum(num1, num2) {
  return num1 + num2;
}

let sumResult = sum(2, 8);
console.log(sumResult); // Respuesta en consola: 10
```

### **2.1. Function declarations**

Function declarations are defined using the `function` keyword.

### **Syntax:**

```js
function greet(name) {
  console.log(`¡Hola, ${name}!`); // Muestra un saludo por consola
}
```

Here the function is called `greet` and receives a `name` parameter.

### **Calling the function:**

```js
greet("Ana"); // Salida: ¡Hola, Ana!
```

When the `greet` function is called, the value `"Ana"` is passed as an argument, and that's the value the `name` parameter receives.

> **Note:** Function declarations are affected by "hoisting", that is, they can be invoked before they're declared in the code. That's because hoisting moves the function up to the first lines of the code before it's interpreted. It's usually not a good idea to take advantage of this behavior: you should declare functions before calling them.

---

### **2.2. Function expressions**

Function expressions are assigned to a variable. They aren't hoisted like function declarations.

This type of function is declared much like a variable, but it keeps the reserved word `function`.

### **Syntax:**

```js
const sum = function (a, b) {
  return a + b; // Retorna la suma de dos números
};
```

### **Example:**

```js
console.log(sum(3, 4)); // Salida: 7
```

---

[![Functions](https://img.youtube.com/vi/cRUhXVzwkEo/0.jpg)](https://www.youtube.com/watch?v=cRUhXVzwkEo&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

## **3. Arrow functions (`arrow functions`)**

Arrow functions offer a more concise syntax for writing functions.

### **Syntax:**

```js
const functionName = (parameters) => {
  // Código a ejecutar
};
```

### **Example**:

```js
const square = (num) => {
  return num * num;
};

console.log(square(5)); // Salida: 25
```

If the function has only one parameter, you can simplify it by removing the parentheses:

```js
const square = (num) => {
  return num * num;
};

console.log(square(5)); // Salida: 25
```

If the function has a single line of code, you can simplify it by removing the curly braces and the return:

```js
const square = (num) => num * num;

console.log(square(5)); // Salida: 25
```

### **Example:**

```js
const greet = (name) => console.log(`¡Hola, ${name}!`);

greet("Carlos"); // Salida: ¡Hola, Carlos!
```

> **Note:** Arrow functions **do not** have their own `this`, which affects their behavior in certain contexts. We'll see this later in the course.

---

[![Arrow Functions](https://img.youtube.com/vi/8WIQMu0l9XA/0.jpg)](https://www.youtube.com/watch?v=8WIQMu0l9XA&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

## **4. Parameters and arguments**

### **4.1. Default values**

You can assign default values to parameters:

```js
function greet(name = "Invitado") {
  console.log(`¡Hola, ${name}!`); // Saluda al usuario o a "Invitado"
}

greet(); // Salida: ¡Hola, Invitado!
```

---

### **4.2. Rest parameters (`...`)**

They let you pass an indefinite number of arguments to a function:

```js
function sumAll(...numbers) {
  let result = 0;

  for (number of numbers) {
    result += number;
  }
  return result;
}

console.log(sumAll(1, 2, 3, 4)); // Salida: 10
```

---

### **4.3. Spread operator (`...`)**

It's used to expand the elements of an array when calling a function:

```js
const numbers = [1, 2, 3];

function sum(a, b, c) {
  return a + b + c; // Suma tres números
}

console.log(sum(...numbers)); // Salida: 6
```

---

## **5. Callbacks & anonymous functions**

### **5.1. What is a callback?**

In JavaScript, a **callback** is a function that is passed as an argument to another function and is executed after that function has finished its task. Callbacks are a key tool in JavaScript for handling asynchrony, allowing code to keep running without blocking while it waits for a task to complete.

Callbacks are commonly used in asynchronous operations such as server requests, timers, or event handling.

---

### **5.2. Basic callback example**

Here is a simple example of how to use a callback in JavaScript:

```js
// Definimos una función que acepta un callback
function greetUser(name, callback) {
  console.log(`Hola, ${name}!`);
  callback(); // Ejecutamos el callback
}

// Definimos el callback
function sayGoodbye() {
  console.log("¡Adiós!");
}

// Llamamos a la función con el callback
greetUser("Ana", sayGoodbye);
```

**Output:**

```
Hola, Ana!
¡Adiós!
```

In this example, the `greetUser` function receives two arguments: a name and a callback function. After greeting the user, the `sayGoodbye` callback is executed.

---

### **5.3. Callbacks in asynchronous operations**

A practical case where callbacks come in handy is asynchronous operations like `setTimeout`:

```js
console.log("Inicio");

setTimeout(() => {
  console.log("Esto se muestra después de 2 segundos");
}, 2000);

console.log("Fin");
```

**Output:**

```
Inicio
Fin
Esto se muestra después de 2 segundos
```

Here, `setTimeout` accepts a callback that will run after 2 seconds. Meanwhile, the program keeps running and displays "Fin" before the delayed message.

---

### **5.4. Conclusion**

Callbacks are essential in JavaScript for controlling program flow, and you can use them to handle asynchronous tasks.

---

[![Callbacks](https://img.youtube.com/vi/xP8y4Zh5rIQ/0.jpg)](https://www.youtube.com/watch?v=xP8y4Zh5rIQ&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

### **5.5. What is an anonymous function?**

They're functions without a name, commonly used as callbacks:

```js
setTimeout(function () {
  console.log("Ejecutado tras 2 segundos"); // Mensaje tras retraso
}, 2000);
```

With an arrow function:

```js
setTimeout(() => {
  console.log("Ejecutado tras 2 segundos");
}, 2000);
```

---

[![Anonymous Functions](https://img.youtube.com/vi/0iQgTKfHO7w/0.jpg)](https://www.youtube.com/watch?v=0iQgTKfHO7w&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

## **6. Higher-order functions**

They're functions that receive other functions as arguments or return functions.

### **Example returning a function:**

```js
function multiplier(factor) {
  return function (number) {
    return number * factor; // Retorna el número multiplicado por el factor
  };
}

const double = multiplier(2);
console.log(double(5)); // Salida: 10
```

---

## **7. Self-invoking functions (IIFE)**

They run immediately after being declared.

```js
(function () {
  console.log("Función autoinvocada");
})();

// Con función flecha
(() => {
  console.log("IIFE con función flecha");
})();
```

---

## **8. Modularization with functions**

Using functions to break code into small pieces improves its maintainability.

### **Example:**

```js
function getFullName(firstName, lastName) {
  return `${firstName} ${lastName}`; // Retorna el nombre completo
}

function greetPerson(fullName) {
  console.log(`¡Hola, ${fullName}!`); // Saluda a la persona
}

const fullName = getFullName("Laura", "García");
greetPerson(fullName); // Salida: ¡Hola, Laura García!
```

---

## **9. Best practices**

1. Give your functions descriptive names in English.
2. Keep functions short and focused on a single task.
3. Avoid unwanted side effects.
4. Use pure functions whenever possible.
5. Prefer arrow functions for simple callbacks.

---

## **10. Conclusion**
Functions are essential in JavaScript for structuring and reusing code. Mastering the different types and techniques for making code modular will improve the efficiency and readability of your projects.

In the next topic, we'll explore **objects** and how they represent more complex data in JavaScript.
