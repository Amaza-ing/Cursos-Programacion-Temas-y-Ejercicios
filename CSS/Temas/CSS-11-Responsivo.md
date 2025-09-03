# **Tema 11: Media Queries y Diseño Responsivo en CSS**

## **1. Introducción al diseño responsivo**

El diseño responsivo permite que una página web se adapte a diferentes tamaños de pantalla y dispositivos, mejorando la experiencia del usuario en móviles, tabletas y escritorios. Para lograrlo, CSS ofrece las **media queries**, que aplican estilos condicionales según las características del dispositivo.

---

## **2. ¿Qué son las Media Queries?**

Las **media queries** permiten aplicar reglas CSS basadas en el ancho, alto, resolución o características específicas del dispositivo.

### **Sintaxis básica:**

```css
@media (condición) {
  /* Reglas CSS */
}
```

### **Ejemplo:**

```css
/* Cambia el fondo a azul en pantallas menores a 600px */
@media (max-width: 600px) {
  body {
    background-color: lightblue;
  }
}
```

En este ejemplo, cuando el ancho de la pantalla sea de 600 píxeles o menos, el fondo se volverá azul.

---

## **3. Breakpoints comunes en diseño responsivo**

Los **breakpoints** son puntos donde el diseño cambia para adaptarse al tamaño del dispositivo.

| Dispositivo         | Ancho máximo |
| ------------------- | ------------ |
| Teléfonos pequeños  | 480px        |
| Teléfonos grandes   | 600px        |
| Tabletas            | 768px        |
| Laptops             | 1024px       |
| Escritorios grandes | 1200px       |

### **Ejemplo de múltiples breakpoints:**

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

## **4. Uso de operadores lógicos en media queries**

Las media queries pueden combinar condiciones usando operadores lógicos.

- **`and`**: Combina múltiples condiciones.
- **`not`**: Excluye ciertas condiciones.
- **`only`**: Aplica estilos solo si se cumple toda la condición.

### **Ejemplo:**

```css
/* Aplica estilos solo en pantallas entre 600px y 900px */
@media (min-width: 600px) and (max-width: 900px) {
  .container {
    background-color: lightgray;
  }
}
```

---

## **5. Media Queries para orientación y resolución**

También se pueden usar media queries para detectar la orientación de la pantalla o la densidad de píxeles.

### **Ejemplo de orientación:**

```css
/* Estilo para pantallas en orientación horizontal */
@media (orientation: landscape) {
  body {
    background-color: lightgreen;
  }
}
```

### **Ejemplo de resolución:**

```css
/* Estilos para pantallas de alta resolución */
@media (min-resolution: 192dpi) {
  img {
    filter: brightness(0.9);
  }
}
```

---

## **6. Diseño móvil primero (Mobile First)**

El enfoque **mobile first** sugiere diseñar primero para dispositivos móviles y luego escalar hacia pantallas más grandes.

### **Ejemplo:**

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

Este enfoque mejora el rendimiento y la accesibilidad para dispositivos móviles.

---

## **7. Novedades y Sintaxis Moderna de Media Queries en CSS**

Con el paso del tiempo, las **media queries** han evolucionado, introduciendo nuevas características y simplificaciones en la sintaxis. Estas actualizaciones permiten un control más granular y limpio del diseño responsivo.

---

### Sintaxis de nivel 4 de Media Queries

La especificación de **Media Queries Level 4** trajo consigo una serie de mejoras que simplifican la sintaxis y amplían las posibilidades.

### Sintaxis simplificada para rangos

Antes, para definir un rango se usaban operadores lógicos:

```css
/* Método antiguo */
@media (min-width: 600px) and (max-width: 1200px) {
  body {
    background-color: lightgray;
  }
}
```

Con la sintaxis moderna, se puede escribir de forma más sencilla:

```css
/* Método moderno */
@media (600px <= width <= 1200px) {
  body {
    background-color: lightgray;
  }
}
```

### Nuevos tipos de consultas

- `width` y `height`: Se puede omitir `min-` o `max-` usando operadores.
- `aspect-ratio`: Detecta la relación de aspecto.
- `color-gamut`: Detecta el rango de colores soportados.
- `prefers-reduced-motion`: Detecta si el usuario prefiere animaciones reducidas.

---

## **8. Nuevas características y consultas avanzadas**

### **8.1. `prefers-color-scheme` (Modo oscuro/claro)**

Permite detectar si el usuario utiliza un tema claro u oscuro.

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

### **8.2. `prefers-reduced-motion` (Reducir animaciones)**

Detecta si el usuario prefiere minimizar las animaciones.

```css
@media (prefers-reduced-motion: reduce) {
  * {
    animation: none;
    transition: none;
  }
}
```

### **8.3. `hover` y `pointer`**

Permiten detectar las capacidades de entrada del dispositivo.

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

### **8.4. `aspect-ratio` (Relación de aspecto)**

Permite aplicar estilos basados en la relación de aspecto de la pantalla.

```css
@media (aspect-ratio: 16/9) {
  .video {
    border: 3px solid red;
  }
}
```

---

## **9. Media Queries Contenedores (Container Queries)**

Una de las novedades más importantes es la introducción de las **Container Queries**, que permiten aplicar estilos basados en el tamaño de un contenedor, en lugar del tamaño de la ventana.

### **9.1. Ejemplo básico de Container Queries**

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

Esto permite que los componentes sean más responsivos y adaptables sin depender del tamaño del viewport.

Con estas novedades y sintaxis moderna, puedes crear diseños responsivos más inteligentes, accesibles y fáciles de mantener.

## **10. Buenas prácticas en diseño responsivo**

- Diseñar con el enfoque **mobile first**.
- Evitar unidades fijas como `px` y usar unidades relativas (`em`, `%`, `vh`, `vw`).
- Utilizar **flexbox** o **grid** para layouts flexibles.
- Probar el diseño en múltiples dispositivos y tamaños de pantalla.
- Optimizar imágenes y recursos para cargas rápidas en móviles.
- Utilizar la sintaxis simplificada para rangos para un código más limpio.
- Implementar `prefers-color-scheme` y `prefers-reduced-motion` para mejorar la experiencia de usuario.
- Aprovechar las Container Queries para componentes más flexibles.
