# **Ejercicios - Tema 6: Tipografía y Fuentes en CSS**

## **Instrucciones:**

A continuación, encontrarás 5 ejercicios prácticos sobre tipografía y fuentes en CSS.

Intenta resolverlos antes de consultar la solución.

---

### **Ejercicio 1: Aplicar una fuente específica**

Define un párrafo con la fuente `Arial` y una fuente de respaldo `sans-serif`.

<details><summary>Mostrar solución</summary>

```css
p {
  font-family: Arial, sans-serif;
}
```

```html
<p>Este es un texto con fuente Arial.</p>
```

</details>

---

### **Ejercicio 2: Modificar el tamaño de la fuente**

Crea un título `<h1>` con un tamaño de fuente de `32px`.

<details><summary>Mostrar solución</summary>

```css
h1 {
  font-size: 32px;
}
```

```html
<h1>Este título tiene un tamaño de 32px.</h1>
```

</details>

---

### **Ejercicio 3: Aplicar negrita y cursiva**

Define un texto con negrita y otro con cursiva usando `font-weight` y `font-style`.

<details><summary>Mostrar solución</summary>

```css
.bold-text {
  font-weight: bold;
}
.italic-text {
  font-style: italic;
}
```

```html
<p class="bold-text">Este texto es en negrita.</p>
<p class="italic-text">Este texto es en cursiva.</p>
```

</details>

---

### **Ejercicio 4: Usar `letter-spacing` y `line-height`**

Crea un párrafo con un espaciado entre letras de `2px` y un interlineado de `1.5`.

<details><summary>Mostrar solución</summary>

```css
p {
  letter-spacing: 2px;
  line-height: 1.5;
}
```

```html
<p>
  Este párrafo tiene un espaciado entre letras de 2px y un interlineado de 1.5.
</p>
```

</details>

---

### **Ejercicio 5: Importar una fuente de Google Fonts**

Importa la fuente `Roboto` desde Google Fonts y aplícala a todo el cuerpo del documento.

<details><summary>Mostrar solución</summary>

```css
@import url("https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap");

body {
  font-family: "Roboto", sans-serif;
}
```

```html
<p>Este texto usa la fuente Roboto.</p>
```

</details>
