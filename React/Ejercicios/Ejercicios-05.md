# **Exercises - Topic 5: One-line components**

Below you will find **10 practical exercises** on one-line components (arrow functions, implicit return and readability).

Try to solve them before looking at the solution.

---

## **Exercise 1: Convert to a one-line component**

Convert this component to a one-line version using an arrow function and an implicit return:

```js
function Title() {
  return <h1>Welcome</h1>;
}

export default Title;
```

<details><summary>Show solution</summary>

```js
const Title = () => <h1>Welcome</h1>;

export default Title;
```

</details>

---

## **Exercise 2: JSX on multiple lines with parentheses**

Create an `EmptyMessage.jsx` component in a single declaration with an arrow function that renders:

- `h3` with the text: **"No results"**
- `p` with the text: **"Try a different search"**

The JSX should be on multiple lines using parentheses.

<details><summary>Show solution</summary>

```js
const EmptyMessage = () => (
  <div>
    <h3>No results</h3>
    <p>Try a different search</p>
  </div>
);

export default EmptyMessage;
```

</details>

---

## **Exercise 3: Spot the implicit return error**

This component doesn't show anything. Fix it:

```js
const Badge = () => {
  <span>New</span>;
};

export default Badge;
```

<details><summary>Show solution</summary>

When you use curly braces `{}`, you need `return`:

```js
const Badge = () => {
  return <span>New</span>;
};

export default Badge;
```

Alternative with implicit return (without braces):

```js
const Badge = () => <span>New</span>;

export default Badge;
```

</details>

---

## **Exercise 4: Create a simple “visual” component**

Create a one-line `Separator.jsx` component that returns an `hr` with `className="separator"`.

<details><summary>Show solution</summary>

```js
const Separator = () => <hr className="separator" />;

export default Separator;
```

</details>

---

## **Exercise 5: Refactor to improve readability**

You have this component on one line, but it's hard to read. Rewrite it using parentheses and several lines:

```js
const Info = () => (
  <div>
    <h4>Info</h4>
    <p>React is component-based</p>
  </div>
);
```

<details><summary>Show solution</summary>

```js
const Info = () => (
  <div>
    <h4>Info</h4>
    <p>React is component-based</p>
  </div>
);

export default Info;
```

</details>

---

## **Exercise 6: When NOT to use a one-line component (choose the correct option)**

Choose the most recommended option:

1. A component with 2 tags and no logic

   - a) On one line
   - b) Classic form

2. A component with long JSX (many elements)

   - a) On one line
   - b) Classic form or several lines with parentheses

3. A component with several variables and calculations

   - a) On one line
   - b) Classic form

<details><summary>Show solution</summary>

1. a) On one line (if it's really short and readable).
2. b) Classic form or several lines with parentheses.
3. b) Classic form.

</details>

---

## **Exercise 7: Compare `function` vs arrow function**

Write the `FooterNote` component in two ways:

- Classic form with `function`.
- Compact form with an arrow function on one line.

It should render: `small` with the text **"Built with React"**.

<details><summary>Show solution</summary>

Classic form:

```js
function FooterNote() {
  return <small>Built with React</small>;
}

export default FooterNote;
```

One-line form:

```js
const FooterNote = () => <small>Built with React</small>;

export default FooterNote;
```

</details>

---

## **Exercise 8: One-line components inside `App.jsx`**

In `App.jsx`, create a one-line `Label` component and use it twice. It must render:

- `span` with the text: **"Featured"**

<details><summary>Show solution</summary>

```js
const Label = () => <span>Featured</span>;

function App() {
  return (
    <div>
      <Label />
      <Label />
    </div>
  );
}

export default App;
```

</details>

---
## **Exercise 9: Use parentheses correctly (typical bug)**

This component tries to return JSX on multiple lines, but it doesn't work. Fix it:

```js
const Tip = () => <p>Remember to save your work</p>;

export default Tip;
```

<details><summary>Show solution</summary>

For implicit returns that span multiple lines, use parentheses:

```js
const Tip = () => <p>Remember to save your work</p>;

export default Tip;
```

</details>

---

## **Exercise 10: Choose the right style (mini-cases)**

Indicate which one you would choose and why (one sentence per case):

1. A `Dot` component that only renders a `span` with a dot (`•`).
2. A `UserProfile` component with multiple variables, long JSX and a complex structure.
3. A `LoadingText` component that renders a very short `p`.

<details><summary>Show solution</summary>

1. One-line component: it is very small and visual.
2. Classic form: it needs readability and probably has logic.
3. On one line if it is short and readable; if it grows, I would switch to the classic form.

</details>

---
