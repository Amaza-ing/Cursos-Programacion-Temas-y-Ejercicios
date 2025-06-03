# **Ejercicios - Tema 7: Paso por Valor y Paso por Referencia**

A continuación, encontrarás 5 ejercicios prácticos sobre el paso por valor y paso por referencia en JavaScript.

Intenta resolverlos antes de consultar la solución.

---

### **Ejercicio 1: Paso por Valor con Variables Primitivas**
Crea dos variables `x` e `y`, asignando a `y` el valor de `x`. Luego, cambia el valor de `y` y verifica si `x` ha cambiado.

<details><summary>Mostrar solución</summary>

```js
let x = 42;
let y = x;
y = 100;

console.log(x); // Salida: 42
console.log(y); // Salida: 100
```

</details>

---

### **Ejercicio 2: Modificación de un Objeto por Referencia**
Crea un objeto `car` con propiedades `brand` y `year`. Luego, asigna este objeto a una nueva variable `carCopy` y modifica `year` en `carCopy`. ¿Qué sucede con `car`?

<details><summary>Mostrar solución</summary>

```js
const car = { brand: "Toyota", year: 2020 };
const carCopy = car;
carCopy.year = 2025;

console.log(car.year); // Salida: 2025
console.log(carCopy.year); // Salida: 2025
```

</details>

---

### **Ejercicio 3: Crear una Copia Independiente de un Objeto**
Dado el siguiente objeto `user`, crea una copia independiente y modifica solo la propiedad `age` en la copia sin afectar el objeto original.

<details><summary>Mostrar solución</summary>

```js
const user = { name: "Elena", age: 30 };
const userCopy = { ...user };
userCopy.age = 35;

console.log(user.age); // Salida: 30
console.log(userCopy.age); // Salida: 35
```

</details>

---

### **Ejercicio 4: Copiar un Array sin Modificar el Original**
Dado un array `numbers`, crea una copia del array y añade un nuevo número a la copia sin afectar el original.

<details><summary>Mostrar solución</summary>

```js
const numbers = [10, 20, 30];
const numbersCopy = [...numbers];
numbersCopy.push(40);

console.log(numbers); // Salida: [10, 20, 30]
console.log(numbersCopy); // Salida: [10, 20, 30, 40]
```

</details>

---

### **Ejercicio 5: Copia Profunda de un Objeto con Objetos Anidados**
Dado el siguiente objeto `student`, realiza una copia profunda y modifica la propiedad `grade` sin afectar el original.

```js
const student = {
  name: "Pedro",
  info: {
    grade: "A",
    age: 21
  }
};
```

<details><summary>Mostrar solución</summary>

```js
const student = {
  name: "Pedro",
  info: {
    grade: "A",
    age: 21
  }
};

const studentCopy = JSON.parse(JSON.stringify(student));
studentCopy.info.grade = "B";

console.log(student.info.grade); // Salida: A
console.log(studentCopy.info.grade); // Salida: B
```

</details>

