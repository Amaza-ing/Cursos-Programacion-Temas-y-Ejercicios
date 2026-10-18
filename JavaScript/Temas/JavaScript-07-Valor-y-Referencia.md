# **Topic 7: Passing by Value and Passing by Reference in JavaScript**

## **1. Introduction**

When values are assigned to variables or passed as arguments to functions in JavaScript, they can be handled in two ways:

- **Step by Value** (Primitives)
- **Step by Reference** (Objects and Arrays)

Understanding this difference is key to avoiding unexpected effects on your code.

---

## **2. Step by Value**

**passing by value** occurs when a variable containing a primitive data type is assigned or passed:

- Numbers (`Number`)
- Chains (`String`)
- Booleans (`Boolean`)
- `null`, `undefined`
- `Symbol`
- `BigInt`

Each time a variable of primitive type is assigned to another variable, an **independent copy** of the original value is created.

### **Pass by Value Example**

```js
let a = 10;
let b = a; // Se copia el valor de 'a' en 'b'

b = 20; // Modificamos 'b', pero 'a' sigue siendo 10

console.log(a); // Salida: 10
console.log(b); // Salida: 20
```

> **Note:** The `b` variable gets a copy of the value of `a`, so modifying `b` does not affect `a`.

---

## **3. Step by Reference**

**Passing by reference** occurs when a variable containing a non-primitive data type is assigned or passed:

- Items (`Object`)
- Arrays (`Array`)
- Functions (`Function`)

In these cases, instead of copying the value, **the reference** is copied into memory. That is, both variables point to the same object.

### **Example of Pass by Reference**

```js
let person1 = { name: "Ana", age: 25 };
let person2 = person1; // Ambas variables apuntan al mismo objeto

person2.age = 30; // Modificamos 'person2', pero también afecta a 'person1'

console.log(person1.age); // Salida: 30
console.log(person2.age); // Salida: 30
```

> **Note:** Changes in `person2` affect `person1` because both variables refer to the same object in memory.

---

[![Step by Value vs Reference](https://img.youtube.com/vi/tPcA6iDA5yc/0.jpg)](https://www.youtube.com/watch?v=tPcA6iDA5yc&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

## **4. Copy Objects and Arrays without modifying the original**

To avoid unwanted modifications to objects and arrays, it is necessary to make **independent copies**.

### **4.1. Shallow Copy with `Object.assign()`**

```js
const original = { name: "Carlos", age: 40 };
const copy = Object.assign({}, original);

copy.age = 45;
console.log(original.age); // Salida: 40 (no se modifica)
```

### **4.2. Shallow copy with the Spread operator (`...`)**

```js
const copy2 = { ...original };
copy2.age = 50;
console.log(original.age); // Salida: 40
```

### **4.3. Deep Copy with `JSON.parse(JSON.stringify())`**

If the object is nested, `Object.assign()` and `spread` **do not** copy the internal objects.

```js
const nestedObject = {
  name: "Laura",
  details: {
    age: 30,
  },
};
const deepCopy = JSON.parse(JSON.stringify(nestedObject));

deepCopy.details.age = 35;
console.log(nestedObject.details.age); // Salida: 30 (no se modifica)
```

> **Note:** `JSON.stringify()` does not work well with `undefined` functions or values.

### **4.4. Deep copy with `structuredClone()` (ES2021)**

```js
const deepClone = structuredClone(nestedObject);
deepClone.details.age = 40;
console.log(nestedObject.details.age); // Salida: 30
```

---

[![Copy of Objects](https://img.youtube.com/vi/nxcXzZzdXKU/0.jpg)](https://www.youtube.com/watch?v=nxcXzZzdXKU&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

## **5. Copying Arrays**

### **5.1. Shallow copy with `slice()`**

```js
const numbers = [1, 2, 3, 4];
const numbersCopy = numbers.slice();
numbersCopy.push(5);

console.log(numbers); // [1, 2, 3, 4]
console.log(numbersCopy); // [1, 2, 3, 4, 5]
```

### **5.2. Shallow copy with the Spread operator (`...`)**

```js
const newNumbers = [...numbers];
```

### **5.3. Shallow copy with `map()`**

```js
const newNumbers = numbers.map((number) => number);
```

### **5.4. Deep copy with `JSON.parse(JSON.stringify())`**

```js
const nestedArray = [
  [1, 2],
  [3, 4],
];
const deepArrayCopy = JSON.parse(JSON.stringify(nestedArray));
deepArrayCopy[0][0] = 99;

console.log(nestedArray[0][0]); // Salida: 1 (no se modifica)
```

### **5.5. Deep copy with `structuredClone()` (ES2021)**

```js
const originalArray = [
  [1, 2],
  [3, 4],
];

const deepCopyArray = structuredClone(originalArray);
deepCopyArray[0][0] = 99;

console.log(originalArray[0][0]); // 1 (no se modifica)
console.log(deepCopyArray[0][0]); // 99 (copia independiente)
```

---

[![Copy of Arrays](https://img.youtube.com/vi/V727GTGDvv0/0.jpg)](https://www.youtube.com/watch?v=V727GTGDvv0&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

## **6. Good Practices**

- **Use passing by value** for primitive types when reference sharing is not needed.
- **Avoid modifying shared objects** when using pass by reference.
- **Make independent copies** with `Object.assign()`, `spread (...)`, `JSON.parse(JSON.stringify())` or `structuredClone()`.
- **Be careful with superficial copies**: They do not copy nested objects.

---
## **7. Conclusion**

Understanding the difference between **passing by value** and **passing by reference** helps you write more predictable code and avoid unexpected errors when modifying objects and arrays in JavaScript.

In the next topic we will see some less known operators, such as spread operator, optional chaining and others.
