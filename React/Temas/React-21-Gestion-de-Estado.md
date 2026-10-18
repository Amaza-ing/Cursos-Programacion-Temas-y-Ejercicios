# **Topic 21: State Management in React**

## **1. Introduction**

As an application grows, so does the amount of data it needs to handle: inputs, results from an API, authentication status, filters, user preferences, etc.

In React, **properly managing state** is key to making the application clear, predictable, and easy to maintain.

In this topic you will learn:

- What is the state and why is it important.
- Local state vs shared state.
- When to raise the status.
- Common state management patterns.
- Typical errors and good practices.

---

## **2. What is the state?**

The **status** is the information that:

- May change over time.
- Affects what is rendered on screen.
- Belongs to a component.

State examples:

- The text of an input.
- Whether a modal is open or closed.
- Data obtained from an API.
- If a user is authenticated.

In React, state is mainly managed with the `useState` hook.

---

## **3. Local state with `useState`**

The local state belongs to **a single component**.

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

- Only used by `Counter`.
- It is not shared with other components.

---

## **4. Shared state: the problem**

Typical problem:

- Two components need the same data.
- One modifies it and the other shows it.

Example:

- `SearchInput` updates a text.
- `ResultsList` filters results with that text.

If each has its own state, they **do not sync**.

---

## **5. Lifting state up**

The solution is to **raise the status** to the common parent component.

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

- The state lives in the father.
- Children receive data and functions.

---

## **6. Data flow in React**

React follows a **one-way** flow:

- Low status (props).
- Shares rise (callbacks).

This makes:

- Behavior is predictable.
- Be easier to debug errors.

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

You do not need `useState`.

---

## **8. Status and effects**

When the state changes:

- The component is re-rendered.
- The `useEffect` that depend on that state are executed.

```js
useEffect(() => {
  console.log("Query changed", query);
}, [query]);
```

---

## **9. Typical errors**

### **9.1. Duplicate status**

Save the same data in multiple places.

### **9.2. Unnecessary state**

Use `useState` for derived data.

### **9.3. Passing too many props (prop drilling)**

Will be resolved later with **Context**.

---

## **10. Good practices**

- Keep the status as high as possible, but no higher.
- Use local state when only one component needs it.
- Raise status when shared.
- Avoid duplicating information.

---

In the next topic you will learn how to use **Context** to share state without manually passing props.
