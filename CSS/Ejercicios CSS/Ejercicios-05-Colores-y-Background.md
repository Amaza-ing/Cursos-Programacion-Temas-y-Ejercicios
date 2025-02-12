# **Ejercicios - Tema 5: Colores y Fondos en CSS**

## **Instrucciones:**
A continuación, encontrarás 5 ejercicios prácticos sobre colores y fondos en CSS.

Intenta resolverlos antes de consultar la solución.

---

### **Ejercicio 1: Aplicar color a un texto**

Crea un párrafo con el color de texto rojo.

<details><summary>Mostrar solución</summary>

```css
p {
    color: red;
}
```
```html
<p>Este es un texto en color rojo.</p>
```

</details>

---

### **Ejercicio 2: Usar un color hexadecimal**

Crea un encabezado `<h1>` con color de texto azul utilizando un código hexadecimal.

<details><summary>Mostrar solución</summary>

```css
h1 {
    color: #0000ff;
}
```
```html
<h1>Este título es azul.</h1>
```

</details>

---

### **Ejercicio 3: Aplicar una imagen de fondo**

Crea un `div` con una imagen de fondo llamada `fondo.jpg`.

<details><summary>Mostrar solución</summary>

```css
div {
    background-image: url("fondo.jpg");
    width: 300px;
    height: 200px;
}
```
```html
<div>Este es un contenedor con una imagen de fondo.</div>
```

</details>

---

### **Ejercicio 4: Crear un degradado de fondo**

Crea un `div` con un fondo degradado de rojo a azul de izquierda a derecha.

<details><summary>Mostrar solución</summary>

```css
div {
    background: linear-gradient(to right, red, blue);
    width: 300px;
    height: 200px;
}
```
```html
<div>Este es un contenedor con un fondo degradado.</div>
```

</details>

---

### **Ejercicio 5: Fijar una imagen de fondo**

Crea un `div` con una imagen de fondo que permanezca fija al hacer scroll.

<details><summary>Mostrar solución</summary>

```css
div {
    background-image: url("fondo.jpg");
    background-attachment: fixed;
    width: 100%;
    height: 300px;
}
```
```html
<div>Este es un contenedor con una imagen de fondo fija.</div>
```

</details>
