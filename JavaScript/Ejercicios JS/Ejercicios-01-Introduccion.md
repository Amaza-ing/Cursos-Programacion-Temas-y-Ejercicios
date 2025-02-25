# **Ejercicios - Tema 1: Introducción a JavaScript**

A continuación, encontrarás 4 ejercicios prácticos sobre los fundamentos de JavaScript.

Intenta resolverlos antes de consultar la solución.

---

### **Ejercicio 1: Hola Mundo**
Crea un programa que muestre el mensaje "¡Hola, mundo!" en la consola.

<details><summary>Mostrar solución</summary>

```js
console.log("¡Hola, mundo!");
```

</details>

---

### **Ejercicio 2: Declaración de Variables**
Declara dos variables llamadas `firstName` y `lastName`, asígnales tus nombres y apellidos, y muestra el mensaje "Hola, [firstName] [lastName]!" en la consola.

<details><summary>Mostrar solución</summary>

```js
const firstName = "Sara";
const lastName = "Martín";

console.log("Hola " + firstName + lastName");
```

</details>

---

### **Ejercicio 3: Condicionales**
Crea un programa que verifique si una persona es mayor de edad. Pide al usuario su edad (usa `prompt`) y muestra un mensaje indicando si es mayor o menor de edad.

<details><summary>Mostrar solución</summary>

```js
const age = prompt("Introduce tu edad:");

if (age >= 18) {
  console.log("Eres mayor de edad.");
} else {
  console.log("Eres menor de edad.");
}
```

</details>

---

### **Ejercicio 4: Bucle For**
Muestra en la consola los números del 1 al 10 utilizando un bucle `for`.

<details><summary>Mostrar solución</summary>

```js
for (let i = 1; i <= 10; i++) {
  console.log(i);
}
```

</details>

