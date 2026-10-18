# **Exercises - Topic 3: Inline elements and block elements**

## **Instructions:**

Below you'll find 7 practical exercises on inline and block elements in HTML. Do each one in a code editor and check the results in your browser.

Try to solve them before looking at the solution.

---

## **Exercise 1: Identify block and inline elements**

Look at the following code and answer:

```html
<h1>Bienvenido a mi Blog</h1>
<p>
  Este es un <strong>párrafo</strong> con una <a href="#">palabra enlazada</a>.
</p>
```

Which of these elements are block elements and which are inline elements?

<details><summary>Show solution</summary>

- **Block elements:** `<h1>`, `<p>`
- **Inline elements:** `<strong>`, `<a>`

</details>

---

## **Exercise 2: Create a layout with block elements**

Create a basic page structure using the following block elements:

- `header`
- `nav`
- `section`
- `footer`

<details><summary>Show solution</summary>

Possible example:

```html
<header>
  <h1>Mi Página Web</h1>
</header>
<nav>
  <ul>
    <li><a href="#">Inicio</a></li>
    <li><a href="#">Sobre mí</a></li>
    <li><a href="#">Contacto</a></li>
  </ul>
</nav>
<section>
  <p>Bienvenido a mi sitio web.</p>
</section>
<footer>
  <p>Todos los Derechos reservados</p>
</footer>
```

</details>

---

## **Exercise 3: Combine inline and block elements**

Write a paragraph that includes **bold text**, a **link** and a **span**.

<details><summary>Show solution</summary>

```html
<p>
  Este es un <strong>texto en negrita</strong> con un
  <a href="#">enlace importante</a> y una
  <span style="color:blue;">palabra resaltada en color azul</span>.
</p>
```

</details>

---

## **Exercise 4: Avoid nesting elements incorrectly**

Why is the following code incorrect? Fix it.

```html
<span>
  <h2>Este es un título</h2>
</span>
```

<details><summary>Show solution</summary>

The problem with the code is that `<span>` is an inline element and can't contain a block element like `<h2>`. The fixed version would be:

```html
<div>
  <h2>Este es un título</h2>
</div>
```

</details>

---

## **Exercise 5: Using `em` and `div` in text**

Write a paragraph where you use `em` to highlight a phrase, and a `div` to wrap a group of sentences in a separate block.

<details><summary>Show solution</summary>

```html
<p>
  <em>Esta es una frase resaltada en cursiva.</em>
</p>
<div>
  <p>Aquí está un bloque de texto separado.</p>
  <p>Otro párrafo dentro del bloque.</p>
</div>
```

</details>

---

## **Exercise 6: Create a list of items**

Use a list (`ul` or `ol`) and make sure you use `li` elements. It can be a shopping list, a list of languages or anything else.

<details><summary>Show solution</summary>

```html
<ul>
  <li>Leche</li>
  <li>Pan</li>
  <li>Huevos</li>
  <li>Frutas</li>
</ul>
```

</details>

---

## **Exercise 7: Create a horizontal navigation bar**

Use only inline elements to create a horizontal navigation menu with links.

<details><summary>Show solution</summary>

```html
<nav>
  <a href="#">Inicio</a> | <a href="#">Servicios</a> | <a href="#">Blog</a> |
  <a href="#">Contacto</a>
</nav>
```

</details>
