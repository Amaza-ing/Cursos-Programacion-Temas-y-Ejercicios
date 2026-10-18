# **Topic 1: Introduction to JavaScript**

## **1. What is JavaScript?**

JavaScript is an interpreted, object-oriented, prototype-based programming language. It is one of the essential languages of web development, along with HTML and CSS, and it lets you create dynamic, interactive web pages.

### **Key features of JavaScript:**

- **Interpreted language:** It doesn't need to be compiled beforehand.
- **Cross-platform:** It works in most modern web browsers.
- **Object-oriented:** It uses objects and prototypes to structure the code.
- **Event-driven:** It lets you respond to user actions, such as clicks and key presses.
- **DOM manipulation:** It can access and modify the content and structure of web pages.

---

## **2. History and evolution of JavaScript**

- **1995:** JavaScript was created by Brendan Eich at Netscape.
- **1997:** It was standardized under the name ECMAScript.
- **ECMAScript 6 (2015):** It introduced modern features such as `let`, `const`, classes and arrow functions.
- **Today:** JavaScript keeps evolving with a new version of ECMAScript every year.

---

## **3. Installing and setting up the environment**

To start programming in JavaScript, you don't need to install complex tools. All you need is:

### **Basic requirements:**

1. **Web browser:** Chrome, Firefox, Edge or Safari.
2. **Code editor:** Visual Studio Code, Sublime Text or any other editor.

### **Installing Node.js (optional)**

If you want to run JavaScript code outside the browser:

