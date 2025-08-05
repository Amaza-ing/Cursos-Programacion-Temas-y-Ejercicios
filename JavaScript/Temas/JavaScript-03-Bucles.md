# **Tema 3: Bucles en JavaScript**

## **1. Introducción a los bucles**

Los bucles permiten ejecutar un bloque de código repetidamente mientras se cumpla una condición específica. En JavaScript, existen varios tipos de bucles que nos permiten iterar sobre datos y ejecutar tareas repetitivas.

---

## **2. Bucle `for`**

El bucle `for` es uno de los más utilizados cuando conocemos el número exacto de iteraciones.

### **Sintaxis:**

```js
for (inicialización; condición; incremento) {
  // Código a ejecutar en cada iteración
}
```

### **Ejemplo:**

```js
for (let i = 0; i < 5; i++) {
  console.log(`Iteración número ${i}`);
}
```

**Salida:**

```
Iteración número 0
Iteración número 1
Iteración número 2
Iteración número 3
Iteración número 4
```

---

[![Bucle for](https://img.youtube.com/vi/MvneErXddY4/0.jpg)](https://www.youtube.com/watch?v=MvneErXddY4&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

## **3. Bucle `while`**

El bucle `while` ejecuta el bloque de código mientras la condición sea verdadera.

### **Sintaxis:**

```js
while (condición) {
  // Código a ejecutar
}
```

### **Ejemplo:**

```js
let count = 0;

while (count < 3) {
  console.log(`Contador: ${count}`);
  count++;
}
```

**Salida:**

```
Contador: 0
Contador: 1
Contador: 2
```

> **Precaución:** Asegúrate de que la condición se vuelva falsa en algún momento para evitar bucles infinitos.

---

## **4. Bucle `do...while`**

El bucle `do...while` ejecuta el bloque de código al menos una vez antes de verificar la condición.

### **Sintaxis:**

```js
do {
  // Código a ejecutar
} while (condición);
```

### **Ejemplo:**

```js
let i = 0;

do {
  console.log(`Número: ${i}`);
  i++;
} while (i < 3);
```

**Salida:**

```
Número: 0
Número: 1
Número: 2
```

> **Nota:** `do...while` siempre ejecutará el bloque de código al menos una vez.

---

[![Bucles while & do while](https://img.youtube.com/vi/3LZHs0xtJEY/0.jpg)](https://www.youtube.com/watch?v=3LZHs0xtJEY&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

## **5. Bucle `for...of`**

El bucle `for...of` se utiliza para iterar sobre elementos de estructuras iterables como arrays, strings o sets.

### **Sintaxis:**

```js
for (const elemento of iterable) {
  // Código a ejecutar
}
```

### **Ejemplo con un array:**

```js
const fruits = ["manzana", "banana", "cereza"];

for (const fruit of fruits) {
  console.log(fruit);
}
```

**Salida:**

```
manzana
banana
cereza
```

### **Ejemplo con un string:**

```js
const word = "Hola";

for (const letter of word) {
  console.log(letter);
}
```

**Salida:**

```
H
o
l
a
```

---

## **6. Bucle `for...in`**

El bucle `for...in` se usa para iterar sobre las propiedades enumerables de un objeto.

### **Sintaxis:**

```js
for (const clave in objeto) {
  // Código a ejecutar
}
```

### **Ejemplo:**

```js
const person = {
  nombre: "Ana",
  edad: 25,
  ciudad: "Madrid",
};

for (const key in person) {
  console.log(`${key}: ${person[key]}`);
}
```

**Salida:**

```
nombre: Ana
edad: 25
ciudad: Madrid
```

> **Nota:** `for...in` es mejor usarlo con objetos y no con arrays.

---

[![Bucles for of & for in](https://img.youtube.com/vi/kB2vGOxs024/0.jpg)](https://www.youtube.com/watch?v=kB2vGOxs024&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

## **7. Controlando bucles: `break` y `continue`**

- **`break`**: Termina el bucle por completo.
- **`continue`**: Omite la iteración actual y pasa a la siguiente.

### **Ejemplo con `break`:**

```js
for (let i = 0; i < 10; i++) {
  if (i === 5) {
    break;
  }
  console.log(i);
}
```

**Salida:**

```
0
1
2
3
4
```

### **Ejemplo con `continue`:**

```js
for (let i = 0; i < 5; i++) {
  if (i === 2) {
    continue;
  }
  console.log(i);
}
```

**Salida:**

```
0
1
3
4
```

---

[![Break & Continue](https://img.youtube.com/vi/x4AXCSeVn-o/0.jpg)](https://www.youtube.com/watch?v=x4AXCSeVn-o&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

## **8. Métodos de arrays para iterar**

JavaScript también ofrece métodos funcionales para iterar sobre arrays. Profundizaremos sobre este tema más adelante.

### **`forEach()`**

Ejecuta una función para cada elemento del array.

```js
const numbers = [1, 2, 3];

numbers.forEach((num) => console.log(num));
```

**Salida:**

```
1
2
3
```

Existen otros métodos de los array como `map` o `filter` que se explicarán en las próximas lecciones.

---

## **9. Buenas prácticas**

- Elige el bucle adecuado según la estructura de datos.
- Evita bucles infinitos verificando bien las condiciones.
- Usa métodos funcionales (`forEach`) para código más limpio.
- Evita usar `for...in` en arrays, ya que puede incluir propiedades heredadas.

---

## **10. Conclusión**

Los bucles son fundamentales para manejar datos y automatizar tareas repetitivas en JavaScript. Comprender las diferencias entre los distintos tipos de bucles te permitirá escribir código más eficiente y limpio.

En el próximo tema, exploraremos las **funciones** y cómo modularizar tu código en JavaScript.
