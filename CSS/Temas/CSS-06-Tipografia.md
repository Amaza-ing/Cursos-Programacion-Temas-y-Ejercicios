# **Tema 6: Tipografía y Fuentes en CSS**

## **1. Introducción a la tipografía en CSS**

La tipografía es un aspecto fundamental del diseño web, ya que afecta la legibilidad y la estética de una página. CSS permite definir fuentes, tamaños, espaciados y estilos para personalizar la apariencia del texto.

---

## **2. Propiedad `font-family`**

Define la fuente del texto. Se recomienda usar una lista de fuentes de respaldo.

```css
p {
  font-family: Arial, Helvetica, sans-serif;
}
```

Tipos de fuentes:

- **Serif**: Con remates (Times New Roman, Georgia)
- **Sans-serif**: Sin remates (Arial, Helvetica)
- **Monospace**: Cada carácter tiene el mismo ancho (Courier New, Consolas)
- **Cursive**: Estilo manuscrito (Comic Sans, Pacifico)
- **Fantasy**: Diseños decorativos (Papyrus, Impact)

---

## **3. Tamaño de fuente con `font-size`**

Determina el tamaño del texto, utilizando distintas unidades.

```css
h1 {
  font-size: 24px;
}
```

Unidades recomendadas:

- `px`: Píxeles (tamaño fijo)
- `em`: Relativo al tamaño del elemento padre
- `rem`: Relativo al tamaño de la raíz (`html`)

Ejemplo:

```css
p {
  font-size: 1.5em; /* 1.5 veces el tamaño base */
}
```

---

## **4. Estilos de fuente con `font-style` y `font-weight`**

### **`font-style`**

Define si el texto es normal, cursivo o inclinado.

```css
p {
  font-style: italic;
}
```

### **`font-weight`**

Define el grosor del texto.

```css
h1 {
  font-weight: bold;
}
```

Valores comunes:

- `normal`
- `bold`
- `lighter`
- `bolder`
- Números (`100` a `900`)

Ejemplo:

```css
h2 {
  font-weight: 300;
}
```

---

## **5. Espaciado del texto con `letter-spacing` y `line-height`**

### **`letter-spacing`**

Controla el espaciado entre caracteres.

```css
p {
  letter-spacing: 2px;
}
```

### **`line-height`**

Controla el espacio entre líneas.

```css
p {
  line-height: 1.5;
}
```

---

## **6. Importar fuentes externas con Google Fonts**

Para usar una fuente externa, como las de [Google Fonts](https://fonts.google.com/), se debe importar en el archivo CSS.

Ejemplo con **Roboto**:

```css
@import url("https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap");

body {
  font-family: "Roboto", sans-serif;
}
```

---

[![Tipografía & Google Fonts](https://img.youtube.com/vi/3L7GkNa0jtc/0.jpg)](https://www.youtube.com/watch?v=3L7GkNa0jtc&list=PLzA2VyZwsq_9hRcJ0nEDQkoI1aK5V74y-)

---

## **7. Buenas prácticas con tipografía en CSS**

- Utilizar `rem` o `em` en lugar de `px` para mejor accesibilidad.
- Definir fuentes de respaldo en `font-family`.
- Evitar el uso excesivo de fuentes decorativas.
- Aplicar `line-height` adecuado para mejorar la legibilidad.
- Usar **Google Fonts** o **@font-face** para fuentes personalizadas.

---

En el próximo tema, exploraremos **el posicionamiento con CSS**, incluyendo las diferencias entre posicionamiento relativo y absoluto así como otras utilidades.
