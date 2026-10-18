# **Topic 8: Design with Flexbox in CSS**

## **1. Introduction to Flexbox**

Flexbox is a CSS layout system that allows you to efficiently distribute and align elements in a flexible container. It is ideal for creating responsive layouts and adjusting the position of elements.

---

## **2. `display: flex`** property

To enable Flexbox on a container, the `display: flex` property is used.

```css
.container {
  display: flex;
}
```


This turns the child elements into **flex items**, which can be manipulated with additional properties.

---

## **3. Main shaft direction (`flex-direction`)**

Defines the direction in which elements are arranged within the container.

```css
.container {
  flex-direction: row; /* Por defecto: los elementos se alinean en fila */
}
```


Possible values:

- `row` (default): in a row, from left to right.
- `row-reverse`: in a row, from right to left.
- `column`: in column, from top to bottom.
- `column-reverse`: in column, from bottom to top.

---

## **4. Element Alignment (`justify-content`)**

Controls the alignment of elements along the main axis.

```css
.container {
  justify-content: center;
}
```


Possible values:

- `flex-start` (default): Aligns elements at start.
- `flex-end`: Align the elements at the end.
- `center`: Center the elements.
- `space-between`: Distribute the elements with space between them.
- `space-around`: Add space around each element.
- `space-evenly`: Distributes space evenly.

---

## **5. Alignment on the secondary axis (`align-items`)**

Controls the alignment of the elements on the axis perpendicular to the main one.

```css
.container {
  align-items: center;
}
```


Possible values:

- `stretch` (default): Items expand to fill available space.
- `flex-start`: Align the elements on top.
- `flex-end`: Align the elements at the bottom.
- `center`: Centers elements vertically.
- `baseline`: Aligns elements according to their text baseline.

---

## **6. Element size control (`flex-grow`, `flex-shrink`, `flex-basis`)**

These three values allow you to control how elements are distributed within the flex container.

### **`flex-grow` (Growth)**

Defines how much an element can grow in relation to the others.

```css
.item {
  flex-grow: 1; /* Todos los elementos crecen equitativamente */
}
```


### **`flex-shrink` (Shrinkage)**

Determines how much an item shrinks if there is a lack of space.

```css
.item {
  flex-shrink: 0; /* No se encogerá */
}
```


### **`flex-basis` (Base size)**

Sets the initial size of the element before applying `flex-grow` or `flex-shrink`.

```css
.item {
  flex-basis: 100px; /* Tamaño inicial de 100px */
}
```


---

## **7. `align-self` property**

Allows individual elements to be aligned within the container, overriding `align-items`.

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

Allows you to change the order of the elements within the container.

```css
.item1 {
  order: 2;
}
.item2 {
  order: 1;
}
```


By default, all items have `order: 0`. A smaller number is positioned before a larger number.

---

## **9. Other important properties**
`flex-wrap` moves the last element to a new line if it does not fit in the current space.

`gap` indicates the space between the different items of the flex container.

```css
.container {
  flex-wrap: wrap;
  gap: 10px;
}
```


---

[![Flexbox](https://img.youtube.com/vi/ONi3VOxQSjc/0.jpg)](https://www.youtube.com/watch?v=ONi3VOxQSjc&list=PLzA2VyZwsq_9hRcJ0nEDQkoI1aK5V74y-)

---

## **9. Good practices with Flexbox**

- Use `flex-wrap` when elements should not shrink too much.
- Avoid setting arbitrary values in `flex-grow` without considering the distribution.
- Use `align-items` and `justify-content` to improve the arrangement of elements.
- Apply `order` only when it is necessary to visually reorder elements.

---

## **Links of Interest.**

- Game to practice with Flexbox: [froggy](https://flexboxfroggy.com/#es).
- Guide to using Flexbox: [css-tricks](https://css-tricks.com/snippets/css/a-guide-to-flexbox/).

---

In the next topic, we'll explore **CSS Grid**, a more advanced layout system for organizing elements in two dimensions.
