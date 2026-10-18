# **Exercises - Topic 11: Semantic HTML**

## **Instructions:**

Below you'll find 5 practical exercises on semantic HTML.

Try to solve them before looking at the solution.

---

### **Exercise 1: Create a basic structure with semantic tags**

Create an HTML page that contains a header (`<header>`), a navigation menu (`<nav>`), a main section (`<main>`), an article (`<article>`), a sidebar (`<aside>`) and a footer (`<footer>`).

<details><summary>Show solution</summary>

```html
<header>
  <h1>Mi Blog Personal</h1>
</header>

<nav>
  <ul>
    <li><a href="#">Inicio</a></li>
    <li><a href="#">Sobre mí</a></li>
    <li><a href="#">Contacto</a></li>
  </ul>
</nav>

<main>
  <article>
    <h2>Mi Primer Artículo</h2>
    <p>Bienvenido a mi blog donde comparto mis ideas y pensamientos.</p>
  </article>
</main>

<aside>
  <h3>Publicaciones Recientes</h3>
  <ul>
    <li><a href="#">Cómo aprender HTML</a></li>
    <li><a href="#">Introducción a CSS</a></li>
  </ul>
</aside>

<footer>
  <p>© Mi Blog - Todos los derechos reservados.</p>
</footer>
```

</details>

---

### **Exercise 2: Convert a `div`-based structure to semantic HTML**

Turn the following `div`-based structure into a proper semantic structure.

```html
<div class="container">
  <div class="header">
    <h1>Mi Sitio</h1>
  </div>
  <div class="content">
    <p>Bienvenidos a mi sitio web.</p>
  </div>
</div>
```

<details><summary>Show solution</summary>

```html
<header>
  <h1>Mi Sitio</h1>
</header>

<main>
  <p>Bienvenidos a mi sitio web.</p>
</main>
```

</details>

---

### **Exercise 3: Create a structure with `<section>` and `<article>`**

Create a page that has a section (`<section>`) with two articles (`<article>`), each with a title and a paragraph of text.

<details><summary>Show solution</summary>

```html
<section>
  <article>
    <h2>Noticia 1</h2>
    <p>Esta es la primera noticia del día.</p>
  </article>

  <article>
    <h2>Noticia 2</h2>
    <p>Esta es la segunda noticia del día.</p>
  </article>
</section>
```

</details>

---

### **Exercise 4: Using `<figure>` and `<figcaption>`**

Create an HTML structure that includes an image with a description using `<figure>` and `<figcaption>`.

<details><summary>Show solution</summary>

```html
<figure>
  <img src="imagen.jpg" alt="Descripción de la imagen" />
  <figcaption>Esta es una imagen de un hermoso paisaje.</figcaption>
</figure>
```

</details>

---

### **Exercise 5: Create a `<footer>` with additional links**

Design a footer that contains links to a privacy policy, terms of service and social media.

<details><summary>Show solution</summary>

```html
<footer>
  <p>Mi Empresa</p>
  <nav>
    <ul>
      <li><a href="#">Política de Privacidad</a></li>
      <li><a href="#">Términos de Servicio</a></li>
      <li><a href="#">Facebook</a></li>
      <li><a href="#">X (Twitter)</a></li>
    </ul>
  </nav>
</footer>
```

</details>
