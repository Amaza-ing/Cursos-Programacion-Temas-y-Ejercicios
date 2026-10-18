# **Topic 10: Pseudoclasses and Pseudoelements in CSS**

## **1. Introduction**

**Pseudoclasses** and **Pseudoelements** allow you to apply CSS styling based on the **state** of an element or **specific parts** of it, without needing to modify the HTML. They are fundamental tools to improve the interaction, accessibility and visual presentation of a web page.

---

## **2. What is a pseudo class?**

A **pseudoclass** defines a special state of an element.

They are written with **a single colon (`:`)**.

```css
selector:pseudoclase {
  propiedad: valor;
}
```


---

## **3. Most common pseudoclasses**

### **`:hover`**

Applies styles when the user hovers the mouse.

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

It is applied when an element receives focus (forms, links, inputs).

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

They allow you to style form elements according to their state.

```css
input:disabled {
  background-color: lightgray;
}
```


---

## **4. Structural pseudoclasses**

They allow elements to be selected according to their position in the DOM.

### **`:first-child`**

Selects the first child of a container.

```css
li:first-child {
  font-weight: bold;
}
```


---

### **`:last-child`**

Select the last child.

```css
li:last-child {
  color: red;
}
```


---

### **`:nth-child()`**

Select elements based on their position.

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

They are written with **double colon (`::`)**.

```css
selector::pseudoelemento {
  propiedad: valor;
}
```


---

## **6. Most used pseudoelements**

### **`::before` and `::after`**

They allow content to be inserted before or after an element.

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


⚠ It is mandatory to use the `content` property.

---

### **`::first-letter`**

Stylizes the first letter of a text.

```css
p::first-letter {
  font-size: 2em;
  font-weight: bold;
}
```


---

### **`::first-line`**

Stylizes the first line of a text.

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

## **7. Differences between pseudoclasses and pseudoelements**

| Feature | Pseudoclasses | Pseudoelements |
| --------------------- | ------------ | ------------------- |
| Syntax | `:` | `::` |
| They act on | States | Parts of the element |
| They modify interaction | Yes | No |
| Insert content | No | Yes (`before/after`) |

---

[![Pseudoclasses & Pseudoelements](https://img.youtube.com/vi/D9DoH8gLsXY/0.jpg)](https://www.youtube.com/watch?v=D9DoH8gLsXY&list=PLzA2VyZwsq_9hRcJ0nEDQkoI1aK5V74y-)

---

## **8. Good practices**

- Use `::` for pseudo-elements (modern standard).
- Avoid abusing `::before` and `::after` for important content.
- Combine pseudo classes with transitions to improve the experience.
- Use structural pseudoclasses to reduce unnecessary classes in HTML.

---
In the next topic, we will explore **animations and transitions in CSS**, to give our interfaces dynamism and fluidity.
