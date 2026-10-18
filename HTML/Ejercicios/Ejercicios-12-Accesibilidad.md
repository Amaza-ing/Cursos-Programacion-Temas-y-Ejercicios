# **Exercises - Topic 12: Accessibility in HTML**

## **Instructions:**

Below you'll find 5 practical exercises on accessibility in HTML.

Try to solve them before looking at the solution.

---

### **Exercise 1: Add `aria-label` to an icon button**

Create a button that contains only an icon (for example, an envelope) and use `aria-label` to describe what it does.

<details><summary>Show solution</summary>

```html
<button aria-label="Enviar mensaje">📩</button>
```

</details>

---

### **Exercise 2: Improve accessibility with `aria-labelledby`**

Fix the following code so that the input field is correctly labeled with `aria-labelledby`.

```html
<input type="text" id="username" /> <label for="username">Nombre</label>
```

<details><summary>Show solution</summary>

```html
<label for="username" id="label-name">Nombre</label>
<input type="text" id="username" aria-labelledby="label-name" />
```

</details>

---

### **Exercise 3: Add `alt` to an image**

Fix the following code so that the image has proper alt text.

```html
<img src="paisaje.jpg" />
```

<details><summary>Show solution</summary>

```html
<img src="paisaje.jpg" alt="Imagen de un paisaje montañoso al atardecer" />
```

</details>

---

### **Exercise 4: Make a keyboard-navigable list using `tabindex`**

Add `tabindex` to the links in the list below to define the navigation order.

```html
<ul>
  <li><a href="#">Inicio</a></li>
  <li><a href="#">Servicios</a></li>
  <li><a href="#">Contacto</a></li>
</ul>
```

<details><summary>Show solution</summary>

```html
<ul>
  <li><a href="#" tabindex="1">Inicio</a></li>
  <li><a href="#" tabindex="2">Servicios</a></li>
  <li><a href="#" tabindex="3">Contacto</a></li>
</ul>
```

</details>

---

### **Exercise 5: Use `role` to define elements**

Add the `role` attribute to the following code to indicate that the navigation is a menu.

```html
<nav>
  <ul>
    <li><a href="#">Inicio</a></li>
    <li><a href="#">Blog</a></li>
  </ul>
</nav>
```

<details><summary>Show solution</summary>

```html
<nav role="navigation">
  <ul>
    <li><a href="#">Inicio</a></li>
    <li><a href="#">Blog</a></li>
  </ul>
</nav>
```

</details>
