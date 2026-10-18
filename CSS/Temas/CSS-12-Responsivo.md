# **Topic 12: Media Queries and Responsive Design in CSS**

## **1. Introduction to responsive design**

Responsive design lets a web page adapt to different screen sizes and devices, improving the user experience on phones, tablets and desktops. To achieve this, CSS offers **media queries**, which apply conditional styles depending on the characteristics of the device.

---

## **2. What are Media Queries?**

**Media queries** let you apply CSS rules based on the width, height, resolution or specific characteristics of the device.

### **Basic syntax:**

```css
@media (condición) {
  /* Reglas CSS */
}
```


### **Example:**

```css
/* Cambia el fondo a azul en pantallas menores a 600px */
@media (max-width: 600px) {
  body {
    background-color: lightblue;
  }
}
```


In this example, when the screen width is 600 pixels or less, the background will turn blue.

---

## **3. Common breakpoints in responsive design**

**Breakpoints** are the points where the layout changes to adapt to the size of the device.

| Device | Maximum width |
| ------------------- | ------------ |
| Small phones | 480px |
| Large phones | 600px |
| Tablets | 768px |
| Laptops | 1024px |
| Large desktops | 1200px |

### **Example of multiple breakpoints:**

```css
/* Estilos para teléfonos */
@media (max-width: 600px) {
  body {
    font-size: 14px;
  }
}

/* Estilos para tabletas */
@media (min-width: 601px) and (max-width: 1024px) {
  body {
    font-size: 16px;
  }
}

/* Estilos para pantallas grandes */
@media (min-width: 1025px) {
  body {
    font-size: 18px;
  }
}
```


---

## **4. Using logical operators in media queries**

Media queries can combine conditions using logical operators.

- **`and`**: Combines multiple conditions.
- **`not`**: Excludes certain conditions.
- **`only`**: Applies styles only if the whole condition is met.

### **Example:**

```css
/* Aplica estilos solo en pantallas entre 600px y 900px */
@media (min-width: 600px) and (max-width: 900px) {
  .container {
    background-color: lightgray;
  }
}
```


---

## **5. Media Queries for orientation and resolution**

Media queries can also be used to detect screen orientation or pixel density.

### **Orientation example:**

```css
/* Estilo para pantallas en orientación horizontal */
@media (orientation: landscape) {
  body {
    background-color: lightgreen;
  }
}
```


### **Resolution example:**

```css
/* Estilos para pantallas de alta resolución */
@media (min-resolution: 192dpi) {
  img {
    filter: brightness(0.9);
  }
}
```


---

## **6. Mobile-first design**

The **mobile first** approach suggests designing for mobile devices first and then scaling up to larger screens.

### **Example:**

```css
/* Estilo base para móviles */
.button {
  font-size: 14px;
}

/* Mejora para pantallas mayores a 768px */
@media (min-width: 768px) {
  .button {
    font-size: 18px;
  }
}
```


This approach improves performance and accessibility for mobile devices.

---

## **7. New features and modern Media Queries syntax in CSS**

Over time, **media queries** have evolved, introducing new features and simplifying the syntax. These updates give you finer-grained, cleaner control over responsive design.

---

### Media Queries Level 4 syntax

The **Media Queries Level 4** specification brought with it a series of improvements that simplify the syntax and expand the possibilities.

### Simplified syntax for ranges

Previously, logical operators were used to define a range:

```css
/* Método antiguo */
@media (min-width: 600px) and (max-width: 1200px) {
  body {
    background-color: lightgray;
  }
}
```


With the modern syntax, you can write it more simply:

```css
/* Método moderno */
@media (600px <= width <= 1200px) {
  body {
    background-color: lightgray;
  }
}
```


### New types of queries

- `width` and `height`: you can leave out `min-` or `max-` by using operators.
- `aspect-ratio`: Detects the aspect ratio.
- `color-gamut`: Detects the range of supported colors.
- `prefers-reduced-motion`: Detects whether the user prefers reduced animations.

---
## **8. New features and advanced queries**

### **8.1. `prefers-color-scheme` (Dark/light mode)**

It lets you detect whether the user is using a light or dark theme.

```css
@media (prefers-color-scheme: dark) {
  body {
    background-color: #121212;
    color: #ffffff;
  }
}

@media (prefers-color-scheme: light) {
  body {
    background-color: #ffffff;
    color: #000000;
  }
}
```


### **8.2. `prefers-reduced-motion` (Reduce animations)**

It detects whether the user prefers to minimize animations.

```css
@media (prefers-reduced-motion: reduce) {
  * {
    animation: none;
    transition: none;
  }
}
```


### **8.3. `hover` and `pointer`**

They let you detect the input capabilities of the device.

```css
/* Detecta dispositivos que soportan hover */
@media (hover: hover) {
  a:hover {
    text-decoration: underline;
  }
}

/* Detecta dispositivos con puntero preciso (mouse) */
@media (pointer: fine) {
  button {
    cursor: pointer;
  }
}
```


### **8.4. `aspect-ratio` (Aspect ratio)**

It lets you apply styles based on the aspect ratio of the screen.

```css
@media (aspect-ratio: 16/9) {
  .video {
    border: 3px solid red;
  }
}
```


---

## **9. Container Queries**

One of the most important new features is the introduction of **Container Queries**, which let you apply styles based on the size of a container instead of the size of the window.

### **9.1. Basic Container Queries example**

```css
/* Definir un contenedor */
.card {
  container-type: inline-size;
}

/* Aplicar estilos según el tamaño del contenedor */
@container (min-width: 400px) {
  .card {
    background-color: lightblue;
  }
}
```


This allows components to be more responsive and adaptable without depending on the viewport size.

With these new features and modern syntax, you can create responsive designs that are smarter, more accessible, and easier to maintain.

---

[![Responsive CSS](https://img.youtube.com/vi/o2BqdTxIA9I/0.jpg)](https://www.youtube.com/watch?v=o2BqdTxIA9I&list=PLzA2VyZwsq_9hRcJ0nEDQkoI1aK5V74y-)

---

## **10. Best practices for responsive design**

- Design with the **mobile first** approach.
- Avoid fixed units like `px` and use relative units (`em`, `%`, `vh`, `vw`).
- Use **flexbox** or **grid** for flexible layouts.
- Test the layout on multiple devices and screen sizes.
- Optimize images and resources for fast loading on mobile.
- Use the simplified range syntax for cleaner code.
- Implement `prefers-color-scheme` and `prefers-reduced-motion` to improve the user experience.
- Take advantage of Container Queries for more flexible components.
