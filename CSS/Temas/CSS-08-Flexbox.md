# **Topic 8: Layout with Flexbox in CSS**

## **1. Introduction to Flexbox**

Flexbox is a CSS layout system that lets you distribute and align elements efficiently inside a flexible container. It is ideal for creating responsive layouts and adjusting the position of elements.

---

## **2. `display: flex` property**

To enable Flexbox on a container, you use the `display: flex` property.

```css
.container {
  display: flex;
}
```


This turns the child elements into **flex items**, which can be manipulated with additional properties.

---

## **3. Main axis direction (`flex-direction`)**

It defines the direction in which elements are arranged inside the container.

```css
.container {
  flex-direction: row; /* Por defecto: los elementos se alinean en fila */
}
```


Possible values:

- `row` (default): in a row, from left to right.
- `row-reverse`: in a row, from right to left.
- `column`: in a column, from top to bottom.
- `column-reverse`: in a column, from bottom to top.

---

## **4. Aligning elements (`justify-content`)**

It controls the alignment of elements along the main axis.

```css
.container {
  justify-content: center;
}
```


Possible values:

- `flex-start` (default): Aligns the elements at the start.
- `flex-end`: Aligns the elements at the end.
- `center`: Centers the elements.
- `space-between`: Distributes the elements with space between them.
- `space-around`: Adds space around each element.
- `space-evenly`: Distributes space evenly.

---

## **5. Alignment on the cross axis (`align-items`)**

It controls the alignment of the elements on the axis perpendicular to the main axis.

```css
.container {
  align-items: center;
}
```


Possible values:

- `stretch` (default): The elements stretch to fill the available space.
- `flex-start`: Aligns the elements at the top.
- `flex-end`: Aligns the elements at the bottom.
- `center`: Centers the elements vertically.
- `baseline`: Aligns the elements by their text baseline.

---

## **6. Controlling the size of elements (`flex-grow`, `flex-shrink`, `flex-basis`)**

These three values let you control how elements are distributed inside the flex container.

### **`flex-grow` (Growth)**

It defines how much an element can grow compared with the others.

```css
.item {
  flex-grow: 1; /* Todos los elementos crecen equitativamente */
}
```


### **`flex-shrink` (Shrinkage)**

It determines how much an element shrinks when there isn't enough space.

```css
.item {
  flex-shrink: 0; /* No se encogerá */
}
```


### **`flex-basis` (Base size)**

It sets the initial size of the element before applying `flex-grow` or `flex-shrink`.

```css
.item {
  flex-basis: 100px; /* Tamaño inicial de 100px */
}
```


---

## **7. `align-self` property**

It lets you align individual elements inside the container, overriding `align-items`.

```css
.item {
  align-self: flex-end;
}
```


Possible values:

- `auto` (default)
- `flex-start`
- `flex-end`
- `center`
- `stretch`
- `baseline`

---

## **8. Order of elements (`order`)**

It lets you change the order of the elements inside the container.

```css
.item1 {
  order: 2;
}
.item2 {
  order: 1;
}
```


By default, all elements have `order: 0`. A lower number is placed before a higher one.

---

## **9. Other important properties**
`flex-wrap` moves the last element to a new line if it does not fit in the current space.

`gap` sets the space between the items of the flex container.

```css
.container {
  flex-wrap: wrap;
  gap: 10px;
}
```


---

[![Flexbox](https://img.youtube.com/vi/ONi3VOxQSjc/0.jpg)](https://www.youtube.com/watch?v=ONi3VOxQSjc&list=PLzA2VyZwsq_9hRcJ0nEDQkoI1aK5V74y-)

---

## **10. Best practices with Flexbox**

- Use `flex-wrap` when elements should not shrink too much.
- Avoid setting arbitrary `flex-grow` values without thinking about the distribution.
- Use `align-items` and `justify-content` to improve the arrangement of elements.
- Use `order` only when you need to reorder elements visually.

---

## **Useful links**

- A game to practice Flexbox: [froggy](https://flexboxfroggy.com/#es).
- A guide to using Flexbox: [css-tricks](https://css-tricks.com/snippets/css/a-guide-to-flexbox/).

---

In the next topic, we'll explore **CSS Grid**, a more advanced layout system for organizing elements in two dimensions.
