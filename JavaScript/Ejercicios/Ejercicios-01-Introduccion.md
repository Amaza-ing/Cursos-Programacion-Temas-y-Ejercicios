# **Exercises - Topic 1: Introduction to JavaScript**

Below you'll find 4 practical exercises on the fundamentals of JavaScript.

Try to solve them before looking at the solution.

---

### **Exercise 1: Hello World**

Create a program that displays the message "Hello, world!" in the console.

<details><summary>Show solution</summary>

```js
console.log("¡Hola, mundo!");
```

</details>

---

### **Exercise 2: Declaring variables**

Declare two variables named `firstName` and `lastName`, assign them your first name and last name, and display the message "Hello, [firstName] [lastName]!" in the console.

<details><summary>Show solution</summary>

```js
const firstName = "Sara";
const lastName = "Martín";

console.log("Hola, " + firstName + " " + lastName + "!");
```

</details>

---

### **Exercise 3: Conditionals**

Create a program that checks whether a person is an adult. Ask the user for their age (use `prompt`) and display a message saying whether they're an adult or a minor.

<details><summary>Show solution</summary>

```js
const age = prompt("Introduce tu edad:");

if (age >= 18) {
  console.log("Eres mayor de edad.");
} else {
  console.log("Eres menor de edad.");
}
```

</details>

---

### **Exercise 4: For loop**

Display the numbers from 1 to 10 in the console using a `for` loop.

<details><summary>Show solution</summary>

```js
for (let i = 1; i <= 10; i++) {
  console.log(i);
}
```

</details>
