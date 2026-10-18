# **Exercises - Topic 10: Pseudo-classes and Pseudo-elements in CSS**

## **Instructions:**

Below you will find **6 practical exercises** on pseudo-classes and pseudo-elements in CSS.

Try to solve them before consulting the solution.

---

### **Exercise 1: Use the `:hover` pseudo-class**

Create a button that changes its background color to black and its text color to white when the user hovers over it.

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

Create a text field (`input`) that shows a 2-pixel blue border when it has focus.

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

### **Exercise 3: Use structural pseudo-classes**

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

Change the background color of the even items in a list to light gray.

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

Add a ★ symbol before the text of all `<h2>` headings using a pseudo-element.

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

### **Exercise 6: Style the text selection**

Change the background color to black and the text color to white when the user selects text on the page.

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
