# **Exercises - Topic 1: Introduction to CSS**

## **Instructions:**

Below you will find 5 practical exercises on the introduction to CSS.

Try to solve them before consulting the solution.

---

### **Exercise 1: Apply an inline style**

Create an HTML paragraph that has red text color using inline CSS.

<details><summary>Show solution</summary>

```html
<p style="color: red;">Este es un párrafo con CSS en línea.</p>
```


</details>

---

### **Exercise 2: Use internal CSS**

Create an HTML document that defines a CSS style on the `<style>` tag so that all paragraphs are colored blue.

<details><summary>Show solution</summary>

```html
<!DOCTYPE html>
<html>
  <head>
    <style>
      p {
        color: blue;
      }
    </style>
  </head>
  <body>
    <p>Este es un párrafo con CSS interno.</p>
  </body>
</html>
```


</details>

---

### **Exercise 3: Apply a style from an external file**

Create an external CSS file called `styles.css` and apply it to an HTML document so that the `<h1>` titles are colored green.

<details><summary>Show solution</summary>

**`styles.css` file**:

```css
h1 {
  color: green;
}
```


**`index.html` file**:

```html
<!DOCTYPE html>
<html>
  <head>
    <link rel="stylesheet" href="styles.css" />
  </head>
  <body>
    <h1>Este es un título con CSS externo.</h1>
  </body>
</html>
```


</details>

---

### **Exercise 4: Modify the text size**

Use CSS to resize paragraph text to 20 pixels.

<details><summary>Show solution</summary>

```html
<!DOCTYPE html>
<html>
  <head>
    <style>
      p {
        font-size: 20px;
      }
    </style>
  </head>
  <body>
    <p>Este es un párrafo con tamaño de texto de 20px.</p>
  </body>
</html>
```


</details>

---

### **Exercise 5: Using multiple CSS properties**

Create a paragraph with CSS that has red text color, 18px font size, and centered alignment.

<details><summary>Show solution</summary>

```html
<!DOCTYPE html>
<html>
  <head>
    <style>
      p {
        color: red;
        font-size: 18px;
        text-align: center;
      }
    </style>
  </head>
  <body>
    <p>Este es un párrafo con múltiples propiedades CSS.</p>
  </body>
</html>
```


</details>
