# **Exercises - Topic 12: Media Queries and Responsive Design**

## **Instructions:**

Below, you will find 5 practical exercises on media queries and responsive design in CSS.

Try to solve them before consulting the solution.

---

### **Exercise 1: Change the background color on small screens**

Create a media query that changes the background color of `<body>` to blue when the screen width is less than 600 pixels.

<details><summary>Show solution</summary>

```css
@media (max-width: 600px) {
  body {
    background-color: blue;
  }
}
```


</details>

---

### **Exercise 2: Adapt the font size on different devices**

Make paragraphs a font size of 14px on mobile (less than 600px), 16px on tablets (between 600px and 1024px), and 18px on large screens (more than 1024px).

<details><summary>Show solution</summary>

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

### **Exercise 3: Hide an element on mobile devices**

Create a media query that hides a navigation menu (`.nav`) on screens smaller than 768 pixels.

<details><summary>Show solution</summary>

```css
@media (max-width: 768px) {
  .nav {
    display: none;
  }
}
```


</details>

---

### **Exercise 4: Change the layout of an image gallery**

Create an image gallery that displays images in a single column on mobile devices and in three columns on large screens.

<details><summary>Show solution</summary>

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
  <img src="img1.jpg" alt="Imagen 1" />
  <img src="img2.jpg" alt="Imagen 2" />
  <img src="img3.jpg" alt="Imagen 3" />
</div>
```


</details>

---

### **Exercise 5: Change the orientation of text in landscape mode**

Use media queries to make the text in a paragraph center-aligned in portrait orientation and left-aligned in landscape orientation.

<details><summary>Show solution</summary>

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
