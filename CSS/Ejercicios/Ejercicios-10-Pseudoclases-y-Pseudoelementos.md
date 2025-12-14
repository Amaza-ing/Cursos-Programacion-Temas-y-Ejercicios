# **Ejercicios - Tema 10: Pseudoclases y Pseudoelementos en CSS**

## **Instrucciones:**

A continuación, encontrarás **6 ejercicios prácticos** sobre pseudoclases y pseudoelementos en CSS.

Intenta resolverlos antes de consultar la solución.

---

### **Ejercicio 1: Usar la pseudoclase `:hover`**

Crea un botón que cambie su color de fondo a negro y el color del texto a blanco cuando el usuario pase el ratón por encima.

<details><summary>Mostrar solución</summary>

```css
button:hover {
  background-color: black;
  color: white;
}
```

```html
<button>Pasar el ratón</button>
```

</details>

---

### **Ejercicio 2: Aplicar `:focus` a un input**

Crea un campo de texto (`input`) que muestre un borde azul de 2 píxeles cuando tenga el foco.

<details><summary>Mostrar solución</summary>

```css
input:focus {
  border: 2px solid blue;
}
```

```html
<input type="text" placeholder="Escribe aquí" />
```

</details>

---

### **Ejercicio 3: Usar pseudoclases estructurales**

Selecciona el primer elemento de una lista y haz que aparezca en negrita.

<details><summary>Mostrar solución</summary>

```css
li:first-child {
  font-weight: bold;
}
```

```html
<ul>
  <li>Primer elemento</li>
  <li>Segundo elemento</li>
  <li>Tercer elemento</li>
</ul>
```

</details>

---

### **Ejercicio 4: Usar `:nth-child()`**

Cambia el color de fondo de los elementos pares de una lista a un color gris claro.

<details><summary>Mostrar solución</summary>

```css
li:nth-child(even) {
  background-color: lightgray;
}
```

```html
<ul>
  <li>Elemento 1</li>
  <li>Elemento 2</li>
  <li>Elemento 3</li>
  <li>Elemento 4</li>
</ul>
```

</details>

---

### **Ejercicio 5: Insertar contenido con `::before`**

Añade un símbolo ★ antes del texto de todos los encabezados `<h2>` usando un pseudoelemento.

<details><summary>Mostrar solución</summary>

```css
h2::before {
  content: "★ ";
  color: gold;
}
```

```html
<h2>Sección destacada</h2>
```

</details>

---

### **Ejercicio 6: Estilizar la selección de texto**

Cambia el color de fondo a negro y el color del texto a blanco cuando el usuario seleccione texto en la página.

<details><summary>Mostrar solución</summary>

```css
::selection {
  background-color: black;
  color: white;
}
```

```html
<p>Selecciona este texto para ver el efecto.</p>
```

</details>
