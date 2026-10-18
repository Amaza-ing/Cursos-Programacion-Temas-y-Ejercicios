# **Topic 5: One-line components**

## **1. Introduction**

As you start creating components in React, you'll notice that some are **very small**: they return a single line of JSX and require no additional logic.

In those cases, you can write the component more compactly (on “one line”), keeping the code clean and easy to read.

In this topic you will learn:

- What a “one-line component” means.
- When it makes sense to use one and when it doesn't.
- The difference between `return (...)` and an implicit return.
- Best practices to keep your code readable.

---

## **2. What is a one-line component?**

A one-line component is a functional component that:

- Doesn't need complex logic.
- Returns JSX directly.
- Can be written compactly.

Example:

```js
function Hello() {
  return <h1>Hello</h1>;
}

export default Hello;
```

This component is already very simple, but it still uses `return`.

---

## **3. Arrow functions and implicit return**

In JavaScript, an **arrow function** can return a value without writing `return` if:

- You don't use curly braces `{}`.
- You return the expression directly.

Example:

```js
const sum = (a, b) => a + b;
```

In React, we can do the same with JSX.

---

## **4. One-line component with an arrow function**

Example:

```js
const Title = () => <h1>React Course</h1>;

export default Title;
```

Features:

- It's declared as `const`.
- It uses an arrow function.
- The JSX is returned implicitly.

---

## **5. One-line components with longer JSX**

If the JSX spans multiple lines, you can wrap it in parentheses:

```js
const EmptyState = () => (
  <div>
    <h3>No data</h3>
    <p>Try again later</p>
  </div>
);

export default EmptyState;
```

Even if the component is small, once it spans several lines, keeping it **readable** is usually what matters most.

---

## **6. When to use one-line components**

They're useful when:

- The component is very small.
- There's no state or logic.
- It's a simple “visual” component.

Typical examples:

- Tags (`Tag`)
- Separators (`Divider`)
- Icons
- “Static” components

Example:

```js
const Divider = () => <hr />;

export default Divider;
```

---

## **7. When NOT to use them**

Avoid writing them on one line if:

- The JSX is long and hard to read.
- There's logic inside the component.
- You're just starting out and the implicit return confuses you.

In these cases, it's better to use the classic form:

```js
function Profile() {
  const userName = "Alex";

  return (
    <section>
      <h2>{userName}</h2>
      <p>Profile details...</p>
    </section>
  );
}

export default Profile;
```

---

## **8. Quick differences: `function` vs arrow function**

Both are valid.

### **8.1. Classic form (the most common when you're starting out)**

```js
function Header() {
  return <h1>Header</h1>;
}

export default Header;
```

### **8.2. One-line form (compact)**

```js
const Header = () => <h1>Header</h1>;

export default Header;
```

---

## **9. Best practices**

- Prioritize **clarity** over “saving lines”.
- Use one-line components for very simple pieces.
- If the JSX grows, switch to the classic form.
- Keep names clear, in PascalCase.

---

## **10. Things to keep in mind**

- A one-line component is a compact way to write small components.
- It relies on arrow functions and implicit returns.
- It isn't “better” by default: it depends on size and readability.

---

[![One-Line Components](https://img.youtube.com/vi/iIjk-AhtJ9A/0.jpg)](https://www.youtube.com/watch?v=iIjk-AhtJ9A&list=PLzA2VyZwsq_-dE3Jvunglxq8a6UcH6gnF)

---

In the next topic we'll see how to handle **events in React** (click, input and handler functions).
