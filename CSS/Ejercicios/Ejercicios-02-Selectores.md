# **Exercises - Topic 2: Selectors and specificity in CSS**

## **Instructions:**

Below you will find 5 practical exercises on selectors and specificity in CSS.

Try to solve them before consulting the solution.

---

### **Exercise 1: Using a tag selector**

Applies a yellow background color to all paragraphs (`<p>`) on a web page.

<details><summary>Show solution</summary>

```css
p {
  background-color: yellow;
}
```


</details>

---

### **Exercise 2: Using a class selector**

Create a class called `.danger` and use it to make the text of the elements it applies to red and bold.

<details><summary>Show solution</summary>

```css
.danger {
  color: red;
  font-weight: bold;
}
```


```html
<p class="danger">Este es un párrafo importante.</p>
```


</details>

---

### **Exercise 3: Using an ID selector**

Create an ID called `#some-title` and use it to center the text of an `<h1>` header.

<details><summary>Show solution</summary>

```css
#some-title {
  text-align: center;
}
```


```html
<h1 id="some-title">Este es un título centrado</h1>
```


</details>

---

### **Exercise 4: Using a descendant selector**

Select all links (`<a>`) that are within a paragraph (`<p>`) and change their color to blue.

<details><summary>Show solution</summary>

```css
p a {
  color: blue;
}
```


```html
<p>Visita <a href="#">este enlace</a> para más información.</p>
```


</details>

---

### **Exercise 5: Using specificity**

Apply different styles to a paragraph using a type selector, a class selector, and an ID selector. See which one has priority.

<details><summary>Show solution</summary>

```css
p {
  color: black;
}
.special {
  color: green;
}
#some-id {
  color: red;
}
```


```html
<p id="some-id" class="special">
  Este párrafo tendrá color rojo por la especificidad del ID.
</p>
```


</details>
