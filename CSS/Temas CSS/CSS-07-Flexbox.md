# **Tema 7: Diseño con Flexbox en CSS**

## **1. Introducción a Flexbox**

Flexbox es un sistema de diseño en CSS que permite distribuir y alinear elementos de manera eficiente en un contenedor flexible. Es ideal para crear diseños responsivos y ajustar la posición de los elementos.

---

## **2. Propiedad `display: flex`**

Para activar Flexbox en un contenedor, se usa la propiedad `display: flex`.

```css
.container {
  display: flex;
}
```

Esto convierte a los elementos hijos en **flex items**, que pueden ser manipulados con propiedades adicionales.

---

## **3. Dirección del eje principal (`flex-direction`)**

Define la dirección en la que los elementos se organizan dentro del contenedor.

```css
.container {
  flex-direction: row; /* Por defecto: los elementos se alinean en fila */
}
```

Valores posibles:

- `row` (por defecto): en fila, de izquierda a derecha.
- `row-reverse`: en fila, de derecha a izquierda.
- `column`: en columna, de arriba hacia abajo.
- `column-reverse`: en columna, de abajo hacia arriba.

---

## **4. Alineación de elementos (`justify-content`)**

Controla la alineación de los elementos a lo largo del eje principal.

```css
.container {
  justify-content: center;
}
```

Valores posibles:

- `flex-start` (por defecto): Alinea los elementos al inicio.
- `flex-end`: Alinea los elementos al final.
- `center`: Centra los elementos.
- `space-between`: Distribuye los elementos con espacio entre ellos.
- `space-around`: Agrega espacio alrededor de cada elemento.
- `space-evenly`: Distribuye el espacio de manera equitativa.

---

## **5. Alineación en el eje secundario (`align-items`)**

Controla la alineación de los elementos en el eje perpendicular al principal.

```css
.container {
  align-items: center;
}
```

Valores posibles:

- `stretch` (por defecto): Los elementos se expanden para ocupar el espacio disponible.
- `flex-start`: Alinea los elementos en la parte superior.
- `flex-end`: Alinea los elementos en la parte inferior.
- `center`: Centra los elementos verticalmente.
- `baseline`: Alinea los elementos según su línea base de texto.

---

## **6. Control del tamaño de los elementos (`flex-grow`, `flex-shrink`, `flex-basis`)**

Estos tres valores permiten controlar cómo los elementos se distribuyen dentro del contenedor flexible.

### **`flex-grow` (Crecimiento)**

Define cuánto puede crecer un elemento en relación con los demás.

```css
.item {
  flex-grow: 1; /* Todos los elementos crecen equitativamente */
}
```

### **`flex-shrink` (Encogimiento)**

Determina cuánto se encoge un elemento si hay falta de espacio.

```css
.item {
  flex-shrink: 0; /* No se encogerá */
}
```

### **`flex-basis` (Tamaño base)**

Define el tamaño inicial del elemento antes de aplicar `flex-grow` o `flex-shrink`.

```css
.item {
  flex-basis: 100px; /* Tamaño inicial de 100px */
}
```

---

## **7. Propiedad `align-self`**

Permite alinear elementos individuales dentro del contenedor, sobrescribiendo `align-items`.

```css
.item {
  align-self: flex-end;
}
```

Valores posibles:

- `auto` (por defecto)
- `flex-start`
- `flex-end`
- `center`
- `stretch`
- `baseline`

---

## **8. Orden de los elementos (`order`)**

Permite cambiar el orden de los elementos dentro del contenedor.

```css
.item1 {
  order: 2;
}
.item2 {
  order: 1;
}
```

Por defecto, todos los elementos tienen `order: 0`. Un número menor se posiciona antes que un número mayor.

---

## **9. Otras propiedades importantes**

`flex-wrap` mueve el último elemento a una linea nueva si no cabe en el espacio actual.

`gap` indica el espacio entre los diferentes items del contenedor flex.

```css
.container {
  flex-wrap: wrap;
  gap: 10px;
}
```

---

## **9. Buenas prácticas con Flexbox**

- Usar `flex-wrap` cuando los elementos no deben encogerse demasiado.
- Evitar establecer valores arbitrarios en `flex-grow` sin considerar la distribución.
- Usar `align-items` y `justify-content` para mejorar la disposición de los elementos.
- Aplicar `order` solo cuando sea necesario reordenar elementos visualmente.

---

En el próximo tema, exploraremos **CSS Grid**, un sistema de diseño más avanzado para organizar elementos en dos dimensiones.
