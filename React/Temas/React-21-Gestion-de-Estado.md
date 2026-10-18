# **Topic 21: State Management in React**

## **1. Introduction**

As an application grows, so does the amount of data it needs to handle: inputs, API results, authentication state, filters, user preferences, etc.

In React, **managing state properly** is key to keeping the application clear, predictable and easy to maintain.

In this topic you will learn:

- What state is and why it's important.
- Local state vs shared state.
- When to lift state up.
- Common state management patterns.
- Common mistakes and best practices.

---

## **2. What is state?**

**State** is the information that:

- Can change over time.
- Affects what's rendered on screen.
- Belongs to a component.

Examples of state:

- The text of an input.
- Whether a modal is open or closed.
- The data fetched from an API.
- Whether a user is authenticated.

In React, state is mainly managed with the `useState` hook.

---

## **3. Local state with `useState`**

Local state belongs to **a single component**.

```js
import { useState } from "react";

function Counter() {
  const [count, setCount] = useState(0);

  return (
    <div>
      <p>Count: {count}</p>
      <button onClick={() => setCount(count + 1)}>+</button>
    </div>
  );
}

export default Counter;
```

This state:

- Is only used by `Counter`.
- Isn't shared with other components.

---

## **4. Shared state: the problem**

A typical problem:

- Two components need the same piece of data.
- One modifies it and the other shows it.

Example:

- `SearchInput` updates some text.
- `ResultsList` filters results with that text.

If each one has its own state, they **don't stay in sync**.

---

## **5. Lifting state up**

The solution is to **lift the state up** to the common parent component.

```js
import { useState } from "react";

function App() {
  const [query, setQuery] = useState("");

  return (
    <>
      <SearchInput value={query} onChange={setQuery} />
      <ResultsList query={query} />
    </>
  );
}
```

Here:

- The state lives in the parent.
- The children receive data and functions.

---

## **6. Data flow in React**

React follows a **one-way** flow:

- State flows down (props).
- Actions flow up (callbacks).

This means:

- Behavior is predictable.
- Errors are easier to debug.

---

## **7. Common state management patterns**

### **7.1. One state per field**

```js
const [email, setEmail] = useState("");
const [password, setPassword] = useState("");
```

Clear and explicit.

---

### **7.2. A single state for multiple fields**

```js
const [form, setForm] = useState({ email: "", password: "" });
```

Useful for large forms.

---

### **7.3. Derived state**

Data that is calculated from another state:

```js
const filteredItems = items.filter((item) => item.includes(query));
```

It doesn't need `useState`.

---

## **8. State and effects**

When the state changes:

- The component re-renders.
- Any `useEffect` that depends on that state runs.

```js
useEffect(() => {
  console.log("Query changed", query);
}, [query]);
```

---

## **9. Common mistakes**

### **9.1. Duplicating state**

Storing the same data in several places.

### **9.2. Unnecessary state**

Using `useState` for derived data.

### **9.3. Passing too many props (prop drilling)**

We'll solve this later with **Context**.

---

## **10. Best practices**

- Keep the state as low as possible, and lift it only as high as needed.
- Use local state when only one component needs it.
- Lift the state up when it's shared.
- Avoid duplicating information.

---

In the next topic you'll learn how to use **Context** to share state without passing props manually.
