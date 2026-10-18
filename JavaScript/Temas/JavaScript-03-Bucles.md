# **Topic 3: Loops in JavaScript**

## **1. Introduction to loops**

Loops allow a block of code to be executed repeatedly as long as a specific condition is met. In JavaScript, there are several types of loops that allow us to iterate over data and execute repetitive tasks.

---

## **2. `for`** loop

The `for` loop is one of the most used when we know the exact number of iterations.

### **Syntax:**

```js
for (inicialización; condición; incremento) {
  // Código a ejecutar en cada iteración
}
```

### **Example:**

```js
for (let i = 0; i < 5; i++) {
  console.log(`Iteración número ${i}`);
}
```

**Output:**

```
Iteración número 0
Iteración número 1
Iteración número 2
Iteración número 3
Iteración número 4
```

---

[![Loop for](https://img.youtube.com/vi/MvneErXddY4/0.jpg)](https://www.youtube.com/watch?v=MvneErXddY4&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

## **3. `while`** loop

The `while` loop executes the code block as long as the condition is true.

### **Syntax:**

```js
while (condición) {
  // Código a ejecutar
}
```

### **Example:**

```js
let count = 0;

while (count < 3) {
  console.log(`Contador: ${count}`);
  count++;
}
```

**Output:**

```
Contador: 0
Contador: 1
Contador: 2
```

> **Caution:** Make sure the condition becomes false at some point to avoid infinite loops.

---

## **4. `do...while`** loop

The `do...while` loop executes the code block at least once before checking the condition.

### **Syntax:**

```js
do {
  // Código a ejecutar
} while (condición);
```

### **Example:**

```js
let i = 0;

do {
  console.log(`Número: ${i}`);
  i++;
} while (i < 3);
```

**Output:**

```
Número: 0
Número: 1
Número: 2
```

> **Note:** `do...while` will always execute the code block at least once.

---

[![While & do while](https://img.youtube.com/vi/3LZHs0xtJEY/0.jpg) loops](https://www.youtube.com/watch?v=3LZHs0xtJEY&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

## **5. `for...of`** loop

The `for...of` loop is used to iterate over elements of iterable structures such as arrays, strings or sets.

### **Syntax:**

```js
for (const elemento of iterable) {
  // Código a ejecutar
}
```

### **Example with an array:**

```js
const fruits = ["manzana", "banana", "cereza"];

for (const fruit of fruits) {
  console.log(fruit);
}
```

**Output:**

```
manzana
banana
cereza
```

### **Example with a string:**

```js
const word = "Hola";

for (const letter of word) {
  console.log(letter);
}
```

**Output:**

```
H
o
l
a
```

---

## **6. `for...in`** loop

The `for...in` loop is used to iterate over the enumerable properties of an object.

### **Syntax:**

```js
for (const clave in objeto) {
  // Código a ejecutar
}
```

### **Example:**

```js
const person = {
  nombre: "Ana",
  edad: 25,
  ciudad: "Madrid",
};

for (const key in person) {
  console.log(`${key}: ${person[key]}`);
}
```

**Output:**

```
nombre: Ana
edad: 25
ciudad: Madrid
```

> **Note:** `for...in` is best used with objects and not arrays.

---

[![Loops for of & for in](https://img.youtube.com/vi/kB2vGOxs024/0.jpg)](https://www.youtube.com/watch?v=kB2vGOxs024&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

## **7. Controlling loops: `break` and `continue`**

- **`break`**: Completely ends the loop.
- **`continue`**: Skip the current iteration and move to the next one.

### **Example with `break`:**

```js
for (let i = 0; i < 10; i++) {
  if (i === 5) {
    break;
  }
  console.log(i);
}
```

**Output:**

```
0
1
2
3
4
```

### **Example with `continue`:**

```js
for (let i = 0; i < 5; i++) {
  if (i === 2) {
    continue;
  }
  console.log(i);
}
```

**Output:**

```
0
1
3
4
```

---

[![Break & Continue](https://img.youtube.com/vi/x4AXCSeVn-o/0.jpg)](https://www.youtube.com/watch?v=x4AXCSeVn-o&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

## **8. Array methods to iterate**

JavaScript also offers functional methods for iterating over arrays. We will delve into this topic later.

### **`forEach()`**

Execute a function for each element of the array.

```js
const numbers = [1, 2, 3];

numbers.forEach((num) => console.log(num));
```

**Output:**

```
1
2
3
```

There are other array methods such as `map` or `filter` that will be explained in the next lessons.

---

## **9. Good practices**

- Choose the appropriate loop based on the data structure.
- Avoid infinite loops by verifying the conditions well.
- Use functional methods (`forEach`) for cleaner code.
- Avoid using `for...in` in arrays, as it may include inherited properties.

---

## **10. Conclusion**
Loops are essential for handling data and automating repetitive tasks in JavaScript. Understanding the differences between different types of loops will allow you to write more efficient and cleaner code.

In the next topic, we'll explore **functions** and how to modularize your code in JavaScript.
