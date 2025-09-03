# **Tema 11: HTML semántico - Estructurando correctamente el contenido**

## **1. ¿Qué es HTML semántico y por qué es importante?**

HTML semántico se refiere al uso de etiquetas con significado propio que describen el contenido de una página web de manera clara y estructurada. Estas etiquetas permiten mejorar la accesibilidad, la optimización en motores de búsqueda (SEO) y la mantenibilidad del código.

### **Beneficios del HTML semántico:**

- Facilita la comprensión del código tanto para desarrolladores como para navegadores.
- Mejora la accesibilidad para personas con discapacidad que utilizan lectores de pantalla.
- Mejora el posicionamiento en buscadores como Google.
- Proporciona una estructura lógica al contenido.

---

## **2. Uso de `<header>`, `<nav>`, `<main>`, `<section>`, `<article>`, `<aside>`, `<footer>`**

### **2.1. `<header>` - Encabezado de la página o sección**

El elemento `<header>` representa la cabecera de un documento o una sección.

**Ejemplo:**

```html
<header>
  <h1>Mi Sitio Web</h1>
  <p>Bienvenido a mi sitio web de noticias y tecnología.</p>
</header>
```

### **2.2. `<nav>` - Menú de navegación**

El elemento `<nav>` define una sección que contiene enlaces de navegación.

**Ejemplo:**

```html
<nav>
  <ul>
    <li><a href="#inicio">Inicio</a></li>
    <li><a href="#servicios">Servicios</a></li>
    <li><a href="#contacto">Contacto</a></li>
  </ul>
</nav>
```

### **2.3. `<main>` - Contenido principal de la página**

El elemento `<main>` contiene el contenido principal del documento, excluyendo encabezados, menús y pie de página.

**Ejemplo:**

```html
<main>
  <h2>Últimas Noticias</h2>
  <p>Aquí encontrarás las noticias más recientes sobre tecnología.</p>
</main>
```

### **2.4. `<section>` - Una Sección independiente de la página**

El elemento `<section>` representa una sección independiente, como el tablón de comentarios o una galería de imágenes.

**Ejemplo:**

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

### **2.5. `<article>` - Contenido independiente y reutilizable**

El elemento `<article>` representa contenido independiente, como un artículo de blog o una noticia.

**Ejemplo:**

```html
<article>
  <h3>Nuevo Avance Tecnológico</h3>
  <p>
    Investigadores han desarrollado una nueva IA con capacidades sorprendentes.
  </p>
</article>
```

### **2.6. `<aside>` - Contenido relacionado o complementario**

El elemento `<aside>` se usa para información relacionada, como barras laterales o anuncios.

**Ejemplo:**

```html
<aside>
  <h3>Publicidad</h3>
  <p>Descubre las mejores ofertas en tecnología.</p>
</aside>
```

### **2.6. `<footer>` - Pie de página**

El elemento `<footer>` representa el pie de página de un documento o sección.

**Ejemplo:**

```html
<footer>
  <p>© Mi Sitio Web - Todos los derechos reservados.</p>
</footer>
```

---

## **3. Diferencia entre `<div>` y elementos semánticos**

El elemento `<div>` se utiliza como un contenedor genérico sin significado semántico, mientras que los elementos semánticos proporcionan contexto sobre su contenido.

### **Ejemplo de `<div>` sin semántica:**

```html
<div class="cabecera">
  <h1>Mi Sitio Web</h1>
</div>
```

### **Ejemplo con `<header>` semántico:**

```html
<header>
  <h1>Mi Sitio Web</h1>
</header>
```

**Conclusión:** Se recomienda usar elementos semánticos en lugar de `<div>` siempre que sea posible para mejorar la estructura y accesibilidad del contenido.

---

## **4. Otros aspectos importantes del HTML semántico**

- **Etiquetas semánticas adicionales:** `<figure>`, `<figcaption>`, ...
- **Mejorar el SEO con HTML semántico.**
- **Uso correcto de etiquetas anidadas para una estructura clara y ordenada.**

---

En el próximo tema, exploraremos **el uso de accesibilidad en HTML**, incluyendo atributos como `aria-label` y buenas prácticas para mejorar la experiencia de usuario.
