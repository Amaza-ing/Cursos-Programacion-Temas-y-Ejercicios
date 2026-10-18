# **Topic 4: Units of Measurement in CSS**

## **1. Introduction to units of measurement**

CSS lets you define sizes, spacing and dimensions using different **units of measurement**. Understanding them is key to designing flexible, adaptable websites.

There are two main categories of units:

1. **Absolute units**: They have a fixed size, regardless of the context.
2. **Relative units**: They depend on another element or the size of the screen.

---

## **2. Absolute units**

Absolute units have a fixed value and do not change with the size of the screen or container.

| Unit | Description | Equivalence |
| ------ | ------------------- | ---------------------------------- |
| `px` | Pixels | The most common unit on screens |
| `cm` | Centimeters | Related to print |
| `mm` | Millimeters | Similar to cm, used for print |
| `in` | Inches | 1in = 2.54cm |
| `pt` | Points | 1pt = 1/72 in |
| `pc` | Picas | 1pc = 12pt |

**Example:**

```css
p {
  font-size: 16px;
  width: 10cm;
}
```


---

## **3. Relative units**

Relative units depend on the size of other elements or the screen.

| Unit | Description |
| ------ | ----------------------------------------------------------------- |
| `%` | Relative to the size of the parent container |
| `em` | Relative to the element's font size (in `font-size`, to the parent's) |
| `rem` | Relative to the root element's font size (`html`) |
| `vw` | Relative to the viewport width (1vw = 1% of the window width) |
| `vh` | Relative to the viewport height (1vh = 1% of the window height) |
| `vmin` | Relative to the smaller of `vw` and `vh` |
| `vmax` | Relative to the larger of `vw` and `vh` |

**Example:**

```css
.container {
  width: 50%; /* 50% del contenedor padre */
  font-size: 2em; /* Doble del tamaño de fuente del padre */
}
```


---

## **4. Difference between `em` and `rem`**

- `em` is based on the element's own font size (when you use it in `font-size`, on the parent element's).
- `rem` is based on the `html` font size.

**Example:**

```css
html {
  font-size: 16px;
}

p {
  font-size: 2em; /* 32px si el tamaño base es 16px */
}

div {
  font-size: 2rem; /* Siempre 32px, sin importar el padre */
}
```


---

## **5. Using `vw`, `vh`, `vmin` and `vmax`**

These units let you create fluid layouts.

- `vw` and `vh` are useful for defining sizes based on the screen.
- `vmin` and `vmax` let you size elements according to the smaller or larger dimension of the viewport.

**Example:**

```css
.full-screen {
  width: 100vw; /* Ocupa todo el ancho de la pantalla */
  height: 100vh; /* Ocupa todo el alto de la pantalla */
}
```


---

[![Absolute and relative units](https://img.youtube.com/vi/fMCka7YgKxg/0.jpg)](https://www.youtube.com/watch?v=fMCka7YgKxg&list=PLzA2VyZwsq_9hRcJ0nEDQkoI1aK5V74y-)

---

## **6. Best practices for using units**

- Use `rem` to define font sizes and keep your styles scalable.
- Use `%` and `vw/vh` to make responsive designs.
- Avoid using `px` for font sizes if you care about accessibility.
- Combine relative and absolute units as needed.

---

In the next topic, we will explore **colors and backgrounds in CSS**, including different color formats and how to apply them to elements.
