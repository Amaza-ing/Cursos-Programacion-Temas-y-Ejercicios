# **Ejercicios - Tema 4: Estilos en React**

A continuación, encontrarás **10 ejercicios prácticos** sobre estilos en React.

Intenta resolverlos antes de consultar la solución.

---

## **Ejercicio 1: Estilo global para toda la app**

En `src/index.css`, añade estilos globales para que:

- El `body` tenga `margin: 0`.
- La fuente sea `system-ui`.
- El fondo tenga un color claro (elige uno).

<details><summary>Mostrar Solución</summary>

```css
body {
  margin: 0;
  font-family: system-ui;
  background: #f5f5f5;
}
```

</details>

---

## **Ejercicio 2: Importar un CSS desde un componente**

Crea un componente `Notice.jsx` en `src/components/` que muestre:

- Un `div` con un `p` que diga: **"This is a notice"**

Crea su CSS asociado `Notice.css` y aplícale una clase para que el `div`:

- Tenga `padding: 12px`
- Tenga `border-radius: 10px`
- Tenga un borde fino

<details><summary>Mostrar Solución</summary>

**`src/components/Notice.css`**

```css
.notice {
  padding: 12px;
  border-radius: 10px;
  border: 1px solid #ddd;
}
```

**`src/components/Notice.jsx`**

```js
import "./Notice.css";

function Notice() {
  return (
    <div className="notice">
      <p>This is a notice</p>
    </div>
  );
}

export default Notice;
```

</details>

---

## **Ejercicio 3: Corregir `class` por `className`**

Este componente no aplica la clase en React. Corrígelo:

```js
function Banner() {
  return <div class="banner">Hello</div>;
}

export default Banner;
```

<details><summary>Mostrar Solución</summary>

```js
function Banner() {
  return <div className="banner">Hello</div>;
}

export default Banner;
```

</details>

---

## **Ejercicio 4: Inline styles con camelCase**

Crea un componente `InlineBox.jsx` que:

- Renderice un `div` con el texto **"Inline"**.
- Use `style` con estas propiedades:

  - `padding: 14px`
  - `borderRadius: 12px`
  - `border: 1px solid #ddd`

<details><summary>Mostrar Solución</summary>

```js
function InlineBox() {
  return (
    <div
      style={{
        padding: "14px",
        borderRadius: "12px",
        border: "1px solid #ddd",
      }}
    >
      Inline
    </div>
  );
}

export default InlineBox;
```

</details>

---

## **Ejercicio 5: Estilos inline con objeto reutilizable**

Crea un componente `Panel.jsx` que:

- Defina un objeto `panelStyle` fuera del JSX.
- Lo use en un `section` con `style={panelStyle}`.
- Dentro muestre un `h3` que diga: **"Panel"**.

<details><summary>Mostrar Solución</summary>

```js
function Panel() {
  const panelStyle = {
    padding: "16px",
    border: "1px solid #ddd",
    borderRadius: "12px",
  };

  return (
    <section style={panelStyle}>
      <h3>Panel</h3>
    </section>
  );
}

export default Panel;
```

</details>

---

## **Ejercicio 6: `className` dinámico con ternario**

Crea un componente `PriorityTag.jsx` con una variable `isHighPriority` (en `true`).

- Si es `true`, aplica la clase `priorityHigh`.
- Si es `false`, aplica `priorityLow`.

Crea el CSS `PriorityTag.css` con ambas clases (puedes dar estilos simples).

<details><summary>Mostrar Solución</summary>

**`src/components/PriorityTag.css`**

```css
.priorityHigh {
  padding: 6px 10px;
  border-radius: 10px;
  border: 1px solid #ddd;
}

.priorityLow {
  padding: 6px 10px;
  border-radius: 10px;
  border: 1px solid #ddd;
  opacity: 0.6;
}
```

**`src/components/PriorityTag.jsx`**

```js
import "./PriorityTag.css";

function PriorityTag() {
  const isHighPriority = true;

  const tagClass = isHighPriority ? "priorityHigh" : "priorityLow";

  return <span className={tagClass}>Priority</span>;
}

export default PriorityTag;
```

</details>

---

## **Ejercicio 7: `className` dinámico con array de clases**

Crea un componente `Chip.jsx` que:

- Tenga `isSelected = true`.
- Siempre aplique la clase `chip`.
- Si `isSelected` es `true`, añada también la clase `chipSelected`.

Pista: puedes construir un array de clases y unirlo con `.join(" ")`.

<details><summary>Mostrar Solución</summary>

**`src/components/Chip.css`**

```css
.chip {
  display: inline-block;
  padding: 6px 10px;
  border-radius: 999px;
  border: 1px solid #ddd;
}

.chipSelected {
  font-weight: bold;
}
```

**`src/components/Chip.jsx`**

```js
import "./Chip.css";

function Chip() {
  const isSelected = true;

  const classList = ["chip"];
  if (isSelected) classList.push("chipSelected");

  return <span className={classList.join(" ")}>Chip</span>;
}

export default Chip;
```

</details>

---

## **Ejercicio 8: Crear y usar un CSS Module**

Crea un componente `MiniCard.jsx` usando CSS Modules:

- Archivo CSS: `MiniCard.module.css`
- Clases: `card` y `title`

El componente debe renderizar:

- Un `div` con clase `card`
- Un `h4` con clase `title` y texto **"Mini Card"**

<details><summary>Mostrar Solución</summary>

**`src/components/MiniCard.module.css`**

```css
.card {
  padding: 14px;
  border: 1px solid #ddd;
  border-radius: 12px;
}

.title {
  margin: 0;
}
```

**`src/components/MiniCard.jsx`**

```js
import styles from "./MiniCard.module.css";

function MiniCard() {
  return (
    <div className={styles.card}>
      <h4 className={styles.title}>Mini Card</h4>
    </div>
  );
}

export default MiniCard;
```

</details>

---

## **Ejercicio 9: Decidir entre `assets` y `public` (caso práctico)**

Decide dónde guardarías cada archivo y por qué:

1. `brand.svg` que quieres importar en un componente con `import brand from ...`.
2. `terms.pdf` que quieres abrir con un link directo `/terms.pdf`.

<details><summary>Mostrar Solución</summary>

1. `src/assets/` porque se importará desde el código y pasa por el bundler.
2. `public/` porque quieres acceso directo por URL (`/terms.pdf`).

</details>

---

## **Ejercicio 10: Organización de estilos (elige la opción más recomendada)**

Elige la opción más recomendable:

1. ¿Dónde pondrías un reset básico (por ejemplo `body { margin: 0 }`)?

   - a) En un CSS Module
   - b) En `index.css`
   - c) Dentro de `style={{...}}` en `App.jsx`

2. Si un componente crece y empieza a tener muchas clases, ¿qué opción suele ser más sólida?

   - a) Mantener todo inline
   - b) CSS Modules
   - c) Poner todas las clases en `index.css`

3. En React, para aplicar una clase se usa:

   - a) `class`
   - b) `className`
   - c) `cssClass`

<details><summary>Mostrar Solución</summary>

1. b) En `index.css`.
2. b) CSS Modules.
3. b) `className`.

</details>
