# **Ejercicios - Tema 3: Elementos en línea y elementos en bloque**

## **Instrucciones:**
A continuación, encontrarás 7 ejercicios prácticos sobre elementos en línea y en bloque en HTML. Realiza cada uno de ellos en un editor de código y visualiza los resultados en tu navegador.

Intenta resolverlos antes de consultar la solución.

---

## **Ejercicio 1: Identificar elementos en bloque e inline**
Observa el siguiente código y responde:
```html
<h1>Bienvenido a mi Blog</h1>
<p>Este es un <strong>párrafo</strong> con una <a href="#">palabra enlazada</a>.</p>
```
¿Cuáles de estos elementos son de tipo bloque y cuáles son de tipo inline?

<details><summary>Mostrar solución</summary>

- **Elementos en bloque:** `<h1>`, `<p>`
- **Elementos en línea:** `<strong>`, `<a>`

</details>

---

## **Ejercicio 2: Crear un diseño con elementos en bloque**
Crea una estructura de página básica usando los siguientes elementos en bloque:
- `header`
- `nav`
- `section`
- `footer`

<details><summary>Mostrar solución</summary>

Posible ejemplo:
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
    <p>Todos los Derechos reservados </p>
</footer>
```
</details>

---

## **Ejercicio 3: Combinar elementos en línea y en bloque**
Escribe un párrafo donde incluyas un **texto en negrita**, un **enlace** y un **span**.

<details><summary>Mostrar solución</summary>

```html
<p>
    Este es un <strong>texto en negrita</strong> con un <a href="#">enlace importante</a> y una
    <span style="color:blue;">palabra resaltada en color azul</span>.
</p>
```

</details>

---

## **Ejercicio 4: Evitar anidar elementos incorrectamente**
¿Por qué el siguiente código es incorrecto? Corrígelo.
```html
<span>
    <h2>Este es un título</h2>
</span>
```

<details><summary>Mostrar solución</summary>

El problema en el código es que `<span>` es un elemento en línea y no puede contener un elemento en bloque como `<h2>`. La corrección sería:
```html
<div>
    <h2>Este es un título</h2>
</div>
```

</details>

---

## **Ejercicio 5: Uso de `span` y `div` en un texto**
Escribe un párrafo donde uses `em` para resaltar una frase y un `div` para encerrar un conjunto de frases en un bloque separado.

<details><summary>Mostrar solución</summary>

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

## **Ejercicio 6: Crear una lista de elementos**
Usa una lista (`ul` o `ol`) y asegúrate de que usas los elementos `li`. Puede ser una lista de la compra, lista de idiomas o cualquier otra cosa.

<details><summary>Mostrar solución</summary>

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

## **Ejercicio 7: Crear una barra de navegación horizontal**
Usa solo elementos en línea para crear un menú de navegación horizontal con enlaces.

<details><summary>Mostrar solución</summary>

```html
<nav>
    <a href="#">Inicio</a> |
    <a href="#">Servicios</a> |
    <a href="#">Blog</a> |
    <a href="#">Contacto</a>
</nav>
```
</details>
