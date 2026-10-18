# **Topic 5: Objects in JavaScript**

## **1. Introduction to objects**

In JavaScript, an **object** is a collection of key-value pairs where the keys are strings and the values can be any data type, including functions and other objects. Objects let you structure complex data and are essential in object-oriented programming.

This is the structure of an object:

```js
const myObject {
  property1: "algún valor",
  property2: 1234,
}
```

---

[![Objects](https://img.youtube.com/vi/6jMtvnjITdw/0.jpg)](https://www.youtube.com/watch?v=6jMtvnjITdw&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

## **2. Creating objects**

### **2.1. Using object literal syntax**

The most common and easiest way to create an object.

```js
const person = {
  firstName: "Ana",
  lastName: "García",
  age: 30,
  isStudent: false,
};

console.log(person);
```

### **2.2. Using the `Object` constructor**

```js
const car = new Object();
car.brand = "Toyota";
car.model = "Corolla";
car.year = 2022;

console.log(car);
```

### **2.3. Using constructor functions**

```js
function Person(firstName, lastName, age) {
  this.firstName = firstName;
  this.lastName = lastName;
  this.age = age;
}

const user = new Person("Carlos", "López", 28);
console.log(user);
```

### **2.4. Using classes (ES6)**

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

## **3. Accessing properties**

You don't need to use the whole object: you can access an object's properties in different ways.

### **3.1. Dot notation**

object.property

```js
console.log(person.firstName); // Salida: Ana
```

### **3.2. Bracket notation**

object[property]

```js
console.log(person["lastName"]); // Salida: García
```

> **Note:** Bracket notation is useful when the property name is in a variable.

```js
const key = "age";
console.log(person[key]); // Salida: 30
```

### **3.3. Adding properties**

You can add new properties to an object by accessing them, even if they didn't exist before.

```js
person.country = "España";
console.log(person.country); // Salida: España
```

---

## **4. Methods in objects**

Objects can have functions as properties, called **methods**.

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

## **5. The `this` object**

Inside a method, `this` refers to the object that calls the method.

```js
const user = {
  firstName: "Laura",
  greet() {
    console.log(`Hola, soy ${this.firstName}`);
  },
};

user.greet(); // Salida: Hola, soy Laura
```

> **Note:** Arrow functions don't have their own `this`, so it's better to use regular functions for methods that depend on `this`.

---

## **6. Useful methods for objects**

```js
const person = {
  firstName: "Ana",
  lastName: "García",
  age: 30,
  isStudent: false,
};
```

### **6.1. `Object.keys()`**

Returns an array with the keys of the object.

```js
console.log(Object.keys(person)); // Salida: ["firstName", "lastName", "age", "isStudent"]
```

### **6.2. `Object.values()`**

Returns an array with the values of the object.

```js
console.log(Object.values(person)); // Salida: ["Ana", "García", 30, false]
```

### **6.3. `Object.entries()`**

Returns an array of arrays with key-value pairs.

```js
console.log(Object.entries(person));
// Salida: [["firstName", "Ana"], ["lastName", "García"], ["age", 30], ["isStudent", false]]
```

### **6.4. `hasOwnProperty()`**

Checks whether the object has a specific property.

```js
console.log(person.hasOwnProperty("age")); // Salida: true
```

---

[![Object methods and constructor functions](https://img.youtube.com/vi/8G3gSkERg0o/0.jpg)](https://www.youtube.com/watch?v=8G3gSkERg0o&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

## **7. Object destructuring**

It lets you extract properties from an object and assign them to variables.

```js
const { firstName, age } = person;
console.log(firstName); // Salida: Ana
console.log(age); // Salida: 30
```

You can also give the variables new names:

```js
const { firstName: name, age: years } = person;
console.log(name); // Salida: Ana
console.log(years); // Salida: 30
```

---

[![Destructuring](https://img.youtube.com/vi/jMJRFhG1__8/0.jpg)](https://www.youtube.com/watch?v=jMJRFhG1__8&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

## **8. Conclusion**

Objects in JavaScript are a powerful tool for structuring and manipulating complex data. With the ability to add methods, inherit properties and use classes, objects form the basis of many modern applications.

In the next topic, we'll take a closer look at **arrays** and how to work efficiently with collections of data in JavaScript.
