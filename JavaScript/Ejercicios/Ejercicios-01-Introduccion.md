# **Exercises - Topic 1: Introduction to JavaScript**

Below you will find 4 practical exercises on the fundamentals of JavaScript.

Try to solve them before consulting the solution.

---

### **Exercise 1: Hello World**

Create a program that displays the message "Hello, world!" on the console.

<details><summary>Show solution</summary>

```js
console.log("¡Hola, mundo!");
```

</details>

---

### **Exercise 2: Declaration of Variables**

Declare two variables named `firstName` and `lastName`, give them your first and last names, and display the message "Hello, [firstName] [lastName]!" on the console.

<details><summary>Show solution</summary>

```js
const firstName = "Sara";
const lastName = "Martín";

console.log("Hola " + firstName + lastName");
```

</details>

---

### **Exercise 3: Conditionals**

Create a program that verifies if a person is of legal age. Asks the user for their age (use `prompt`) and displays a message indicating whether they are older or younger.

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

### **Exercise 4: For Loop**

Display the numbers 1 to 10 on the console using an `for` loop.

<details><summary>Show solution</summary>

```js
for (let i = 1; i <= 10; i++) {
  console.log(i);
}
```

</details>
