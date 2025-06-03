# **Ejercicios - Tema 8: Funciones Avanzadas en JavaScript**

A continuación, encontrarás 5 ejercicios prácticos sobre funciones avanzadas en JavaScript.

Intenta resolverlos antes de consultar la solución.

---

### **Ejercicio 1: Función de Orden Superior**

Crea una función llamada `applyOperation` que reciba dos números y una función como parámetros. La función debe aplicar la operación dada a los dos números.

<details><summary>Mostrar solución</summary>

```js
function applyOperation(a, b, operation) {
  return operation(a, b);
}

function add(x, y) {
  return x + y;
}

function multiply(x, y) {
  return x * y;
}

console.log(applyOperation(5, 3, add)); // Salida: 8
console.log(applyOperation(5, 3, multiply)); // Salida: 15
```

</details>

---

### **Ejercicio 2: Closure**

Crea una función `createMultiplier` que acepte un número como argumento y devuelva otra función que multiplique cualquier número por el número dado.

<details><summary>Mostrar solución</summary>

```js
function createMultiplier(factor) {
  return function (number) {
    return number * factor;
  };
}

const double = createMultiplier(2);
console.log(double(5)); // Salida: 10
```

</details>

---

### **Ejercicio 3: Currying**

Convierte la función `sum` en una función curried que permita sumar números en llamadas separadas.

<details><summary>Mostrar solución</summary>

```js
function sum(a) {
  return function (b) {
    return a + b;
  };
}

const addFive = sum(5);
console.log(addFive(3)); // Salida: 8
```

</details>

---

### **Ejercicio 4: Modularización con `import` y `export`**

Crea un módulo `math.js` que exporte dos funciones (`add` y `subtract`). Luego, impórtalas y úsalas en otro archivo.

<details><summary>Mostrar solución</summary>

**math.js**

```js
export function add(a, b) {
  return a + b;
}

export function subtract(a, b) {
  return a - b;
}
```

**main.js**

```js
import { add, subtract } from "./math.js";

console.log(add(10, 5)); // Salida: 15
console.log(subtract(10, 5)); // Salida: 5
```

</details>

---

### **Ejercicio 5: Recursión**

Crea una función recursiva `factorial` que calcule el factorial de un número.

<details><summary>Mostrar solución</summary>

```js
function factorial(n) {
  if (n === 0) return 1;
  return n * factorial(n - 1);
}

console.log(factorial(5)); // Salida: 120
```

</details>
