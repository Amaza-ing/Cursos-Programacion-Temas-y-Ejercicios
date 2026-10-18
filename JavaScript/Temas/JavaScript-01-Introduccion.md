# **Topic 1: Introduction to JavaScript**

## **1. What is JavaScript?**

JavaScript is an interpreted, object-oriented, prototype-based programming language. It is one of the essential languages ​​for web development, along with HTML and CSS, allowing you to create dynamic and interactive web pages.

### **JavaScript Key Features:**

- **Interpreted language:** Does not require prior compilation.
- **Cross-platform:** Works on most modern web browsers.
- **Object-oriented:** Uses objects and prototypes to structure the code.
- **Event-based:** Allows you to respond to user actions, such as clicks and keystrokes.
- **DOM Manipulation:** You can access and modify the content and structure of web pages.

---

## **2. History and evolution of JavaScript**

- **1995:** JavaScript was created by Brendan Eich at Netscape.
- **1997:** It was standardized under the name ECMAScript.
- **ECMAScript 6 (2015):** Introduced modern features like `let`, `const`, arrow classes and functions.
- **Current:** JavaScript continues to evolve with new annual versions of ECMAScript.

---

## **3. Environment installation and configuration**

To start programming in JavaScript it is not necessary to install complex tools. You only need:

### **Basic requirements:**

1. **Web browser:** Chrome, Firefox, Edge or Safari.
2. **Code editor:** Visual Studio Code, Sublime Text or any other editor.

### **Installing Node.js (optional)**

If you want to run JavaScript code outside the browser:

