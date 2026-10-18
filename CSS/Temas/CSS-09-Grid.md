# **Topic 9: Layout with CSS Grid**

## **1. Introduction to CSS Grid**

CSS Grid is a CSS layout system that lets you arrange elements in a two-dimensional grid of rows and columns. It is useful for building complex layouts in a flexible, simple way.

---

## **2. `display: grid` property**

To enable CSS Grid on a container, you use the `display: grid` property.

```css
.container {
  display: grid;
}
```


This turns the child elements into **grid items**, which can be arranged across rows and columns.

---

## **3. Defining columns and rows with `grid-template-columns` and `grid-template-rows`**

These properties let you define the size and number of columns and rows in the grid.

```css
.container {
  display: grid;
  grid-template-columns: 200px 200px;
  grid-template-rows: 100px 100px;
}
```


Common values:

- Fixed sizes (`px`, `em`, `rem`, `%`, etc.)
- Automatic (`auto`)
- Fractions (`fr`), which divide the remaining space proportionally

Example with fractions:

```css
.container {
  grid-template-columns: 1fr 2fr;
}
```


---

## **4. Repeat and spacing between elements (`gap`)**

You can also set the number of rows and columns using `repeat(número, tamaño)`.

The `gap` property defines the spacing between rows and columns.

```css
.container {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 20px;
}
```


Available values:

- `row-gap`: Spacing between rows
- `column-gap`: Spacing between columns
- `gap`: Spacing in both directions

---

## **5. Placing elements on the grid (`grid-column` and `grid-row`)**

Elements can span multiple columns or rows using `grid-column` and `grid-row`.

```css
.item {
  grid-column: 1 / 3;
  grid-row: 1 / 2;
}
```


Shortcuts:

```css
.item {
  grid-column: span 2;
}
```


---

## **6. Alignment in CSS Grid**

CSS Grid lets you align elements inside their cells with these properties (the elements need to have a size for you to see the positioning):

- `justify-items`: Aligns elements on the horizontal axis
- `align-items`: Aligns elements on the vertical axis
- `place-items`: Combines both properties

```css
.container {
  justify-items: center;
  align-items: center;
}
```


You can also align specific cells with `justify-self` and `align-self`:

```css
.item {
  justify-self: end;
  align-self: start;
}
```


---

## **7. Grid areas (`grid-template-areas`)**

It lets you define areas inside the grid and assign elements to them.

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

## **8. Best practices with CSS Grid**

- Use `fr` to create flexible layouts without needing fixed pixel sizes.
- Avoid excessive use of `grid-template-areas` for simple structures.
- Apply `gap` instead of margins to space elements.
- Use `repeat()` when you need several columns or rows of the same size.
- Combine CSS Grid with Flexbox depending on what the design needs.

---

## **Useful links**

- A game to practice CSS Grid: [Grid Garden](https://cssgridgarden.com/#es).

---

In the next topic, we will explore **pseudo-elements and pseudo-classes in CSS**, which give you more flexibility when working with the elements of a web page.
