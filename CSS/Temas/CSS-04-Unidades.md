# **Topic 4: Units of Measurement in CSS**

## **1. Introduction to units of measurement**

CSS allows you to define sizes, spaces and dimensions using different **units of measurement**. Understanding them is key to designing flexible and adaptable websites.

There are two main categories of units:

1. **Absolute units**: They have a fixed size, regardless of the context.
2. **Relative units**: They depend on another element or the size of the screen.

---

## **2. Absolute units**

Absolute units have a fixed value and do not change with the size of the screen or container.

| Unit | Description | Equivalence |
| ------ | ------------------- | ---------------------------------- |
| `px` | Pixels | Most common unit in screens |
| `cm` | Centimeters | Related to impressions |
| `mm` | Millimeters | Similar to cm, used in prints |
| `in` | Inches | 1in = 2.54cm |
| `pt` | Typographic points | 1pt = 1/72 in |
| `pc` | Spades | 1pc = 12pt |

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
| `em` | Relative to element font size |
| `rem` | Relative to root element font size (`html`) |
| `vw` | Relative to viewport width (1vw = 1% of window width) |
| `vh` | Relative to the height of the viewport (1vh = 1% of the window height) |
| `vmin` | Relative to the lower value between `vw` and `vh` |
| `vmax` | Relative to the highest value between `vw` and `vh` |

**Example:**

```css
.container {
  width: 50%; /* 50% del contenedor padre */
  font-size: 2em; /* Doble del tamaño de fuente del elemento */
}
```


---

## **4. Difference between `em` and `rem`**

- `em` is based on the font size of the parent element.
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

## **5. Use of `vw`, `vh`, `vmin`, and `vmax`**

These units allow you to create fluid designs.

- `vw` and `vh` are useful for defining sizes based on the screen.
- `vmin` and `vmax` allow you to adjust elements according to the lower or higher value of the viewport.

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

## **6. Good practices in the use of units**

- Use `rem` to define sources and maintain scalability.
- Use `%` and `vw/vh` to make responsive designs.
- Avoid using `px` in font sizes if you are looking for accessibility.
- Combine relative and absolute units as needed.

---

In the next topic, we will explore **colors and backgrounds in CSS**, including different color formats and how to apply them to elements.
