# **Topic 12: className, htmlFor and other similar cases**

## **1. Introduction**

When you come from HTML/CSS, there are several attributes that in React are **not written the same**. This happens because React uses JSX, and JSX is closer to JavaScript than to traditional HTML.

In this topic you will learn:

- Why React uses `className` instead of `class`.
- Why React uses `htmlFor` instead of `for`.
- Other “special” attributes, or ones with important differences.
- Best practices and common mistakes.

---

## **2. `className` in React**

In HTML we write:

```html
<div class="card">...</div>
```

In React, **you don't use `class`**, because `class` is a reserved word in JavaScript. Instead, you use **`className`**:

```js
function Card() {
  return <div className="card">Card</div>;
}

export default Card;
```

### **2.1. Dynamic `className`**

`className` can also depend on a condition (this ties in with what we saw in styles and conditional rendering).

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

In HTML, to associate a `label` with an `input`, you use `for`:

```html
<label for="email">Email</label> <input id="email" />
```

In React, **you don't use `for`** because `for` is a reserved word in JavaScript. In JSX you use **`htmlFor`**.

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

**Key point:**

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

- It's written in camelCase (`onClick`).
- You pass a function (not a string).

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

### **4.3. `tabIndex` (not `tabindex`)**

In React you use:

```js
<div tabIndex={0}>Focusable</div>
```

---

### **4.4. `readOnly` (not `readonly`)**

```js
<input value="Fixed" readOnly />
```

---

### **4.5. Boolean attributes**

In React, boolean attributes can be written in short form:

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

In **uncontrolled** inputs, you use:

```js
<input defaultValue="Hello" />
<input type="checkbox" defaultChecked />
```

This is useful when:

- You don't want to use `useState`.
- You just want an initial value.

---

### **4.7. `dangerouslySetInnerHTML` (advanced case)**

Sometimes you need to insert HTML that comes from outside (for example, from an API). React blocks it for security reasons and requires you to use this prop.

```js
function HtmlBlock() {
  const html = "<strong>Bold</strong>";

  return <div dangerouslySetInnerHTML={{ __html: html }} />;
}

export default HtmlBlock;
```

> Note: use it with care, because it can cause security issues (XSS) if the HTML isn't sanitized.

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

## **6. Common mistakes**

### **6.1. Using `class` in JSX**

```js
<div class="box">...</div>
```

It must be:

```js
<div className="box">...</div>
```

---

### **6.2. Using `for` in `label`**

```js
<label for="name">Name</label>
```

It must be:

```js
<label htmlFor="name">Name</label>
```

---

### **6.3. Writing `style` as a string**

```js
<div style="color: red">...</div>
```

It must be an object:

```js
<div style={{ color: "red" }}>...</div>
```

---

## **7. Best practices**

- Be consistent with `className`.
- Make sure `htmlFor` and `id` match.
- Prefer styles in CSS/CSS Modules and use inline styles only when it makes sense.
- Learn the list of the most common special attributes: it'll save you a lot of mistakes.

---

## **8. Things to keep in mind**

- JSX isn't HTML: some attributes change.
- The most important ones when you're starting out are `className` and `htmlFor`.
- Events are written in camelCase and receive functions.
- `style` is written as an object.

---

[![className, htmlFor and others](https://img.youtube.com/vi/CcMlJxlHno8/0.jpg)](https://www.youtube.com/watch?v=CcMlJxlHno8&list=PLzA2VyZwsq_-dE3Jvunglxq8a6UcH6gnF)

---

In the next topic we'll look at **Props from Child to Parent and Lifting State Up**, so that a child component can send information to its parent through functions.
