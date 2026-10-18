# **Topic 5: Colors and Backgrounds in CSS**

## **1. Introduction to colors in CSS**

CSS allows you to define colors in various ways to apply to texts, backgrounds and borders. Different formats can be used to specify colors.

### **Methods to define colors:**

- **Color name**: `red`, `blue`, `green`, etc.
- **Hexadecimal**: `#ff0000`, `#00ff00`, `#0000ff`
- **RGB**: `rgb(255, 0, 0)`, `rgb(0, 255, 0)`, `rgb(0, 0, 255)`
- **RGBA**: `rgba(255, 0, 0, 0.5)` (with transparency)
- **HSL**: `hsl(0, 100%, 50%)`
- **HSLA**: `hsla(0, 100%, 50%, 0.5)` (with transparency)

**Example:**

```css
.texto-rojo {
  color: red;
}
.texto-hex {
  color: #ff0000;
}
.texto-rgb {
  color: rgb(255, 0, 0);
}
.texto-rgba {
  color: rgba(255, 0, 0, 0.5);
}
```


---

## **2. `background-color` property**

Allows you to define the background color of an element.

```css
div {
  background-color: lightblue;
}
```


Solid colors can be combined with transparencies using `rgba` or `hsla`.

```css
div {
  background-color: rgba(0, 0, 255, 0.5);
}
```


---

## **3. Backgrounds with images**

CSS allows you to define images as the background of an element with `background-image`.

```css
div {
  background-image: url("fondo.jpg");
}
```


You can also adjust the image size:

```css
div {
  background-size: cover; /* Ajusta la imagen para cubrir todo el contenedor */
}
```


---

## **4. `background-repeat` property**

Defines how a background image repeats.

```css
div {
  background-repeat: no-repeat;
  background-repeat: repeat-x; /* Solo en el eje X */
  background-repeat: repeat-y; /* Solo en el eje Y */
}
```


---

## **5. Property `background-position`**

Defines the position of a background image within the container.

```css
div {
  background-position: center center;
}
```


Possible values:

- `top left`, `top center`, `top right`
- `center left`, `center center`, `center right`
- `bottom left`, `bottom center`, `bottom right`

---

## **6. Property `background-attachment`**

Defines whether the background moves with the page or remains fixed.

```css
div {
  background-attachment: fixed;
}
```


Possible values:

- `scroll` (by default the background scrolls with the page)
- `fixed` (the background remains fixed when scrolling)
- `local` (moves with item content)

---

## **7. Backgrounds with gradients**

CSS allows creating gradients with the `background` property.

**Linear gradient:**

```css
div {
  background: linear-gradient(to right, red, blue);
}
```


**Radial Gradient:**

```css
div {
  background: radial-gradient(circle, red, blue);
}
```


---

[![Colors in CSS](https://img.youtube.com/vi/zCdle5q-V14/0.jpg)](https://www.youtube.com/watch?v=zCdle5q-V14&list=PLzA2VyZwsq_9hRcJ0nEDQkoI1aK5V74y-)

---

## **8. Good practices when using colors and backgrounds**

- Use colors with sufficient contrast to improve readability.
- Prefer `rgba` to handle transparencies when necessary.
- Do not abuse large background images to improve performance.
- Use `background-size` correctly so that the images adapt correctly.
- Combine colors and gradients to achieve attractive designs.

---

In the next topic, we will explore **typefaces and fonts in CSS**, including how to customize texts and use external fonts.
