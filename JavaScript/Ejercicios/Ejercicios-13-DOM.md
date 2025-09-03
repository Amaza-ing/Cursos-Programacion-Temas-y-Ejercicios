# **Ejercicios - Tema 13: Manipulación del DOM en JavaScript**

A continuación, encontrarás 10 ejercicios prácticos sobre cómo seleccionar, modificar y manipular el DOM en JavaScript.

Intenta resolverlos antes de consultar la solución.

---

### **Ejercicio 1: Seleccionar un elemento por su `id` y cambiar su texto**

Selecciona un elemento con `id="header-title"` y cambia su texto a "Nuevo Encabezado".

<details><summary>Mostrar solución</summary>

```js
document.getElementById("header-title").textContent = "Nuevo Encabezado";
```

</details>

---

### **Ejercicio 2: Seleccionar múltiples elementos por `class` y cambiar su color**

Selecciona todos los elementos con la clase `item` y cambia su color de texto a rojo.

<details><summary>Mostrar solución</summary>

```js
const items = document.getElementsByClassName("item");
for (let item of items) {
  item.style.color = "red";
}
```

</details>

---

### **Ejercicio 3: Agregar un nuevo párrafo a un `div` existente**

Crea un nuevo elemento `<p>`, agrega un texto y añádelo dentro de un `div` con `id="container"`.

<details><summary>Mostrar solución</summary>

```js
const newParagraph = document.createElement("p");
newParagraph.textContent = "Este es un nuevo párrafo";
document.getElementById("container").appendChild(newParagraph);
```

</details>

---

### **Ejercicio 4: Modificar un atributo de un enlace**

Cambia el `href` de un enlace con `id="link"` para que apunte a `https://www.example.com`.

<details><summary>Mostrar solución</summary>

```js
document.getElementById("link").setAttribute("href", "https://www.example.com");
```

</details>

---

### **Ejercicio 5: Alternar una clase en un elemento al hacer clic**

Crea un botón con `id="toggle-btn"` y haz que al hacer clic agregue o elimine la clase `active` de un `div` con `id="box"`.

<details><summary>Mostrar solución</summary>

```js
document.getElementById("toggle-btn").addEventListener("click", () => {
  document.getElementById("box").classList.toggle("active");
});
```

</details>

---

### **Ejercicio 6: Eliminar un elemento del DOM**

Elimina un elemento con `id="remove-me"` del DOM.

<details><summary>Mostrar solución</summary>

```js
document.getElementById("remove-me").remove();
```

</details>

---

### **Ejercicio 7: Crear una lista dinámica y añadir elementos**

Crea una función que agregue un nuevo `li` a una lista con `id="my-list"` cada vez que se llame.

<details><summary>Mostrar solución</summary>

```js
function addListItem() {
  const newItem = document.createElement("li");
  newItem.textContent = "Nuevo ítem";
  document.getElementById("my-list").appendChild(newItem);
}
```

</details>

---

### **Ejercicio 8: Detectar eventos de teclado y mostrar la tecla presionada**

Muestra en un `div` con `id="key-output"` la tecla presionada por el usuario.

<details><summary>Mostrar solución</summary>

```js
document.addEventListener("keydown", (event) => {
  document.getElementById("key-output").textContent =
    `Tecla presionada: ${event.key}`;
});
```

</details>

---

### **Ejercicio 9: Cambiar la imagen de una etiqueta `img`**

Cambia la imagen de una etiqueta `img` con `id="image"` a una nueva URL `https://some-image.jpg`.

<details><summary>Mostrar solución</summary>

```js
document.getElementById("image").src = "https://some-image.jpg";
```

</details>

---

### **Ejercicio 10: Validar un campo de entrada y mostrar un mensaje**

Crea un campo de entrada con `id="username"` y un botón con `id="validate-btn"`. Si el usuario no ha escrito nada en el campo, muestra un mensaje de error en un `div` con `id="error-msg"`.

<details><summary>Mostrar solución</summary>

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