1. Download and install Node.js from [nodejs.org](https://nodejs.org/).
2. Verify the installation by running in the terminal:

```sh
node -v
npm -v
```


---

[![How to get started with JavaScript](https://img.youtube.com/vi/lD8C0NVmn7A/0.jpg)](https://www.youtube.com/watch?v=lD8C0NVmn7A&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

## **4. Writing your first program in JavaScript**

Let's create a simple program that displays a message in the console.

### **Option 1: Using the browser**

1. Open your web browser.
2. Right-click anywhere on the page and select "Inspect" or "Inspect Element."
3. Go to the **Console** tab.
4. Type the following code and press **Enter**:

```js
console.log("¡Hola, mundo!");
```


You should see the message "Hello, world!" on the console.

### **Option 2: Using an HTML file**

1. Create a file called `index.html` and write the following:

```html
<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="UTF-8" />
    <title>Mi primer programa</title>
  </head>
  <body>
    <h1>¡Hola, mundo!</h1>
    <script>
      console.log("¡Hola desde el archivo HTML!");
    </script>
  </body>
</html>
```


2. Open the file in your browser (In VSCode you can install the `Live Server` extension and then click the `Go Live` button at the bottom right)
3. Go to the browser console to view the message.

### **Option 3: Using a JS file**

Create a new file with the extension `.js`. Example: `main.js`

Modify the html file so that it links the JavaScript file using the `<script src="main.js">` tag again, adding the path to the `main.js` file in the `src` attribute.

```html
<head>
  <script src="main.js"></script>
</head>
```


> Note: This is the recommended way of working with JavaScript

---

## **5. Basic JavaScript Syntax**

### **5.1. Variables**

Variables are data, that is, information, that is stored under a specific name.
In JavaScript you can declare variables using `var`, `let` or `const`:

```js
let name = "Sara";
const pi = 3.1416;
var oldVariable = "Usado antes de ES6";
```


- **`let`**: Used to declare variables that can change.
- **`const`**: Declare constants that cannot be reassigned.
- **`var`**: Obsolete, avoid its use.

---

[![Variables](https://img.youtube.com/vi/NtFNodPjfh0/0.jpg)](https://www.youtube.com/watch?v=NtFNodPjfh0&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

### **5.2. Data types**

- **String:** Text strings. They are in quotes. Example: `"Hola"`.
- **Number:** Numbers. Example: `42`, `3.14`.
- **Boolean:** Logical values. Example: `true`, `false`.
- **Array:** Lists of elements. They are in brackets. Example: `[1, 2, 3]`.
- **Object:** Collection of key-value pairs. They go between keys. Example:

```js
const user = {
  name: "Sara",
  age: 25,
};
```


---

[![Typed](https://img.youtube.com/vi/m8-g18kKjg8/0.jpg)](https://www.youtube.com/watch?v=m8-g18kKjg8&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

### **5.3 Strings in JavaScript**

A **string** in JavaScript is a sequence of characters used to represent text. Strings are one of the most used primitive data types and there are several ways to create them.

---

### **Ways to create Strings**

#### **1. Using single quotes (`'`)**

Allows you to create a simple string by enclosing the text in single quotes.

```js
const singleQuoteString = "Hola, mundo";
console.log(singleQuoteString); // Salida: Hola, mundo
```


**Advantages:**

- Simple and direct.

**Disadvantages:**

- If the text contains apostrophes, it is necessary to escape them with `\`.

```js
const escapedString = 'No es posible' hacerlo así';
```


```js
const escapedString = "Hay que hacerlo' así";
console.log(escapedString); // Salida: Hay que hacerlo' así
```


---

#### **2. Using double quotes (`"`)**

Similar to single quotes, but using double quotes.

```js
const doubleQuoteString = "Hola, mundo";
console.log(doubleQuoteString); // Salida: Hola, mundo
```


**Advantages:**

- Useful when the text contains single quotes.

**Disadvantages:**

- If the text contains double quotes, they must be escaped with `\`.

```js
const escapedDouble = 'Ella dijo: "Hola"';
console.log(escapedDouble); // Salida: Ella dijo: "Hola"
```


---

#### **3. Using backticks (Template Literals) `` ` ``**

Introduced in ES6, **Template Literals** allow you to create advanced strings.

```js
const templateLiteral = `Hola, mundo`;
console.log(templateLiteral); // Salida: Hola, mundo
```


**Advantages:**

- Allows interpolation of variables using `${}`.
- Supports multiple lines without the need for special characters.

#### **Variable interpolation:**

```js
const name = "Ana";
const greeting = `Hola, ${name}`;
console.log(greeting); // Salida: Hola, Ana
```


#### **Multiline:**

```js
const multilineString = `Esto es una línea.
Y esta es otra línea.`;

console.log(multilineString);
/* Salida:
Esto es una línea.
Y esta es otra línea.
*/
```


---

#### **Comparison between ways to create Strings**

| Method | Interpolation | Multiline | Needs escape |
| ---------------------- | ------------- | ---------- | --------------- |
| Single quotes (`'`) | ❌ | ❌ | Yes |
| Double quotes (`"`) | ❌ | ❌ | Yes |
| Backticks (`` ` ``) | ✅ | ✅ | No |

**Recommendation:**

- Use **Template Literals** for cases that require interpolation or multiline.
- Use single or double quotes for simple strings depending on the content.

---

### **Concatenation**

- Multiple strings can be concatenated **Using `+`**:

```js
const firstName = "Laura";
const lastName = "García";
const fullName = firstName + " " + lastName;
console.log(fullName); // Salida: Laura García
```


- **Using Template Literals**:

```js
const fullNameTemplate = `${firstName} ${lastName}`;
console.log(fullNameTemplate); // Salida: Laura García
```


---

#### **Useful methods for Strings**

We'll talk about functions later, but we should know some useful and easy methods to use with strings.
Any string variable that we create can use these methods using the dot "." `variableName.method()`.

---

#### **Common methods**

- `length`: Returns the length of the string.

  ```js
  const text = "Hola";
  console.log(text.length); // Salida: 4
  ```


- `toUpperCase() / toLowerCase()`: Converts to upper or lower case.

  ```js
  console.log(text.toUpperCase()); // Salida: HOLA
  console.log(text.toLowerCase()); // Salida: hola
  ```


- `includes()`: Check if a text contains a substring.

  ```js
  console.log(text.includes("la")); // Salida: true
  ```


- `replace()`: Replaces one substring with another.

  ```js
  console.log(text.replace("Hola", "Adiós")); // Salida: Adiós
  ```


- `trim()`: Remove spaces at the beginning and end.
  ```js
  const spaced = "  Hola  ";
  console.log(spaced.trim()); // Salida: Hola
  ```


---

JavaScript offers multiple ways to create and manipulate strings. Choosing the appropriate method depends on the context and the need for interpolation or formatting. With **Template Literals**, the creation of dynamic and multiline strings is simpler and clearer.

---

[![Strings](https://img.youtube.com/vi/Bi-DguuLtac/0.jpg)](https://www.youtube.com/watch?v=Bi-DguuLtac&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

### **5.4. Basic operators**

Basic mathematical and logical operations can be performed easily using operators.

- **Arithmetic:** `+`, `-`, `*`, `/`, `%`
- **Assignment:** `=`, `+=`, `-=`, `*=`
- **Comparison:** `==`, `===`, `!=`, `!==`, `>`, `<`
- **Logical:** `&&`, `||`, `!`

```js
let num1 = 5;
let num2 = 3;

const result = num1 + num2; // result = 8
```


If two strings are "added" the result will be a concatenation.

```js
let str1 = "Hola";
let str2 = "Qué tal?";

const result = str1 + ", " + str2; // result = Hola, Qué tal?
```


The `%` modulo operator calculates the remainder of the integer division. This can be useful for example to check if a number is even (If the remainder of the division by 2 is 0 it will be even, if it is 1 it will be odd).

```js
let num1 = 7;
let num2 = 2;

const result = num1 % num2; // result = 1
```


---

[![Basic Operators](https://img.youtube.com/vi/r1MW3omHpsU/0.jpg)](https://www.youtube.com/watch?v=r1MW3omHpsU&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

### **5.5. Flow control structures**

In the following topics we will delve into these concepts. But in essence, when we write our code we can decide whether to execute one line or another, or none at all using a conditional flow control structure. We can also decide to repeat blocks of code as many times as we want by using loops.

- **Conditional:**

```js
let age = 18;
if (age >= 18) {
  console.log("Eres mayor de edad");
} else {
  console.log("Eres menor de edad");
}
```


- **Loops:**

```js
for (let i = 0; i < 5; i++) {
  console.log("Número: " + i);
}

// Resultado por consola:
// Número 0
// Número 1
// Número 2
// Número 3
// Número 4
```


---

## **6. Console and debugging**

### **6.1. Basic methods of `console`**

- `console.log()`: Shows general messages.
- `console.warn()`: Shows warnings.
- `console.error()`: Shows errors.
- `console.table()`: Displays data in table format.

Example:

```js
console.table([
  { name: "Sara", age: 25 },
  { name: "Luis", age: 30 },
]);
```


---

[![Console.log and More](https://img.youtube.com/vi/Onhv6yP-oY4/0.jpg)](https://www.youtube.com/watch?v=Onhv6yP-oY4&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

### **6.2. Use of Breakpoints**

In the browser's developer tools, you can set **breakpoints** to pause execution and examine the program's status.

1. Open the **Sources** tab.
2. Find your JavaScript file.
3. Click the line number where you want to pause.
4. Refresh the page and watch it stop at the breakpoint.

---

[![Breakpoints](https://img.youtube.com/vi/mHrCe3gQ3SE/0.jpg)](https://www.youtube.com/watch?v=mHrCe3gQ3SE&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

## **7. Good practices in JavaScript**

- Use `let` and `const` instead of `var`.
- Name variables and functions descriptively (in English, using camelCase).
- Use `===` instead of `==` for strict comparisons.
- Comment the code when necessary.

---

## **8. Conclusion**

In this topic, we explore the fundamentals of JavaScript, its history, basic setup, and essential concepts. With this knowledge, you can now start writing your own simple programs.

In the next topic, we will delve into **conditionals** in JavaScript.
