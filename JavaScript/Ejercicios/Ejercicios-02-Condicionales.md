# **Exercises - Topic 2: Conditionals in JavaScript**

Below you'll find 5 practical exercises on using conditionals in JavaScript.

Try to solve them before looking at the solution.

---

### **Exercise 1: Check whether a number is positive or negative**

Create a program that asks the user for a number using `prompt` and displays in the console whether it's positive, negative or zero.

<details><summary>Show solution</summary>

```js
const number = parseFloat(prompt("Introduce un número:"));

if (number > 0) {
  console.log("El número es positivo.");
} else if (number < 0) {
  console.log("El número es negativo.");
} else {
  console.log("El número es cero.");
}
```

</details>

---

### **Exercise 2: Age classification**

Ask the user for their age and display a message indicating their age group:

- Under 13: "Child"
- Between 13 and 19: "Teenager"
- Between 20 and 64: "Adult"
- 65 or over: "Senior"

<details><summary>Show solution</summary>

```js
const age = parseInt(prompt("Introduce tu edad:"));

if (age < 13) {
  console.log("Niño/a");
} else if (age >= 13 && age <= 19) {
  console.log("Adolescente");
} else if (age >= 20 && age <= 64) {
  console.log("Adulto/a");
} else {
  console.log("Adulto/a mayor");
}
```

</details>

---

### **Exercise 3: Simple calculator with `switch`**

Create a program that asks for two numbers and a math operation (`+`, `-`, `*`, `/`) and displays the result using `switch`.

<details><summary>Show solution</summary>

```js
const num1 = parseFloat(prompt("Introduce el primer número:"));
const num2 = parseFloat(prompt("Introduce el segundo número:"));
const operation = prompt("Introduce la operación (+, -, *, /):");

let result;

switch (operation) {
  case "+":
    result = num1 + num2;
    break;
  case "-":
    result = num1 - num2;
    break;
  case "*":
    result = num1 * num2;
    break;
  case "/":
    result = num2 !== 0 ? num1 / num2 : "Error: división por cero";
    break;
  default:
    result = "Operación no válida";
}

console.log(`Resultado: ${result}`);
```

</details>

---

### **Exercise 4: Check for a leap year**

Create a program that asks for a year and determines whether it's a leap year.

**Rules for a leap year:**

- It's divisible by 4.
- It isn't divisible by 100, unless it's also divisible by 400.

<details><summary>Show solution</summary>

```js
const year = parseInt(prompt("Introduce un año:"));

if ((year % 4 === 0 && year % 100 !== 0) || year % 400 === 0) {
  console.log(`${year} es un año bisiesto.`);
} else {
  console.log(`${year} no es un año bisiesto.`);
}
```

</details>

---

### **Exercise 5: Using the ternary operator**

Using the ternary operator, ask the user for their age and display "You're an adult" if they're 18 or older, and "You're a minor" otherwise.

<details><summary>Show solution</summary>

```js
const age = parseInt(prompt("Introduce tu edad:"));

const message = age >= 18 ? "Eres mayor de edad" : "Eres menor de edad";
console.log(message);
```

</details>
