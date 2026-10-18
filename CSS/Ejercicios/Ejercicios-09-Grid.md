# **Exercises - Topic 9: Layout with CSS Grid**

## **Instructions:**

Below you will find 5 practical exercises on CSS Grid.

Try to solve them before consulting the solution.

---

### **Exercise 1: Create a basic grid**

Create a container with 3 columns of equal size and 2 rows.

<details><summary>Show solution</summary>

```css
.container {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  grid-template-rows: repeat(2, 100px);
  gap: 10px;
  background-color: lightgray;
}

.item {
  background-color: lightblue;
  border: 1px solid #000;
  text-align: center;
  line-height: 100px;
}
```


```html
<div class="container">
  <div class="item">1</div>
  <div class="item">2</div>
  <div class="item">3</div>
  <div class="item">4</div>
  <div class="item">5</div>
  <div class="item">6</div>
</div>
```


</details>

---

### **Exercise 2: Merge cells**

Create a `div` that spans two columns in a 3x2 grid.

<details><summary>Show solution</summary>

```css
.container {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  grid-template-rows: repeat(2, 100px);
  gap: 10px;
}

.item1 {
  grid-column: 1 / 3;
  background-color: salmon;
  text-align: center;
  line-height: 100px;
}

.item {
  background-color: lightblue;
  text-align: center;
  line-height: 100px;
}
```


```html
<div class="container">
  <div class="item1">1</div>
  <div class="item">2</div>
  <div class="item">3</div>
  <div class="item">4</div>
  <div class="item">5</div>
</div>
```


</details>

---

### **Exercise 3: Use `grid-template-areas`**

Create a layout with defined areas for `header`, `sidebar`, `content` and `footer`.

<details><summary>Show solution</summary>

```css
.container {
  display: grid;
  grid-template-areas:
    "header header"
    "sidebar content"
    "footer footer";
  grid-template-columns: 1fr 3fr;
  grid-template-rows: auto 1fr auto;
  gap: 10px;
}

.header {
  grid-area: header;
  background-color: lightcoral;
  text-align: center;
}

.sidebar {
  grid-area: sidebar;
  background-color: lightgreen;
}

.content {
  grid-area: content;
  background-color: lightblue;
}

.footer {
  grid-area: footer;
  background-color: lightgray;
  text-align: center;
}
```


```html
<div class="container">
  <div class="header">Header</div>
  <div class="sidebar">Sidebar</div>
  <div class="content">Content</div>
  <div class="footer">Footer</div>
</div>
```


</details>

---

### **Exercise 4: Align elements on the grid**

Create a grid where the elements are centered both horizontally and vertically.

<details><summary>Show solution</summary>

```css
.container {
  display: grid;
  grid-template-columns: repeat(3, 100px);
  grid-template-rows: repeat(3, 100px);
  justify-items: center;
  align-items: center;
  gap: 10px;
}

.item {
  background-color: lightblue;
  text-align: center;
  width: 50px;
  height: 50px;
  line-height: 50px;
}
```


```html
<div class="container">
  <div class="item">1</div>
  <div class="item">2</div>
  <div class="item">3</div>
  <div class="item">4</div>
  <div class="item">5</div>
  <div class="item">6</div>
  <div class="item">7</div>
  <div class="item">8</div>
  <div class="item">9</div>
</div>
```


</details>

---

### **Exercise 5: Create a responsive layout with `auto-fit`**

Use `auto-fit` to create a flexible grid that adjusts to the size of the screen.

<details><summary>Show solution</summary>

```css
.container {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
  gap: 10px;
}

.item {
  background-color: lightblue;
  text-align: center;
  padding: 20px;
}
```


```html
<div class="container">
  <div class="item">1</div>
  <div class="item">2</div>
  <div class="item">3</div>
  <div class="item">4</div>
  <div class="item">5</div>
  <div class="item">6</div>
</div>
```


</details>
