# **Topic 1: What is HTML and how does it work?**

## **1. Introduction to HTML**

HTML (_HyperText Markup Language_) is the markup language used to structure content on the web. It isn't a programming language, but a tag-based system that defines how the content of a web page is organized.

### **Key features of HTML:**

- It defines the **structure** of a web page.
- It uses a system of **tags** to mark up content.
- It works together with **CSS** (design) and **JavaScript** (interactivity).
- It is interpreted by **web browsers**.
- It is compatible with all devices and platforms.

---

## **2. How HTML works**

When we write HTML, we create a document with different tags that tell the browser how to display the content.

### **Step by step:**

1. The browser receives an HTML file from a server or from your own computer.
2. It interprets the HTML tags and generates the **DOM** (Document Object Model).
3. It renders the content on the screen according to the defined structure.

HTML documents are made up of elements such as:

- **Headings** (`h1` to `h6`)
- **Paragraphs** (`p`)
- **Images** (`img`)
- **Links** (`a`)
- **Lists** (`ul`, `ol`, `li`)
- **Tables** (`table`, `tr`, `td`)
- **Forms** (`form`, `input`, `button`)

---

[![How to get started with HTML](https://img.youtube.com/vi/hkWMQFWgm34/0.jpg)](https://www.youtube.com/watch?v=hkWMQFWgm34&list=PLzA2VyZwsq_9NPG0g7N4fo6lw50rWnWPc)

---

## **3. Your first HTML document**

An HTML document follows a basic structure that must always include certain required tags.

### **Basic HTML structure:**

```html
<!DOCTYPE html>
<html>
  <head>
    <title>Mi primera página</title>
  </head>
  <body>
    <h1>Hola, mundo</h1>
    <p>Este es mi primer documento HTML.</p>
  </body>
</html>
```

### **The tags explained:**

- `<!DOCTYPE html>`: Indicates the HTML version used (HTML5).
- `<html>`: Root element that wraps all the content.
- `<head>`: Contains the page's metadata and settings.
- `<title>`: Defines the page title shown in the browser tab.
- `<body>`: Contains the visible content of the page.
- `<h1>`: Main heading.
- `<p>`: Paragraph of text.

---

## **4. HTML versions**

HTML has evolved over time. The latest version is **HTML5**, which added new semantic tags and better multimedia support.

### **Main HTML versions:**

- **HTML 1.0 (1993)** - The first basic version.
- **HTML 4.01 (1999)** - Broad support for CSS and JavaScript.
- **XHTML (2000)** - A stricter variant of HTML.
- **HTML5 (2014 - present)** - Support for audio, video, graphics and better accessibility.

---

## **5. Browsers and compatibility**

Web browsers interpret the HTML code and display the content on the screen. Each browser may have slight differences in the way it renders HTML.

### **Most widely used browsers:**

- **Google Chrome**
- **Mozilla Firefox**
- **Microsoft Edge**
- **Safari**
- **Opera**

### **Best practices for compatibility:**

- Follow the HTML5 standards.
- Use semantic tags correctly.
- Validate your HTML code with tools such as the [W3C Validator](https://validator.w3.org/).

---

## **Useful commands and tools**

### **Create an HTML file**

To create an HTML file on your computer:

1. Open a text editor (Visual Studio Code, Notepad++, Sublime Text).
2. Save the file with the `.html` extension (for example: `index.html`).
3. Write the basic HTML structure.
4. Open the file in a web browser.

> Note: If you're using Visual Studio Code, it's highly recommended to install the `Live Server` extension from the Extensions menu. Once it's installed, you can open any HTML document by clicking the _Go Live_ button at the bottom right.

---

In the next topic, we'll learn about the **basic structure of an HTML document** and why it matters when building websites.
