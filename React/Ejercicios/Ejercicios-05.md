# **Exercises - Topic 5: Components in a line**

Below you will find **10 practical exercises** on components in a line (arrow functions, implicit return and readability).

Try to solve them before consulting the solution.

---

## **Exercise 1: Convert to component in a line**

Convert this component to a one-line version using arrow function and implicit return:

```js
function Title() {
  return <h1>Welcome</h1>;
}

export default Title;
```

<details><summary>Show Solution</summary>

```js
const Title = () => <h1>Welcome</h1>;

export default Title;
```

</details>

---

## **Exercise 2: JSX on multiple lines with parentheses**

Create an `EmptyMessage.jsx` component in a single declaration with arrow function that renders:

- `h3` with the text: **"No results"**
- `p` with the text: **"Try a different search"**

The JSX should be on multiple lines using parentheses.

<details><summary>Show Solution</summary>

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

## **Exercise 3: Detect the implicit return error**

This component does not show anything. Correct it:

```js
const Badge = () => {
  <span>New</span>;
};

export default Badge;
```

<details><summary>Show Solution</summary>

When using `{}` keys, you need `return`:

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

Create an `Separator.jsx` component on a line that returns an `hr` with `className="separator"`.

<details><summary>Show Solution</summary>

```js
const Separator = () => <hr className="separator" />;

export default Separator;
```

</details>

---

## **Exercise 5: Refactor to improve readability**

You have this component on one line, but it is poorly readable. Rewrite it using parentheses and several lines:

```js
const Info = () => (
  <div>
    <h4>Info</h4>
    <p>React is component-based</p>
  </div>
);
```

<details><summary>Show Solution</summary>

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

## **Exercise 6: When NOT to use component in a line (choose the correct option)**

Choose the most recommended option:

1. A component with 2 labels and no logic

   - a) In a line
   - b) Classic form

2. A component with long JSX (many elements)

   - a) In a line
   - b) Classic form or several lines with parentheses

3. A component with several variables and calculations

   - a) In a line
   - b) Classic form

<details><summary>Show Solution</summary>

1. a) On one line (if it's really short and readable).
2. b) Classic form or several lines with parentheses.
3. b) Classic form.

</details>

---

## **Exercise 7: Compare `function` vs arrow function**

Write the `FooterNote` component in two ways:

- Classic shape with `function`.
- Compact shape with arrow function in one line.

Should render: `small` with the text **"Built with React"**.

<details><summary>Show Solution</summary>

Classic shape:

```js
function FooterNote() {
  return <small>Built with React</small>;
}

export default FooterNote;
```

Form in one line:

```js
const FooterNote = () => <small>Built with React</small>;

export default FooterNote;
```

</details>

---

## **Exercise 8: Components on a line within `App.jsx`**

In `App.jsx`, create an `Label` component on one line and use it twice. You must render:

- `span` with the text: **"Featured"**

<details><summary>Show Solution</summary>

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

<details><summary>Show Solution</summary>

On implicit returns with multiple lines, use parentheses:

```js
const Tip = () => <p>Remember to save your work</p>;

export default Tip;
```

</details>

---

## **Exercise 10: Decide on the appropriate style (mini-cases)**

Indicate which one you would choose and why (one sentence per case):

1. `Dot` component that only renders an `span` with a dot (`•`).
2. `UserProfile` component with multiple variables, long JSX and complex structure.
3. `LoadingText` component that renders a very short `p`.

<details><summary>Show Solution</summary>

1. Component in a line: it is very small and visual.
2. Classic form: needs readability and probably logic.
3. On one line if it is short and legible; If it grows, it would change to classical form.

</details>

---
