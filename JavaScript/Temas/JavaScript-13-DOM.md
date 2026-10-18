# **Topic 13: DOM Manipulation in JavaScript**

## **1. Introduction**

The **DOM (Document Object Model)** is a structured representation of a web page that JavaScript can manipulate to change its content, structure and styles dynamically.

With JavaScript we can:

- Select DOM elements.
- Modify their content and styles.
- Create, delete and move elements.
- Respond to user events.

> Note: Before we start testing DOM manipulation code, we must tell the browser to wait for the HTML to load before loading the JavaScript. We can do this by adding the `defer` attribute to the `<script>` tag in the .html file:

> `<script defer></script>`

---

## **2. Selecting DOM elements**

There are several ways to select a DOM element.

### **2.1. `getElementById()`**

Selects an element by its `id`.

```html
<h1 id="main-title">Este es el Título</h1>
```

```js
const title = document.getElementById("main-title");
console.log(title.textContent);
```

### **2.2. `getElementsByClassName()`**

Selects elements by their `class`. It returns a collection of elements.

```html
<ul>
  <li class="list-item">Elemento 1</li>
  <li class="list-item">Elemento 2</li>
  <li class="list-item">Elemento 3</li>
</ul>
```

```js
const items = document.getElementsByClassName("list-item");
console.log(items[0].textContent);
```

### **2.3. `getElementsByTagName()`**

Selects elements by their tag name.

```html
<p>Esto es un párrafo</p>
<p>Esto es otro párrafo</p>
```

```js
const paragraphs = document.getElementsByTagName("p");
console.log(paragraphs.length);
```

### **2.4. `querySelector()` and `querySelectorAll()`**

This is the recommended way to do it: it's more modern and versatile. We just have to use the different CSS selectors as needed, while the functions `querySelector()` and `querySelectorAll()` stay the same.

- `querySelector()`: selects the **first** element that matches a CSS selector.
- `querySelectorAll()`: selects **all** the matching elements.

```js
const firstItem = document.querySelector(".list-item");
const allItems = document.querySelectorAll(".list-item");
console.log(firstItem.textContent);
console.log(allItems.length);
```

---

[![Selecting DOM elements](https://img.youtube.com/vi/nB6KHr9U6mE/0.jpg)](https://www.youtube.com/watch?v=nB6KHr9U6mE&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

## **3. Modifying content and attributes**

A DOM element has many different attributes we can access; let's look at some of the most commonly used ones.

### **3.1. `textContent` and `innerHTML`**

They represent, respectively, the text content and the HTML code between the tags of any element.

```js
document.querySelector("#main-title").textContent = "Nuevo título";
document.querySelector("#content").innerHTML =
  "<strong>Texto en negrita</strong>";
```

### **3.2. Modifying attributes with `setAttribute()` and `getAttribute()`**

```js
const link = document.querySelector("a");
link.setAttribute("href", "https://www.google.com");
console.log(link.getAttribute("href"));
```

### **3.3. Modifying styles with `style`**

When we access the `style` property directly, we must use camelCase for the names of the CSS properties.

This can be handy for small style changes, but for most style changes it's usually better to add or remove classes.

```js
document.body.style.backgroundColor = "lightblue";
```

### **3.4. Adding or removing classes**

You can add or remove classes on different DOM elements dynamically, which is an elegant way to change styles.

```js
const container = document.querySelector(".container") as HTMLElement;

container.classList.add("big");
container.classList.remove("red");
```

---

[![DOM element manipulation](https://img.youtube.com/vi/Qh3PDWMl1iM/0.jpg)](https://www.youtube.com/watch?v=Qh3PDWMl1iM&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

## **4. Creating and deleting elements**

You can create and delete DOM elements using JavaScript with the following methods:

- `createElement()`: Creates a new element.
- `appendChild()`: Adds a created element to another one that we have selected in a variable.
- `remove()`: Removes an element from the DOM.
- `replaceWith()`: Replaces an element.
- The `innerHTML` property: It can be used to add or remove elements by writing the HTML code directly.

### **4.1. Creating elements dynamically**

```js
const newElement = document.createElement("p");
newElement.textContent = "Este es un nuevo párrafo";
document.body.appendChild(newElement);
```

### **4.2. Removing elements from the DOM**

```js
const elementToRemove = document.querySelector("#old-element");
elementToRemove.remove();
```

### **4.3. Replacing an element**

```js
const newHeading = document.createElement("h2");
newHeading.textContent = "Nuevo subtítulo";
const oldHeading = document.querySelector("#main-title");
oldHeading.replaceWith(newHeading);
```

### **4.4. Modifying elements using `innerHTML`**

```js
const container = document.querySelector("#container");
container.innerHTML =
  "<p><span>Código HTML insertado diréctamente al Contenedor</span></p>";
```

---

[![Creating DOM elements](https://img.youtube.com/vi/fFF77mgl6_Q/0.jpg)](https://www.youtube.com/watch?v=fFF77mgl6_Q&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

## **5. Event handling**

Events let a page respond to user actions. There are lots of events, such as `click`, for when the user clicks an element with the mouse, or `input`, for when a form field is modified.

### **5.1. Adding events with `addEventListener()`**

```js
document.querySelector("#btn").addEventListener("click", () => {
  alert("Botón clickeado");
});
```

### **5.2. Keyboard events**

```js
document.addEventListener("keydown", (event) => {
  console.log("Tecla presionada:", event.key);
});
```

### **5.3. Form events**

When a form is submitted, the default behavior is to reload the page. We can prevent this default behavior by using the event object, which in this case is called `event`, and its `preventDefault()` method.

> Note: You can give the event object any name you want; it's usually called `event` or simply `e`.

```js
document.querySelector("#form").addEventListener("submit", (event) => {
  event.preventDefault();
  alert("Formulario enviado");
});
```

---

[![Events](https://img.youtube.com/vi/PRUiwhjkGbc/0.jpg)](https://www.youtube.com/watch?v=PRUiwhjkGbc&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

[![Dynamic web, part 1](https://img.youtube.com/vi/UY18JrstVzk/0.jpg)](https://www.youtube.com/watch?v=UY18JrstVzk&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

[![Dynamic web, part 2](https://img.youtube.com/vi/tdPG9lezPsk/0.jpg)](https://www.youtube.com/watch?v=tdPG9lezPsk&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

## **6. Conclusion**

JavaScript lets you manipulate the DOM dynamically, making pages interactive and dynamic. With these techniques, we can modify elements, add events and create new structures within the document.

In the next topic, we'll see how to use **localStorage** and **sessionStorage** to store information on the client.
