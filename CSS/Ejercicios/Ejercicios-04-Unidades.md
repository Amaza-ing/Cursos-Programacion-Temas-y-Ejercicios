# **Exercises - Topic 4: Units of Measurement in CSS**

## **Instructions:**

Below you will find 6 practical exercises on units of measurement in CSS.

Try to solve them before consulting the solution.

---

### **Exercise 1: Use absolute units**

Create a `div` with a width of 500 pixels and a height of 80 pixels.

<details><summary>Show solution</summary>

```css
.box {
  width: 500px;
  height: 80px;
  background-color: lightgray;
}
```


```html
<div class="box">Caja con unidades absolutas.</div>
```


</details>

---

### **Exercise 2: Use percentages for a flexible layout**

Define a container whose width is 80% of the size of its parent element.

<details><summary>Show solution</summary>

```css
.container {
  width: 80%;
  background-color: lightblue;
}
```


```html
<div class="container">
  Este contenedor ocupa el 80% del ancho del elemento padre.
</div>
```


</details>

---

### **Exercise 3: Compare `em` and `rem`**

Create a paragraph where the font size is 2em and another where it is 2rem. Give `html` a `font-size` of 16px and the parent container a `font-size` of 10px, and see the difference.

<details><summary>Show solution</summary>

```css
html {
  font-size: 16px;
}
.container {
  font-size: 10px;
}
p.rem-example {
  font-size: 2rem; /* 32px relativo al html */
}
p.em-example {
  font-size: 2em; /* 20px relativo al padre */
}
```


```html
<div class="container">
  <p class="em-example">Este texto usa 2em.</p>
  <p class="rem-example">Este texto usa 2rem.</p>
</div>
```


</details>

---

### **Exercise 4: Apply `vw` and `vh`**

Create a `div` that takes up 50% of the width and 30% of the height of the browser window.

<details><summary>Show solution</summary>

```css
.full-screen-box {
  width: 50vw;
  height: 30vh;
  background-color: pink;
}
```


```html
<div class="full-screen-box">Este contenedor usa vw y vh.</div>
```


</details>

---

### **Exercise 5: Use `vmin` and `vmax`**

Create a `div` where the font size is `5vmin`, and another one where it is `5vmax`.

<details><summary>Show solution</summary>

```css
.text-vmin {
  font-size: 5vmin; /* Basado en el menor valor entre ancho y alto de la pantalla */
}
.text-vmax {
  font-size: 5vmax; /* Basado en el mayor valor entre ancho y alto de la pantalla */
}
```


```html
<p class="text-vmin">Este texto usa vmin.</p>
<p class="text-vmax">Este texto usa vmax.</p>
```


</details>

---

### **Exercise 6: Create a responsive layout by combining units**

Define a flexible container with `width: 80%`, `max-width: 600px` and `min-width: 300px`. Use `rem` to define the padding.

<details><summary>Show solution</summary>

```css
.responsive-box {
  width: 80%;
  max-width: 600px;
  min-width: 300px;
  padding: 2rem;
  background-color: lightgreen;
}
```


```html
<div class="responsive-box">Este contenedor es flexible.</div>
```


</details>
