# **Exercises - Topic 13: DOM Manipulation in JavaScript**

Below you will find 10 practical exercises on how to select, modify and manipulate the DOM in JavaScript.

Try to solve them before consulting the solution.

---

### **Exercise 1: Select an element by its `id` and change its text**

Select an element with `id="header-title"` and change its text to "New Header".

<details><summary>Show solution</summary>

```js
document.getElementById("header-title").textContent = "Nuevo Encabezado";
```

</details>

---

### **Exercise 2: Select multiple elements by `class` and change their color**

Select all elements with class `item` and change their text color to red.

<details><summary>Show solution</summary>

```js
const items = document.getElementsByClassName("item");
for (let item of items) {
  item.style.color = "red";
}
```

</details>

---

### **Exercise 3: Add a new paragraph to an existing `div`**

Create a new `<p>` element, add some text and add it inside an `div` with `id="container"`.

<details><summary>Show solution</summary>

```js
const newParagraph = document.createElement("p");
newParagraph.textContent = "Este es un nuevo párrafo";
document.getElementById("container").appendChild(newParagraph);
```

</details>

---

### **Exercise 4: Modify a link attribute**

Change the `href` of a link with `id="link"` to point to `https://www.example.com`.

<details><summary>Show solution</summary>

```js
document.getElementById("link").setAttribute("href", "https://www.example.com");
```

</details>

---

### **Exercise 5: Toggle a class on an element on click**

Create a button with `id="toggle-btn"` and have it add or remove the `active` class from an `div` with `id="box"` when clicked.

<details><summary>Show solution</summary>

```js
document.getElementById("toggle-btn").addEventListener("click", () => {
  document.getElementById("box").classList.toggle("active");
});
```

</details>

---

### **Exercise 6: Delete an element from the DOM**

Removes an element with `id="remove-me"` from the DOM.

<details><summary>Show solution</summary>

```js
document.getElementById("remove-me").remove();
```

</details>

---

### **Exercise 7: Create a dynamic list and add elements**

Create a function that adds a new `li` to a list with `id="my-list"` each time it is called.

<details><summary>Show solution</summary>

```js
function addListItem() {
  const newItem = document.createElement("li");
  newItem.textContent = "Nuevo ítem";
  document.getElementById("my-list").appendChild(newItem);
}
```

</details>

---

### **Exercise 8: Detect keyboard events and display the key pressed**

Shows on an `div` with `id="key-output"` the key pressed by the user.

<details><summary>Show solution</summary>

```js
document.addEventListener("keydown", (event) => {
  document.getElementById("key-output").textContent =
    `Tecla presionada: ${event.key}`;
});
```

</details>

---

### **Exercise 9: Change the image of an `img` tag**

Change the image of an `img` tag with `id="image"` to a new `https://some-image.jpg` URL.

<details><summary>Show solution</summary>

```js
document.getElementById("image").src = "https://some-image.jpg";
```

</details>

---

### **Exercise 10: Validate an input field and display a message**

Create an input field with `id="username"` and a button with `id="validate-btn"`. If the user has not entered anything in the field, it displays an error message on an `div` with `id="error-msg"`.

<details><summary>Show solution</summary>

```js
document.getElementById("validate-btn").addEventListener("click", () => {
  const input = document.getElementById("username");
  const errorMsg = document.getElementById("error-msg");
  if (input.value.trim() === "") {
    errorMsg.textContent = "El campo no puede estar vacío";
    errorMsg.style.color = "red";
  } else {
    errorMsg.textContent = "";
  }
});
```

</details>
