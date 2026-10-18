# **Topic 9: Design with CSS Grid**

## **1. Introduction to CSS Grid**

CSS Grid is a CSS design system that allows you to organize elements in a two-dimensional grid, with rows and columns. It is useful for creating complex design structures flexibly and easily.

---

## **2. `display: grid`** Property

To enable CSS Grid on a container, the `display: grid` property is used.

```css
.container {
  display: grid;
}
```


This turns the child elements into **grid items**, which can be arranged across rows and columns.

---

## **3. Define columns and rows with `grid-template-columns` and `grid-template-rows`**

These properties allow you to define the size and number of columns and rows in the grid.

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

You can also describe the number of rows and columns using `repeat(número, tamaño)`.

The `gap` property defines the spacing between rows and columns.

```css
.container {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 20px;
}
```


Available values:

- `row-gap`: Row spacing
- `column-gap`: Column spacing
- `gap`: Spacing in both directions

---

## **5. Locate elements on the grid (`grid-column` and `grid-row`)**

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

## **6. CSS Grid Alignment**

CSS Grid allows you to align elements within their cells with the properties (Elements must have some size to be able to observe the positioning):

- `justify-items`: Aligns elements on the horizontal axis
- `align-items`: Aligns elements on the vertical axis
- `place-items`: Combine both properties

```css
.container {
  justify-items: center;
  align-items: center;
}
```


Specific cells can also be aligned with `justify-self` and `align-self`:

```css
.item {
  justify-self: end;
  align-self: start;
}
```


---

## **7. Grid areas (`grid-template-areas`)**

Allows you to define areas within the grid and assign elements to them.

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

## **8. Good practices with CSS Grid**

- Use `fr` to create flexible layouts without the need for fixed pixels.
- Avoid excessive use of `grid-template-areas` for simple structures.
- Apply `gap` instead of margins to space elements.
- Use `repeat()` when multiple columns or rows of equal size are required.
- Combine CSS Grid with Flexbox according to the need of the design.

---

## **Links of Interest.**

- Game to practice with CSS Grid: [Grid Garden](https://cssgridgarden.com/#es).

---

In the next topic, we will explore **pseudo elements and pseudo classes in CSS**, to have greater flexibility when playing with the elements of a web page.
