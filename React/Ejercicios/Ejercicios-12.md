# **Exercises - Topic 12: className, htmlFor and other similar cases**

Below you will find **10 practical exercises** on “special” attributes in React (`className`, `htmlFor`, `style`, events in camelCase, etc.).

Try to solve them before looking at the solution.

---

## **Exercise 1: Replace `class` with `className`**

This component is written as HTML. Fix it for React:

```js
function Card() {
  return <div class="card">Card</div>;
}

export default Card;
```

<details><summary>Show solution</summary>

```js
function Card() {
  return <div className="card">Card</div>;
}

export default Card;
```

</details>

---

## **Exercise 2: Dynamic `className` with a ternary**

Create a `ModeTag.jsx` component with an `isDarkMode = true` variable.

- If it is `true`, use `className="tagDark"`
- If it is `false`, use `className="tagLight"`

It must render:

- `span` with the text: **"Mode"**

<details><summary>Show solution</summary>

```js
function ModeTag() {
  const isDarkMode = true;

  return <span className={isDarkMode ? "tagDark" : "tagLight"}>Mode</span>;
}

export default ModeTag;
```

</details>

---

## **Exercise 3: Replace `for` with `htmlFor`**

This form has a bug in React. Fix it:

```js
function NameField() {
  return (
    <div>
      <label for="name">Name</label>
      <input id="name" />
    </div>
  );
}

export default NameField;
```

<details><summary>Show solution</summary>

```js
function NameField() {
  return (
    <div>
      <label htmlFor="name">Name</label>
      <input id="name" />
    </div>
  );
}

export default NameField;
```

</details>

---

## **Exercise 4: Associate `label` and `input` correctly**

Create a `PasswordField.jsx` component that has:

- `label` with `htmlFor="password"` and the text **"Password"**
- `input` with `id="password"` and `type="password"`

<details><summary>Show solution</summary>

```js
function PasswordField() {
  return (
    <div>
      <label htmlFor="password">Password</label>
      <input id="password" type="password" />
    </div>
  );
}

export default PasswordField;
```

</details>

---

## **Exercise 5: `style` as an object (camelCase)**

Create an `InlineBadge.jsx` component that renders a `span` with:

- Text: **"New"**
- `style` with:

  - `padding: "6px 10px"`
  - `borderRadius: "999px"`
  - `border: "1px solid #ddd"`

<details><summary>Show solution</summary>

```js
function InlineBadge() {
  return (
    <span
      style={{
        padding: "6px 10px",
        borderRadius: "999px",
        border: "1px solid #ddd",
      }}
    >
      New
    </span>
  );
}

export default InlineBadge;
```

</details>

---

## **Exercise 6: Fix the event `onclick` → `onClick`**

This button is written incorrectly for React. Fix it:

```js
function App() {
  const handleClick = () => console.log("clicked");

  return <button onclick={handleClick}>Ok</button>;
}
```

<details><summary>Show solution</summary>

```js
function App() {
  const handleClick = () => console.log("clicked");

  return <button onClick={handleClick}>Ok</button>;
}

export default App;
```

</details>

---

## **Exercise 7: `tabIndex` and focus**

Create a `FocusableBox.jsx` component that renders a `div`:

- With `tabIndex={0}`
- With the text: **"Focus me"**

<details><summary>Show solution</summary>

```js
function FocusableBox() {
  return <div tabIndex={0}>Focus me</div>;
}

export default FocusableBox;
```

</details>

---

## **Exercise 8: `readOnly` and a fixed value**

Create a `FixedInput.jsx` component that renders:

- An `input` with `value="Read only"`
- And `readOnly`

<details><summary>Show solution</summary>

```js
function FixedInput() {
  return <input value="Read only" readOnly />;
}

export default FixedInput;
```

</details>

---

## **Exercise 9: `autoFocus` (not `autofocus`)**

Create an `AutoFocusSearch.jsx` component that renders an input with:

- `placeholder="Search"`
- `autoFocus`

<details><summary>Show solution</summary>

```js
function AutoFocusSearch() {
  return <input placeholder="Search" autoFocus />;
}

export default AutoFocusSearch;
```

</details>

---

## **Exercise 10: Mini-case (choose the correct form)**

You want to apply this style to the `div`:

- background color: `"#f5f5f5"`
- padding: `"12px"`

Which is the correct way in React?

1.

```js
<div style="background-color: #f5f5f5; padding: 12px" />
```

2.

```js
<div style={{ backgroundColor: "#f5f5f5", padding: "12px" }} />
```

3.

```js
<div style={{ "background-color": "#f5f5f5", padding: "12px" }} />
```

<details><summary>Show solution</summary>

The correct option is **2**:

```js
<div style={{ backgroundColor: "#f5f5f5", padding: "12px" }} />
```

Reason:
- `style` receives an object.
- The properties go in camelCase (`backgroundColor`).

</details>
