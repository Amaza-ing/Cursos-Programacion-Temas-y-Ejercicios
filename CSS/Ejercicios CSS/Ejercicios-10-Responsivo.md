# **Ejercicios - Tema 10: Media Queries y Diseño Responsivo**

## **Instrucciones:**
A continuación, encontrarás 5 ejercicios prácticos sobre media queries y diseño responsivo en CSS.

Intenta resolverlos antes de consultar la solución.

---

### **Ejercicio 1: Cambiar el color de fondo en pantallas pequeñas**

Crea una media query que cambie el color de fondo del `<body>` a azul cuando el ancho de la pantalla sea menor a 600 píxeles.

<details><summary>Mostrar solución</summary>

```css
@media (max-width: 600px) {
  body {
    background-color: blue;
  }
}
```

</details>

---

### **Ejercicio 2: Adaptar el tamaño de fuente en diferentes dispositivos**

Haz que los párrafos tengan un tamaño de fuente de 14px en móviles (menos de 600px), 16px en tabletas (entre 600px y 1024px) y 18px en pantallas grandes (más de 1024px).

<details><summary>Mostrar solución</summary>

```css
/* Móviles */
@media (max-width: 600px) {
  p {
    font-size: 14px;
  }
}

/* Tabletas */
@media (min-width: 601px) and (max-width: 1024px) {
  p {
    font-size: 16px;
  }
}

/* Pantallas grandes */
@media (min-width: 1025px) {
  p {
    font-size: 18px;
  }
}
```

</details>

---

### **Ejercicio 3: Ocultar un elemento en dispositivos móviles**

Crea una media query que oculte un menú de navegación (`.nav`) en pantallas menores a 768 píxeles.

<details><summary>Mostrar solución</summary>

```css
@media (max-width: 768px) {
  .nav {
    display: none;
  }
}
```

</details>

---

### **Ejercicio 4: Cambiar el diseño de una galería de imágenes**

Crea una galería de imágenes que muestre las imágenes en una sola columna en dispositivos móviles y en tres columnas en pantallas grandes.

<details><summary>Mostrar solución</summary>

```css
.gallery {
  display: grid;
  grid-template-columns: 1fr;
  gap: 10px;
}

@media (min-width: 768px) {
  .gallery {
    grid-template-columns: repeat(3, 1fr);
  }
}
```
```html
<div class="gallery">
  <img src="img1.jpg" alt="Imagen 1">
  <img src="img2.jpg" alt="Imagen 2">
  <img src="img3.jpg" alt="Imagen 3">
</div>
```

</details>

---

### **Ejercicio 5: Cambiar la orientación del texto en modo horizontal**

Usa media queries para que el texto de un párrafo esté alineado al centro en orientación vertical y alineado a la izquierda en orientación horizontal.

<details><summary>Mostrar solución</summary>

```css
/* Orientación vertical */
@media (orientation: portrait) {
  p {
    text-align: center;
  }
}

/* Orientación horizontal */
@media (orientation: landscape) {
  p {
    text-align: left;
  }
}
```

</details>
