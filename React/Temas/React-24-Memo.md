# **Topic 24: React.memo and Render Optimization**

## **1. Introduction**

As a React application grows, the number of components and renders also increases. Not all renders are necessary: sometimes a component re-renders even though **its props haven't changed**.

React offers a tool to optimize this behavior: **`React.memo`**.

In this topic you will learn:

- What an unnecessary render is.
- What `React.memo` does.
- When to use it and when not to.
- The relationship between `React.memo`, props and state.
- Common mistakes and best practices.

---

## **2. What is a render in React?**

A component **renders** when:

- Its state changes.
- Its props change.
- Its parent component renders.

The last one is important: **a child renders when its parent renders**, even if its props don't change.

---

## **3. The problem: unnecessary renders**

Example:

```js
function Parent() {
  const [count, setCount] = useState(0);

  return (
    <>
      <button onClick={() => setCount(count + 1)}>+</button>
      <Child />
    </>
  );
}
```

Although `Child` doesn't receive any props, **it renders every time** `count` changes.

In small apps it isn't a problem, but in large components it can affect performance.

---

## **4. What is `React.memo`?**

`React.memo` is a function that **memoizes** a component.

- If the props **don't change**, React reuses the previous render.
- If the props **change**, the component re-renders.

---

## **5. Basic usage of `React.memo`**

```js
import { memo } from "react";

function Child() {
  console.log("Child rendered");
  return <p>Child component</p>;
}

export default memo(Child);
```

Now `Child` **doesn't re-render** if its props don't change.

---

## **6. `React.memo` with props**

Example:

```js
function Child({ name }) {
  console.log("Child rendered");
  return <p>Hello {name}</p>;
}

export default memo(Child);
```

- If `name` doesn't change → there's no render.
- If `name` changes → there is a render.

---

## **7. Shallow comparison of props**

`React.memo` does a **shallow comparison**:

- Primitive values (`string`, `number`, `boolean`) → work fine.
- Objects and arrays → are compared by reference.

Problematic example:

```js
<Child options={{ theme: "dark" }} />
```

This object is **new on every render**, even though its content is the same.

---

## **8. `React.memo` and objects/functions**

When you pass:

- Objects
- Arrays
- Functions

…as props, their reference usually changes.

Solutions (we'll see them later):

- `useCallback`
- `useMemo`

For now, the key idea:

> `React.memo` works best with simple props.

---

## **9. When to use `React.memo`**

✔️ Useful when:

- The component is heavy.
- It renders many times.
- It receives stable props.

❌ Not needed when:

- The component is small.
- The render is cheap.
- Props change constantly.

Optimizing without measuring can be counterproductive.

---

## **10. Common mistakes**

### **10.1. Using `React.memo` on every component**

It isn't good practice.

### **10.2. Expecting it to fix renders caused by local state**

If the state is inside the component, **it renders anyway**.

### **10.3. Forgetting that it's an optimization**

First make it work, then optimize.

---

## **11. Best practices**

- Use `React.memo` selectively.
- Start with large components or lists.
- Avoid passing objects inline.
- Combine it with `useCallback` and `useMemo` when necessary.

---
[![React Memo](https://img.youtube.com/vi/Y9aWic62X7M/0.jpg)](https://www.youtube.com/watch?v=Y9aWic62X7M&list=PLzA2VyZwsq_-dE3Jvunglxq8a6UcH6gnF)

---

In the next topic you'll learn how to optimize loading with **Lazy Loading**.
