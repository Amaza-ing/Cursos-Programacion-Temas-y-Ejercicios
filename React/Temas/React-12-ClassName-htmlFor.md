# **Topic 12: className, htmlFor and other similar cases**

## **1. Introduction**

When you come from HTML/CSS, there are several attributes that in React are **not written the same**. This happens because React uses JSX, and JSX is closer to JavaScript than traditional HTML.

In this topic you will learn:

- Why is it used in React? `className` rather `class`.
- Why is it used in React? `htmlFor` rather `for`.
- Other “special” attributes or with important differences.
- Good practices and typical errors.

---

## **2. `className` in React**

In HTML we write:

```html
<div class="card">...</div>
```

In React, **not used `class`**, because `class` is a reserved word in JavaScript. ** is used instead`className`**:

```js
function Card() {
  return <div className="card">Card</div>;
}

export default Card;
```

### **2.1. `className` dynamic**

`className` It can also depend on a condition (we connect it with what we see in styles and conditional rendering).

```js
function StatusPill() {
  const isActive = true;

  return (
    <span className={isActive ? "pillActive" : "pillInactive"}>Status</span>
  );
}

export default StatusPill;
```

---

## **3. `htmlFor` in React**

In HTML, to associate a `label` still `input` is used `for`:

```html
<label for="email">Email</label> <input id="email" />
```

In React, **not used `for`** because the reserved word exists in JavaScript `for`. In JSX you use **`htmlFor`**.

### **Correct example in React**

```js
function EmailField() {
  return (
    <div>
      <label htmlFor="email">Email</label>
      <input id="email" type="email" />
    </div>
  );
}

export default EmailField;
```

**Clue:**

- `htmlFor` must match the `id` of the input.

---

## **4. Other important attributes and differences**

### **4.1. `style` (object, not string)**

In HTML:

```html
<div style="background: red; padding: 10px"></div>
```

In React, `style` receives an **object** and the properties go in **camelCase**:

```js
function Box() {
  return <div style={{ backgroundColor: "red", padding: "10px" }}>Box</div>;
}

export default Box;
```

---

### **4.2. `onClick`, `onChange`, etc. (camelCase + function)**

In HTML:

```html
<button onclick="doSomething()">Click</button>
```

In React:

- It is written in camelCase (`onClick`).
- A function is passed (not a string).

```js
function Button() {
  const handleClick = () => {
    console.log("Clicked");
  };

  return <button onClick={handleClick}>Click</button>;
}

export default Button;
```

---

### **4.3. `tabIndex` (No `tabindex`)**

In React you use:

```js
<div tabIndex={0}>Focusable</div>
```

---

### **4.4. `readOnly` (No `readonly`)**

```js
<input value="Fixed" readOnly />
```

---

### **4.5. Boolean attributes**

In React, booleans can be written short:

```js
<input disabled />
<input required />
```

And also dynamically:

```js
<input disabled={isDisabled} />
```

---

### **4.6. `defaultValue` and `defaultChecked`**

In **uncontrolled** inputs, the following are used:

```js
<input defaultValue="Hello" />
<input type="checkbox" defaultChecked />
```

This is useful when:

- You don't want to use `useState`.
- You just want an initial value.

---

### **4.7. `dangerouslySetInnerHTML` (advanced case)**

Sometimes you need to insert HTML that comes from outside (for example, from an API). React blocks it for security, and requires using this property.

```js
function HtmlBlock() {
  const html = "<strong>Bold</strong>";

  return <div dangerouslySetInnerHTML={{ __html: html }} />;
}

export default HtmlBlock;
```

> Note: use with care, because it can cause security issues (XSS) if the HTML is not sanitized.

---

## **5. Quick list of common “translations”**

- `class` → `className`
- `for` → `htmlFor`
- `tabindex` → `tabIndex`
- `readonly` → `readOnly`
- `onclick` → `onClick`
- `onchange` → `onChange`
- `autofocus` → `autoFocus`

---

## **6. Typical errors**

### **6.1. Wear `class` in JSX**

```js
<div class="box">...</div>
```

It must be:

```js
<div className="box">...</div>
```

---

### **6.2. Wear `for` in `label`**

```js
<label for="name">Name</label>
```

It must be:

```js
<label htmlFor="name">Name</label>
```

---

### **6.3. Write `style` as string**

```js
<div style="color: red">...</div>
```

Must be an object:

```js
<div style={{ color: "red" }}>...</div>
```

---

## **7. Good practices**

- Be consistent with `className`.
- Make sure `htmlFor` and `id` match.
- Prefer styles in CSS/CSS Modules and use inline styles only when it makes sense.
- Learn the list of most common special attributes: it will save you a lot of mistakes.

---

## **8. To take into account**

- JSX is not HTML: some attributes change.
- The most important ones when starting out are `className` and `htmlFor`.
- Events are written to camelCase and given functions.
- `style` is written as an object.

---

[![Classname, htmlFor and others](https://img.youtube.com/vi/CcMlJxlHno8/0.jpg)](https://www.youtube.com/watch?v=CcMlJxlHno8&list=PLzA2VyZwsq_-dE3Jvunglxq8a6UcH6gnF)

---

In the next topic we will see **Props Child to Parent and Raise State**, so that a child component can communicate information to the parent through functions.
