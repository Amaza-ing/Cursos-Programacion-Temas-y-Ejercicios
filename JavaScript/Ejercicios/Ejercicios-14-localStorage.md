# **Ejercicios - Tema 14: Almacenamiento en el Cliente con `localStorage` y `sessionStorage`**

A continuación, encontrarás 5 ejercicios prácticos sobre cómo utilizar `localStorage` y `sessionStorage` en JavaScript.

Intenta resolverlos antes de consultar la solución.

---

### **Ejercicio 1: Guardar y recuperar un nombre de usuario en `localStorage`**

Crea una función que almacene un nombre de usuario ingresado por el usuario en `localStorage` y otra función que lo recupere y lo muestre en la consola.

<details><summary>Mostrar solución</summary>

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

### **Ejercicio 2: Contador de clics con `localStorage`**

Crea un botón en HTML con `id="click-btn"` que cuente cuántas veces ha sido presionado y almacene ese valor en `localStorage` para persistencia entre sesiones.

<details><summary>Mostrar solución</summary>

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

### **Ejercicio 3: Guardar y recuperar preferencias del usuario con `sessionStorage`**

Crea un formulario con un `select` para elegir un color de fondo. Guarda la preferencia en `sessionStorage` y aplícala a la página al cargar.

<details><summary>Mostrar solución</summary>

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

### **Ejercicio 4: Almacenar y recuperar una lista de tareas en `localStorage`**

Crea una función que permita agregar tareas a una lista y guardarlas en `localStorage`, asegurando que las tareas persistan entre sesiones.

<details><summary>Mostrar solución</summary>

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

### **Ejercicio 5: Eliminar datos almacenados en `localStorage` y `sessionStorage`**

Crea dos botones en HTML para limpiar el almacenamiento de `localStorage` y `sessionStorage` al hacer clic en ellos.

<details><summary>Mostrar solución</summary>

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
