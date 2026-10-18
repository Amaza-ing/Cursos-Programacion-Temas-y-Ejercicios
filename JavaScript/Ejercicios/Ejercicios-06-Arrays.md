# **Exercises - Topic 6: Arrays in JavaScript**

Below you will find 5 practical exercises on using arrays in JavaScript.

Try to solve them before consulting the solution.

---

### **Exercise 1: Access elements of an array**

Create an array called `colors` with the following values: `"rojo"`, `"verde"`, `"azul"`. Then, it shows the second element of the array in the console.

<details><summary>Show solution</summary>

```js
const colors = ["rojo", "verde", "azul"];
console.log(colors[1]); // Salida: verde
```

</details>

---

### **Exercise 2: Add and delete elements**

Create an array called `fruits` with the values `"manzana"` and `"banana"`. Then:

- Add `"naranja"` to the end of the array.
- Delete the first element of the array.
- Shows the updated array in the console.

<details><summary>Show solution</summary>

```js
const fruits = ["manzana", "banana"];
fruits.push("naranja");
fruits.shift();
console.log(fruits); // Salida: ["banana", "naranja"]
```

</details>

---

### **Exercise 3: Loop through an array with `forEach`**

Create an array called `numbers` with the values `[1, 2, 3, 4, 5]`. Then, use `forEach` to print each number multiplied by 2.

<details><summary>Show solution</summary>

```js
const numbers = [1, 2, 3, 4, 5];
numbers.forEach((num) => console.log(num * 2));
```

</details>

---

### **Exercise 4: Filter elements of an array**

Create an array called `ages` with the values `[12, 25, 18, 30, 16]`. Then, use `filter` to create a new array with only values ​​greater than or equal to 18 and display it in the console.

<details><summary>Show solution</summary>

```js
const ages = [12, 25, 18, 30, 16];
const adults = ages.filter((age) => age >= 18);
console.log(adults); // Salida: [25, 18, 30]
```

</details>

---

### **Exercise 5: Create a new array with `map`**

Create an array called `prices` with the `[10, 20, 30]` values. Then, use `map` to create a new array with the prices increased by 10% and display it in the console.

<details><summary>Show solution</summary>

```js
const prices = [10, 20, 30];
const updatedPrices = prices.map((price) => price * 1.1);
console.log(updatedPrices); // Salida: [11, 22, 33]
```

</details>
