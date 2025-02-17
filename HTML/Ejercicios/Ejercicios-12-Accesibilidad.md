# **Ejercicios - Tema 12: Accesibilidad en HTML**

## **Instrucciones:**

A continuación, encontrarás 5 ejercicios prácticos sobre accesibilidad en HTML.

Intenta resolverlos antes de consultar la solución.

---

### **Ejercicio 1: Agregar `aria-label` a un botón con ícono**

Crea un botón que contenga solo un ícono (por ejemplo, un sobre de correo) y usa `aria-label` para describir su función.

<details><summary>Mostrar solución</summary>

```html
<button aria-label="Enviar mensaje">📩</button>
```

</details>

---

### **Ejercicio 2: Mejorar accesibilidad con `aria-labelledby`**

Corrige el siguiente código para que el campo de entrada esté correctamente etiquetado con `aria-labelledby`.

```html
<input type="text" id="username" /> <label for="username">Nombre</label>
```

<details><summary>Mostrar solución</summary>

```html
<label for="username" id="label-name">Nombre</label>
<input type="text" id="username" aria-labelledby="label-name" />
```

</details>

---

### **Ejercicio 3: Agregar `alt` a una imagen**

Corrige el siguiente código para que la imagen tenga un texto alternativo adecuado.

```html
<img src="paisaje.jpg" />
```

<details><summary>Mostrar solución</summary>

```html
<img src="paisaje.jpg" alt="Imagen de un paisaje montañoso al atardecer" />
```

</details>

---

### **Ejercicio 4: Hacer una lista navegable con teclado usando `tabindex`**

Agrega `tabindex` a los enlaces de la siguiente lista para definir el orden de navegación.

```html
<ul>
  <li><a href="#">Inicio</a></li>
  <li><a href="#">Servicios</a></li>
  <li><a href="#">Contacto</a></li>
</ul>
```

<details><summary>Mostrar solución</summary>

```html
<ul>
  <li><a href="#" tabindex="1">Inicio</a></li>
  <li><a href="#" tabindex="2">Servicios</a></li>
  <li><a href="#" tabindex="3">Contacto</a></li>
</ul>
```

</details>

---

### **Ejercicio 5: Usar `role` para definir elementos**

Añade el atributo `role` al siguiente código para indicar que la navegación es un menú.

```html
<nav>
  <ul>
    <li><a href="#">Inicio</a></li>
    <li><a href="#">Blog</a></li>
  </ul>
</nav>
```

<details><summary>Mostrar solución</summary>

```html
<nav role="navigation">
  <ul>
    <li><a href="#">Inicio</a></li>
    <li><a href="#">Blog</a></li>
  </ul>
</nav>
```

</details>

