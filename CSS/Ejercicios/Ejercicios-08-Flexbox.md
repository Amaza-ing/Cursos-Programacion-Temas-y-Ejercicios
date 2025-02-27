# **Ejercicios - Tema 7: Diseño con Flexbox en CSS**

## **Instrucciones:**

A continuación, encontrarás 7 ejercicios prácticos sobre Flexbox en CSS.

Intenta resolverlos antes de consultar la solución.

---

### **Ejercicio 1: Crear un contenedor flexible**

Crea un contenedor con `display: flex` y tres elementos hijos.

<details><summary>Mostrar solución</summary>

```css
.container {
  display: flex;
  background-color: lightgray;
}
.item {
  width: 100px;
  height: 100px;
  background-color: steelblue;
  margin: 10px;
}
```

```html
<div class="container">
  <div class="item"></div>
  <div class="item"></div>
  <div class="item"></div>
</div>
```

</details>

---

### **Ejercicio 2: Alinear elementos con `justify-content`**

Alinea los elementos del contenedor al centro horizontalmente usando `justify-content`.

<details><summary>Mostrar solución</summary>

```css
.container {
  display: flex;
  justify-content: center;
}
```

```html
<div class="container">
  <div class="item"></div>
  <div class="item"></div>
  <div class="item"></div>
</div>
```

</details>

---

### **Ejercicio 3: Alinear elementos en el eje vertical**

Alinea los elementos en el centro verticalmente usando `align-items`.

<details><summary>Mostrar solución</summary>

```css
.container {
  display: flex;
  height: 300px;
  align-items: center;
}
```

```html
<div class="container">
  <div class="item"></div>
  <div class="item"></div>
  <div class="item"></div>
</div>
```

</details>

---

### **Ejercicio 4: Cambiar la dirección con `flex-direction`**

Cambia la dirección de los elementos para que se coloquen en una columna.

<details><summary>Mostrar solución</summary>

```css
.container {
  display: flex;
  flex-direction: column;
}
```

```html
<div class="container">
  <div class="item"></div>
  <div class="item"></div>
  <div class="item"></div>
</div>
```

</details>

---

### **Ejercicio 5: Distribuir espacio entre elementos**

Usa `space-between` para distribuir los elementos con espacio entre ellos.

<details><summary>Mostrar solución</summary>

```css
.container {
  display: flex;
  justify-content: space-between;
}
```

```html
<div class="container">
  <div class="item"></div>
  <div class="item"></div>
  <div class="item"></div>
</div>
```

</details>

---

### **Ejercicio 6: Controlar el crecimiento de elementos con `flex-grow`**

Haz que el segundo elemento crezca más que los demás usando `flex-grow`.

<details><summary>Mostrar solución</summary>

```css
.container {
  display: flex;
}
.item {
  flex-grow: 1;
}
.item:nth-child(2) {
  flex-grow: 2;
}
```

```html
<div class="container">
  <div class="item"></div>
  <div class="item"></div>
  <div class="item"></div>
</div>
```

</details>

---

### **Ejercicio 7: Cambiar el orden de los elementos con `order`**

Haz que el tercer elemento aparezca primero utilizando `order`.

<details><summary>Mostrar solución</summary>

```css
.container {
  display: flex;
}
.item:nth-child(3) {
  order: -1;
}
```

```html
<div class="container">
  <div class="item">1</div>
  <div class="item">2</div>
  <div class="item">3</div>
</div>
```

</details>
