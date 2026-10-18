# **Topic 2: Basic structure of an HTML document**

## **1. Introduction**

An HTML document has a fundamental structure that all files must follow. This structure is made up of various tags that organize the content and define its behavior within a web browser.

### **Importance of an ordered structure:**

- Facilitates understanding of the document.
- Improves accessibility and usability.
- Allows better interpretation by browsers and search engines.

---

## **2. Main components of an HTML document**

Every HTML document is made up of the following sections:

1. **Document type declaration (`DOCTYPE`)**
2. **`<html>` element** (Main container of the page)
3. **`<head>` Section** (Metadata and imports)
4. **`<body>` Section** (Content visible on the page)

### **Basic structure example:**

```HTML
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mi primer documento HTML</title>
</head>
<body>
    <h1>Bienvenido a mi página</h1>
    <p>Este es un párrafo de ejemplo.</p>
</body>
</html>
```

---

[![HTML basic structure](https://img.youtube.com/vi/MenMpkevMpE/0.jpg)](https://www.youtube.com/watch?v=MenMpkevMpE&list=PLzA2VyZwsq_9NPG0g7N4fo6lw50rWnWPc)

---

## **3. Explanation of main tags**

### **1. `<!DOCTYPE html>`**

- Indicates to the browser that the document is written in HTML5.
- It is not a label itself, but an instruction for the browser.

### **2. `<html>`**

- Contains all the HTML code of the page.
- It is the root tag of any HTML document.

### **3. `<head>`**

- Contains information about the document.
- May include:
  - Metadata (`<meta>`)
  - Page Title (`<title>`)
  - Links to style sheets (`<link>`)
  - Scripts (`<script>`)

### **4. `<body>`**

- Contains all the content visible on the page.
- May include:
  - Headers (`<h1>` to `<h6>`)
  - Paragraphs (`<p>`)
  - Images (`<img>`)
  - Links (`<a>`)
  - Lists (`<ul>`, `<ol>`, `<li>`)
  - Tables (`<table>`)
  - Forms (`<form>`)

---

## **4. Importance of metadata in the `<head>`**

Metadata helps improve performance, accessibility, and search engine optimization (**SEO**).

### **Common metadata:**

- `<meta charset="UTF-8">` → Defines the character encoding.
- `<meta name="viewport" content="width=device-width, initial-scale=1.0">` → Optimize the page for mobile devices.
- `<meta name="description" content="Descripción de la página">` → Improves search engine positioning.

---

## **5. Good practices in HTML structuring**

- **Use a clear and semantic structure.**
- **Close all labels correctly.**
- **Avoid excessive use of `<div>` when semantic tags are available.**
- **Include basic metadata for compatibility and SEO.**
- **Keep the code clean and commented when necessary.**

---

## **6. Creating an HTML file**

To create an HTML file on your computer:

1. Open a text editor (Visual Studio Code, Notepad++, Sublime Text).
2. Save the file with the extension `.html` (Example: `index.html`).
3. Write the basic HTML structure.
4. Open the file in a web browser to view it.

---

In the next topic, we will learn about **Elements, tags and attributes in HTML**, fundamental for web development.
