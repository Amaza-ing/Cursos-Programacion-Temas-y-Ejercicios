# **Topic 1: Introduction to CSS**

## **1. What is CSS and what is it for?**

CSS (Cascading Style Sheets) is a language used to define the design and presentation of HTML documents. It allows you to improve the appearance of a web page, separating the structure of the content from the visual design.

### **CSS Key Features:**

- Allows you to customize the style of a web page.
- Separates the content (HTML) from the presentation.
- Facilitates maintenance and reuse of styles.
- Improves accessibility and user experience.
- Compatible with all modern browsers.

---

## **2. How does CSS work?**

CSS works by applying style rules to HTML elements. These rules can be defined in different ways and in different locations within the code.

### **Structure of a CSS rule:**

```css
selector {
  propiedad: valor;
}
```


### **Example of a CSS rule:**

```css
p {
  color: blue;
  font-size: 16px;
}
```


In this case:

- `p` is the **selector**, which indicates that the style will be applied to all paragraphs (`<p>`).
- `color` and `font-size` are **properties**.
- `blue` and `16px` are the **values** of those properties.

---

## **3. Ways to apply CSS**

There are three main ways to include CSS in an HTML document:

### **1. Inline CSS**

It is applied directly in the HTML tag using the `style` attribute.

```html
<p style="color: red; font-size: 18px;">
  Este es un párrafo con estilo en línea.
</p>
```


✔ Fast for small changes, but difficult to maintain on large projects. It is not recommended to use it if there is an alternative.

### **2. Internal CSS (internal CSS)**

It is placed inside the `<style>` tag in the `<head>` of the HTML document.

```html
<!DOCTYPE html>
<html>
  <head>
    <style>
      p {
        color: green;
        font-size: 20px;
      }
    </style>
  </head>
  <body>
    <p>Este es un párrafo con CSS interno.</p>
  </body>
</html>
```


✔ Useful for small pages without the need for multiple CSS files.

### **3. External CSS (external CSS)**

It is saved in a separate file (`.css`) and linked from the HTML with `<link>`.

**`styles.css` file**:

```css
h1 {
  color: purple;
  text-align: center;
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


✔ Best practice for large, scalable projects.

---

## **4. Cascade and specificity in CSS**

The name "Cascading Style Sheets" comes from the concept of **cascading**, which determines the order of priority of style rules.

### **Order of applying styles:**

1. Browser styles (default).
2. External styles (`.css`).
3. Internal styles (`<style>` in HTML).
4. Inline styles (`style=""` in the HTML tag).
5. Rules with `!important` (they have the highest priority).

### **Priority example:**

```css
p {
  color: blue !important; /* Se aplicará este color */
}

p {
  color: red;
}
```


📌 **Rules with `!important`** overwrite any other style, even if it comes from an external file. The use of `!important` is completely discouraged.

---

[![How to get started with CSS](https://img.youtube.com/vi/4SHxtVj5NL4/0.jpg)](https://www.youtube.com/watch?v=4SHxtVj5NL4&list=PLzA2VyZwsq_9hRcJ0nEDQkoI1aK5V74y-)

---

## **5. Good practices in CSS**

- Use external CSS files to keep code organized.
- Avoid excessive use of inline styles.
- Maintain a clear structure with comments in the code.
- Reuse classes and avoid IDs when possible.
- Optimize the code avoiding unnecessary rules.

---
In the next topic, we will explore **selectors and specificity in CSS**, essential for effectively applying styles to a web page.
