# **Exercises - Topic 7: Positioning in CSS**

## **Instructions:**

Below, you will find 5 practical exercises on positioning in CSS.

Try to solve them before consulting the solution.

---

### **Exercise 1: Create an item with `position: relative`**

Create an `div` with a width of 150px, a height of 100px and a green background color. Then, shift it 30px down and 40px to the right using `position: relative`.

<details><summary>Show solution</summary>

```css
.box {
  width: 150px;
  height: 100px;
  background-color: green;
  position: relative;
  top: 30px;
  left: 40px;
}
```


```html
<div class="box"></div>
```


</details>

---

### **Exercise 2: Create a container with an `absolute` element**

Define a parent `div` with `position: relative` and inside it place another `div` with `position: absolute`, which is positioned in the lower right corner of the container.

<details><summary>Show solution</summary>

```css
.container {
  width: 300px;
  height: 200px;
  background-color: lightgray;
  position: relative;
}

.child {
  width: 80px;
  height: 50px;
  background-color: red;
  position: absolute;
  bottom: 0;
  right: 0;
}
```


```html
<div class="container">
  <div class="child"></div>
</div>
```


</details>

---

### **Exercise 3: Create a sticky navigation menu (`fixed`)**

Creates a 100% width navigation bar with blue background color and fixed position at the top of the page.

<details><summary>Show solution</summary>

```css
.navbar {
  width: 100%;
  height: 50px;
  background-color: blue;
  position: fixed;
  top: 0;
  left: 0;
  color: white;
  text-align: center;
  line-height: 50px;
}
```


```html
<div class="navbar">Menú de navegación</div>
```


</details>

---

### **Exercise 4: Create an item with `sticky`**

Create an `<h2>` header that stays stuck to the top of the page when the user scrolls.

<details><summary>Show solution</summary>

```css
.header {
  background-color: yellow;
  padding: 10px;
  position: sticky;
  top: 0;
}
```


```html
<h2 class="header">Encabezado adhesivo</h2>
<p>Texto de prueba para hacer scroll...</p>
```


</details>

---

### **Exercise 5: Center an element with `absolute` and `transform`**

Create a 100x100px `div` with an orange background and position it in the exact center of the screen using `position: absolute` and `transform`.

<details><summary>Show solution</summary>

```css
.center-box {
  width: 100px;
  height: 100px;
  background-color: orange;
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
}
```


```html
<div class="center-box"></div>
```


</details>
