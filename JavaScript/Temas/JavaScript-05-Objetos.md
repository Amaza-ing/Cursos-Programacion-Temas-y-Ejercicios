# **Tema 5: Objetos en JavaScript**

## **1. Introducción a los objetos**

En JavaScript, un **objeto** es una colección de pares clave-valor donde las claves son cadenas de caracteres y los valores pueden ser cualquier tipo de dato, incluidas otras funciones y objetos. Los objetos permiten estructurar datos complejos y son fundamentales en la programación orientada a objetos.

Esta es la estructura de un objeto:

```js
const myObject {
  property1: "algún valor",
  property2: 1234,
}
```

---

[![Objetos](https://img.youtube.com/vi/6jMtvnjITdw/0.jpg)](https://www.youtube.com/watch?v=6jMtvnjITdw&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

## **2. Creación de objetos**

### **2.1. Usando la sintaxis de objeto literal**

La forma más común y sencilla de crear un objeto.

```js
const person = {
  firstName: "Ana",
  lastName: "García",
  age: 30,
  isStudent: false,
};

console.log(person);
```

### **2.2. Usando el constructor `Object`**

```js
const car = new Object();
car.brand = "Toyota";
car.model = "Corolla";
car.year = 2022;

console.log(car);
```

### **2.3. Usando funciones constructoras**

```js
function Person(firstName, lastName, age) {
  this.firstName = firstName;
  this.lastName = lastName;
  this.age = age;
}

const user = new Person("Carlos", "López", 28);
console.log(user);
```

### **2.4. Usando clases (ES6)**

```js
class Animal {
  constructor(name, species) {
    this.name = name;
    this.species = species;
  }

  describe() {
    return `${this.name} es un ${this.species}`;
  }
}

const dog = new Animal("Firulais", "perro");
console.log(dog.describe()); // Salida: Firulais es un perro
```

---

## **3. Acceso a propiedades**

No hace falta usar el objeto al completo, se puede acceder a las propiedades de un objeto de diferentes formas.

### **3.1. Notación del punto**

objeto.propiedad

```js
console.log(person.firstName); // Salida: Ana
```

### **3.2. Notación de corchetes**

objeto[propiedad]

```js
console.log(person["lastName"]); // Salida: García
```

> **Nota:** La notación por corchetes es útil cuando el nombre de la propiedad está en una variable.

```js
const key = "age";
console.log(person[key]); // Salida: 30
```

### **3.3. Añadir propiedades**

Se pueden añadir propiedades nuevas a un objeto accediendo a ellas aunque previamente no existieran.

```js
person.country = "España";
console.log(person.country); // Salida: España
```

---

## **4. Métodos en objetos**

Los objetos pueden tener funciones como propiedades, llamadas **métodos**.

```js
const calculator = {
  sum: function (a, b) {
    return a + b;
  },
  subtract(a, b) {
    return a - b; // Sintaxis abreviada
  },
};

console.log(calculator.sum(5, 3)); // Salida: 8
console.log(calculator.subtract(5, 3)); // Salida: 2
```

---

## **5. El objeto `this`**

Dentro de un método, `this` hace referencia al objeto que llama al método.

```js
const user = {
  firstName: "Laura",
  greet() {
    console.log(`Hola, soy ${this.firstName}`);
  },
};

user.greet(); // Salida: Hola, soy Laura
```

> **Nota:** Las funciones flecha no tienen su propio `this`, por lo que es preferible usar funciones normales para métodos que dependan de `this`.

---

## **6. Métodos útiles para objetos**

```js
const person = {
  firstName: "Ana",
  lastName: "García",
  age: 30,
  isStudent: false,
};
```

### **6.1. `Object.keys()`**

Devuelve un array con las claves del objeto.

```js
console.log(Object.keys(person)); // Salida: ["firstName", "lastName", "age", "isStudent"]
```

### **6.2. `Object.values()`**

Devuelve un array con los valores del objeto.

```js
console.log(Object.values(person)); // Salida: ["Ana", "García", 30, false]
```

### **6.3. `Object.entries()`**

Devuelve un array de arrays con pares clave-valor.

```js
console.log(Object.entries(person));
// Salida: [["firstName", "Ana"], ["lastName", "García"], ["age", 30], ["isStudent", false]]
```

### **6.4. `hasOwnProperty()`**

Verifica si el objeto tiene una propiedad específica.

```js
console.log(person.hasOwnProperty("age")); // Salida: true
```

---

[![Métodos de los objetos y funciones constructoras](https://img.youtube.com/vi/8G3gSkERg0o/0.jpg)](https://www.youtube.com/watch?v=8G3gSkERg0o&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

## **7. Desestructuración de objetos**

Permite extraer propiedades de un objeto y asignarlas a variables.

```js
const { firstName, age } = person;
console.log(firstName); // Salida: Ana
console.log(age); // Salida: 30
```

También puedes asignar nuevos nombres a las variables:

```js
const { firstName: name, age: years } = person;
console.log(name); // Salida: Ana
console.log(years); // Salida: 30
```

---

## **8. Conclusión**

Los objetos en JavaScript son una herramienta poderosa para estructurar y manipular datos complejos. Con la capacidad de agregar métodos, heredar propiedades y utilizar clases, los objetos forman la base de muchas aplicaciones modernas.

En el próximo tema, profundizaremos en los **arrays** y cómo trabajar eficientemente con colecciones de datos en JavaScript.
