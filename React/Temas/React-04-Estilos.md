# **Topic 4: Styles in React**

## **1. Introduction**

In React, styles can be applied in several ways. Choosing the right approach from the start helps you keep your code more **tidy**, **scalable** and easier to work with.

In this topic you will learn:

- How to apply global styles.
- How to use CSS per component.
- How to write inline styles.
- How to use dynamic classes with `className`.
- Basic good practices for organizing styles.

---

## **2. Global Styles (`index.css`)**

Global styles affect the entire application. In Vite projects, they are typically loaded from `main.jsx`:

```js
import "./index.css";
```

### **Example of global styles**

**`src/index.css`**

```css
body {
  margin: 0;
  font-family: Arial, sans-serif;
}

h1 {
  font-size: 32px;
}
```

This type of styles is useful for:

- Reset or normalization
- Fonts
- Base styles of the application

---

## **3. CSS per component (`.css` file + import)**

A very common way to work in React is to create component-specific CSS and **import it** into the component file.

### **Example: component with its own CSS**

Recommended structure:

```
src/
│── components/
│   ├── Button.jsx
│   ├── Button.css
```

**`src/components/Button.css`**

```css
.primaryButton {
  padding: 10px 14px;
  border: none;
  border-radius: 8px;
  cursor: pointer;
}
```

**`src/components/Button.jsx`**

```js
import "./Button.css";

function Button() {
  return <button className="primaryButton">Click</button>;
}

export default Button;
```

This approach is:

- Simple to understand
- Compatible with any project
- Easy to scale if you are consistent with names

> Note: This CSS is still global (classes exist throughout the project), but is **organized by component**.

---

## **4. Inline styles (JavaScript object)**

React allows you to apply inline styles using an object in the `style` property.

### **Key Features**

- `style` receives an **item**.
- CSS properties are written to **camelCase**.
- Numeric values ​​are interpreted as `px` (in many cases).

Example:

```js
function Card() {
  const cardStyle = {
    padding: "16px",
    borderRadius: "12px",
    border: "1px solid #ddd",
  };

  return <div style={cardStyle}>Card</div>;
}

export default Card;
```

### **When to use inline styles**

- For very specific styles
- For values calculated in real time
- For prototypes

### **When to avoid them**

- When the component has a lot of CSS
- When you want to use pseudo-classes (`:hover`, `:focus`) without libraries

---

## **5. `className` in React (very important)**

In React `class` is not used, `className` is used.

This is required:

```js
function Alert() {
  return <div className="alert">Warning</div>;
}
```

---

## **6. Dynamic classes with `className`**

Many times, we want to change the class based on a condition.

Example:

```js
function StatusBadge() {
  const isOnline = true;

  const badgeClass = isOnline ? "badgeOnline" : "badgeOffline";

  return <span className={badgeClass}>Status</span>;
}

export default StatusBadge;
```

**`StatusBadge.css`**

```css
.badgeOnline {
  padding: 6px 10px;
  border-radius: 10px;
}

.badgeOffline {
  padding: 6px 10px;
  border-radius: 10px;
  opacity: 0.5;
}
```

---

## **7. CSS Modules (isolate styles per component)**

**CSS Modules** allow classes to be **isolated** per file, avoiding name collisions.

In Vite (and in many environments), they work by creating the file with extension:

- `Component.module.css`

### **Example with CSS Modules**

**`src/components/ProfileCard.module.css`**

```css
.card {
  padding: 16px;
  border: 1px solid #ddd;
  border-radius: 12px;
}

.title {
  margin: 0;
}
```

**`src/components/ProfileCard.jsx`**

```js
import styles from "./ProfileCard.module.css";

function ProfileCard() {
  return (
    <div className={styles.card}>
      <h3 className={styles.title}>Profile</h3>
    </div>
  );
}

export default ProfileCard;
```

Advantages:

- There are no class collisions.
- Really “per component” styles.
- Makes it easier to maintain large projects.

---

## **8. Good practices for organizing styles**

- Maintain global styles only for the essentials.
- For reusable components, use CSS per component or CSS Modules.
- Avoid mixing many inline styles with traditional CSS.
- Name classes with intent: `primaryButton`, `errorText`, `cardHeader`.

---
## **9. To take into account**

- In React, `className` replaces `class`.
- You can apply styles in many ways: global, per component, inline or CSS Modules.
- For growing projects, CSS Modules are a very solid option.

---

[![Styles](https://img.youtube.com/vi/WkaNDbO8za4/0.jpg)](https://www.youtube.com/watch?v=WkaNDbO8za4&list=PLzA2VyZwsq_-dE3Jvunglxq8a6UcH6gnF)

---

In the next topic we will look at **components on a line** and how to write small, reusable components in a clean way.
