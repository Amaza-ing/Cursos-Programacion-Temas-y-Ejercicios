# **Exercises - Topic 6: Events in React**

Below you will find **10 practical exercises** on events in React.

Try to solve them before consulting the solution.

---

## **Exercise 1: Button with `onClick`**

Create an `ClickCounter.jsx` component with a button that when clicked shows in the console: **"Button clicked"**.

<details><summary>Show Solution</summary>

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

## **Exercise 2: Correct the event written as in HTML**

This code is written as if it were traditional HTML. Fix it for React:

```js
function App() {
  return <button onclick="handleClick()">Click</button>;
}
```

<details><summary>Show Solution</summary>

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

## **Exercise 3: Pass parameters without executing when rendering**

Create an `MessageButtons.jsx` component with two buttons:

- One that sends the message **"Hello"**.
- Another one who sends the message **"Goodbye"**.

When you click, the message with `alert` should be displayed.

<details><summary>Show Solution</summary>

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

Create an `LiveInput.jsx` component with an input that:

- In each change, show the text that the user writes in the console.

<details><summary>Show Solution</summary>

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

## **Exercise 5: Event `onMouseEnter` and `onMouseLeave`**

Create an `HoverLogger.jsx` component with an `div` that:

- When the mouse enters, show: **"Mouse entered"** in the console.
- When the mouse exits, show: **"Mouse left"** in the console.

<details><summary>Show Solution</summary>

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

Create an `NewsletterForm.jsx` component with a form that has:

- An entry with `name="email"`.
- A submit button.

When the form is submitted:

- Avoid recharging with `preventDefault()`.
- Show in console: **"Form submitted"**.

<details><summary>Show Solution</summary>

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

## **Exercise 7: Obtain the value of an input in `onSubmit`**

Create an `SimpleSearchForm.jsx` component with:

- An `form`.
- An `input` with `name="query"`.
- A submit button.

When sending:

- Use `preventDefault()`.
- Show the input text in the console using `event.target`.

<details><summary>Show Solution</summary>

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

This code runs the function when rendering. Correct it:

```js
function App() {
  const handleClick = () => alert("Hi");

  return <button onClick={handleClick()}>Click</button>;
}
```

<details><summary>Show Solution</summary>

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

Rewrite this component using more recommended handler names:

```js
function App() {
  const click = () => console.log("clicked");

  return <button onClick={click}>Ok</button>;
}
```

<details><summary>Show Solution</summary>

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

## **Exercise 10: Mini-case study (choose the correct solution)**

You want a button to call a function `handleSelect` by passing the text `"Option A"`.
What is the correct option?

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

<details><summary>Show Solution</summary>

The correct option is **2**:

```js
<button onClick={() => handleSelect("Option A")}>Select</button>
```

Reason:

- `onClick` must go in camelCase.
- To pass parameters, you need a function that is executed when clicked.

</details>

---
