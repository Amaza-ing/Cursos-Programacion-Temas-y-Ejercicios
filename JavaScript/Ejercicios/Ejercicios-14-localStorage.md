# **Exercises - Topic 14: Client-Side Storage with `localStorage` and `sessionStorage`**

Below you'll find 5 practical exercises on how to use `localStorage` and `sessionStorage` in JavaScript.

Try to solve them before looking at the solution.

---

### **Exercise 1: Save and retrieve a username in `localStorage`**

Create a function that stores a username entered by the user in `localStorage` and another function that retrieves it and displays it in the console.

<details><summary>Show solution</summary>

```js
function saveUsername(name) {
  localStorage.setItem("username", name);
}

function getUsername() {
  console.log(localStorage.getItem("username"));
}

saveUsername("Juan Pérez");
getUsername(); // Salida: "Juan Pérez"
```

</details>

---

### **Exercise 2: Click counter with `localStorage`**

Create a button in HTML with `id="click-btn"` that counts how many times it has been clicked and stores that value in `localStorage` so it persists between sessions.

<details><summary>Show solution</summary>

```js
let count = localStorage.getItem("clicks") || 0;

document.getElementById("click-btn").addEventListener("click", () => {
  count++;
  localStorage.setItem("clicks", count);
  console.log(`Botón presionado ${count} veces`);
});
```

</details>

---

### **Exercise 3: Save and retrieve user preferences with `sessionStorage`**

Create a form with a `select` to choose a background color. Save the preference in `sessionStorage` and apply it to the page when it loads.

<details><summary>Show solution</summary>

```js
function saveTheme(color) {
  sessionStorage.setItem("themeColor", color);
  document.body.style.backgroundColor = color;
}

function loadTheme() {
  const savedColor = sessionStorage.getItem("themeColor");
  if (savedColor) {
    document.body.style.backgroundColor = savedColor;
  }
}

document
  .getElementById("color-selector")
  .addEventListener("change", (event) => {
    saveTheme(event.target.value);
  });

loadTheme();
```

</details>

---

### **Exercise 4: Store and retrieve a task list in `localStorage`**

Create a function that lets you add tasks to a list and save them in `localStorage`, making sure the tasks persist between sessions.

<details><summary>Show solution</summary>

```js
function addTask(task) {
  let tasks = JSON.parse(localStorage.getItem("tasks")) || [];
  tasks.push(task);
  localStorage.setItem("tasks", JSON.stringify(tasks));
}

function getTasks() {
  console.log(JSON.parse(localStorage.getItem("tasks")) || []);
}

addTask("Comprar leche");
addTask("Hacer ejercicio");
getTasks();
```

</details>

---

### **Exercise 5: Delete data stored in `localStorage` and `sessionStorage`**

Create two buttons in HTML that clear `localStorage` and `sessionStorage` when clicked.

<details><summary>Show solution</summary>

```js
document.getElementById("clear-local").addEventListener("click", () => {
  localStorage.clear();
  console.log("localStorage limpiado");
});

document.getElementById("clear-session").addEventListener("click", () => {
  sessionStorage.clear();
  console.log("sessionStorage limpiado");
});
```

</details>
