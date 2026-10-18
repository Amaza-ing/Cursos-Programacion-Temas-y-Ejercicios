# **Topic 6: Arrays in JavaScript**

## **1. Introduction to arrays**

In JavaScript, an **array** is a data structure used to store multiple values in a single variable. Arrays let you work with collections of data efficiently and flexibly.

An array can contain any type of data: numbers, strings, booleans, objects and even other arrays.

```js
const fruits = ["manzana", "banana", "cereza"];
console.log(fruits); // Salida: ["manzana", "banana", "cereza"]
```

---

## **2. Creating arrays**

### **2.1. Using square brackets `[]`**

The most common and simplest way to create an array.

```js
const numbers = [1, 2, 3, 4, 5];
```

### **2.2. Using the `Array` constructor**

```js
const colors = new Array("rojo", "verde", "azul");
```

> **Note:** It's recommended to use the square bracket notation `[]`, as it's more readable and less error-prone.

### **2.3. Empty arrays**

```js
const emptyArray = [];
const anotherEmptyArray = new Array();
```

---

## **3. Accessing the elements of an array**

You access the elements of an array through their index, starting from 0.

```js
const animals = ["perro", "gato", "pájaro"];
console.log(animals[0]); // Salida: perro
console.log(animals[2]); // Salida: pájaro
```

If you access an index that doesn't exist, you'll get `undefined`.

```js
console.log(animals[5]); // Salida: undefined
```

---

[![Arrays](https://img.youtube.com/vi/Y3QAWQ93f2s/0.jpg)](https://www.youtube.com/watch?v=Y3QAWQ93f2s&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

## **4. Basic array methods**

### **4.1. `push()` and `pop()`**

- `push()` adds an element to the end of the array.
- `pop()` removes the last element of the array.

```js
const fruits = ["manzana", "banana"];
fruits.push("naranja");
console.log(fruits); // ["manzana", "banana", "naranja"]

fruits.pop();
console.log(fruits); // ["manzana", "banana"]
```

### **4.2. `unshift()` and `shift()`**

- `unshift()` adds an element to the beginning of the array.
- `shift()` removes the first element of the array.

```js
fruits.unshift("fresa");
console.log(fruits); // ["fresa", "manzana", "banana"]

fruits.shift();
console.log(fruits); // ["manzana", "banana"]
```

### **4.3. `indexOf()` and `includes()`**

- `indexOf()` returns the index of the first matching element, or -1 if it doesn't exist.
- `includes()` checks whether an element is present in the array.

```js
console.log(fruits.indexOf("banana")); // Salida: 1
console.log(fruits.includes("manzana")); // Salida: true
```

### **4.4. `slice()` and `splice()`**

- `slice()` returns a shallow copy of a portion of the array. The two arguments it receives are the indexes of the array that delimit the new array: the first one included and the second one excluded.
- `splice()` changes the contents of the array by removing or replacing elements. It takes three or more arguments: (index to start at, number of elements to remove, new values to insert at that position).

```js
const numbers = [1, 2, 3, 4, 5];

const sliced = numbers.slice(1, 4);
console.log(sliced); // [2, 3, 4]

numbers.splice(2, 1, 99);
console.log(numbers); // [1, 2, 99, 4, 5]
```

### **4.5. `join()` and `toString()`**

- `join()` joins all the elements of the array into a string. The argument indicates the string that will go between each pair of elements.
- `toString()` converts the array to a comma-separated string.

```js
const words = ["Hola", "mundo"];
console.log(words.join(" ")); // Salida: Hola mundo
console.log(words.toString()); // Salida: Hola,mundo
```

---

[![Basic array methods](https://img.youtube.com/vi/FEMeEuBJmsM/0.jpg)](https://www.youtube.com/watch?v=FEMeEuBJmsM&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

## **5. Iteration methods**

### **5.1. `forEach()`**

Runs a function for each element of the array.

```js
const numbers = [1, 2, 3];
numbers.forEach((num) => console.log(num));
```

---

[![Arrays: forEach](https://img.youtube.com/vi/Xmt7FTN4u5Y/0.jpg)](https://www.youtube.com/watch?v=Xmt7FTN4u5Y&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

### **5.2. `map()`**

Creates a new array with the results of applying the function to each element.

```js
const doubled = numbers.map((num) => num * 2);
console.log(doubled); // [2, 4, 6]
```

---

[![Arrays: map](https://img.youtube.com/vi/Z8UYbJ_e_Do/0.jpg)](https://www.youtube.com/watch?v=Z8UYbJ_e_Do&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

### **5.3. `filter()`**

Creates a new array with the elements that meet a condition.

```js
const even = numbers.filter((num) => num % 2 === 0);
console.log(even); // [2]
```

---

[![Arrays: filter](https://img.youtube.com/vi/FDPcPjHL6W4/0.jpg)](https://www.youtube.com/watch?v=FDPcPjHL6W4&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

### **5.4. `reduce()`**

Reduces the array to a single value.

```js
const sum = numbers.reduce((acc, num) => acc + num, 0);
console.log(sum); // 6
```

---
[![Arrays: reduce](https://img.youtube.com/vi/U5kIj9P-IhU/0.jpg)](https://www.youtube.com/watch?v=U5kIj9P-IhU&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

### **5.5. `find()` and `findIndex()`**

- `find()` returns the first element that meets a condition. If no element meets the condition, it returns `undefined`.
- `findIndex()` returns the index of the first element that meets a condition.

```js
const found = numbers.find((num) => num > 2);
console.log(found); // 3

const foundIndex = numbers.findIndex((num) => num > 2);
console.log(foundIndex); // 2
```

---

[![Arrays: find & findIndex](https://img.youtube.com/vi/JE56a775rrs/0.jpg)](https://www.youtube.com/watch?v=JE56a775rrs&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

## **6. Advanced operations with arrays**

### **6.1. Concatenating arrays**

```js
const array1 = [1, 2];
const array2 = [3, 4];
const combined = array1.concat(array2);
console.log(combined); // [1, 2, 3, 4]
```

### **6.2. Spread operator (`...`)**

It lets you expand the elements of an array. You can use it to copy an array or to create a new one from several arrays.

```js
const newArray = [...array1, ...array2];
console.log(newArray); // [1, 2, 3, 4]
```

### **6.3. Array destructuring**

```js
const [first, second] = numbers;
console.log(first); // 1
console.log(second); // 2
```

### **6.4. Multidimensional arrays**

You can have arrays of any type of data, including other arrays. If we have an array of arrays of the same size (number of elements), we get a matrix.

```js
const matrix = [
  [1, 2, 3],
  [4, 5, 6],
  [7, 8, 9],
];

console.log(matrix[1][2]); // Salida: 6
```

---

## **7. Conclusion**

Arrays are a fundamental tool in JavaScript for managing collections of data. With the wide range of methods and operations available, you can perform complex tasks efficiently and easily.

In the next topic, we'll see the difference between pass by value and pass by reference, and how it affects things like copying and working with arrays and objects.
