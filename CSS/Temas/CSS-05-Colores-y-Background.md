# **Topic 5: Colors and Backgrounds in CSS**

## **1. Introduction to colors in CSS**

CSS lets you define colors in several ways and apply them to text, backgrounds and borders. You can use different formats to specify colors.

### **Ways to define colors:**

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

It lets you set the background color of an element.

```css
div {
  background-color: lightblue;
}
```


You can combine solid colors with transparency using `rgba` or `hsla`.

```css
div {
  background-color: rgba(0, 0, 255, 0.5);
}
```


---

## **3. Backgrounds with images**

CSS lets you use images as the background of an element with `background-image`.

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

It defines how a background image is repeated.

```css
div {
  background-repeat: no-repeat;
  background-repeat: repeat-x; /* Solo en el eje X */
  background-repeat: repeat-y; /* Solo en el eje Y */
}
```


---

## **5. `background-position` property**

It defines the position of a background image inside the container.

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

## **6. `background-attachment` property**

It defines whether the background scrolls with the page or stays fixed.

```css
div {
  background-attachment: fixed;
}
```


Possible values:

- `scroll` (the default: the background scrolls with the page)
- `fixed` (the background stays fixed when you scroll)
- `local` (it moves with the element's content)

---

## **7. Backgrounds with gradients**

CSS lets you create gradients with the `background` property.

**Linear gradient:**

```css
div {
  background: linear-gradient(to right, red, blue);
}
```


**Radial gradient:**

```css
div {
  background: radial-gradient(circle, red, blue);
}
```


---

[![Colors in CSS](https://img.youtube.com/vi/zCdle5q-V14/0.jpg)](https://www.youtube.com/watch?v=zCdle5q-V14&list=PLzA2VyZwsq_9hRcJ0nEDQkoI1aK5V74y-)

---

## **8. Best practices for colors and backgrounds**

- Use colors with enough contrast to improve readability.
- Prefer `rgba` to handle transparency when you need it.
- Don't overuse large background images, so performance doesn't suffer.
- Use `background-size` properly so that images fit correctly.
- Combine colors and gradients to achieve attractive designs.

---

In the next topic, we will explore **typography and fonts in CSS**, including how to customize text and use external fonts.
