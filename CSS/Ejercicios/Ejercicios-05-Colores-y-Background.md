# **Exercises - Topic 5: Colors and Backgrounds in CSS**

## **Instructions:**

Below you will find 5 practical exercises on colors and backgrounds in CSS.

Try to solve them before consulting the solution.

---

### **Exercise 1: Apply color to text**

Create a paragraph with the text color red.

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

### **Exercise 2: Using a hexadecimal color**

Creates an `<h1>` header with blue text color using a hexadecimal code.

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

Creates an `div` with a background image named `fondo.jpg`.

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

Creates an `div` with a red to blue gradient background from left to right.

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

### **Exercise 5: Set a background image**

Create an `div` with a background image that remains fixed when scrolling.

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
