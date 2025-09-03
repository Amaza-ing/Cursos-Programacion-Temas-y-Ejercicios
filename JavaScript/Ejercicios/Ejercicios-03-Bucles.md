# **Ejercicios - Tema 3: Bucles en JavaScript**

A continuación, encontrarás 6 ejercicios prácticos sobre el uso de bucles en JavaScript.

Intenta resolverlos antes de consultar la solución.

---

### **Ejercicio 1: Contar del 1 al 10**

Crea un programa que imprima los números del 1 al 10 usando un bucle `for`.

<details><summary>Mostrar solución</summary>

```js
for (let i = 1; i <= 10; i++) {
  console.log(i);
}
```

</details>

---

### **Ejercicio 2: Suma de números pares**

Usando un bucle `while`, suma todos los números pares entre 1 y 20 e imprime el resultado.

<details><summary>Mostrar solución</summary>

```js
let i = 1;
let sum = 0;

while (i <= 20) {
  if (i % 2 === 0) {
    sum += i;
  }
  i++;
}

console.log(`La suma de los números pares entre 1 y 20 es: ${sum}`);
```

</details>

---

### **Ejercicio 3: Palabra al revés**

Usa un bucle `for` para imprimir una palabra al revés.

**Ejemplo:** Si la palabra es "JavaScript", el resultado debe ser "tpircSavaJ".

<details><summary>Mostrar solución</summary>

```js
const word = "JavaScript";
let reversedWord = "";

for (let i = word.length - 1; i >= 0; i--) {
  reversedWord += word[i];
}

console.log(reversedWord);
```

</details>

---

### **Ejercicio 4: Imprimir propiedades de un objeto**

Usa un bucle `for...in` para imprimir las claves y valores de un objeto.

**Ejemplo:**

```js
const person = {
  nombre: "Ana",
  edad: 30,
  ciudad: "Madrid",
};
```

**Salida esperada:**

```
nombre: Ana
edad: 30
ciudad: Madrid
```

<details><summary>Mostrar solución</summary>

```js
const person = {
  nombre: "Ana",
  edad: 30,
  ciudad: "Madrid",
};

for (const key in person) {
  console.log(`${key}: ${person[key]}`);
}
```

</details>

---

### **Ejercicio 5: Iterar sobre un array con `for...of`**

Crea un programa que itere sobre el siguiente array usando `for...of` y muestre cada elemento.

```js
const fruits = ["manzana", "banana", "cereza", "mango"];
```

**Salida esperada:**

```
manzana
banana
cereza
mango
```

<details><summary>Mostrar solución</summary>

```js
const fruits = ["manzana", "banana", "cereza", "mango"];

for (const fruit of fruits) {
  console.log(fruit);
}
```

</details>

---

### **Ejercicio 6: Tabla de multiplicar**

Solicita al usuario un número y muestra su tabla de multiplicar del 1 al 10 usando un bucle `for`.

**Ejemplo:** Si el usuario introduce `5`, la salida será:

```
5 x 1 = 5
5 x 2 = 10
...
5 x 10 = 50
```

<details><summary>Mostrar solución</summary>

```js
const number = parseInt(
  prompt("Introduce un número para ver su tabla de multiplicar:"),
);

for (let i = 1; i <= 10; i++) {
  console.log(`${number} x ${i} = ${number * i}`);
}
```

</details>

---
