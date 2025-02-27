# **Ejercicios - Tema 6: Arrays en JavaScript**

A continuación, encontrarás 5 ejercicios prácticos sobre el uso de arrays en JavaScript.

Intenta resolverlos antes de consultar la solución.

---

### **Ejercicio 1: Acceder a elementos de un array**
Crea un array llamado `colors` con los siguientes valores: `"rojo"`, `"verde"`, `"azul"`. Luego, muestra en consola el segundo elemento del array.

<details><summary>Mostrar solución</summary>

```js
const colors = ["rojo", "verde", "azul"];
console.log(colors[1]); // Salida: verde
```

</details>

---

### **Ejercicio 2: Agregar y eliminar elementos**
Crea un array llamado `fruits` con los valores `"manzana"` y `"banana"`. Luego:
- Agrega `"naranja"` al final del array.
- Elimina el primer elemento del array.
- Muestra el array actualizado en consola.

<details><summary>Mostrar solución</summary>

```js
const fruits = ["manzana", "banana"];
fruits.push("naranja");
fruits.shift();
console.log(fruits); // Salida: ["banana", "naranja"]
```

</details>

---

### **Ejercicio 3: Recorrer un array con `forEach`**
Crea un array llamado `numbers` con los valores `[1, 2, 3, 4, 5]`. Luego, usa `forEach` para imprimir cada número multiplicado por 2.

<details><summary>Mostrar solución</summary>

```js
const numbers = [1, 2, 3, 4, 5];
numbers.forEach(num => console.log(num * 2));
```

</details>

---

### **Ejercicio 4: Filtrar elementos de un array**
Crea un array llamado `ages` con los valores `[12, 25, 18, 30, 16]`. Luego, usa `filter` para crear un nuevo array con solo los valores mayores o iguales a 18 y muéstralo en consola.

<details><summary>Mostrar solución</summary>

```js
const ages = [12, 25, 18, 30, 16];
const adults = ages.filter(age => age >= 18);
console.log(adults); // Salida: [25, 18, 30]
```

</details>

---

### **Ejercicio 5: Crear un nuevo array con `map`**
Crea un array llamado `prices` con los valores `[10, 20, 30]`. Luego, usa `map` para crear un nuevo array con los precios incrementados en un 10% y muéstralo en consola.

<details><summary>Mostrar solución</summary>

```js
const prices = [10, 20, 30];
const updatedPrices = prices.map(price => price * 1.1);
console.log(updatedPrices); // Salida: [11, 22, 33]
```

</details>

