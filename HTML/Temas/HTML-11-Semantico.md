# **Topic 11: Semantic HTML - Correctly structuring the content**

## **1. What is semantic HTML and why is it important?**

Semantic HTML refers to the use of tags with their own meaning that describe the content of a web page in a clear and structured way. These tags help improve accessibility, search engine optimization (SEO), and code maintainability.

### **Benefits of semantic HTML:**

- Makes code easier to understand for both developers and browsers.
- Improves accessibility for people with disabilities who use screen readers.
- Improves positioning in search engines like Google.
- Provides a logical structure to the content.

---

## **2. Using `<header>`, `<nav>`, `<main>`, `<section>`, `<article>`, `<aside>`, `<footer>`**

### **2.1. `<header>` - Page or section header**

The `<header>` element represents the header of a document or section.

**Example:**

```html
<header>
  <h1>Mi Sitio Web</h1>
  <p>Bienvenido a mi sitio web de noticias y tecnología.</p>
</header>
```

### **2.2. `<nav>` - Navigation Menu**

The `<nav>` element defines a section containing navigation links.

**Example:**

```html
<nav>
  <ul>
    <li><a href="#inicio">Inicio</a></li>
    <li><a href="#servicios">Servicios</a></li>
    <li><a href="#contacto">Contacto</a></li>
  </ul>
</nav>
```

### **23. `<main>` - Main page content**

The `<main>` element contains the main content of the document, excluding headers, menus, and footers.

**Example:**

```html
<main>
  <h2>Últimas Noticias</h2>
  <p>Aquí encontrarás las noticias más recientes sobre tecnología.</p>
</main>
```

### **2.4. `<section>` - An independent Section of the page**

The `<section>` element represents a separate section, such as a comment board or an image gallery.

**Example:**

```html
<section>
  <h2>Comentarios:</h2>
  <ul>
    <li>Comentario1</li>
    <li>Comentario2</li>
    <li>Comentario3</li>
  </ul>
</section>
```

### **2.5. `<article>` - Independent and reusable content**

The `<article>` element represents stand-alone content, such as a blog article or news story.

**Example:**

```html
<article>
  <h3>Nuevo Avance Tecnológico</h3>
  <p>
    Investigadores han desarrollado una nueva IA con capacidades sorprendentes.
  </p>
</article>
```

### **2.6. `<aside>` - Related or complementary content**

The `<aside>` element is used for related information, such as sidebars or advertisements.

**Example:**

```html
<aside>
  <h3>Publicidad</h3>
  <p>Descubre las mejores ofertas en tecnología.</p>
</aside>
```

### **2.6. `<footer>` - Footer**

The `<footer>` element represents the footer of a document or section.

**Example:**

```html
<footer>
  <p>© Mi Sitio Web - Todos los derechos reservados.</p>
</footer>
```

---

## **3. Difference between `<div>` and semantic elements**

The `<div>` element is used as a generic container with no semantic meaning, while semantic elements provide context about its content.

### **`<div>` example without semantics:**

```html
<div class="cabecera">
  <h1>Mi Sitio Web</h1>
</div>
```

### **Example with semantic `<header>`:**

```html
<header>
  <h1>Mi Sitio Web</h1>
</header>
```

**Conclusion:** It is recommended to use semantic elements instead of `<div>` whenever possible to improve the structure and accessibility of the content.

---

[![Semantic HTML](https://img.youtube.com/vi/easFWSS1Tqw/0.jpg)](https://www.youtube.com/watch?v=easFWSS1Tqw&list=PLzA2VyZwsq_9NPG0g7N4fo6lw50rWnWPc)

---

## **4. Other important aspects of semantic HTML**

- **Additional semantic tags:** `<figure>`, `<figcaption>`, ...
- **Improve SEO with semantic HTML.**
- **Correct use of nested tags for a clear and orderly structure.**

---
In the next topic, we will explore **the use of accessibility in HTML**, including attributes like `aria-label` and best practices to improve the user experience.
