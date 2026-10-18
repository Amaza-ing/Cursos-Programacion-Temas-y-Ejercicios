# **Exercises - Topic 3: The Box Model in CSS**

## **Instructions:**

Below you will find 5 practical exercises on the box model in CSS.

Try to solve them before consulting the solution.

---

### **Exercise 1: Define margins and padding**

Creates an `div` with a gray background, a 20 pixel margin, and a 10 pixel padding.

<details><summary>Show solution</summary>

```css
.box {
  background-color: gray;
  margin: 20px;
  padding: 10px;
}
```


```html
<div class="box">Este es un contenedor con margen y padding.</div>
```


</details>

---

### **Exercise 2: Use `box-sizing: border-box`**

Defines an `div` with a width of 200 pixels, a border of 5 pixels, and activates the `box-sizing: border-box` property.

<details><summary>Show solution</summary>

```css
.container {
  width: 200px;
  border: 5px solid black;
  box-sizing: border-box;
}
```


```html
<div class="container">Este contenedor usa box-sizing.</div>
```


</details>

---

### **Exercise 3: Apply different margins**

Create an `div` with different margins: 10 pixels on top, 20 pixels on the right, 30 pixels on the bottom, and 40 pixels on the left.

<details><summary>Show solution</summary>

```css
.margin-box {
  margin: 10px 20px 30px 40px;
}
```


```html
<div class="margin-box">Este es un contenedor con márgenes diferentes.</div>
```


</details>

---

### **Exercise 4: Create a rounded edge**

Defines an `div` with a 2 pixel solid black border and 15 pixel rounded corners.

<details><summary>Show solution</summary>

```css
.rounded-box {
  border: 2px solid black;
  border-radius: 15px;
}
```


```html
<div class="rounded-box">Este es un contenedor con bordes redondeados.</div>
```


</details>

---

### **Exercise 5: Create a shadow effect**

Creates an `div` with a blue background and a 5 pixel offset shadow on the X and Y axes, with an opacity of 0.5.

<details><summary>Show solution</summary>

```css
.shadow-box {
  background-color: blue;
  box-shadow: 5px 5px 10px rgba(0, 0, 0, 0.5);
}
```


```html
<div class="shadow-box">Este es un contenedor con sombra.</div>
```


</details>
