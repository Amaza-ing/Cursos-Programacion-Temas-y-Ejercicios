# **Exercises - Topic 4: Styles in React**

Below you will find **10 practical exercises** on styles in React.

Try to solve them before looking at the solution.

---

## **Exercise 1: Global style for the entire app**

In `src/index.css`, add global styles so that:

- The `body` has `margin: 0`.
- The font is `system-ui`.
- The background is a light color (choose one).

<details><summary>Show solution</summary>

```css
body {
  margin: 0;
  font-family: system-ui;
  background: #f5f5f5;
}
```

</details>

---

## **Exercise 2: Import a CSS file from a component**

Create a `Notice.jsx` component in `src/components/` that displays:

- A `div` with a `p` that says: **"This is a notice"**

Create its associated CSS file, `Notice.css`, and apply a class so that the `div`:

- Has `padding: 12px`
- Has `border-radius: 10px`
- Has a thin border

<details><summary>Show solution</summary>

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

## **Exercise 3: Replace `class` with `className`**

This component doesn't apply the class in React. Fix it:

```js
function Banner() {
  return <div class="banner">Hello</div>;
}

export default Banner;
```

<details><summary>Show solution</summary>

```js
function Banner() {
  return <div className="banner">Hello</div>;
}

export default Banner;
```

</details>

---

## **Exercise 4: Inline styles with camelCase**

Create an `InlineBox.jsx` component that:

- Renders a `div` with the text **"Inline"**.
- Uses `style` with these properties:

  - `padding: 14px`
  - `borderRadius: 12px`
  - `border: 1px solid #ddd`

<details><summary>Show solution</summary>

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

## **Exercise 5: Inline styles with a reusable object**

Create a `Panel.jsx` component that:

- Defines a `panelStyle` object outside the JSX.
- Uses it on a `section` with `style={panelStyle}`.
- Shows an `h3` inside that says: **"Panel"**.

<details><summary>Show solution</summary>

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

## **Exercise 6: Dynamic `className` with a ternary**

Create a `PriorityTag.jsx` component with an `isHighPriority` variable (set to `true`).

- If it is `true`, it applies the `priorityHigh` class.
- If it is `false`, it applies `priorityLow`.

Create the CSS file `PriorityTag.css` with both classes (simple styles are enough).

<details><summary>Show solution</summary>

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

## **Exercise 7: Dynamic `className` with an array of classes**

Create a `Chip.jsx` component that:

- Has `isSelected = true`.
- Always applies the `chip` class.
- If `isSelected` is `true`, also adds the `chipSelected` class.

Hint: you can build an array of classes and join it with `.join(" ")`.

<details><summary>Show solution</summary>

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

## **Exercise 8: Create and use a CSS Module**

Create a `MiniCard.jsx` component using CSS Modules:

- CSS file: `MiniCard.module.css`
- Classes: `card` and `title`

The component must render:

- A `div` with class `card`
- An `h4` with class `title` and text **"Mini Card"**

<details><summary>Show solution</summary>

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

## **Exercise 9: Decide between `assets` and `public` (practical case)**

Decide where you would store each file and why:

1. `brand.svg` that you want to import into a component with `import brand from ...`.
2. `terms.pdf` that you want to open with a direct `/terms.pdf` link.

<details><summary>Show solution</summary>

1. `src/assets/` because it will be imported from the code and goes through the bundler.
2. `public/` because you want direct access by URL (`/terms.pdf`).

</details>

---

## **Exercise 10: Organizing styles (choose the most recommended option)**

Choose the most recommended option:

1. Where would you put a basic reset (for example `body { margin: 0 }`)?

   - a) In a CSS Module
   - b) In `index.css`
   - c) Inside `style={{...}}` in `App.jsx`

2. If a component grows and starts to have many classes, which option is usually more robust?

   - a) Keep everything inline
   - b) CSS Modules
   - c) Put all classes in `index.css`

3. In React, to apply a class you use:

   - a) `class`
   - b) `className`
   - c) `cssClass`

<details><summary>Show solution</summary>

1. b) In `index.css`.
2. b) CSS Modules.
3. b) `className`.

</details>
