# **Exercises - Topic 5: Colors and Backgrounds in CSS**

## **Instructions:**

Below you will find 5 practical exercises on colors and backgrounds in CSS.

Try to solve them before consulting the solution.

---

### **Exercise 1: Apply a color to text**

Create a paragraph with red text.

<details><summary>Show solution</summary>

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

### **Exercise 2: Use a hexadecimal color**

Create an `<h1>` heading with blue text using a hexadecimal code.

<details><summary>Show solution</summary>

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

### **Exercise 3: Apply a background image**

Create a `div` with a background image called `fondo.jpg`.

<details><summary>Show solution</summary>

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

### **Exercise 4: Create a background gradient**

Create a `div` with a background gradient from red to blue, going from left to right.

<details><summary>Show solution</summary>

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

### **Exercise 5: Fix a background image in place**

Create a `div` with a background image that stays fixed when you scroll.

<details><summary>Show solution</summary>

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
