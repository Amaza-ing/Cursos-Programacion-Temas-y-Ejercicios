# **Ejercicios - Tema 4: Funciones en JavaScript**

A continuación, encontrarás 6 ejercicios prácticos sobre el uso de funciones en JavaScript.

Intenta resolverlos antes de consultar la solución.

---

### **Ejercicio 1: Crear una función simple**

Crea una función llamada `showMsg` que reciba un parámetro `msg` y muestre por consola el mensaje "Mensaje: [msg]!".

<details><summary>Mostrar solución</summary>

```js
function showMsg(msg) {
  console.log(`Mensaje: ${msg}!`);
}

showMsg("Hola a todos"); // Salida: Mensaje: Hola a todos!
```

</details>

---

### **Ejercicio 2: Función que retorne un valor**

Crea una función llamada `sum` que reciba dos números como parámetros y retorne su suma.

<details><summary>Mostrar solución</summary>

```js
function sum(a, b) {
  return a + b;
}

const result = sum(5, 7);
console.log(result); // Salida: 12
```

</details>

---

### **Ejercicio 3: Función con valores por defecto**

Crea una función llamada `greetUser` que reciba un parámetro `name` y tenga un valor por defecto de "Invitado" si no se proporciona ningún nombre.

<details><summary>Mostrar solución</summary>

```js
function greetUser(name = "Invitado") {
  console.log(`¡Hola, ${name}!`);
}

greetUser(); // Salida: ¡Hola, Invitado!
greetUser("Carlos"); // Salida: ¡Hola, Carlos!
```

</details>

---

### **Ejercicio 4: Función flecha**

Convierte la siguiente función en una función flecha:

```js
function multiply(a, b) {
  return a * b;
}
```

<details><summary>Mostrar solución</summary>

```js
const multiply = (a, b) => {
  return a * b;
};

// O en su versión reducida:

const multiply = (a, b) => a * b;

console.log(multiply(3, 4)); // Salida: 12
```

</details>

---

### **Ejercicio 5: Función que use parámetros rest**

Crea una función llamada `multiplyAll` que acepte un número indefinido de argumentos y retorne su multiplicación.

<details><summary>Mostrar solución</summary>

```js
function multiplyAll(...numbers) {
  let result = 1;

  for (number of numbers) {
    result *= number;
  }
  return result;
}

console.log(multiplyAll(1, 2, 3, 4)); // Salida: 24
```

</details>

---

### **Ejercicio 6: Función de orden superior**

Crea una función llamada `applyOperation` que reciba dos números y una función callback. La función debe aplicar el callback a los dos números.

**Ejemplo:**

```js
function add(a, b) {
  return a + b;
}

function subtract(a, b) {
  return a - b;
}

applyOperation(5, 3, add); // Salida: 8
applyOperation(5, 3, subtract); // Salida: 2
```

<details><summary>Mostrar solución</summary>

```js
function applyOperation(a, b, operation) {
  console.log(operation(a, b));
}

function add(a, b) {
  return a + b;
}

function subtract(a, b) {
  return a - b;
}

applyOperation(5, 3, add); // Salida: 8
applyOperation(5, 3, subtract); // Salida: 2
```

</details>
