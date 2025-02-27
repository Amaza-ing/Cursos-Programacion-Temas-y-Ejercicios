# **Ejercicios - Tema 8: Diseño con CSS Grid**

## **Instrucciones:**
A continuación, encontrarás 5 ejercicios prácticos sobre CSS Grid.

Intenta resolverlos antes de consultar la solución.

---

### **Ejercicio 1: Crear una cuadrícula básica**

Crea un contenedor con 3 columnas de igual tamaño y 2 filas.

<details><summary>Mostrar solución</summary>

```css
.container {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    grid-template-rows: repeat(2, 100px);
    gap: 10px;
    background-color: lightgray;
}

.item {
    background-color: lightblue;
    border: 1px solid #000;
    text-align: center;
    line-height: 100px;
}
```
```html
<div class="container">
  <div class="item">1</div>
  <div class="item">2</div>
  <div class="item">3</div>
  <div class="item">4</div>
  <div class="item">5</div>
  <div class="item">6</div>
</div>
```

</details>

---

### **Ejercicio 2: Combinar celdas**

Crea un `div` que ocupe dos columnas en una cuadrícula de 3x2.

<details><summary>Mostrar solución</summary>

```css
.container {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    grid-template-rows: repeat(2, 100px);
    gap: 10px;
}

.item1 {
    grid-column: 1 / 3;
    background-color: salmon;
    text-align: center;
    line-height: 100px;
}

.item {
    background-color: lightblue;
    text-align: center;
    line-height: 100px;
}
```
```html
<div class="container">
  <div class="item1">1</div>
  <div class="item">2</div>
  <div class="item">3</div>
  <div class="item">4</div>
  <div class="item">5</div>
</div>
```

</details>

---

### **Ejercicio 3: Usar `grid-template-areas`**

Crea un diseño con áreas definidas para `header`, `sidebar`, `content` y `footer`.

<details><summary>Mostrar solución</summary>

```css
.container {
    display: grid;
    grid-template-areas:
        "header header"
        "sidebar content"
        "footer footer";
    grid-template-columns: 1fr 3fr;
    grid-template-rows: auto 1fr auto;
    gap: 10px;
}

.header {
    grid-area: header;
    background-color: lightcoral;
    text-align: center;
}

.sidebar {
    grid-area: sidebar;
    background-color: lightgreen;
}

.content {
    grid-area: content;
    background-color: lightblue;
}

.footer {
    grid-area: footer;
    background-color: lightgray;
    text-align: center;
}
```
```html
<div class="container">
  <div class="header">Header</div>
  <div class="sidebar">Sidebar</div>
  <div class="content">Content</div>
  <div class="footer">Footer</div>
</div>
```

</details>

---

### **Ejercicio 4: Alinear elementos en la cuadrícula**

Crea una cuadrícula donde los elementos estén centrados tanto horizontal como verticalmente.

<details><summary>Mostrar solución</summary>

```css
.container {
    display: grid;
    grid-template-columns: repeat(3, 100px);
    grid-template-rows: repeat(3, 100px);
    justify-items: center;
    align-items: center;
    gap: 10px;
}

.item {
    background-color: lightblue;
    text-align: center;
    width: 50px;
    height: 50px;
    line-height: 50px;
}
```
```html
<div class="container">
  <div class="item">1</div>
  <div class="item">2</div>
  <div class="item">3</div>
  <div class="item">4</div>
  <div class="item">5</div>
  <div class="item">6</div>
  <div class="item">7</div>
  <div class="item">8</div>
  <div class="item">9</div>
</div>
```

</details>

---

### **Ejercicio 5: Crear un diseño responsivo con `auto-fit`**

Usa `auto-fit` para crear una cuadrícula flexible que se ajuste al tamaño de la pantalla.

<details><summary>Mostrar solución</summary>

```css
.container {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
    gap: 10px;
}

.item {
    background-color: lightblue;
    text-align: center;
    padding: 20px;
}
```
```html
<div class="container">
  <div class="item">1</div>
  <div class="item">2</div>
  <div class="item">3</div>
  <div class="item">4</div>
  <div class="item">5</div>
  <div class="item">6</div>
</div>
```

</details>