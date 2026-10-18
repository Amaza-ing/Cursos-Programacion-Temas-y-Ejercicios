# **Topic 7: useState**

## **1. Introduction**

So far we've created components and managed events, but there's still one key piece missing: **storing information within the component** and having the interface update when that information changes.

In React, this is done with **state**. The most important hook to start with is `useState`.

In this topic you will learn:

- What is state and why a normal variable is not useful.
- How to use `useState`.
- How to update status correctly.
- Typical cases: counter, toggle and controlled input.

---

## **2. What is state in React?**

**status** is information that:

- Belongs to a component.
- May change over time.
- When it changes, React **re-renders** the component to update the UI.

State examples:

- Likes counter
- Text written in an input
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

- `count` changes in console.
- But the UI is not updated.

This happens because React does **not re-render** the component when you change a normal variable.

---

## **4. Create state with `useState`**

`useState` is a hook that returns:

- The value of the state.
- A function to update it.

### **4.1. Import `useState`**

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

## **5. Example 1: Accountant**

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

What we want happens here:

- When clicked, `setCount` updates the status.
- React re-renders the component.
- The UI shows the new value.

---

## **6. Secure update with feature (very important)**

Sometimes React can bundle updates. To avoid problems, it is highly recommended to use the functional form:

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

This way is safer because it always uses the most recent value.

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

- `value={name}` makes the input state dependent.
- `onChange` updates status.
- UI updates automatically.

---

## **9. Good practices with `useState`**

- Name the status clearly: `count`, `isOpen`, `name`.
- Name the setter `set...`: `setCount`, `setIsOpen`.
- To update based on the previous value, use the functional form.
- Avoid directly modifying the state.

---

## **10. To take into account**

- State is what makes React reactive.
- `useState` allows you to save and update status.
- Changing state with the setter causes re-render.
- For updates based on the previous value, use `setState((prev) => ...)`.

---

[![useState](https://img.youtube.com/vi/ln8FKnZBvNo/0.jpg)](https://www.youtube.com/watch?v=ln8FKnZBvNo&list=PLzA2VyZwsq_-dE3Jvunglxq8a6UcH6gnF)

---
In the next topic we will see **Reactive Attributes**, to connect state with HTML attributes (for example `disabled`, `value`, `checked`).