1. Download and install Node.js from [nodejs.org](https://nodejs.org/).
2. Check the installation by running this in the terminal:

```sh
node -v
npm -v
```


---

[![How to get started with JavaScript](https://img.youtube.com/vi/lD8C0NVmn7A/0.jpg)](https://www.youtube.com/watch?v=lD8C0NVmn7A&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

## **4. Writing your first JavaScript program**

Let's create a simple program that displays a message in the console.

### **Option 1: Using the browser**

1. Open your web browser.
2. Right-click anywhere on the page and select "Inspect" or "Inspect Element."
3. Go to the **Console** tab.
4. Type the following code and press **Enter**:

```js
console.log("¡Hola, mundo!");
```


You should see the message "¡Hola, mundo!" in the console.

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


2. Open the file in your browser (in VS Code you can install the `Live Server` extension and then click the `Go Live` button at the bottom right).
3. Go to the browser console to see the message.

### **Option 3: Using a JS file**

Create a new file with the extension `.js`. Example: `main.js`

Modify the HTML file so that it links the JavaScript file, once again with the `<script src="main.js">` tag, putting the path to the `main.js` file in the `src` attribute.

```html
<head>
  <script src="main.js"></script>
</head>
```


> Note: This is the recommended way of working with JavaScript

---

## **5. Basic JavaScript syntax**

### **5.1. Variables**

Variables are data, that is, information, stored under a specific name.

In JavaScript you can declare variables using `var`, `let` or `const`:

```js
let name = "Sara";
const pi = 3.1416;
var oldVariable = "Usado antes de ES6";
```


- **`let`**: Used to declare variables that can change.
- **`const`**: Declares constants that can't be reassigned.
- **`var`**: Obsolete; avoid using it.

---

[![Variables](https://img.youtube.com/vi/NtFNodPjfh0/0.jpg)](https://www.youtube.com/watch?v=NtFNodPjfh0&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

### **5.2. Data types**

- **String:** Text strings. They go in quotes. Example: `"Hola"`.
- **Number:** Numbers. Example: `42`, `3.14`.
- **Boolean:** Logical values. Example: `true`, `false`.
- **Array:** Lists of elements. They go in square brackets. Example: `[1, 2, 3]`.
- **Object:** Collections of key-value pairs. They go in curly braces. Example:

```js
const user = {
  name: "Sara",
  age: 25,
};
```


---

[![Typing](https://img.youtube.com/vi/m8-g18kKjg8/0.jpg)](https://www.youtube.com/watch?v=m8-g18kKjg8&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

### **5.3 Strings in JavaScript**

A **string** in JavaScript is a sequence of characters used to represent text. Strings are one of the most widely used primitive data types, and there are several ways to create them.

---

### **Ways to create strings**

#### **1. Using single quotes (`'`)**

Lets you create a simple string by enclosing the text in single quotes.

```js
const singleQuoteString = "Hola, mundo";
console.log(singleQuoteString); // Salida: Hola, mundo
```


**Advantages:**

- Simple and direct.

**Disadvantages:**

- If the text contains apostrophes, you need to escape them with `\`.

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

- They allow variable interpolation using `${}`.
- They support multiple lines without needing special characters.

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

#### **Comparison of the ways to create strings**

| Method | Interpolation | Multiline | Needs escaping |
| ---------------------- | ------------- | ---------- | --------------- |
| Single quotes (`'`) | ❌ | ❌ | Yes |
| Double quotes (`"`) | ❌ | ❌ | Yes |
| Backticks (`` ` ``) | ✅ | ✅ | No |

**Recommendation:**

- Use **Template Literals** when you need interpolation or multiple lines.
- Use single or double quotes for simple strings, depending on the content.

---

### **Concatenation**

- You can concatenate several strings **using `+`**:

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

#### **Useful methods for strings**

We'll talk about functions later on, but we should know a few useful, easy-to-use methods for strings.

Any string variable we create can use these methods with dot "." syntax: `variableName.method()`.

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


- `includes()`: Checks whether a text contains a substring.

  ```js
  console.log(text.includes("la")); // Salida: true
  ```


- `replace()`: Replaces one substring with another.

  ```js
  console.log(text.replace("Hola", "Adiós")); // Salida: Adiós
  ```


- `trim()`: Removes spaces at the beginning and end.
  ```js
  const spaced = "  Hola  ";
  console.log(spaced.trim()); // Salida: Hola
  ```


---

JavaScript offers multiple ways to create and manipulate strings. Choosing the right one depends on the context and on whether you need interpolation or formatting. With **Template Literals**, creating dynamic and multiline strings is simpler and clearer.

---

[![Strings](https://img.youtube.com/vi/Bi-DguuLtac/0.jpg)](https://www.youtube.com/watch?v=Bi-DguuLtac&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

### **5.4. Basic operators**

You can easily perform basic mathematical and logical operations using operators.

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


The modulo operator `%` calculates the remainder of an integer division. This can be useful, for example, to check whether a number is even (if the remainder of dividing it by 2 is 0, it's even; if it's 1, it's odd).

```js
let num1 = 7;
let num2 = 2;

const result = num1 % num2; // result = 1
```


---

[![Basic Operators](https://img.youtube.com/vi/r1MW3omHpsU/0.jpg)](https://www.youtube.com/watch?v=r1MW3omHpsU&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

### **5.5. Control flow structures**

We'll go deeper into these concepts in the following topics. But in essence, when we write our code we can decide whether one line or another runs, or none at all, using a conditional control flow structure. We can also repeat blocks of code as many times as we want by using loops.

- **Conditionals:**

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

### **6.2. Using breakpoints**

In the browser's developer tools, you can set **breakpoints** to pause execution and examine the program's state.

1. Open the **Sources** tab.
2. Find your JavaScript file.
3. Click the line number where you want to pause.
4. Reload the page and watch it stop at the breakpoint.

---

[![Breakpoints](https://img.youtube.com/vi/mHrCe3gQ3SE/0.jpg)](https://www.youtube.com/watch?v=mHrCe3gQ3SE&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

## **7. Best practices in JavaScript**

- Use `let` and `const` instead of `var`.
- Name variables and functions descriptively (in English, using camelCase).
- Use `===` instead of `==` for strict comparisons.
- Comment the code when necessary.

---

## **8. Conclusion**

In this topic, we explored the fundamentals of JavaScript, its history, basic setup and essential concepts. With this knowledge, you can now start writing your own simple programs.

In the next topic, we'll take a closer look at **conditionals** in JavaScript.
