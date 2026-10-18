# **Topic 2: Conditionals in JavaScript**

## **1. Introduction to conditional structures**

Conditional structures let you run different blocks of code depending on whether certain conditions are met. In JavaScript, the most common conditional statements are:

- `if` / `else`
- `else if`
- `switch`
- The ternary operator `? :`

---

## **2. The `if` / `else` statement**

The `if` statement evaluates a condition and runs a block of code if it's true. You can use `else` to run another block if the condition isn't met.

### **Basic syntax:**

```js
if (condición) {
  // Código si la condición es verdadera
} else {
  // Código si la condición es falsa
}
```

### **Example:**

```js
let age = 20;

if (age >= 18) {
  console.log("Eres mayor de edad.");
} else {
  console.log("Eres menor de edad.");
}
```

---

## **3. Using `else if` for multiple conditions**

When you need to evaluate multiple conditions, you can use `else if`.

### **Basic syntax:**

```js
if (condición1) {
  // Código si condición1 es verdadera
} else if (condición2) {
  // Código si condición2 es verdadera
} else {
  // Código si ninguna condición es verdadera
}
```

### **Example:**

```js
let score = 85;

if (score >= 90) {
  console.log("Sobresaliente");
} else if (score >= 75) {
  console.log("Notable");
} else if (score >= 60) {
  console.log("Aprobado");
} else {
  console.log("Reprobado");
}
```

---

