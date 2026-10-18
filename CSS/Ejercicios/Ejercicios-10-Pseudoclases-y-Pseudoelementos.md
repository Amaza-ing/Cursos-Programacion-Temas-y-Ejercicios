# **Exercises - Topic 10: Pseudoclasses and Pseudoelements in CSS**

## **Instructions:**

Below you will find **6 practical exercises** on pseudoclasses and pseudoelements in CSS.

Try to solve them before consulting the solution.

---

### **Exercise 1: Using the `:hover` pseudo-class**

Create a button that changes its background color to black and text color to white when the user hovers over it.

<details><summary>Show solution</summary>

```css
button:hover {
  background-color: black;
  color: white;
}
```


```html
<button>Pasar el ratón</button>
```


</details>

---

### **Exercise 2: Apply `:focus` to an input**

Creates a text field (`input`) that displays a 2 pixel blue border when it has focus.

<details><summary>Show solution</summary>

```css
input:focus {
  border: 2px solid blue;
}
```


```html
<input type="text" placeholder="Escribe aquí" />
```


</details>

---

### **Exercise 3: Using structural pseudoclasses**

Select the first item in a list and make it bold.

<details><summary>Show solution</summary>

```css
li:first-child {
  font-weight: bold;
}
```


```html
<ul>
  <li>Primer elemento</li>
  <li>Segundo elemento</li>
  <li>Tercer elemento</li>
</ul>
```


</details>

---

### **Exercise 4: Use `:nth-child()`**

Changes the background color of even-numbered items in a list to a light gray color.

<details><summary>Show solution</summary>

```css
li:nth-child(even) {
  background-color: lightgray;
}
```


```html
<ul>
  <li>Elemento 1</li>
  <li>Elemento 2</li>
  <li>Elemento 3</li>
  <li>Elemento 4</li>
</ul>
```


</details>

---

### **Exercise 5: Insert content with `::before`**

Adds a ★ symbol before the text of all `<h2>` headers using a pseudo element.

<details><summary>Show solution</summary>

```css
h2::before {
  content: "★ ";
  color: gold;
}
```


```html
<h2>Sección destacada</h2>
```


</details>

---

### **Exercise 6: Styling the text selection**

Changes the background color to black and the text color to white when the user selects text on the page.

<details><summary>Show solution</summary>

```css
::selection {
  background-color: black;
  color: white;
}
```


```html
<p>Selecciona este texto para ver el efecto.</p>
```


</details>
