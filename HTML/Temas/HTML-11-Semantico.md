# **Topic 11: Semantic HTML - Correctly structuring the content**

## **1. What is semantic HTML and why is it important?**

Semantic HTML means using tags that carry their own meaning and describe the content of a web page in a clear, structured way. These tags help improve accessibility, search engine optimization (SEO) and code maintainability.

### **Benefits of semantic HTML:**

- It makes the code easier to understand for both developers and browsers.
- It improves accessibility for people with disabilities who use screen readers.
- It improves your ranking in search engines like Google.
- It gives the content a logical structure.

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

### **2.2. `<nav>` - Navigation menu**

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

### **2.3. `<main>` - Main page content**

The `<main>` element contains the main content of the document, excluding headers, menus and footers.

**Example:**

```html
<main>
  <h2>Últimas Noticias</h2>
  <p>Aquí encontrarás las noticias más recientes sobre tecnología.</p>
</main>
```

### **2.4. `<section>` - A standalone section of the page**

The `<section>` element represents a standalone section, such as the comments area or an image gallery.

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

The `<article>` element represents self-contained content, such as a blog post or a news story.

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

### **2.7. `<footer>` - Footer**

The `<footer>` element represents the footer of a document or section.

**Example:**

```html
<footer>
  <p>© Mi Sitio Web - Todos los derechos reservados.</p>
</footer>
```

---

## **3. The difference between `<div>` and semantic elements**

The `<div>` element is used as a generic container with no semantic meaning, while semantic elements provide context about their content.

### **Example of a `<div>` without semantics:**

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

**Conclusion:** Use semantic elements instead of `<div>` whenever possible to improve the structure and accessibility of your content.

---

[![Semantic HTML](https://img.youtube.com/vi/easFWSS1Tqw/0.jpg)](https://www.youtube.com/watch?v=easFWSS1Tqw&list=PLzA2VyZwsq_9NPG0g7N4fo6lw50rWnWPc)

---

## **4. Other important aspects of semantic HTML**

- **Additional semantic tags:** `<figure>`, `<figcaption>`, ...
- **Improving SEO with semantic HTML.**
- **Nesting tags correctly for a clear, orderly structure.**

---

In the next topic, we'll explore **applying accessibility in HTML**, including attributes like `aria-label` and best practices to improve the user experience.
