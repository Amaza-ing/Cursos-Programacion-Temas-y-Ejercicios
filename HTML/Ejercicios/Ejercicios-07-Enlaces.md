# **Exercises - Topic 7: Links in HTML**

## **Instructions:**

Below you will find 5 practical exercises on links in HTML. Perform each one in a code editor and view the results in your browser.

Try to solve them before consulting the solution.

---

### **Exercise 1: Basic Link**

Create an HTML document that includes a link to an external website such as Google or Wikipedia.

<details><summary>Show solution</summary>

```html
<a href="https://www.google.com">Visitar Google</a>
```

</details>

---

### **Exercise 2: Link that opens in a new tab**

Modify the link from the previous exercise to open in a new tab using the `target` attribute safely with `rel="noopener noreferrer"`.

<details><summary>Show solution</summary>

```html
<a href="https://www.google.com" target="_blank" rel="noopener noreferrer"
  >Abrir Google en nueva pestaña</a
>
```

</details>

---

### **Exercise 3: Internal link within a page**

Create an HTML page with two sections. Add a link at the top that when clicked takes the user to the second section using an `id`.

<details><summary>Show solution</summary>

```html
<a href="#seccion2">Ir a la Sección 2</a>

<h2 id="seccion2">Sección 2</h2>
<p>Este es el contenido de la segunda sección.</p>
```

</details>

---

### **Exercise 4: Relative link to another internal page**

Create a link that directs the user to another HTML page within the same project.

<details><summary>Show solution</summary>

```html
<a href="contacto.html">Ir a la página de contacto</a>
```

</details>

---

### **Exercise 5: Email and Phone Link**

Create links that allow you to send an email and make a phone call from the website.

<details><summary>Show solution</summary>

```html
<a href="mailto:correo@ejemplo.com">Enviar un correo</a>
<a href="tel:+123456789">Llamar al 123456789</a>
```

</details>
