# **Topic 7: useState**

## **1. Introduction**

So far we've created components and managed events, but there's still one key piece missing: **storing information inside the component** and having the interface update when that information changes.

In React, this is done with **state**. The most important hook to start with is `useState`.

In this topic you will learn:

- What state is and why a normal variable won't do.
- How to use `useState`.
- How to update state correctly.
- Typical cases: counter, toggle and controlled input.

---

## **2. What is state in React?**

**State** is information that:

- Belongs to a component.
- Can change over time.
- When it changes, React **re-renders** the component to update the UI.

Examples of state:

- A likes counter
- The text typed into an input
- Whether a menu is open or closed

---

## **3. Why a normal variable doesn't work**

Look at this example:

```js
function Counter() {
  let count = 0;

  const handleClick = () => {
    count = count + 1;
    console.log(count);
  };

  return <button onClick={handleClick}>Count: {count}</button>;
}

export default Counter;
```

Something important happens here:

- `count` changes in the console.
- But the UI doesn't update.

This happens because React does **not re-render** the component when you change a normal variable.

---

## **4. Creating state with `useState`**

`useState` is a hook that returns:

- The value of the state.
- A function to update it.

### **4.1. Importing `useState`**

```js
import { useState } from "react";
```

### **4.2. Basic syntax**

```js
const [count, setCount] = useState(0);
```

- `count` is the current value.
- `setCount` is the function to update it.
- `useState(0)` defines the initial value.

---

## **5. Example 1: Counter**

```js
import { useState } from "react";

function Counter() {
  const [count, setCount] = useState(0);

  const handleClick = () => {
    setCount(count + 1);
  };

  return <button onClick={handleClick}>Count: {count}</button>;
}

export default Counter;
```

Now what we want actually happens:

- When you click, `setCount` updates the state.
- React re-renders the component.
- The UI shows the new value.

---

## **6. Safe updates with a function (very important)**

Sometimes React may batch updates. To avoid problems, it's highly recommended to use the functional form:

```js
setCount((prevCount) => prevCount + 1);
```

Example:

```js
import { useState } from "react";

function Counter() {
  const [count, setCount] = useState(0);

  const handleClick = () => {
    setCount((prevCount) => prevCount + 1);
  };

  return <button onClick={handleClick}>Count: {count}</button>;
}

export default Counter;
```

This form is safer because it always uses the most recent value.

---

## **7. Example 2: Toggle (true/false)**

```js
import { useState } from "react";

function Toggle() {
  const [isOpen, setIsOpen] = useState(false);

  const handleToggle = () => {
    setIsOpen((prevIsOpen) => !prevIsOpen);
  };

  return (
    <div>
      <button onClick={handleToggle}>Toggle</button>
      <p>Open: {isOpen ? "Yes" : "No"}</p>
    </div>
  );
}

export default Toggle;
```

Here, the `isOpen` state changes between `true` and `false`.

---

## **8. Example 3: Controlled input**

A controlled input is one whose value comes from the state.

```js
import { useState } from "react";

function NameInput() {
  const [name, setName] = useState("");

  const handleChange = (event) => {
    setName(event.target.value);
  };

  return (
    <div>
      <input value={name} onChange={handleChange} placeholder="Your name" />
      <p>Hello, {name}</p>
    </div>
  );
}

export default NameInput;
```

Here:

- `value={name}` makes the input depend on the state.
- `onChange` updates the state.
- The UI updates automatically.

---

## **9. Best practices with `useState`**

- Give the state a clear name: `count`, `isOpen`, `name`.
- Name the setter `set...`: `setCount`, `setIsOpen`.
- To update based on the previous value, use the functional form.
- Avoid modifying the state directly.

---

## **10. Things to keep in mind**

- State is what makes React reactive.
- `useState` lets you store and update state.
- Changing the state with the setter triggers a re-render.
- For updates based on the previous value, use `setState((prev) => ...)`.

---

[![useState](https://img.youtube.com/vi/ln8FKnZBvNo/0.jpg)](https://www.youtube.com/watch?v=ln8FKnZBvNo&list=PLzA2VyZwsq_-dE3Jvunglxq8a6UcH6gnF)

---
In the next topic we'll look at **Reactive Attributes**, to connect state with HTML attributes (for example `disabled`, `value`, `checked`).
