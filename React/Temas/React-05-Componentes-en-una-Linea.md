# **Topic 5: Components in a line**

## **1. Introduction**

As you start creating components in React, you'll notice that some are **very small**: they return a single line of JSX and require no additional logic.

In those cases, you can write the component more compactly (on “one line”), keeping the code clean and easy to read.

In this topic you will learn:

- What does “component in a line” mean?
- When it makes sense to use it and when it doesn't.
- Differences between `return (...)` and implicit return.
- Good practices to maintain readability.

---

## **2. What is a component in a line?**

A component on a line is a functional component that:

- Does not need complex logic.
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

In JavaScript, an arrow function can return a value without typing `return` if:

- You do not use `{}` keys.
- You directly return the expression.

Example:

```js
const sum = (a, b) => a + b;
```

In React, we can apply the same with JSX.

---

## **4. Component on a line with arrow function**

Example:

```js
const Title = () => <h1>React Course</h1>;

export default Title;
```

Features:

- It is declared as `const`.
- An arrow function is used.
- JSX is returned implicitly.

---

## **5. Components in a line with longer JSX**

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

Even if the component is small, if it already has multiple lines, usually the most important thing is to maintain **readability**.

---

## **6. When to use components on a line**

They are useful when:

- The component is very small.
- There is no state or logic.
- It is a simple “visual” component.

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

- The JSX is long and difficult to read.
- There is logic within the component.
- You are just starting out and the implicit return confuses you.

In these cases, it is better to use the classic way:

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

### **8.1. Classic shape (most common when starting out)**

```js
function Header() {
  return <h1>Header</h1>;
}

export default Header;
```

### **8.2. Shape in a line (compact)**

```js
const Header = () => <h1>Header</h1>;

export default Header;
```

---

## **9. Good practices**

- Prioritize **clarity** over “saving lines”.
- Use components in a line for very simple parts.
- If the JSX grows, it changes to the classic form.
- Keep names clear in PascalCase.

---

## **10. To take into account**

- A component on a line is a compact way to write small components.
- It is supported by arrow functions and implicit return.
- It is not “better” by default: it depends on size and readability.

---

[![Components of a Line](https://img.youtube.com/vi/iIjk-AhtJ9A/0.jpg)](https://www.youtube.com/watch?v=iIjk-AhtJ9A&list=PLzA2VyZwsq_-dE3Jvunglxq8a6UcH6gnF)

---

In the next topic we will see how to handle **events in React** (click, input, and handler functions).
