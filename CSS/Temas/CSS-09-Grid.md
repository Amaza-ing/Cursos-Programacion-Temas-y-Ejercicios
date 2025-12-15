# **Tema 9: Diseño con CSS Grid**

## **1. Introducción a CSS Grid**

CSS Grid es un sistema de diseño en CSS que permite organizar elementos en una cuadrícula bidimensional, con filas y columnas. Es útil para crear estructuras de diseño complejas de manera flexible y sencilla.

---

## **2. Propiedad `display: grid`**

Para activar CSS Grid en un contenedor, se usa la propiedad `display: grid`.

```css
.container {
  display: grid;
}
```

Esto convierte a los elementos hijos en **grid items**, que pueden distribuirse en filas y columnas.

---

## **3. Definir columnas y filas con `grid-template-columns` y `grid-template-rows`**

Estas propiedades permiten definir el tamaño y número de columnas y filas en la cuadrícula.

```css
.container {
  display: grid;
  grid-template-columns: 200px 200px;
  grid-template-rows: 100px 100px;
}
```

Valores comunes:

- Tamaños fijos (`px`, `em`, `rem`, `%`, etc.)
- Automático (`auto`)
- Fracciones (`fr`), que dividen el espacio restante proporcionalmente

Ejemplo con fracciones:

```css
.container {
  grid-template-columns: 1fr 2fr;
}
```

---

## **4. Repeat y espaciado entre elementos (`gap`)**

También se pueden describir el número de filas y columnas usando `repeat(número, tamaño)`.

La propiedad `gap` define el espacio entre filas y columnas.

```css
.container {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 20px;
}
```

Valores disponibles:

- `row-gap`: Espaciado entre filas
- `column-gap`: Espaciado entre columnas
- `gap`: Espaciado en ambas direcciones

---

## **5. Ubicar elementos en la cuadrícula (`grid-column` y `grid-row`)**

Los elementos pueden ocupar varias columnas o filas utilizando `grid-column` y `grid-row`.

```css
.item {
  grid-column: 1 / 3;
  grid-row: 1 / 2;
}
```

Atajos:

```css
.item {
  grid-column: span 2;
}
```

---

## **6. Alineación en CSS Grid**

CSS Grid permite alinear elementos dentro de sus celdas con las propiedades (Los elementos deben tener algún tamaño para poder observar el posicionamiento):

- `justify-items`: Alinea los elementos en el eje horizontal
- `align-items`: Alinea los elementos en el eje vertical
- `place-items`: Combina ambas propiedades

```css
.container {
  justify-items: center;
  align-items: center;
}
```

También se pueden alinear celdas específicas con `justify-self` y `align-self`:

```css
.item {
  justify-self: end;
  align-self: start;
}
```

---

## **7. Áreas de la cuadrícula (`grid-template-areas`)**

Permite definir áreas dentro de la cuadrícula y asignar elementos a ellas.

```css
.container {
  display: grid;
  grid-template-areas:
    "header header"
    "sidebar content"
    "footer footer";
}

.header {
  grid-area: header;
}
.sidebar {
  grid-area: sidebar;
}
.content {
  grid-area: content;
}
.footer {
  grid-area: footer;
}
```

---

[![Grid](https://img.youtube.com/vi/Kl-W-vZOVZM/0.jpg)](https://www.youtube.com/watch?v=Kl-W-vZOVZM&list=PLzA2VyZwsq_9hRcJ0nEDQkoI1aK5V74y-)

---

## **8. Buenas prácticas con CSS Grid**

- Usar `fr` para crear diseños flexibles sin necesidad de píxeles fijos.
- Evitar el uso excesivo de `grid-template-areas` para estructuras sencillas.
- Aplicar `gap` en lugar de márgenes para espaciar elementos.
- Usar `repeat()` cuando se requieran múltiples columnas o filas de igual tamaño.
- Combinar CSS Grid con Flexbox según la necesidad del diseño.

---

## **Enlaces de Interés.**

- Juego para practicar con CSS Grid: [Grid Garden](https://cssgridgarden.com/#es).

---

En el próximo tema, exploraremos **pseudoelementos y pseudoclases en CSS**, para tener una mayor flexibilidad a la hora de jugar con los elementos de una página web.
