# **Ejercicios - Tema 2: Condicionales en JavaScript**

A continuación, encontrarás 5 ejercicios prácticos sobre el uso de condicionales en JavaScript.

Intenta resolverlos antes de consultar la solución.

---

### **Ejercicio 1: Verificar número positivo o negativo**

Crea un programa que solicite al usuario un número mediante `prompt` y muestre en la consola si es positivo, negativo o cero.

<details><summary>Mostrar solución</summary>

```js
const number = parseFloat(prompt("Introduce un número:"));

if (number > 0) {
  console.log("El número es positivo.");
} else if (number < 0) {
  console.log("El número es negativo.");
} else {
  console.log("El número es cero.");
}
```

</details>

---

### **Ejercicio 2: Clasificación de edades**

Solicita al usuario su edad y muestra un mensaje indicando su grupo de edad:

- Menor de 13: "Niño/a"
- Entre 13 y 19: "Adolescente"
- Entre 20 y 64: "Adulto/a"
- 65 o más: "Adulto/a mayor"

<details><summary>Mostrar solución</summary>

```js
const age = parseInt(prompt("Introduce tu edad:"));

if (age < 13) {
  console.log("Niño/a");
} else if (age >= 13 && age <= 19) {
  console.log("Adolescente");
} else if (age >= 20 && age <= 64) {
  console.log("Adulto/a");
} else {
  console.log("Adulto/a mayor");
}
```

</details>

---

### **Ejercicio 3: Calculadora simple con `switch`**

Crea un programa que solicite dos números y una operación matemática (`+`, `-`, `*`, `/`) y muestre el resultado usando `switch`.

<details><summary>Mostrar solución</summary>

```js
const num1 = parseFloat(prompt("Introduce el primer número:"));
const num2 = parseFloat(prompt("Introduce el segundo número:"));
const operation = prompt("Introduce la operación (+, -, *, /):");

let result;

switch (operation) {
  case "+":
    result = num1 + num2;
    break;
  case "-":
    result = num1 - num2;
    break;
  case "*":
    result = num1 * num2;
    break;
  case "/":
    result = num2 !== 0 ? num1 / num2 : "Error: división por cero";
    break;
  default:
    result = "Operación no válida";
}

console.log(`Resultado: ${result}`);
```

</details>

---

### **Ejercicio 4: Verificar año bisiesto**

Crea un programa que solicite un año y determine si es bisiesto.

**Reglas para un año bisiesto:**

- Es divisible por 4.
- No es divisible por 100, salvo que también sea divisible por 400.

<details><summary>Mostrar solución</summary>

```js
const year = parseInt(prompt("Introduce un año:"));

if ((year % 4 === 0 && year % 100 !== 0) || year % 400 === 0) {
  console.log(`${year} es un año bisiesto.`);
} else {
  console.log(`${year} no es un año bisiesto.`);
}
```

</details>

---

### **Ejercicio 5: Uso del operador ternario**

Usando el operador ternario, solicita al usuario su edad y muestra "Eres mayor de edad" si tiene 18 años o más, y "Eres menor de edad" en caso contrario.

<details><summary>Mostrar solución</summary>

```js
const age = parseInt(prompt("Introduce tu edad:"));

const message = age >= 18 ? "Eres mayor de edad" : "Eres menor de edad";
console.log(message);
```

</details>
