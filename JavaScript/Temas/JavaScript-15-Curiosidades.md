# **Topic 15: Curiosities and Strange Behaviors in JavaScript**

## **1. Introduction**

JavaScript is a flexible and dynamic language, but this flexibility sometimes generates unexpected or curious behavior. In this topic we will explore some of the quirks and how to handle them correctly.

---

## **2. Strange Comparisons**

JavaScript performs implicit type conversions when comparing values, which can produce unexpected results.

### **2.1. Comparisons with `==` and `===`**

```js
console.log(0 == "0"); // true (conversión implícita)
console.log(0 === "0"); // false (comparación estricta)
```

### **2.2. `null` and `undefined` in Comparisons**

```js
console.log(null == undefined); // true (se consideran equivalentes)
console.log(null === undefined); // false (son tipos distintos)
```

### **23. Is `NaN` the same as `NaN`?**

```js
console.log(NaN === NaN); // false (NaN nunca es igual a sí mismo)
console.log(Number.isNaN(NaN)); // true (forma correcta de verificar NaN)
```

---

## **3. Strange Array Behavior**

### **3.1. Arrays with Empty Spaces**

```js
const arr = [1, , 3];
console.log(arr.length); // 3 (pero el segundo elemento es `empty`)
console.log(arr[1]); // undefined
```

### **3.2. Add Arrays with `+`**

```js
console.log([1, 2, 3] + [4, 5, 6]); // "1,2,34,5,6" (se convierten en strings y se concatenan)
```

---

## **4. Implicit Type Conversion**

JavaScript tries to automatically convert types in certain operations.

### **4.1. Adding numbers with strings**

```js
console.log(5 + "5"); // "55" (número convertido a string)
console.log("5" - 2); // 3 (string convertido a número)
```

### **4.2. `true` and `false` as numbers**

```js
console.log(true + true); // 2 (true se convierte en 1)
console.log(false + 1); // 1 (false se convierte en 0)
```

---

## **5. Objects and Arrays in Comparisons**

### **5.1. Objects Compared to Themselves**

```js
const obj = {};
console.log(obj === obj); // true (misma referencia en memoria)
console.log({} === {}); // false (diferentes referencias en memoria)
```

### **5.2. `typeof` of Arrays and `null`**

```js
console.log(typeof []); // "object" (aunque es un array)
console.log(typeof null); // "object" (error histórico de JavaScript)
```

---

## **6. `null` and `undefined` in Mathematical Operations**

### **6.1. Sum with `null`**

```js
console.log(null + 1); // 1 (null se convierte en 0)
```

### **6.2. Multiplication with `undefined`**

```js
console.log(undefined * 5); // NaN (undefined no puede convertirse a un número)
```

---

## **7. Strange behaviors with `typeof`**

### **7.1. `typeof` in unexpected values**

```js
console.log(typeof NaN); // "number" (aunque no representa un número real)
console.log(typeof null); // "object" (error histórico de JavaScript)
console.log(typeof []); // "object" (un array es técnicamente un objeto)
console.log(typeof function () {}); // "function" (pero sigue siendo un objeto)
```

### **7.2. Is it an infinite number?**

```js
console.log(typeof Infinity); // "number"
console.log(isFinite(Infinity)); // false
console.log(isFinite(1000)); // true
```

---

## **8. Curious String Behavior**

### **8.1. `String` converted to number automatically**

```js
console.log("10" * 2); // 20 (convierte el string en número implícitamente)
console.log("10" - 1); // 9 (también convierte el string a número)
console.log("10" + 1); // "101" (pero aquí lo trata como una concatenación de string)
```

### **8.2. Comparison with `>` and `<` in strings**

```js
console.log("2" > "12"); // true (comparación lexicográfica, "2" es mayor que "1")
```

---

## **9. `falsy` and `truthy` Strange Values**

### **9.1. Unexpected `falsy` values**

```js
console.log(Boolean(0)); // false
console.log(Boolean("")); // false
console.log(Boolean(NaN)); // false
console.log(Boolean([])); // true (un array vacío es truthy)
console.log(Boolean({})); // true (un objeto vacío es truthy)
```

### **9.2. How to convert any value to `true` or `false`?**

```js
console.log(!!"texto"); // true
console.log(!!0); // false
console.log(!!null); // false
```

---

## **10. Oddities with Arrays and Objects**

### **10.1. Array Comparison**

```js
console.log([] == []); // false (son referencias distintas en memoria)
console.log([] == ![]); // true (![] se convierte en false que se convierte en 0 implícitamente y [] es también convertido a 0 a efectos de esta comparación)
```

### **10.2. Access non-existent indexes in an array**

```js
const arr = [1, 2, 3];
console.log(arr[10]); // undefined (pero no error)
```

---

## **11. Functions and their Unusual Behavior**

### **11.1. Functions with duplicate parameters**

```js
function weird(a, a, a) {
  console.log(a);
}
weird(1, 2, 3); // Salida: 3 (el último valor sobrescribe los anteriores)
```

---

[![How to create a Watch](https://img.youtube.com/vi/7cQ81kmMIpE/0.jpg)](https://www.youtube.com/watch?v=7cQ81kmMIpE&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

## **12. Conclusion**

JavaScript is a powerful language, but some of its features can lead to unexpected results. Understanding these quirks helps you write more robust code and avoid hard-to-detect bugs.

---

[![End of Course](https://img.youtube.com/vi/pP-bbDGJZZE/0.jpg)](https://www.youtube.com/watch?v=pP-bbDGJZZE&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---
