# **Tema 5: Colores y Fondos en CSS**

## **1. Introducción a los colores en CSS**

CSS permite definir colores de varias maneras para aplicar a textos, fondos y bordes. Se pueden usar diferentes formatos para especificar colores.

### **Métodos para definir colores:**

- **Nombre del color**: `red`, `blue`, `green`, etc.
- **Hexadecimal**: `#ff0000`, `#00ff00`, `#0000ff`
- **RGB**: `rgb(255, 0, 0)`, `rgb(0, 255, 0)`, `rgb(0, 0, 255)`
- **RGBA**: `rgba(255, 0, 0, 0.5)` (con transparencia)
- **HSL**: `hsl(0, 100%, 50%)`
- **HSLA**: `hsla(0, 100%, 50%, 0.5)` (con transparencia)

**Ejemplo:**

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

## **2. Propiedad `background-color`**

Permite definir el color de fondo de un elemento.

```css
div {
  background-color: lightblue;
}
```

Se pueden combinar colores sólidos con transparencias mediante `rgba` o `hsla`.

```css
div {
  background-color: rgba(0, 0, 255, 0.5);
}
```

---

## **3. Fondos con imágenes**

CSS permite definir imágenes como fondo de un elemento con `background-image`.

```css
div {
  background-image: url("fondo.jpg");
}
```

También se puede ajustar el tamaño de la imagen:

```css
div {
  background-size: cover; /* Ajusta la imagen para cubrir todo el contenedor */
}
```

---

## **4. Propiedad `background-repeat`**

Define cómo se repite una imagen de fondo.

```css
div {
  background-repeat: no-repeat;
  background-repeat: repeat-x; /* Solo en el eje X */
  background-repeat: repeat-y; /* Solo en el eje Y */
}
```

---

## **5. Propiedad `background-position`**

Define la posición de una imagen de fondo dentro del contenedor.

```css
div {
  background-position: center center;
}
```

Valores posibles:

- `top left`, `top center`, `top right`
- `center left`, `center center`, `center right`
- `bottom left`, `bottom center`, `bottom right`

---

## **6. Propiedad `background-attachment`**

Define si el fondo se desplaza con la página o permanece fijo.

```css
div {
  background-attachment: fixed;
}
```

Valores posibles:

- `scroll` (por defecto, el fondo se desplaza con la página)
- `fixed` (el fondo permanece fijo al hacer scroll)
- `local` (se mueve con el contenido del elemento)

---

## **7. Fondos con degradados**

CSS permite crear degradados con la propiedad `background`.

**Degradado lineal:**

```css
div {
  background: linear-gradient(to right, red, blue);
}
```

**Degradado radial:**

```css
div {
  background: radial-gradient(circle, red, blue);
}
```

---

## **8. Buenas prácticas al usar colores y fondos**

- Usar colores con suficiente contraste para mejorar la legibilidad.
- Preferir `rgba` para manejar transparencias cuando hagan falta.
- No abusar de imágenes de fondo grandes para mejorar el rendimiento.
- Usar `background-size` correctamente para que las imágenes se adapten correctamente.
- Combinar colores y degradados para lograr diseños atractivos.

---

En el próximo tema, exploraremos **tipografías y fuentes en CSS**, incluyendo cómo personalizar textos y utilizar fuentes externas.
