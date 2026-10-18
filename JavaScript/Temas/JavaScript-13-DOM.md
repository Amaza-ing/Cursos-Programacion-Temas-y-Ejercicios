# **Topic 13: DOM Manipulation in JavaScript**

## **1. Introduction**

The **DOM (Document Object Model)** is a structured representation of a web page that JavaScript can manipulate to change content, structure, and styles dynamically.

With JavaScript we can:

- Select DOM elements.
- Modify its content and styles.
- Create, delete and move items.
- Respond to user events.

> Note: Before we start testing the DOM manipulation code we must tell the browser to wait for the HTML to be loaded before loading the JavaScript. We can do this by adding the attribute `defer` to the label `<script>` in the .html file:

> `<script defer></script>`

---

## **2. Select DOM Elements**

There are several ways to select a DOM element.

### **2.1. `getElementById()`**

Select an element by its `id`.

```html
<h1 id="main-title">Este es el Título</h1>
```

```js
const title = document.getElementById("main-title");
console.log(title.textContent);
```

### **2.2. `getElementsByClassName()`**

Select elements by their `class`. Returns a collection of elements.

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

Select items by their tag name.

```html
<p>Esto es un párrafo</p>
<p>Esto es otro párrafo</p>
```

```js
const paragraphs = document.getElementsByTagName("p");
console.log(paragraphs.length);
```

### **2.4. `querySelector()` and `querySelectorAll()`**

It is the recommended way to do it, it is more modern and versatile, we only have to use the different CSS selectors as needed, but the functions `querySelector()` and `querySelectorAll()` they stay the same.

- `querySelector()`- Selects the **first** element that matches a CSS selector.
- `querySelectorAll()`- Select **all** matching items.

```js
const firstItem = document.querySelector(".list-item");
const allItems = document.querySelectorAll(".list-item");
console.log(firstItem.textContent);
console.log(allItems.length);
```

---

[![Select DOM Elements](https://img.youtube.com/vi/nB6KHr9U6mE/0.jpg)](https://www.youtube.com/watch?v=nB6KHr9U6mE&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

## **3. Modify Content and Attributes**

A DOM element has many different attributes that we can access, let's look at some of the most used ones.

### **3.1. `textContent` and `innerHTML`**

They represent the text content and the html code that is between the tags of any element respectively.

```js
document.querySelector("#main-title").textContent = "Nuevo título";
document.querySelector("#content").innerHTML =
  "<strong>Texto en negrita</strong>";
```

### **3.2. Modify attributes with `setAttribute()` and `getAttribute()`**

```js
const link = document.querySelector("a");
link.setAttribute("href", "https://www.google.com");
console.log(link.getAttribute("href"));
```

### **3.3. Modify styles with `style`**

When we directly access the property `style` we must use camelCase for the name of the CSS properties.

This can be good for small style changes, but it is usually more advisable to add or remove classes for most style changes.

```js
document.body.style.backgroundColor = "lightblue";
```

### **3.4. Add or delete classes**

Classes can be added or removed from different DOM elements dynamically, this can be used to change styles in an elegant way.

```js
const container = document.querySelector(".container") as HTMLElement;

container.classList.add("big");
container.classList.remove("red");
```

---

[![DOM Element Manipulation](https://img.youtube.com/vi/Qh3PDWMl1iM/0.jpg)](https://www.youtube.com/watch?v=Qh3PDWMl1iM&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

## **4. Create and Delete Elements**

DOM elements can be created and deleted using JavaScript with the following methods:

- `createElement()`: Create a new item.
- `appendChild()`: Adds a created element to another that we have selected in a variable.
- `remove()`: Removes an element from the DOM.
- `replaceWith()`: Replaces an element.
- Property `innerHTML`: It can be used to add or remove elements by directly writing the HTML code.

### **4.1. Create elements dynamically**

```js
const newElement = document.createElement("p");
newElement.textContent = "Este es un nuevo párrafo";
document.body.appendChild(newElement);
```

### **4.2. Remove elements from the DOM**

```js
const elementToRemove = document.querySelector("#old-element");
elementToRemove.remove();
```

### **4.3. Replace an element**

```js
const newHeading = document.createElement("h2");
newHeading.textContent = "Nuevo subtítulo";
const oldHeading = document.querySelector("#main-title");
oldHeading.replaceWith(newHeading);
```

### **4.2. Modify elements of the using `innerHTML`**

```js
const container = document.querySelector("#container");
container.innerHTML =
  "<p><span>Código HTML insertado diréctamente al Contenedor</span></p>";
```

---

[![Creating DOM Elements](https://img.youtube.com/vi/fFF77mgl6_Q/0.jpg)](https://www.youtube.com/watch?v=fFF77mgl6_Q&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

## **5. Event Management**

Events allow a page to respond to user actions. There are many events such as `click` for when the user clicks with the mouse on an element or `input` for when a form field is modified.

### **5.1. Add events with `addEventListener()`**

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

### **5.3. Form Events**

When a form is submitted the default behavior is to reload the page, we can avoid this default behavior by using the event object, which in this case is called `event` and the method `preventDefault()`.

> Note: The event object can be called whatever we want, usually they are called `event` or simply `e`.

```js
document.querySelector("#form").addEventListener("submit", (event) => {
  event.preventDefault();
  alert("Formulario enviado");
});
```

---

[![Events](https://img.youtube.com/vi/PRUiwhjkGbc/0.jpg)](https://www.youtube.com/watch?v=PRUiwhjkGbc&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

[![Dynamic Web part 1](https://img.youtube.com/vi/UY18JrstVzk/0.jpg)](https://www.youtube.com/watch?v=UY18JrstVzk&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

[![Dynamic Web part 2](https://img.youtube.com/vi/tdPG9lezPsk/0.jpg)](https://www.youtube.com/watch?v=tdPG9lezPsk&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

## **6. Conclusion**

JavaScript allows dynamic manipulation of the DOM, making pages interactive and dynamic. With these techniques, we can modify elements, add events and create new structures within the document.

In the next topic we will see how we can use the **localStorage** and the **sessionStorage** to store information on the client.
