# **Exercises - Topics 4 and 5: Text and Lists in HTML**

## **Instructions:**

Below you will find 10 practical exercises on using headings, paragraphs and lists in HTML. Perform each of them in a code editor and view the results in your browser.

Try to solve them before consulting the solution.

---

## **Exercises on headings and paragraphs**

### **Exercise 1: Structure of an article with headings**

Create an HTML document with an article structure that includes a main heading (`h1`), a subheading (`h2`), and three sections (`h3`). Add content in paragraphs (`p`).

<details><summary>Show solution</summary>

```html
<h1>Título del Artículo</h1>
<h2>Subtítulo del Artículo</h2>

<h3>Primera Sección</h3>
<p>Contenido de la primera sección.</p>

<h3>Segunda Sección</h3>
<p>Contenido de la segunda sección.</p>

<h3>Tercera Sección</h3>
<p>Contenido de la tercera sección.</p>
```

</details>

---

### **Exercise 2: Correct use of headers**

Analyze the following code and correct any misuse of headers:

```html
<h3>Título principal</h3>
<h1>Subtítulo</h1>
<h4>Sección del contenido</h4>
```

Explain why headings should follow a logical hierarchy.

<details><summary>Show solution</summary>

**Correction:**

```html
<h1>Título principal</h1>
<h2>Subtítulo</h2>
<h3>Sección del contenido</h3>
```

**Explanation:** Headers should follow a logical hierarchy, starting from `<h1>`, followed by `<h2>`, `<h3>`, etc. An `<h3>` should not be used as a main title, nor an `<h1>` as a subtitle.

</details>

---

### **Exercise 3: Using line breaks**

Create a paragraph in HTML where you use the `<br>` tag to separate lines within the same paragraph without creating new blocks.

<details><summary>Show solution</summary>

```html
<p>
  Esta es la primera línea.<br />
  Esta es la segunda línea.<br />
  Y esta es la tercera línea.
</p>
```

</details>

---

### **Exercise 4: Quote and preformatted text**

Write an HTML document that includes a quote block (`<blockquote>`) with a famous phrase and a preformatted code block (`<pre>`) with a fragment of text representing a poem or a multi-line message.

<details><summary>Show solution</summary>

```html
<blockquote>
  "La educación es el arma más poderosa que puedes usar para cambiar el mundo."
  - Nelson Mandela
</blockquote>

<pre>
Rosas son rojas,
Violetas son azules,
El código es hermoso,
Y tú también.
</pre>
```

</details>

---

## **Exercises on lists**

### **Exercise 5: Unordered list of favorite items**

Create an unordered list (`<ul>`) with at least five items that represent your favorite foods, movies, or books.

<details><summary>Show solution</summary>

```html
<ul>
  <li>El Señor de los Anillos</li>
  <li>Star Wars</li>
  <li>Harry Potter</li>
</ul>
```

</details>

---

### **Exercise 6: Ordered list of steps in a process**

Create an ordered list (`<ol>`) that describes the steps to make a simple recipe (for example, making coffee or making a salad).

<details><summary>Show solution</summary>

```html
<ol>
  <li>Hervir agua.</li>
  <li>Agregar café molido.</li>
  <li>Esperar 5 minutos.</li>
  <li>Colar el café.</li>
  <li>Servir y disfrutar.</li>
</ol>
```

</details>

---

### **Exercise 7: Nested list of categories and subcategories**

Creates a nested list containing main categories (`<ul>`) and subcategories (`<li>` with internal lists).
Example: List of musical genres and some artists within each genre.

<details><summary>Show solution</summary>

```html
<ul>
  <li>
    Rock
    <ul>
      <li>Queen</li>
      <li>The Beatles</li>
    </ul>
  </li>
  <li>
    Pop
    <ul>
      <li>Taylor Swift</li>
      <li>Ed Sheeran</li>
    </ul>
  </li>
</ul>
```

</details>

---

### **Exercise 8: Correcting a poorly structured list**

Correct the following code to make the list structure valid:

```html
<ol>
  <li>Paso 1</li>
  <ul>
    <li>Detalle adicional</li>
  </ul>
  <li>Paso 2</li>
</ol>
```

Explain what was wrong and how you corrected it.
<details><summary>Show solution</summary>

**Correction:**

```html
<ol>
  <li>
    Paso 1
    <ul>
      <li>Detalle adicional</li>
    </ul>
  </li>
  <li>Paso 2</li>
</ol>
```

**Explanation:** The lists must follow an appropriate structure, preventing an `<ul>` from being directly inside an `<ol>` without being inside an `<li>`.

</details>

---

### **Exercise 9: Description list with terms and definitions**

Create a description list (`<dl>`) where you define at least three terms and their respective explanations.

<details><summary>Show solution</summary>

```html
<dl>
  <dt>HTML</dt>
  <dd>Lenguaje de marcado para la creación de páginas web.</dd>

  <dt>CSS</dt>
  <dd>Lenguaje de estilos para dar formato a las páginas web.</dd>

  <dt>JavaScript</dt>
  <dd>Lenguaje de programación para la interactividad en la web.</dd>
</dl>
```

</details>

---

### **Exercise 10: Create a combined list**

Create a list structure that combines ordered, unordered, and description lists within a single HTML document.

<details><summary>Show solution</summary>

```html
<ul>
  <li>
    Lenguajes de Programación
    <ol>
      <li>Python</li>
      <li>JavaScript</li>
      <li>Java</li>
    </ol>
  </li>
  <li>
    Frameworks y Librerías
    <ul>
      <li>React</li>
      <li>Angular</li>
      <li>Vue</li>
    </ul>
  </li>
  <li>
    Términos Claves
    <dl>
      <dt>API</dt>
      <dd>Interfaz de programación de aplicaciones.</dd>
      <dt>DOM</dt>
      <dd>Modelo de objetos del documento.</dd>
    </dl>
  </li>
</ul>
```

</details>
