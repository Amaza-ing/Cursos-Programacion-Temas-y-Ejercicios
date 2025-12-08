# **Tema 7: Posicionamiento en CSS**

## **1. Introducción al Posicionamiento en CSS**

El posicionamiento en CSS permite controlar la ubicación de los elementos dentro de una página web. Se define con la propiedad `position`, que ofrece diferentes modos para organizar los elementos según la necesidad del diseño.

---

## **2. Propiedad `position` y sus valores**

La propiedad `position` tiene varios valores que afectan la ubicación de un elemento en el flujo del documento.

| Valor      | Descripción                                                                                                |
| ---------- | ---------------------------------------------------------------------------------------------------------- |
| `static`   | Valor por defecto. Los elementos siguen el flujo normal del documento.                                     |
| `relative` | El elemento se posiciona **relativo** a su ubicación original.                                             |
| `absolute` | El elemento se posiciona **relativo** a su primer ancestro con `position: relative`, `absolute` o `fixed`. |
| `fixed`    | El elemento se mantiene fijo en la pantalla sin importar el scroll.                                        |
| `sticky`   | El elemento actúa como relativo hasta que se alcanza un punto del scroll, donde se vuelve fijo.            |

---

## **3. `position: static` (Posición por defecto)**

Todos los elementos en HTML tienen `position: static` de manera predeterminada.

```css
.box {
  position: static;
}
```

Los elementos con `static` siguen el flujo normal del documento y no responden a `top`, `right`, `bottom` o `left`.

---

## **4. `position: relative` (Posición relativa)**

Permite mover un elemento **desde su posición original** sin afectar a los elementos cercanos.

```css
.box {
  position: relative;
  top: 20px;
  left: 30px;
}
```

El elemento se desplazará 20px hacia abajo y 30px hacia la derecha desde su posición inicial.

---

## **5. `position: absolute` (Posición absoluta)**

Posiciona un elemento de manera **absoluta con respecto a su primer ancestro posicionado** (`relative`, `absolute`, `fixed`).

```css
.container {
  position: relative;
}

.box {
  position: absolute;
  top: 10px;
  left: 20px;
}
```

Si `.container` no tuviera `position: relative`, `.box` se posicionaría con respecto al `body`.

---

## **6. `position: fixed` (Posición fija)**

Mantiene un elemento fijo en la pantalla sin importar el scroll.

```css
.navbar {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  background-color: black;
  color: white;
}
```

Útil para menús de navegación fijos en la parte superior de la página.

---

## **7. `position: sticky` (Posición adhesiva)**

El elemento se comporta como `relative` hasta alcanzar un punto del scroll, donde se vuelve `fixed`.

```css
.header {
  position: sticky;
  top: 0;
  background-color: yellow;
}
```

Útil para títulos de secciones o encabezados en tablas.

---

## **8. Diferencias clave entre `relative`, `absolute`, `fixed` y `sticky`**

| Propiedad  | Se mueve con el scroll | Relativo a                              |
| ---------- | ---------------------- | --------------------------------------- |
| `relative` | Sí                     | Su posición original                    |
| `absolute` | Sí                     | Su primer ancestro posicionado          |
| `fixed`    | No                     | La ventana del navegador                |
| `sticky`   | Parcialmente           | Su posición hasta que alcanza un umbral |

---

[![Posicionamiento en CSS](https://img.youtube.com/vi/-BfSfqOHrug/0.jpg)](https://www.youtube.com/watch?v=-BfSfqOHrug&list=PLzA2VyZwsq_9hRcJ0nEDQkoI1aK5V74y-)

---

## **9. Buenas prácticas en el uso del posicionamiento**

- Usar `relative` cuando se necesite mover elementos sin afectar otros.
- Aplicar `absolute` solo cuando se tenga un contenedor posicionado.
- Evitar `fixed` en elementos grandes, ya que pueden afectar la usabilidad.
- Usar `sticky` para mejorar la experiencia de navegación.

---

En el próximo tema, exploraremos **el diseño con flexbox en CSS**, una técnica poderosa para la disposición de elementos en una página.
