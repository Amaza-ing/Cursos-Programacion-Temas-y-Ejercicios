# **Tema 4: Funciones en JavaScript**

## **1. Introducción a las funciones**

Las funciones son bloques de código reutilizables diseñados para realizar una tarea específica. Nos ayudan a estructurar y modularizar el código, mejorando la legibilidad y el mantenimiento.

En JavaScript, las funciones son ciudadanos de primera clase, lo que significa que pueden ser asignadas a variables, pasadas como argumentos y retornadas desde otras funciones.

---

## **2. Declaración de funciones**

Las funciones hay que declararlas, es decir escribir lo que hacen, en algún punto del código, pero eso no quiere decir que se vayan a ejecutar directamente.
Cuando se declara una función se especifica el nombre de la función, los argumentos que necesita y la lógica que va a aplicar.

Para ejecutar una función hay que llamar a la función desde otra linea de código, que deberá estar más abajo de la declaración de la función.
Cuando se llama a una función se le tienen que pasar los argumentos que necesita.

Cuando se le da nombre a una función este debe ser lo más explícito posible y estar en formato camelCase.

### **Ejemplo:**

```js
function sayHello() {
  console.log("Hello!");
}

sayHello(); // Respuesta en consola: Hello!
```

Las funciones pueden no recibir ningún parámetro como en el ejemplo anterior o recibir uno o más:

```js
function saySomething(str) {
  console.log(str);
}

saySomething("Qué tal?"); // Respuesta en consola: Qué tal?
```

Las funciones pueden aplicar diréctamente su lógica interna sin devolver nada como en el ejemplo anterior o también pueden devolver un valor usando la palabra reservada `return`:

```js
function sum(num1, num2) {
  return num1 + num2;
}

let sumResult = sum(2, 8);
console.log(sumResult); // Respuesta en consola: 10
```

### **2.1. Funciones declaradas**

Las funciones declaradas se definen usando la palabra clave `function`.

### **Sintaxis:**

```js
function greet(name) {
  console.log(`¡Hola, ${name}!`); // Muestra un saludo por consola
}
```

Aquí la función se llama `greet` y recibe un parámetro `name`.

### **Ejecución de la función:**

```js
greet("Ana"); // Salida: ¡Hola, Ana!
```

Cuando se ejecuta la función `greet` se ha pasado como argumento el valor `"Ana"`, que será el valor que reciba el parámetro `name`.

> **Nota:** Las funciones declaradas sufren "hoisting", es decir, se pueden invocar antes de ser declaradas en el código. Ya que el "hoisting" (izamiento) lo que hace es elevar la función a las primeras lineas del código antes de que se interprete. No suele ser buena idea aprovecharse de este comportamiento, debiendo declarar las funciones antes de ejecutarlas.

---

### **2.2. Funciones expresadas**

Las funciones expresadas se asignan a una variable. No se elevan como las funciones declaradas.

Este tipo de funciones se declaran de forma parecida a una variable, pero mantienen la palabra reservada `function`.

### **Sintaxis:**

```js
const sum = function (a, b) {
  return a + b; // Retorna la suma de dos números
};
```

### **Ejemplo:**

```js
console.log(sum(3, 4)); // Salida: 7
```

---

## **3. Funciones Flecha (`arrow functions`)**

Las funciones flecha ofrecen una sintaxis más concisa para escribir funciones.

### **Sintaxis:**

```js
const functionName = (parameters) => {
  // Código a ejecutar
};
```

### **Ejemplo**:

```js
const square = (num) => {
  return num * num;
};

console.log(square(5)); // Salida: 25
```

Si la función tiene un solo parámetro se puede simplificar quitando los paréntesis:

```js
const square = (num) => {
  return num * num;
};

console.log(square(5)); // Salida: 25
```

Si la función tiene una sola linea de código se puede simplificar quitando las llaves y el return:

```js
const square = (num) => num * num;

console.log(square(5)); // Salida: 25
```

### **Ejemplo:**

```js
const greet = (name) => console.log(`¡Hola, ${name}!`);

greet("Carlos"); // Salida: ¡Hola, Carlos!
```

> **Nota:** Las funciones flecha **no** tienen su propio `this`, lo que afecta su comportamiento en ciertos contextos. Esto se verá más tarde en el curso.

---

## **4. Parámetros y argumentos**

### **4.1. Valores por defecto**

Puedes asignar valores por defecto a los parámetros:

```js
function greet(name = "Invitado") {
  console.log(`¡Hola, ${name}!`); // Saluda al usuario o a "Invitado"
}

greet(); // Salida: ¡Hola, Invitado!
```

---

### **4.2. Parámetros rest (`...`)**

Permiten pasar un número indefinido de argumentos a una función:

