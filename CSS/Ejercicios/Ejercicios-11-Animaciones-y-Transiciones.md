# **Exercises - Topic 11: Animations and Transitions in CSS**

## **Instructions:**

Below you will find 5 practical exercises on animations and transitions in CSS.

Try to solve them before consulting the solution.

---

### **Exercise 1: Create a color transition**

Create a button that changes its background color from blue to red on hover with a smooth 0.5 second transition.

<details><summary>Show solution</summary>

```css
.button {
  background-color: blue;
  color: white;
  padding: 10px 20px;
  border: none;
  cursor: pointer;
  transition: background-color 0.5s ease;
}

.button:hover {
  background-color: red;
}
```


```html
<button class="button">Pasa el cursor</button>
```


</details>

---

### **Exercise 2: Animate a moving frame**

Create a box that scrolls from left to right using `@keyframes`.

<details><summary>Show solution</summary>

```css
@keyframes move {
  from {
    transform: translateX(0);
  }
  to {
    transform: translateX(200px);
  }
}

.box {
  width: 100px;
  height: 100px;
  background-color: green;
  animation: move 2s infinite alternate;
}
```


```html
<div class="box"></div>
```


</details>

---

### **Exercise 3: Create a scale effect on hover**

Make an element enlarge to 120% of its original size when the cursor hovers over it.

<details><summary>Show solution</summary>

```css
.scale-box {
  width: 100px;
  height: 100px;
  background-color: orange;
  transition: transform 0.3s ease;
}

.scale-box:hover {
  transform: scale(1.2);
}
```


```html
<div class="scale-box"></div>
```


</details>

---

### **Exercise 4: Create a Fade Effect**

Create text that fades in on page load using `opacity`.

<details><summary>Show solution</summary>

```css
@keyframes fadeIn {
  from {
    opacity: 0;
  }
  to {
    opacity: 1;
  }
}

.text {
  font-size: 24px;
  animation: fadeIn 2s ease;
}
```


```html
<p class="text">Texto que aparece gradualmente</p>
```


</details>

---

### **Exercise 5: Create an animated spinner**

Create a circle that rotates continuously simulating a cargo spinner.

<details><summary>Show solution</summary>

```css
@keyframes spin {
  from {
    transform: rotate(0deg);
  }
  to {
    transform: rotate(360deg);
  }
}

.spinner {
  width: 50px;
  height: 50px;
  border: 5px solid lightgray;
  border-top: 5px solid blue;
  border-radius: 50%;
  animation: spin 1s linear infinite;
}
```


```html
<div class="spinner"></div>
```


</details>
