# **Tema 10: Pseudoclases y Pseudoelementos en CSS**

## **1. Introducción**

Las **pseudoclases** y los **pseudoelementos** permiten aplicar estilos en CSS en función del **estado** de un elemento o de **partes específicas** de él, sin necesidad de modificar el HTML. Son herramientas fundamentales para mejorar la interacción, accesibilidad y presentación visual de una página web.

---

## **2. ¿Qué es una pseudoclase?**

Una **pseudoclase** define un estado especial de un elemento.

Se escriben con **un solo dos puntos (`:`)**.

```css
selector:pseudoclase {
  propiedad: valor;
}
```

---

## **3. Pseudoclases más comunes**

### **`:hover`**

Aplica estilos cuando el usuario pasa el ratón por encima.

```css
button:hover {
  background-color: black;
  color: white;
}
```

---

### **`:active`**

Se aplica mientras el elemento está siendo presionado.

```css
button:active {
  transform: scale(0.95);
}
```

---

### **`:focus`**

Se aplica cuando un elemento recibe el foco (formularios, enlaces, inputs).

```css
input:focus {
  border: 2px solid blue;
}
```

---

### **`:visited`**

Aplica estilos a enlaces que ya han sido visitados.

```css
a:visited {
  color: purple;
}
```

---

### **`:disabled` y `:enabled`**

Permiten estilizar elementos de formulario según su estado.

```css
input:disabled {
  background-color: lightgray;
}
```

---

## **4. Pseudoclases estructurales**

Permiten seleccionar elementos según su posición en el DOM.

### **`:first-child`**

Selecciona el primer hijo de un contenedor.

```css
li:first-child {
  font-weight: bold;
}
```

---

### **`:last-child`**

Selecciona el último hijo.

```css
li:last-child {
  color: red;
}
```

---

### **`:nth-child()`**

Selecciona elementos según su posición.

```css
li:nth-child(2) {
  background-color: lightblue;
}
```

Ejemplos habituales:

- `nth-child(odd)`
- `nth-child(even)`
- `nth-child(3n)`

---

## **5. ¿Qué es un pseudoelemento?**

Un **pseudoelemento** permite seleccionar y estilizar **una parte concreta** de un elemento.

Se escriben con **doble dos puntos (`::`)**.

```css
selector::pseudoelemento {
  propiedad: valor;
}
```

---

## **6. Pseudoelementos más utilizados**

### **`::before` y `::after`**

Permiten insertar contenido antes o después de un elemento.

```css
h2::before {
  content: "★ ";
  color: gold;
}
```

```css
p::after {
  content: " ✔";
  color: green;
}
```

⚠ Es obligatorio usar la propiedad `content`.

---

### **`::first-letter`**

Estiliza la primera letra de un texto.

```css
p::first-letter {
  font-size: 2em;
  font-weight: bold;
}
```

---

### **`::first-line`**

Estiliza la primera línea de un texto.

```css
p::first-line {
  color: blue;
}
```

---

### **`::selection`**

Aplica estilos al texto seleccionado por el usuario.

```css
::selection {
  background-color: black;
  color: white;
}
```

---

## **7. Diferencias entre pseudoclases y pseudoelementos**

| Característica        | Pseudoclases | Pseudoelementos     |
| --------------------- | ------------ | ------------------- |
| Sintaxis              | `:`          | `::`                |
| Actúan sobre          | Estados      | Partes del elemento |
| Modifican interacción | Sí           | No                  |
| Insertan contenido    | No           | Sí (`before/after`) |

---

## **8. Buenas prácticas**

- Usar `::` para pseudoelementos (estándar moderno).
- Evitar abusar de `::before` y `::after` para contenido importante.
- Combinar pseudoclases con transiciones para mejorar la experiencia.
- Usar pseudoclases estructurales para reducir clases innecesarias en HTML.

---

En el próximo tema, exploraremos **animaciones y transiciones en CSS**, para dotar a nuestras interfaces de dinamismo y fluidez.
