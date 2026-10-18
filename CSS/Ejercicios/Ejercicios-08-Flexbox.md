# **Exercises - Topic 8: Design with Flexbox in CSS**

## **Instructions:**

Below you will find 7 practical exercises on Flexbox in CSS.

Try to solve them before consulting the solution.

---

### **Exercise 1: Create a flexible container**

Create a container with `display: flex` and three child elements.

<details><summary>Show solution</summary>

```css
.container {
  display: flex;
  background-color: lightgray;
}
.item {
  width: 100px;
  height: 100px;
  background-color: steelblue;
  margin: 10px;
}
```


```html
<div class="container">
  <div class="item"></div>
  <div class="item"></div>
  <div class="item"></div>
</div>
```


</details>

---

### **Exercise 2: Align elements with `justify-content`**

Align the container elements to the center horizontally using `justify-content`.

<details><summary>Show solution</summary>

```css
.container {
  display: flex;
  justify-content: center;
}
```


```html
<div class="container">
  <div class="item"></div>
  <div class="item"></div>
  <div class="item"></div>
</div>
```


</details>

---

### **Exercise 3: Align elements on the vertical axis**

Align the elements in the center vertically using `align-items`.

<details><summary>Show solution</summary>

```css
.container {
  display: flex;
  height: 300px;
  align-items: center;
}
```


```html
<div class="container">
  <div class="item"></div>
  <div class="item"></div>
  <div class="item"></div>
</div>
```


</details>

---

### **Exercise 4: Change the address with `flex-direction`**

Change the direction of the elements so that they are placed in a column.

<details><summary>Show solution</summary>

```css
.container {
  display: flex;
  flex-direction: column;
}
```


```html
<div class="container">
  <div class="item"></div>
  <div class="item"></div>
  <div class="item"></div>
</div>
```


</details>

---

### **Exercise 5: Distribute space between elements**

Use `space-between` to distribute the elements with space between them.

<details><summary>Show solution</summary>

```css
.container {
  display: flex;
  justify-content: space-between;
}
```


```html
<div class="container">
  <div class="item"></div>
  <div class="item"></div>
  <div class="item"></div>
</div>
```


</details>

---

### **Exercise 6: Control the growth of elements with `flex-grow`**

Make the second element grow larger than the others using `flex-grow`.

<details><summary>Show solution</summary>

```css
.container {
  display: flex;
}
.item {
  flex-grow: 1;
}
.item:nth-child(2) {
  flex-grow: 2;
}
```


```html
<div class="container">
  <div class="item"></div>
  <div class="item"></div>
  <div class="item"></div>
</div>
```


</details>

---

### **Exercise 7: Change the order of elements with `order`**

Make the third item appear first using `order`.

<details><summary>Show solution</summary>

```css
.container {
  display: flex;
}
.item:nth-child(3) {
  order: -1;
}
```


```html
<div class="container">
  <div class="item">1</div>
  <div class="item">2</div>
  <div class="item">3</div>
</div>
```


</details>
