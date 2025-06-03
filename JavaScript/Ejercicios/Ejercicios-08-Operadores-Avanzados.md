# **Ejercicios - Tema 8: Operadores Avanzados en JavaScript**

A continuación, encontrarás 5 ejercicios prácticos sobre los operadores avanzados en JavaScript.

Intenta resolverlos antes de consultar la solución.

---

### **Ejercicio 1: Uso del Spread Operator (`...`) con Arrays**
Crea un array `numbers` con los valores `[5, 10, 15]` y otro array `moreNumbers` que contenga los valores de `numbers` más `20` y `25`. Muestra el resultado en consola.

<details><summary>Mostrar solución</summary>

```js
const numbers = [5, 10, 15];
const moreNumbers = [...numbers, 20, 25];
console.log(moreNumbers); // Salida: [5, 10, 15, 20, 25]
```

</details>

---

### **Ejercicio 2: Uso del Rest Operator (`...`) en Funciones**
Crea una función `multiplyAll` que acepte un número `factor` y un número variable de argumentos. La función debe devolver un array con cada número multiplicado por `factor`.

<details><summary>Mostrar solución</summary>

```js
function multiplyAll(factor, ...numbers) {
  return numbers.map(num => num * factor);
}

console.log(multiplyAll(2, 3, 4, 5)); // Salida: [6, 8, 10]
```

</details>

---

### **Ejercicio 3: Uso del Optional Chaining (`?.`)**
Dado el siguiente objeto `person`, accede a la propiedad `address.city` de forma segura usando `?.`. Si no existe, muestra "Ciudad no disponible".

```js
const person = {
  name: "Elena",
  address: null
};
```

<details><summary>Mostrar solución</summary>

```js
console.log(person.address?.city ?? "Ciudad no disponible"); // Salida: "Ciudad no disponible"
```

</details>

---

### **Ejercicio 4: Uso de Nullish Coalescing (`??`)**
Declara una variable `discount` que pueda ser `null` o `0`. Usa `??` para asignarle un valor por defecto de `10` solo si es `null` o `undefined`, pero manteniendo el `0` si es su valor.

<details><summary>Mostrar solución</summary>

```js
let discount = 0;
const finalDiscount = discount ?? 10;
console.log(finalDiscount); // Salida: 0
```

</details>

---

### **Ejercicio 5: Uso del Operador Ternario (`? :`)**
Crea una variable `temperature` y usa un operador ternario para asignar "Calor" si es mayor a 30, "Frío" si es menor a 15, y "Templado" en cualquier otro caso.

<details><summary>Mostrar solución</summary>

```js
const temperature = 22;
const weather = temperature > 30 ? "Calor" : temperature < 15 ? "Frío" : "Templado";
console.log(weather); // Salida: "Templado"
```

</details>

