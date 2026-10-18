# **Topic 1: What is HTML and how does it work?**

## **1. Introduction to HTML**

HTML (_HyperText Markup Language_) is the markup language used to structure content on the web. It is not a programming language, but a tag-based system that defines the organization of the content of a web page.

### **Key Features of HTML:**

- Defines the **structure** of a web page.
- Uses a system of **tags** to mark content.
- Works together with **CSS** (design) and **JavaScript** (interactivity).
- It is interpreted by **web browsers**.
- Compatible with all devices and platforms.

---

## **2. HTML operation**

When we write HTML, we create a document with different tags that tell the browser how to display the content.

### **Operating steps:**

1. The browser receives an HTML file from a server or locally.
2. Interprets the HTML tags and generates the **DOM** (Document Object Model).
3. Renders the content on the screen according to the defined structure.

HTML documents are made up of elements such as:

- **Headers** (`h1` to `h6`)
- **Paragraphs** (`p`)
- **Images** (`img`)
- **Links** (`a`)
- **Lists** (`ul`, `ol`, `li`)
- **Tables** (`table`, `tr`, `td`)
- **Forms** (`form`, `input`, `button`)

---

[![How to get started with HTML](https://img.youtube.com/vi/hkWMQFWgm34/0.jpg)](https://www.youtube.com/watch?v=hkWMQFWgm34&list=PLzA2VyZwsq_9NPG0g7N4fo6lw50rWnWPc)

---

## **3. First HTML document**

An HTML document follows a basic structure that must always include certain mandatory tags.

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

### **Tags Explanation:**

- `<!DOCTYPE html>`: Indicates the HTML version used (HTML5).
- `<html>`: Root element that wraps all content.
- `<head>`: Contains page metadata and settings.
- `<title>`: Defines the page title in the browser tab.
- `<body>`: Contains the visible content of the page.
- `<h1>`: Main header.
- `<p>`: Text paragraph.

---

## **4. HTML Versions**

Over time, HTML has evolved. The most current version is **HTML5**, which added new semantic tags and better support for multimedia.

### **Main HTML versions:**

- **HTML 1.0 (1993)** - First basic version.
- **HTML 4.01 (1999)** - Extensive support for CSS and JavaScript.
- **XHTML (2000)** - Stricter variant of HTML.
- **HTML5 (2014 - Current)** - Support for audio, video, graphics and greater accessibility.

---

## **5. Browsers and Compatibility**

Web browsers interpret the HTML code and display the content on the screen. Each browser may have slight differences in the way it renders HTML.

### **Most used browsers:**

- **Google Chrome**
- **Mozilla Firefox**
- **Microsoft Edge**
- **Safari**
- **Operates**

### **Best practices for compatibility:**

- Follow HTML5 standards.
- Use semantic tags correctly.
- Validate the HTML code with tools such as the [ Validator W3C](https://validator.w3.org/).

---

## **Useful commands and tools**

### **Create an HTML file**

To create an HTML file on your computer:

1. Open a text editor (Visual Studio Code, Notepad++, Sublime Text).
2. Save the file with the extension `.html` (Example: `index.html`).
3. Write the basic HTML structure.
4. Open the file in a web browser.

> Note: If you are using Visual Studio Vode it is highly recommended to install the `Live Server` extension from the extensions menu. Once installed, you can open any HTML document by clicking on the _Go Live_ button that you will find at the bottom right.

---

In the next topic, we will learn about the **basic structure of an HTML document** and its importance in creating websites.
