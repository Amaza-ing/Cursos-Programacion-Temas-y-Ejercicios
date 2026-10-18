# **Exercises - Topic 6: Events in React**

Below you will find **10 practical exercises** on events in React.

Try to solve them before looking at the solution.

---

## **Exercise 1: Button with `onClick`**

Create a `ClickCounter.jsx` component with a button that, when clicked, shows in the console: **"Button clicked"**.

<details><summary>Show solution</summary>

```js
function ClickCounter() {
  const handleClick = () => {
    console.log("Button clicked");
  };

  return <button onClick={handleClick}>Click me</button>;
}

export default ClickCounter;
```

</details>

---

## **Exercise 2: Fix the event written as in HTML**

This code is written as if it were traditional HTML. Fix it for React:

```js
function App() {
  return <button onclick="handleClick()">Click</button>;
}
```

<details><summary>Show solution</summary>

In React, you use `onClick` and pass a function:

```js
function App() {
  const handleClick = () => {
    console.log("Clicked");
  };

  return <button onClick={handleClick}>Click</button>;
}

export default App;
```

</details>

---

## **Exercise 3: Pass parameters without running the function on render**

Create a `MessageButtons.jsx` component with two buttons:

- One that sends the message **"Hello"**.
- Another one that sends the message **"Goodbye"**.

When you click, the message should be displayed with `alert`.

<details><summary>Show solution</summary>

```js
function MessageButtons() {
  const handleMessage = (text) => {
    alert(text);
  };

  return (
    <div>
      <button onClick={() => handleMessage("Hello")}>Send Hello</button>
      <button onClick={() => handleMessage("Goodbye")}>Send Goodbye</button>
    </div>
  );
}

export default MessageButtons;
```

</details>

---

## **Exercise 4: Capture text from an input with `onChange`**

Create a `LiveInput.jsx` component with an input that:

- On every change, shows in the console the text the user types.

<details><summary>Show solution</summary>

```js
function LiveInput() {
  const handleChange = (event) => {
    console.log(event.target.value);
  };

  return <input onChange={handleChange} placeholder="Type here" />;
}

export default LiveInput;
```

</details>

---

## **Exercise 5: `onMouseEnter` and `onMouseLeave` events**

Create a `HoverLogger.jsx` component with a `div` that:

- When the mouse enters, shows **"Mouse entered"** in the console.
- When the mouse leaves, shows **"Mouse left"** in the console.

<details><summary>Show solution</summary>

```js
function HoverLogger() {
  const handleEnter = () => {
    console.log("Mouse entered");
  };

  const handleLeave = () => {
    console.log("Mouse left");
  };

  return (
    <div onMouseEnter={handleEnter} onMouseLeave={handleLeave}>
      Hover area
    </div>
  );
}

export default HoverLogger;
```

</details>

---

## **Exercise 6: `onSubmit` with `preventDefault()`**

Create a `NewsletterForm.jsx` component with a form that has:

- An input with `name="email"`.
- A submit button.

When the form is submitted:

- Prevent the page reload with `preventDefault()`.
- Show in the console: **"Form submitted"**.

<details><summary>Show solution</summary>

```js
function NewsletterForm() {
  const handleSubmit = (event) => {
    event.preventDefault();
    console.log("Form submitted");
  };

  return (
    <form onSubmit={handleSubmit}>
      <input name="email" placeholder="Email" />
      <button type="submit">Subscribe</button>
    </form>
  );
}

export default NewsletterForm;
```

</details>

---

## **Exercise 7: Get the value of an input in `onSubmit`**

Create a `SimpleSearchForm.jsx` component with:

- A `form`.
- An `input` with `name="query"`.
- A submit button.

On submit:

- Use `preventDefault()`.
- Show the input text in the console using `event.target`.

<details><summary>Show solution</summary>

```js
function SimpleSearchForm() {
  const handleSubmit = (event) => {
    event.preventDefault();

    const query = event.target.query.value;
    console.log(query);
  };

  return (
    <form onSubmit={handleSubmit}>
      <input name="query" placeholder="Search" />
      <button type="submit">Search</button>
    </form>
  );
}

export default SimpleSearchForm;
```

</details>

---

## **Exercise 8: Avoid an incorrect handler call**

This code runs the function on render. Fix it:

```js
function App() {
  const handleClick = () => alert("Hi");

  return <button onClick={handleClick()}>Click</button>;
}
```

<details><summary>Show solution</summary>

In React you must pass the function, not call it:

```js
function App() {
  const handleClick = () => alert("Hi");

  return <button onClick={handleClick}>Click</button>;
}

export default App;
```

</details>

---

## **Exercise 9: Create handlers with correct names**

Rewrite this component using better handler names:

```js
function App() {
  const click = () => console.log("clicked");

  return <button onClick={click}>Ok</button>;
}
```

<details><summary>Show solution</summary>

```js
function App() {
  const handleClick = () => {
    console.log("clicked");
  };

  return <button onClick={handleClick}>Ok</button>;
}

export default App;
```

</details>

---

## **Exercise 10: Mini practical case (choose the correct solution)**

You want a button to call a function `handleSelect`, passing it the text `"Option A"`.
Which is the correct option?

1.

```js
<button onClick={handleSelect("Option A")}>Select</button>
```

2.

```js
<button onClick={() => handleSelect("Option A")}>Select</button>
```

3.

```js
<button onclick={() => handleSelect("Option A")}>Select</button>
```

<details><summary>Show solution</summary>

The correct option is **2**:

```js
<button onClick={() => handleSelect("Option A")}>Select</button>
```

Reason:

- `onClick` must be written in camelCase.
- To pass parameters, you need a function that runs when the button is clicked.

</details>

---