[![Conditionals: if else](https://img.youtube.com/vi/_o6rkkqpL20/0.jpg)](https://www.youtube.com/watch?v=_o6rkkqpL20&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

## **4. The `switch` statement**

The `switch` statement is useful when you need to evaluate a variable against multiple possible values.

### **Basic syntax:**

```js
switch (expresión) {
  case valor1:
    // Código si la expresión es igual a valor1
    break;
  case valor2:
    // Código si la expresión es igual a valor2
    break;
  default:
  // Código si ningún caso coincide
}
```

### **Example:**

```js
let day = "martes";

switch (day) {
  case "lunes":
    console.log("Inicio de semana");
    break;
  case "martes":
    console.log("Segundo día de la semana");
    break;
  case "viernes":
    console.log("Casi fin de semana");
    break;
  default:
    console.log("Día no reconocido");
}
```

> **Note:** Don't forget to use `break` to stop the following cases from running.

---

[![Conditionals: switch](https://img.youtube.com/vi/74jf2XDWFnU/0.jpg)](https://www.youtube.com/watch?v=74jf2XDWFnU&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

## **5. The ternary operator `? :`**

The ternary operator is a shorthand way of writing simple conditionals.

### **Syntax:**

```js
condición ? expresión_si_verdadero : expresión_si_falso;
```

### **Example:**

```js
let age = 17;
let message = age >= 18 ? "Eres mayor de edad" : "Eres menor de edad";
console.log(message);
```

> **Output:** `Eres menor de edad`

---

[![Ternary operator](https://img.youtube.com/vi/CAFZ1y4Dzvo/0.jpg)](https://www.youtube.com/watch?v=CAFZ1y4Dzvo&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

## **6. Comparison operators in JavaScript**

To write conditions, you use the following comparison operators:

| Operator | Description | Example | Result |
| -------- | -------------------- | ----------- | --------- |
| `==` | Loose equality | `5 == '5'` | `true` |
| `===` | Strict equality | `5 === '5'` | `false` |
| `!=` | Loose inequality | `5 != '5'` | `false` |
| `!==` | Strict inequality | `5 !== '5'` | `true` |
| `>` | Greater than | `7 > 5` | `true` |
| `<` | Less than | `3 < 5` | `true` |
| `>=` | Greater than or equal to | `5 >= 5` | `true` |
| `<=` | Less than or equal to | `4 <= 3` | `false` |

Strict equality `===` in JavaScript is the equivalent of the double equals `==` in most programming languages.
Loose equality compares only the value, not the data type, while strict equality compares both the value and the type.

> **Recommendation:** Use `===` and `!==` to avoid implicit type conversion problems.

---

[![Logical Operators](https://img.youtube.com/vi/lNzYA0NA3Gw/0.jpg)](https://www.youtube.com/watch?v=lNzYA0NA3Gw&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

[![Double equals vs triple equals](https://img.youtube.com/vi/GuCv3LrxA7A/0.jpg)](https://www.youtube.com/watch?v=GuCv3LrxA7A&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

## **7. Boolean logic**
In conditions, you can use logical operators to combine multiple expressions:

| Operator | Description | Example | Result |
| -------- | ----------- | ----------------- | --------- |
| `&&` | AND (and) | `true && false` | `false` |
| `\|\|` | OR (or) | `true \|\| false` | `true` |
| `!` | NOT (not) | `!true` | `false` |

With the "logical AND" `&&`, all the expressions have to be true for the result to be true.

With the "logical OR" `||`, if just one of the expressions is true, the result is already true.

The "negation" operator turns a `true` into a `false` and vice versa.

### **Example combining conditions:**

```js
let age = 25;
let hasLicense = true;

if (age >= 18 && hasLicense) {
  console.log("Puedes conducir.");
} else {
  console.log("No puedes conducir.");
}
```

---

[![What boolean operators return](https://img.youtube.com/vi/L9qOnh9TK3M/0.jpg)](https://www.youtube.com/watch?v=L9qOnh9TK3M&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

## **8. Truthy and falsy values in JavaScript**

### **8.1. Definition**

In JavaScript, values are evaluated in boolean contexts (such as in conditionals) to determine whether they are "true" or "false." However, not all true or false values are strictly `true` or `false`. This is where the concepts of **truthy** and **falsy** come in.

- **Truthy:** A value that evaluates to `true` in a boolean context.
- **Falsy:** A value that evaluates to `false` in a boolean context.

---

### **8.2. Falsy values**

A **falsy** value is one that is considered `false` when evaluated in a condition.

### **List of falsy values in JavaScript:**

1. `false` — The false boolean value.
2. `0` — The number zero.
3. `-0` — Negative zero.
4. `0n` — The BigInt zero.
5. `""` or `''` or `` (empty string) — An empty string.
6. `null` — Intentional absence of any value.
7. `undefined` — A variable declared but not initialized.
8. `NaN` — Result of invalid math operations.

### **Example:**

```js
if (0) {
  console.log("Este mensaje no se mostrará.");
} else {
  console.log("0 es un valor falsy.");
}

if ("") {
  console.log("Este mensaje no se mostrará.");
} else {
  console.log("Cadena vacía es falsy.");
}
```

**Output:**

```
0 es un valor falsy.
Cadena vacía es falsy.
```

---

### **8.3. Truthy values**

A **truthy** value is any value that is not falsy. These values are considered `true` when evaluated in a boolean context.

### **Examples of truthy values:**

1. Any number other than `0` (positive or negative): `42`, `-7`
2. Non-empty strings: `'Hola'`, `'false'`, `'0'`
3. Arrays: `[]`
4. Objects: `{}`
5. Functions: `function() {}`
6. Class instances

### **Example:**

```js
if ("JavaScript") {
  console.log("Esta cadena no está vacía.");
}

if ([]) {
  console.log("Un array vacío es truthy.");
}

if ({}) {
  console.log("Un objeto vacío es truthy.");
}
```

**Output:**

```
Esta cadena no está vacía.
Un array vacío es truthy.
Un objeto vacío es truthy.
```

> **Note:** Even when an array or object is empty, it's considered truthy.

---

[![Truthy && Falsy](https://img.youtube.com/vi/tRPvHLtIb9U/0.jpg)](https://www.youtube.com/watch?v=tRPvHLtIb9U&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

### **8.4. Implicit conversion to boolean**

JavaScript automatically converts values to booleans in contexts where a `true` or `false` is expected, such as:

- Conditional statements (`if`, `while`, `for`)
- Logical operators (`&&`, `||`, `!`)
### **Example using `Boolean()`:**

```js
console.log(Boolean("Hola")); // true
console.log(Boolean("")); // false
console.log(Boolean(100)); // true
console.log(Boolean(0)); // false
console.log(Boolean(null)); // false
```

### **Example with the `!` (NOT) operator:**

The NOT operator (`!`) returns true when it's applied to a falsy value and false when it's applied to a truthy value.

```js
console.log(!"hola"); // false
console.log(!0); // true
```

You can apply two negation operators (`!!`) to get true from a truthy value and false from a falsy value.

```js
console.log(!!"hola"); // true
console.log(!!0); // false
```

---

[![How to convert any variable to boolean](https://img.youtube.com/vi/5lvql3mcmWk/0.jpg)](https://www.youtube.com/watch?v=5lvql3mcmWk&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

### **8.5. Practical use: default values**

A common use of truthy and falsy values is to provide default values with the "logical OR" operator: even if the first expression is falsy, it keeps evaluating the rest of the expressions until it finds something truthy, and that is the value it returns.

### **Example with logical operator `||`:**

```js
let username = "";
let displayName = username || "Invitado";

console.log(displayName); // Salida: Invitado
```

In this case, since `username` is an empty string (falsy), `displayName` takes the value "Invitado".

---

### **8.6. Best practices**

1. **Be explicit:** Although JavaScript allows these implicit conversions, it's a good idea to keep your code clear.
2. **Avoid common mistakes:** Remember that values like `0`, `""`, `null`, `undefined` and `NaN` are falsy and can cause logic errors.

---

### **8.7. Important**

Understanding the concepts of **truthy** and **falsy** in JavaScript is essential to writing efficient and error-free code. These values affect how conditions and logical operations are evaluated in your code.

## **9. Best practices**

- Use `===` and `!==` instead of `==` and `!=`.
- Keep your conditions simple and readable.
- Comment complex conditionals.
- Use the ternary operator for simple conditions.
- Don't overuse `switch` if `if/else` is clearer.

---

## **10. Conclusion**

Conditional structures are essential for control flow in JavaScript. Knowing when to use `if/else`, `switch` or the ternary operator will help you write cleaner, more efficient code.

In the next topic, we'll dive deeper into **loops** and how to iterate over data in JavaScript.
