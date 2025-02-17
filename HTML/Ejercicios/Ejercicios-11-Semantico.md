# **Ejercicios - Tema 11: HTML Semántico**

## **Instrucciones:**
A continuación, encontrarás 5 ejercicios prácticos sobre HTML semántico.

Intenta resolverlos antes de consultar la solución.

---

### **Ejercicio 1: Crear una estructura básica con etiquetas semánticas**
Crea una página HTML que contenga un encabezado (`<header>`), un menú de navegación (`<nav>`), una sección principal (`<main>`), un artículo (`<article>`), una barra lateral (`<aside>`) y un pie de página (`<footer>`).

<details><summary>Mostrar solución</summary>

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

### **Ejercicio 2: Convertir una estructura basada en `div` en HTML semántico**
Transforma la siguiente estructura que usa `div` en una estructura semántica adecuada.

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

<details><summary>Mostrar solución</summary>

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

### **Ejercicio 3: Crear una estructura con `<section>` y `<article>`**
Crea una página que tenga una sección (`<section>`) con dos artículos (`<article>`), cada uno con un título y un párrafo de texto.

<details><summary>Mostrar solución</summary>

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

### **Ejercicio 4: Uso de `<figure>` y `<figcaption>`**
Crea una estructura HTML que incluya una imagen con una descripción utilizando `<figure>` y `<figcaption>`.

<details><summary>Mostrar solución</summary>

```html
<figure>
  <img src="imagen.jpg" alt="Descripción de la imagen">
  <figcaption>Esta es una imagen de un hermoso paisaje.</figcaption>
</figure>
```

</details>

---

### **Ejercicio 5: Crear un `<footer>` con enlaces adicionales**
Diseña un pie de página que contenga enlaces a una política de privacidad, términos de servicio y redes sociales.

<details><summary>Mostrar solución</summary>

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

