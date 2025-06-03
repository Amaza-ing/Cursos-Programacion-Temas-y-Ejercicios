# **Tema 6: Arrays en JavaScript**

## **1. Introducción a los Arrays**

En JavaScript, un **array** es una estructura de datos utilizada para almacenar múltiples valores en una sola variable. Los arrays permiten trabajar con colecciones de datos de manera eficiente y flexible.

Un array puede contener cualquier tipo de dato: números, cadenas, booleanos, objetos, e incluso otros arrays.

```js
const fruits = ["manzana", "banana", "cereza"];
console.log(fruits); // Salida: ["manzana", "banana", "cereza"]
```

---

## **2. Creación de Arrays**

### **2.1. Usando corchetes `[]`**

La forma más común y simple de crear un array.

```js
const numbers = [1, 2, 3, 4, 5];
```

### **2.2. Usando el constructor `Array`**

```js
const colors = new Array("rojo", "verde", "azul");
```

> **Nota:** Se recomienda usar la notación con corchetes `[]` por ser más legible y menos propensa a errores.

### **2.3. Arrays vacíos**

```js
const emptyArray = [];
const anotherEmptyArray = new Array();
```

---

## **3. Acceso a los elementos de un Array**

Los elementos del array se acceden mediante su índice, empezando desde 0.

```js
const animals = ["perro", "gato", "pájaro"];
console.log(animals[0]); // Salida: perro
console.log(animals[2]); // Salida: pájaro
```

Si se accede a un índice que no existe, se obtendrá `undefined`.

```js
console.log(animals[5]); // Salida: undefined
```

---

## **4. Métodos básicos de Arrays**

### **4.1. `push()` y `pop()`**

- `push()` agrega un elemento al final del array.
- `pop()` elimina el último elemento del array.

```js
const fruits = ["manzana", "banana"];
fruits.push("naranja");
console.log(fruits); // ["manzana", "banana", "naranja"]

fruits.pop();
console.log(fruits); // ["manzana", "banana"]
```

### **4.2. `unshift()` y `shift()`**

- `unshift()` agrega un elemento al inicio del array.
- `shift()` elimina el primer elemento del array.

```js
fruits.unshift("fresa");
console.log(fruits); // ["fresa", "manzana", "banana"]

fruits.shift();
console.log(fruits); // ["manzana", "banana"]
```

### **4.3. `indexOf()` y `includes()`**

- `indexOf()` devuelve el índice del primer elemento coincidente o -1 si no existe.
- `includes()` verifica si un elemento está presente en el array.

```js
console.log(fruits.indexOf("banana")); // Salida: 1
console.log(fruits.includes("manzana")); // Salida: true
```

### **4.4. `slice()` y `splice()`**

- `slice()` devuelve una copia superficial de una porción del array. Los dos argumentos que recibe representan los índices del array para formar el nuevo array. El primero incluído y el segundo no incluído.
- `splice()` cambia el contenido del array eliminando o reemplazando elementos. Tres o más argumentos: (índice por el que empezar, número de elementos que se eliminan, nuevos valores a insertar en esa posición).

```js
const numbers = [1, 2, 3, 4, 5];

const sliced = numbers.slice(1, 4);
console.log(sliced); // [2, 3, 4]

numbers.splice(2, 1, 99);
console.log(numbers); // [1, 2, 99, 4, 5]
```

### **4.5. `join()` y `toString()`**

- `join()` une todos los elementos del array en una cadena. El argumento indica la cadena de caracteres que estará entre cada elemento.
- `toString()` convierte el array a una cadena separada por comas.

```js
const words = ["Hola", "mundo"];
console.log(words.join(" ")); // Salida: Hola mundo
console.log(words.toString()); // Salida: Hola,mundo
```

---

## **5. Métodos de iteración**

### **5.1. `forEach()`**

Ejecuta una función por cada elemento del array.

```js
const numbers = [1, 2, 3];
numbers.forEach((num) => console.log(num));
```

### **5.2. `map()`**

Crea un nuevo array con los resultados de la función aplicada a cada elemento.

```js
const doubled = numbers.map((num) => num * 2);
console.log(doubled); // [2, 4, 6]
```

### **5.3. `filter()`**

Crea un nuevo array con los elementos que cumplen una condición.

```js
const even = numbers.filter((num) => num % 2 === 0);
console.log(even); // [2]
```

### **5.4. `reduce()`**

Reduce el array a un único valor.

```js
const sum = numbers.reduce((acc, num) => acc + num, 0);
console.log(sum); // 6
```

### **5.5. `find()` y `findIndex()`**

- `find()` devuelve el primer elemento que cumple una condición. Si no se encuentra ningún elemento que cumpla la condición devolverá `undefined`.
- `findIndex()` devuelve el índice del primer elemento que cumple una condición.

```js
const found = numbers.find((num) => num > 2);
console.log(found); // 3

const foundIndex = numbers.findIndex((num) => num > 2);
console.log(foundIndex); // 2
```

---

## **6. Operaciones avanzadas con Arrays**

### **6.1. Concatenar arrays**

```js
const array1 = [1, 2];
const array2 = [3, 4];
const combined = array1.concat(array2);
console.log(combined); // [1, 2, 3, 4]
```

### **6.2. Spread operator (`...`)**

Permite expandir los elementos de un array. Esto se puede utilizar para copiar un array o crear uno nuevo a partir de varios arrays.

```js
const newArray = [...array1, ...array2];
console.log(newArray); // [1, 2, 3, 4]
```

### **6.3. Desestructuración de arrays**

```js
const [first, second] = numbers;
console.log(first); // 1
console.log(second); // 2
```

### **6.4. Arrays multidimensionales**

Se pueden tener arrays de cualquier tipo de datos, incluído otros arrays. Si tenemos un array de arrays de igual dimensión (número de elementos) obtendremos una matriz.

```js
const matrix = [
  [1, 2, 3],
  [4, 5, 6],
  [7, 8, 9],
];

console.log(matrix[1][2]); // Salida: 6
```

---

## **7. Conclusión**

Los arrays son una herramienta fundamental en JavaScript para manejar colecciones de datos. Con la amplia gama de métodos y operaciones disponibles, es posible realizar tareas complejas de manera eficiente y sencilla.

En el próximo tema veremos la diferencia entre paso por valor y paso por referencia y cómo afecta eso a cosas como copiar y trabajar con arrays y objetos.
