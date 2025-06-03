# **Tema 8: Funciones Avanzadas y Código Modular en JavaScript**

## **1. Introducción**

Las funciones avanzadas en JavaScript permiten escribir código más eficiente, reutilizable y modular. En este tema exploraremos técnicas avanzadas como funciones de orden superior, closures, currying y modularización del código.

---

## **2. Funciones de Orden Superior**

Una función de orden superior es aquella que recibe otra función como parámetro o devuelve una función.

### **Ejemplo: `map()` como función de orden superior**

```js
const numbers = [1, 2, 3, 4];
const squaredNumbers = numbers.map((num) => num * num);
console.log(squaredNumbers); // Salida: [1, 4, 9, 16]
```

### **Ejemplo: Función que recibe otra función como argumento**

```js
function operate(a, b, operation) {
  return operation(a, b);
}

function add(x, y) {
  return x + y;
}

console.log(operate(5, 3, add)); // Salida: 8
```

---

## **3. Closures (Funciones Anidadas con Acceso al Ámbito Externo)**

Un closure es una función que recuerda el ámbito (scope) en el que fue creada, permitiendo acceder a variables fuera de su propio ámbito.

### **Ejemplo de Closure**

```js
function createCounter() {
  let count = 0;
  return function () {
    count++;
    return count;
  };
}

const counter = createCounter();
console.log(counter()); // Salida: 1
console.log(counter()); // Salida: 2
```

Aquí, `counter` recuerda la variable `count` aunque la función externa `createCounter` haya finalizado su ejecución.

---

## **4. Currying**

El currying es una técnica que transforma una función que recibe múltiples argumentos en una serie de funciones que reciben un solo argumento cada vez.

### **Ejemplo de Currying**

```js
function multiply(a) {
  return function (b) {
    return a * b;
  };
}

const double = multiply(2);
console.log(double(5)); // Salida: 10
```

Esto permite una mayor reutilización y composición de funciones.

---

## **5. Funciones Puras e Inmutabilidad**

Una función es **pura** si:

1. Su salida solo depende de sus entradas.
2. No modifica variables externas ni el estado global.

### **Ejemplo de Función Pura**

```js
function sum(a, b) {
  return a + b;
}

console.log(sum(3, 4)); // Salida: 7
```

> **Nota:** Evita modificar arrays u objetos mutables dentro de funciones para mantener la inmutabilidad.

---

## **6. Modularización del Código**

Para hacer el código más reutilizable y fácil de mantener, se puede dividir en módulos usando `export` e `import`.

### **Ejemplo de Exportación en un Archivo `math.js`**

```js
export function add(a, b) {
  return a + b;
}

export function subtract(a, b) {
  return a - b;
}
```

### **Ejemplo de Importación en `main.js`**

```js
import { add, subtract } from "./math.js";

console.log(add(5, 3)); // Salida: 8
console.log(subtract(5, 3)); // Salida: 2
```

Esto permite organizar el código en archivos separados para mejorar la legibilidad y mantenibilidad.

---

## **7. Funciones Recursivas**

Una función recursiva es aquella que se llama a sí misma hasta alcanzar una condición de salida.

### **Ejemplo de Factorial con Recursión**

```js
function factorial(n) {
  if (n === 0) return 1;
  return n * factorial(n - 1);
}

console.log(factorial(5)); // Salida: 120
```

> **Nota:** Asegúrate de definir una condición de salida para evitar bucles infinitos.

---

## **8. Buenas Prácticas**

- Usa funciones de orden superior para mejorar la reutilización del código.
- Es preferible funciones puras para evitar efectos secundarios.
- Aplica la modularización dividiendo el código en archivos separados.
- Usa closures cuando necesites encapsulación de datos.
- Emplea currying cuando sea útil dividir funciones en llamadas más pequeñas.

---

## **9. Conclusión**

Dominar funciones avanzadas en JavaScript permite escribir código más limpio, modular y eficiente. Aplicando estas técnicas, puedes mejorar la reutilización y escalabilidad de tus programas.

En el siguiente tema veremos algunos operadores menos conocidos, como spread operator, optional chaining y otros.
