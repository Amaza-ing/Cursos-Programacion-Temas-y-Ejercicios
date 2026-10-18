# **Exercises - Topic 8: Images in HTML and optimization for the web**

## **Instructions:**

Below you'll find 5 practical exercises on images in HTML.

Try to solve them before looking at the solution.

---

### **Exercise 1: Insert a basic image**

Create an HTML document that displays an image located in the same folder as the HTML file.

<details><summary>Show solution</summary>

```html
<img src="imagen.jpg" alt="Descripción de la imagen" />
```

</details>

---

### **Exercise 2: Set the size of an image**

Modify the code from the previous exercise so that the image has a width of 400 pixels and a height of 300 pixels.

<details><summary>Show solution</summary>

```html
<img
  src="imagen.jpg"
  width="400"
  height="300"
  alt="Imagen con tamaño definido"
/>
```

</details>

---

### **Exercise 3: Apply lazy loading (`loading="lazy"`)**

Add the `loading="lazy"` attribute to the image so that it only loads when the user can see it on the screen.

<details><summary>Show solution</summary>

```html
<img src="imagen.jpg" alt="Imagen con carga diferida" loading="lazy" />
```

</details>

---

### **Exercise 4: Use different image formats**

Create an HTML document that displays an image in `.webp` format and another in `.svg` format.

<details><summary>Show solution</summary>

```html
<img src="imagen.webp" alt="Imagen en formato WebP" />
<img src="logo.svg" alt="Logotipo en formato SVG" />
```

</details>

---

### **Exercise 5: Image as a link**

Make an image act as a link to another web page.

<details><summary>Show solution</summary>

```html
<a href="https://www.ejemplo.com">
  <img src="imagen.jpg" alt="Imagen con enlace" />
</a>
```

</details>
