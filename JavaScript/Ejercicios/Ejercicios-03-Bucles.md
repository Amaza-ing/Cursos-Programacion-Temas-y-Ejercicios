# **Exercises - Topic 3: Loops in JavaScript**

Below you'll find 6 practical exercises on using loops in JavaScript.

Try to solve them before looking at the solution.

---

### **Exercise 1: Count from 1 to 10**

Create a program that prints the numbers from 1 to 10 using a `for` loop.

<details><summary>Show solution</summary>

```js
for (let i = 1; i <= 10; i++) {
  console.log(i);
}
```

</details>

---

### **Exercise 2: Sum of even numbers**

Using a `while` loop, add up all the even numbers between 1 and 20 and print the result.

<details><summary>Show solution</summary>

```js
let i = 1;
let sum = 0;

while (i <= 20) {
  if (i % 2 === 0) {
    sum += i;
  }
  i++;
}

console.log(`La suma de los números pares entre 1 y 20 es: ${sum}`);
```

</details>

---

### **Exercise 3: Word backwards**

Use a `for` loop to print a word backwards.

**Example:** If the word is "JavaScript", the result should be "tpircSavaJ".

<details><summary>Show solution</summary>

```js
const word = "JavaScript";
let reversedWord = "";

for (let i = word.length - 1; i >= 0; i--) {
  reversedWord += word[i];
}

console.log(reversedWord);
```

</details>

---

### **Exercise 4: Print the properties of an object**

Use a `for...in` loop to print the keys and values of an object.

**Example:**

```js
const person = {
  nombre: "Ana",
  edad: 30,
  ciudad: "Madrid",
};
```

**Expected output:**

```
nombre: Ana
edad: 30
ciudad: Madrid
```

<details><summary>Show solution</summary>

```js
const person = {
  nombre: "Ana",
  edad: 30,
  ciudad: "Madrid",
};

for (const key in person) {
  console.log(`${key}: ${person[key]}`);
}
```

</details>

---

### **Exercise 5: Iterate over an array with `for...of`**

Create a program that iterates over the following array using `for...of` and displays each element.

```js
const fruits = ["manzana", "banana", "cereza", "mango"];
```

**Expected output:**

```
manzana
banana
cereza
mango
```

<details><summary>Show solution</summary>

```js
const fruits = ["manzana", "banana", "cereza", "mango"];

for (const fruit of fruits) {
  console.log(fruit);
}
```

</details>

---

### **Exercise 6: Multiplication table**

Ask the user for a number and display its multiplication table from 1 to 10 using a `for` loop.

**Example:** If the user enters `5`, the output will be:

```
5 x 1 = 5
5 x 2 = 10
...
5 x 10 = 50
```

<details><summary>Show solution</summary>

```js
const number = parseInt(
  prompt("Introduce un número para ver su tabla de multiplicar:"),
);

for (let i = 1; i <= 10; i++) {
  console.log(`${number} x ${i} = ${number * i}`);
}
```

</details>

---
