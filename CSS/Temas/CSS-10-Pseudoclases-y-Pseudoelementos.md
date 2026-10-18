# **Topic 10: Pseudo-classes and Pseudo-elements in CSS**

## **1. Introduction**

**Pseudo-classes** and **pseudo-elements** let you apply CSS styles based on the **state** of an element or on **specific parts** of it, without having to modify the HTML. They are essential tools for improving the interaction, accessibility and visual presentation of a web page.

---

## **2. What is a pseudo-class?**

A **pseudo-class** defines a special state of an element.

Pseudo-classes are written with **a single colon (`:`)**.

```css
selector:pseudoclase {
  propiedad: valor;
}
```


---

## **3. Most common pseudo-classes**

### **`:hover`**

Applies styles when the user hovers the mouse over the element.

```css
button:hover {
  background-color: black;
  color: white;
}
```


---

### **`:active`**

Applies while the element is being pressed.

```css
button:active {
  transform: scale(0.95);
}
```


---

### **`:focus`**

Applies when an element receives focus (forms, links, inputs).

```css
input:focus {
  border: 2px solid blue;
}
```


---

### **`:visited`**

Applies styles to links that have already been visited.

```css
a:visited {
  color: purple;
}
```


---

### **`:disabled` and `:enabled`**

They let you style form elements based on their state.

```css
input:disabled {
  background-color: lightgray;
}
```


---

## **4. Structural pseudo-classes**

They let you select elements based on their position in the DOM.

### **`:first-child`**

Selects the first child of a container.

```css
li:first-child {
  font-weight: bold;
}
```


---

### **`:last-child`**

Selects the last child.

```css
li:last-child {
  color: red;
}
```


---

### **`:nth-child()`**

Selects elements based on their position.

```css
li:nth-child(2) {
  background-color: lightblue;
}
```


Common examples:

- `nth-child(odd)`
- `nth-child(even)`
- `nth-child(3n)`

---

## **5. What is a pseudo-element?**

A **pseudo-element** allows you to select and style **a specific part** of an element.

Pseudo-elements are written with **a double colon (`::`)**.

```css
selector::pseudoelemento {
  propiedad: valor;
}
```


---

## **6. Most commonly used pseudo-elements**

### **`::before` and `::after`**

They let you insert content before or after an element.

```css
h2::before {
  content: "★ ";
  color: gold;
}
```


```css
p::after {
  content: " ✔";
  color: green;
}
```


⚠ You must use the `content` property.

---

### **`::first-letter`**

Styles the first letter of a text.

```css
p::first-letter {
  font-size: 2em;
  font-weight: bold;
}
```


---

### **`::first-line`**

Styles the first line of a text.

```css
p::first-line {
  color: blue;
}
```


---

### **`::selection`**

Applies styles to text selected by the user.

```css
::selection {
  background-color: black;
  color: white;
}
```


---

## **7. Differences between pseudo-classes and pseudo-elements**

| Feature | Pseudo-classes | Pseudo-elements |
| --------------------- | ------------ | ------------------- |
| Syntax | `:` | `::` |
| Act on | States | Parts of the element |
| Modify interaction | Yes | No |
| Insert content | No | Yes (`before/after`) |

---

[![Pseudo-classes & Pseudo-elements](https://img.youtube.com/vi/D9DoH8gLsXY/0.jpg)](https://www.youtube.com/watch?v=D9DoH8gLsXY&list=PLzA2VyZwsq_9hRcJ0nEDQkoI1aK5V74y-)

---

## **8. Best practices**

- Use `::` for pseudo-elements (the modern standard).
- Don't overuse `::before` and `::after` for important content.
- Combine pseudo-classes with transitions to improve the experience.
- Use structural pseudo-classes to reduce unnecessary classes in the HTML.

---
In the next topic, we will explore **animations and transitions in CSS**, to make our interfaces more dynamic and fluid.
