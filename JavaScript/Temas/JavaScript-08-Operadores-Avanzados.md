# **Topic 8: Advanced Operators in JavaScript**

## **1. Introduction**

JavaScript includes a number of lesser-known but very useful operators for writing cleaner, more efficient code. In this topic, we'll explore some of the most important ones:

- Spread Operator (`...`)
- Rest Operator (`...`)
- Optional Chaining (`?.`)
- Nullish Coalescing (`??`)
- Ternary Operator (`? :`)

---

## **2. Spread Operator (`...`)**

The **spread operator** lets you expand the elements of an iterable (arrays, objects, strings) in places where individual values are expected.

### **Example with arrays**

```js
const numbers = [1, 2, 3];
const newNumbers = [...numbers, 4, 5];
console.log(newNumbers); // Salida: [1, 2, 3, 4, 5]
```

### **Example with objects**

```js
const user = { name: "Ana", age: 25 };
const newUser = { ...user, city: "Madrid" };
console.log(newUser); // Salida: { name: "Ana", age: 25, city: "Madrid" }
```

### **Example with strings**

```js
const word = "Hola";
const letters = [...word];
console.log(letters); // Salida: ["H", "o", "l", "a"]
```

---

[![Spread Operator](https://img.youtube.com/vi/p-r0ormnYtA/0.jpg)](https://www.youtube.com/watch?v=p-r0ormnYtA&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

## **3. Rest Operator (`...`)**

The **rest** operator is used in functions to group multiple arguments into an array.

```js
function sum(...numbers) {
  return numbers.reduce((acc, num) => acc + num, 0);
}

console.log(sum(1, 2, 3, 4)); // Salida: 10
```

It is also used to extract elements from an array or object.

```js
const [first, ...rest] = [10, 20, 30, 40];
console.log(first); // 10
console.log(rest); // [20, 30, 40]
```

---

## **4. Optional Chaining (`?.`)**

The **Optional Chaining** operator (`?.`) lets you access an object's properties without causing errors if any intermediate property is `null` or `undefined`.

### **Example without Optional Chaining**

```js
const person = { name: "Carlos", address: null };
// console.log(person.address.street); // Error: No se puede leer 'street' de null
```

### **Example with Optional Chaining**

```js
console.log(person.address?.street); // Salida: undefined (sin error)
```

It also works with method calls:

```js
const user = {
  getName: () => "Pedro",
};
console.log(user.getName?.()); // Salida: "Pedro"
console.log(user.getAge?.()); // Salida: undefined
```

---

[![Optional Chaining](https://img.youtube.com/vi/0JNIXEZu3v0/0.jpg)](https://www.youtube.com/watch?v=0JNIXEZu3v0&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

## **5. Nullish Coalescing (`??`)**

The **Nullish Coalescing** operator (`??`) returns the first operand if it's **neither `null` nor `undefined`**; otherwise, it returns the second one.

```js
const name = null;
const defaultName = name ?? "Invitado";
console.log(defaultName); // Salida: "Invitado"
```

The difference from `||` (logical OR):

```js
const age = 0;
console.log(age || 18); // Salida: 18 (porque 0 es falsy)
console.log(age ?? 18); // Salida: 0 (porque no es null ni undefined)
```

---

[![Nullish Coalescing Operator](https://img.youtube.com/vi/zkdF0wyNI-w/0.jpg)](https://www.youtube.com/watch?v=zkdF0wyNI-w&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

## **6. Ternary Operator (`? :`)**

The **ternary** operator lets you write a conditional structure in a compact way.

```js
const age = 20;
const message = age >= 18 ? "Mayor de edad" : "Menor de edad";
console.log(message); // Salida: "Mayor de edad"
```

You can nest ternary operators:

```js
const score = 85;
const grade = score >= 90 ? "A" : score >= 80 ? "B" : "C";
console.log(grade); // Salida: "B"
```

> **Note:** Avoid nesting ternaries so your code doesn't lose readability.

---

[![Ternary Operator](https://img.youtube.com/vi/CAFZ1y4Dzvo/0.jpg)](https://www.youtube.com/watch?v=CAFZ1y4Dzvo&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

## **7. Conclusion**

These advanced operators let you write more concise, efficient code in JavaScript. Using them correctly can improve readability and reduce the need for longer, more complex structures.

In the next topic, we'll take a closer look at **advanced functions** and techniques for writing cleaner, more modular code.
