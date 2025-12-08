# **Tema 4: Unidades de Medida en CSS**

## **1. Introducción a las unidades de medida**

CSS permite definir tamaños, espacios y dimensiones utilizando distintas **unidades de medida**. Comprenderlas es clave para diseñar sitios web flexibles y adaptables.

Existen dos grandes categorías de unidades:

1. **Unidades absolutas**: Tienen un tamaño fijo, independientemente del contexto.
2. **Unidades relativas**: Dependen de otro elemento o del tamaño de la pantalla.

---

## **2. Unidades absolutas**

Las unidades absolutas tienen un valor fijo y no cambian con el tamaño de la pantalla o el contenedor.

| Unidad | Descripción         | Equivalencia                       |
| ------ | ------------------- | ---------------------------------- |
| `px`   | Píxeles             | Unidad más común en pantallas      |
| `cm`   | Centímetros         | Relacionada con impresiones        |
| `mm`   | Milímetros          | Similar a cm, usada en impresiones |
| `in`   | Pulgadas            | 1in = 2.54cm                       |
| `pt`   | Puntos tipográficos | 1pt = 1/72 in                      |
| `pc`   | Picas               | 1pc = 12pt                         |

**Ejemplo:**

```css
p {
  font-size: 16px;
  width: 10cm;
}
```

---

## **3. Unidades relativas**

Las unidades relativas dependen del tamaño de otros elementos o de la pantalla.

| Unidad | Descripción                                                       |
| ------ | ----------------------------------------------------------------- |
| `%`    | Relativo al tamaño del contenedor padre                           |
| `em`   | Relativo al tamaño de la fuente del elemento                      |
| `rem`  | Relativo al tamaño de la fuente del elemento raíz (`html`)        |
| `vw`   | Relativo al ancho del viewport (1vw = 1% del ancho de la ventana) |
| `vh`   | Relativo al alto del viewport (1vh = 1% del alto de la ventana)   |
| `vmin` | Relativo al menor valor entre `vw` y `vh`                         |
| `vmax` | Relativo al mayor valor entre `vw` y `vh`                         |

**Ejemplo:**

```css
.container {
  width: 50%; /* 50% del contenedor padre */
  font-size: 2em; /* Doble del tamaño de fuente del elemento */
}
```

---

## **4. Diferencia entre `em` y `rem`**

- `em` se basa en el tamaño de la fuente del elemento padre.
- `rem` se basa en el tamaño de la fuente del `html`.

**Ejemplo:**

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

## **5. Uso de `vw`, `vh`, `vmin`, y `vmax`**

Estas unidades permiten crear diseños fluidos.

- `vw` y `vh` son útiles para definir tamaños según la pantalla.
- `vmin` y `vmax` permiten ajustar elementos según el menor o mayor valor del viewport.

**Ejemplo:**

```css
.full-screen {
  width: 100vw; /* Ocupa todo el ancho de la pantalla */
  height: 100vh; /* Ocupa todo el alto de la pantalla */
}
```

---

[![Unidades absolutas y relativas](https://img.youtube.com/vi/fMCka7YgKxg/0.jpg)](https://www.youtube.com/watch?v=fMCka7YgKxg&list=PLzA2VyZwsq_9hRcJ0nEDQkoI1aK5V74y-)

---

## **6. Buenas prácticas en el uso de unidades**

- Usar `rem` para definir fuentes y mantener escalabilidad.
- Emplear `%` y `vw/vh` para hacer diseños responsivos.
- Evitar usar `px` en tamaños de fuente si se busca accesibilidad.
- Combinar unidades relativas y absolutas según la necesidad.

---

En el próximo tema, exploraremos **colores y fondos en CSS**, incluyendo distintos formatos de color y cómo aplicarlos a los elementos.
