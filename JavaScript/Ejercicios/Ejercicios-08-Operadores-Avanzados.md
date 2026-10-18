# **Exercises - Topic 8: Advanced Operators in JavaScript**

Below you will find 5 practical exercises on advanced operators in JavaScript.

Try to solve them before consulting the solution.

---

### **Exercise 1: Using the Spread Operator (`...`) with Arrays**

Create an `numbers` array with the `[5, 10, 15]` values and another `moreNumbers` array containing the `numbers` values plus `20` and `25`. Show the result in the console.

<details><summary>Show solution</summary>

```js
const numbers = [5, 10, 15];
const moreNumbers = [...numbers, 20, 25];
console.log(moreNumbers); // Salida: [5, 10, 15, 20, 25]
```

</details>

---

### **Exercise 2: Using the Rest Operator (`...`) in Functions**

Create a function `multiplyAll` that accepts an `factor` number and a variable number of arguments. The function should return an array with each number multiplied by `factor`.

<details><summary>Show solution</summary>

```js
function multiplyAll(factor, ...numbers) {
  return numbers.map((num) => num * factor);
}

console.log(multiplyAll(2, 3, 4, 5)); // Salida: [6, 8, 10]
```

</details>

---

### **Exercise 3: Using Optional Chaining (`?.`)**

Given the following `person` object, access the `address.city` property safely using `?.`. If it does not exist, it shows "City not available".

```js
const person = {
  name: "Elena",
  address: null,
};
```

<details><summary>Show solution</summary>

```js
console.log(person.address?.city ?? "Ciudad no disponible"); // Salida: "Ciudad no disponible"
```

</details>

---

### **Exercise 4: Using Nullish Coalescing (`??`)**

Declare an `discount` variable that can be `null` or `0`. Use `??` to assign a default value of `10` only if it is `null` or `undefined`, but keeping `0` if it is its value.

<details><summary>Show solution</summary>

```js
let discount = 0;
const finalDiscount = discount ?? 10;
console.log(finalDiscount); // Salida: 0
```

</details>

---

### **Exercise 5: Using the Ternary Operator (`? :`)**

Create a variable `temperature` and use a ternary operator to assign "Hot" if greater than 30, "Cold" if less than 15, and "Warm" otherwise.

<details><summary>Show solution</summary>

```js
const temperature = 22;
const weather =
  temperature > 30 ? "Calor" : temperature < 15 ? "Frío" : "Templado";
console.log(weather); // Salida: "Templado"
```

</details>
