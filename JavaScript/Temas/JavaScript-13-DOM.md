# **Tema 13: Manipulación del DOM en JavaScript**

## **1. Introducción**

El **DOM (Document Object Model)** es una representación estructurada de una página web que JavaScript puede manipular para cambiar contenido, estructura y estilos dinámicamente.

Con JavaScript podemos:

- Seleccionar elementos del DOM.
- Modificar su contenido y estilos.
- Crear, eliminar y mover elementos.
- Responder a eventos del usuario.

---

## **2. Seleccionar Elementos del DOM**

Existen varias formas para seleccionar un elemento del DOM.

### **2.1. `getElementById()`**

Selecciona un elemento por su `id`.

```html
<h1 id="main-title">Este es el Título</h1>
```

```js
const title = document.getElementById("main-title");
console.log(title.textContent);
```

### **2.2. `getElementsByClassName()`**

Selecciona elementos por su `class`. Devuelve una colección de elementos.

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

Selecciona elementos por su nombre de etiqueta.

```html
<p>Esto es un párrafo</p>
<p>Esto es otro párrafo</p>
```

```js
const paragraphs = document.getElementsByTagName("p");
console.log(paragraphs.length);
```

### **2.4. `querySelector()` y `querySelectorAll()`**

Es la manera recomanda de hacerlo, es más moderna y versátil, únicamente tenemos que utilizar los diferentes selectores CSS según necesitemos, pero las funciones `querySelector()` y `querySelectorAll()` se mantienen igual.

- `querySelector()`: selecciona el **primer** elemento que coincida con un selector CSS.
- `querySelectorAll()`: selecciona **todos** los elementos que coincidan.

```js
const firstItem = document.querySelector(".list-item");
const allItems = document.querySelectorAll(".list-item");
console.log(firstItem.textContent);
console.log(allItems.length);
```

---

## **3. Modificar el Contenido y Atributos**

Un elemento del DOM tiene muchos atributos diferentes a los que podemos acceder, vamos a ver algunos de los más utilizados.

### **3.1. `textContent` y `innerHTML`**

Representan el contenido de texto y el código html que está entre las etiquetas de cualquier elemento respectivamente.

```js
document.querySelector("#main-title").textContent = "Nuevo título";
document.querySelector("#content").innerHTML =
  "<strong>Texto en negrita</strong>";
```

### **3.2. Modificar atributos con `setAttribute()` y `getAttribute()`**

```js
const link = document.querySelector("a");
link.setAttribute("href", "https://www.google.com");
console.log(link.getAttribute("href"));
```

### **3.3. Modificar estilos con `style`**

Cuando accedemos directamente a la propiedad `style` debemos utilizar camelCase para el nombre de las propiedades CSS.

Esto puede venir bien para pequeños cambios de estilo, pero suele ser más recomendable añadir o quitar clases para la mayoría de cambios de estilo.

```js
document.body.style.backgroundColor = "lightblue";
```

### **3.4. Añadir o elminar clases**

Se pueden añadir o eliminar clases de los diferentes elementos del DOM dinámicamente, esto se puede utilizar para cambiar los estilos de una manera elegante.

```js
const container = document.querySelector(".container") as HTMLElement;

container.classList.add("big");
container.classList.remove("red");
```

---

## **4. Crear y Eliminar Elementos**

Se pueden crear y elminar elementos del DOM usando JavaScript con los siguientes métodos:

- `createElement()`: Crea un nuevo elemento.
- `appendChild()`: Añade un elemento creado a otro que tengamos seleccionado en una variable.
- `remove()`: Elimina un elemento del DOM.
- `replaceWith()`: Reemplaza un elemento.
- Propiedad `innerHTML`: Se puede utilizar para añadir o eliminar elementos escribiendo diréctamente el código HTML.

### **4.1. Crear elementos dinámicamente**

```js
const newElement = document.createElement("p");
newElement.textContent = "Este es un nuevo párrafo";
document.body.appendChild(newElement);
```

### **4.2. Eliminar elementos del DOM**

```js
const elementToRemove = document.querySelector("#old-element");
elementToRemove.remove();
```

### **4.3. Reemplazar un elemento**

```js
const newHeading = document.createElement("h2");
newHeading.textContent = "Nuevo subtítulo";
const oldHeading = document.querySelector("#main-title");
oldHeading.replaceWith(newHeading);
```

### **4.2. Modificar elementos del usando `innerHTML`**

```js
const container = document.querySelector("#container");
container.innerHTML =
  "<p><span>Código HTML insertado diréctamente al Contenedor</span></p>";
```

---

## **5. Manejo de Eventos**

Los eventos permiten que una página responda a las acciones del usuario. Existen multitud de eventos como `click` para cuando el usuario hace click con el ratón sobre un elemento o `input` para cuando se modifica un campo de un formulario.

### **5.1. Agregar eventos con `addEventListener()`**

```js
document.querySelector("#btn").addEventListener("click", () => {
  alert("Botón clickeado");
});
```

### **5.2. Eventos del teclado**

```js
document.addEventListener("keydown", (event) => {
  console.log("Tecla presionada:", event.key);
});
```

### **5.3. Eventos de formulario**

Cuando se envía un formulario el comportamiento por defecto es recargar la página, podemos evitar este comportamiento por defecto usando el objeto del evento, que en este caso se llama `event` y el método `preventDefault()`.

> Nota: El objeto del evento se puede llamar como queramos, habitualmente se les llama `event` o simplemente `e`.

```js
document.querySelector("#form").addEventListener("submit", (event) => {
  event.preventDefault();
  alert("Formulario enviado");
});
```

---

## **6. Conclusión**

JavaScript permite una manipulación dinámica del DOM, haciendo que las páginas sean interactivas y dinámicas. Con estas técnicas, podemos modificar elementos, agregar eventos y crear nuevas estructuras dentro del documento.

En el siguiente tema veremos como podemos utilizar el **localStorage** y el **sessionStorage** para almacenar información en el cliente.
