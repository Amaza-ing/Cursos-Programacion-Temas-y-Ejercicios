# **Topic 24: React.memo and Render Optimization**

## **1. Introduction**

As a React application grows, the number of components and renders also increases. Not all renders are necessary: ​​sometimes a component is re-rendered even though **its props have not changed**.

React offers a tool to optimize this behavior: **`React.memo`**.

In this topic you will learn:

- What is unnecessary rendering.
- What `React.memo` does.
- When to use it and when not to.
- Relationship between `React.memo`, props and state.
- Common errors and good practices.

---

## **2. What is a render in React?**

A component **renders** when:

- Change your status.
- They change their props.
- Its parent component is rendered.

The latter is important: **a child is rendered when its parent is rendered**, even if its props do not change.

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

Although `Child` does not receive props, **it is rendered every time** `count` changes.

In small apps it is not a problem, but in large components it can affect performance.

---

## **4. What is `React.memo`?**

`React.memo` is a function that **memorizes** a component.

- If the props **do not change**, React reuses the previous render.
- If the props **change**, the component is re-rendered.

---

## **5. Basic use of `React.memo`**

```js
import { memo } from "react";

function Child() {
  console.log("Child rendered");
  return <p>Child component</p>;
}

export default memo(Child);
```

Now `Child` **does not render** if its props don't change.

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

- If `name` does not change → there is no render.
- If `name` changes → yes there is render.

---

## **7. Superficial comparison of props**

`React.memo` does a **shallow comparison**:

- Primitive values (`string`, `number`, `boolean`) → correct.
- Objects and arrays → are compared by reference.

Problematic example:

```js
<Child options={{ theme: "dark" }} />
```

This object is **new in each render**, even though its content is the same.

---

## **8. `React.memo` and objects/functions**

When you pass:

- Objects
- Arrays
- Features

…like props, they usually change reference.

Solutions (will be seen later):

- `useCallback`
- `useMemo`

For now, key idea:

> `React.memo` works best with simple props.

---

## **9. When to use `React.memo`**

✔️ Useful when:

- The component is heavy.
- Rendered many times.
- Receive stable props.

❌ Not necessary when:

- The component is small.
- The render is cheap.
- Props change constantly.

Optimizing without measuring can be counterproductive.

---

## **10. Typical errors**

### **10.1. Use `React.memo` on all components**

It is not good practice.

### **10.2. Wait for it to fix renders by local state**

If the state is inside the component, it **renders the same**.

### **10.3. Forget that it is an optimization**

First make it work, then optimize.

---

## **11. Good practices**

- Use `React.memo` selectively.
- Start with large components or lists.
- Avoid passing objects inline.
- Combine with `useCallback` and `useMemo` when necessary.

---
[![React Memo](https://img.youtube.com/vi/Y9aWic62X7M/0.jpg)](https://www.youtube.com/watch?v=Y9aWic62X7M&list=PLzA2VyZwsq_-dE3Jvunglxq8a6UcH6gnF)

---

In the next topic you will learn how to optimize loading with **Lazy Loading**.
