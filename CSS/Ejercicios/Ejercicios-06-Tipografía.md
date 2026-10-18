# **Exercises - Topic 6: Typography and Fonts in CSS**

## **Instructions:**

Below you will find 5 practical exercises on typography and fonts in CSS.

Try to solve them before consulting the solution.

---

### **Exercise 1: Apply a specific font**

Define a paragraph with the font `Arial` and the fallback font `sans-serif`.

<details><summary>Show solution</summary>

```css
p {
  font-family: Arial, sans-serif;
}
```


```html
<p>Este es un texto con fuente Arial.</p>
```


</details>

---

### **Exercise 2: Modify the font size**

Create an `<h1>` heading with a font size of `32px`.

<details><summary>Show solution</summary>

```css
h1 {
  font-size: 32px;
}
```


```html
<h1>Este título tiene un tamaño de 32px.</h1>
```


</details>

---

### **Exercise 3: Apply bold and italics**

Make one text bold and another italic using `font-weight` and `font-style`.

<details><summary>Show solution</summary>

```css
.bold-text {
  font-weight: bold;
}
.italic-text {
  font-style: italic;
}
```


```html
<p class="bold-text">Este texto es en negrita.</p>
<p class="italic-text">Este texto es en cursiva.</p>
```


</details>

---

### **Exercise 4: Use `letter-spacing` and `line-height`**

Create a paragraph with a letter spacing of `2px` and a line height of `1.5`.

<details><summary>Show solution</summary>

```css
p {
  letter-spacing: 2px;
  line-height: 1.5;
}
```


```html
<p>
  Este párrafo tiene un espaciado entre letras de 2px y un interlineado de 1.5.
</p>
```


</details>

---

### **Exercise 5: Import a font from Google Fonts**

Import the `Roboto` font from Google Fonts and apply it to the whole body of the document.

<details><summary>Show solution</summary>

```css
@import url("https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap");

body {
  font-family: "Roboto", sans-serif;
}
```


```html
<p>Este texto usa la fuente Roboto.</p>
```


</details>