```js
function sumAll(...numbers) {
  let result = 0;

  for (number of numbers) {
    result += number;
  }
  return result;
}

console.log(sumAll(1, 2, 3, 4)); // Salida: 10
```

---

### **4.3. Operador spread (`...`)**

Se usa para expandir elementos de un array al llamar una función:

```js
const numbers = [1, 2, 3];

function sum(a, b, c) {
  return a + b + c; // Suma tres números
}

console.log(sum(...numbers)); // Salida: 6
```

---

## **5. Callbacks & Funciones anónimas**

### **5.1. ¿Qué es un Callback?**

En JavaScript, un **callback** es una función que se pasa como argumento a otra función y se ejecuta después de que dicha función haya terminado su tarea. Los callbacks son una herramienta clave en JavaScript para manejar la asincronía, permitiendo que el código continúe ejecutándose sin bloquearse mientras espera que se complete una tarea.

Los callbacks son comúnmente utilizados en operaciones asíncronas como solicitudes a servidores, temporizadores o manejo de eventos.

---

### **5.2. Ejemplo básico de Callback**

A continuación, un ejemplo simple de cómo se usa un callback en JavaScript:

```js
// Definimos una función que acepta un callback
function greetUser(name, callback) {
  console.log(`Hola, ${name}!`);
  callback(); // Ejecutamos el callback
}

// Definimos el callback
function sayGoodbye() {
  console.log("¡Adiós!");
}

// Llamamos a la función con el callback
greetUser("Ana", sayGoodbye);
```

**Salida:**
```
Hola, Ana!
¡Adiós!
```

En este ejemplo, la función `greetUser` recibe dos argumentos: un nombre y una función callback. Después de saludar al usuario, se ejecuta el callback `sayGoodbye`.

---

### **5.3. Callbacks en operaciones asíncronas**

Un caso práctico donde los callbacks son útiles es en operaciones asíncronas como `setTimeout`:

```js
console.log("Inicio");

setTimeout(() => {
  console.log("Esto se muestra después de 2 segundos");
}, 2000);

console.log("Fin");
```

**Salida:**
```
Inicio
Fin
Esto se muestra después de 2 segundos
```

Aquí, `setTimeout` acepta un callback que se ejecutará después de 2 segundos. Mientras tanto, el programa continúa su ejecución, mostrando "Fin" antes que el mensaje retrasado.

---

### **5.4. Conclusión**

Los callbacks son fundamentales en JavaScript para controlar el flujo del programa y se pueden utilizar para manejar tareas asíncronas.

### **5.5. ¿Qué es una función anónima?**

Son funciones sin nombre, comúnmente usadas como callbacks:

```js
setTimeout(function () {
  console.log("Ejecutado tras 2 segundos"); // Mensaje tras retraso
}, 2000);
```

Con función flecha:

```js
setTimeout(() => {
  console.log("Ejecutado tras 2 segundos");
}, 2000);
```

---

## **6. Funciones de orden superior**

Son funciones que reciben otras funciones como argumentos o devuelven funciones.

### **Ejemplo devolviendo una función:**

```js
function multiplier(factor) {
  return function (number) {
    return number * factor; // Retorna el número multiplicado por el factor
  };
}

const double = multiplier(2);
console.log(double(5)); // Salida: 10
```

---

## **7. Funciones autoinvocadas (IIFE)**

Se ejecutan inmediatamente tras su declaración.

```js
(function () {
  console.log("Función autoinvocada");
})();

// Con función flecha
(() => {
  console.log("IIFE con función flecha");
})();
```

---

## **8. Modularización con funciones**

Usar funciones para dividir el código en piezas pequeñas mejora su mantenibilidad.

### **Ejemplo:**

```js
function getFullName(firstName, lastName) {
  return `${firstName} ${lastName}`; // Retorna el nombre completo
}

function greetPerson(fullName) {
  console.log(`¡Hola, ${fullName}!`); // Saluda a la persona
}

const fullName = getFullName("Laura", "García");
greetPerson(fullName); // Salida: ¡Hola, Laura García!
```

---

## **9. Buenas prácticas**

1. Nombra las funciones de forma descriptiva en inglés.
2. Mantén las funciones cortas y enfocadas en una única tarea.
3. Evita efectos secundarios no deseados.
4. Usa funciones puras siempre que sea posible.
5. Es preferible usar funciones flecha para callbacks simples.

---

## **10. Conclusión**

Las funciones son esenciales en JavaScript para estructurar y reutilizar código. Dominar los diferentes tipos y técnicas para modularizar mejorará la eficiencia y legibilidad de tus proyectos.

En el próximo tema, exploraremos los **objetos** y cómo representan datos más complejos en JavaScript.
