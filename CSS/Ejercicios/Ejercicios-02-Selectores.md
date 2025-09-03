# **Ejercicios - Tema 2: Selectores y especificidad en CSS**

## **Instrucciones:**

A continuación, encontrarás 5 ejercicios prácticos sobre selectores y especificidad en CSS.

Intenta resolverlos antes de consultar la solución.

---

### **Ejercicio 1: Usar un selector de etiqueta**

Aplica un color de fondo amarillo a todos los párrafos (`<p>`) de una página web.

<details><summary>Mostrar solución</summary>

```css
p {
  background-color: yellow;
}
```

</details>

---

### **Ejercicio 2: Usar un selector de clase**

Crea una clase llamada `.danger` y úsala para hacer que el texto de los elementos a los que se aplique sea rojo y en negrita.

<details><summary>Mostrar solución</summary>

```css
.danger {
  color: red;
  font-weight: bold;
}
```

```html
<p class="danger">Este es un párrafo importante.</p>
```

</details>

---

### **Ejercicio 3: Usar un selector de ID**

Crea un ID llamado `#some-title` y úsalo para centrar el texto de un encabezado `<h1>`.

<details><summary>Mostrar solución</summary>

```css
#some-title {
  text-align: center;
}
```

```html
<h1 id="some-title">Este es un título centrado</h1>
```

</details>

---

### **Ejercicio 4: Usar un selector de descendencia**

Selecciona todos los enlaces (`<a>`) que estén dentro de un párrafo (`<p>`) y cambia su color a azul.

<details><summary>Mostrar solución</summary>

```css
p a {
  color: blue;
}
```

```html
<p>Visita <a href="#">este enlace</a> para más información.</p>
```

</details>

---

### **Ejercicio 5: Usar la especificidad**

Aplica diferentes estilos a un párrafo usando un selector de tipo, un selector de clase y un selector de ID. Observa cuál tiene prioridad.

<details><summary>Mostrar solución</summary>

```css
p {
  color: black;
}
.special {
  color: green;
}
#some-id {
  color: red;
}
```

```html
<p id="some-id" class="special">
  Este párrafo tendrá color rojo por la especificidad del ID.
</p>
```

</details>
