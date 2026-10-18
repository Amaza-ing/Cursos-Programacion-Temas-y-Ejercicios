# **Exercises - Topic 24: React.memo**

Below you will find **10 practical exercises** to understand and apply `React.memo` as a rendering optimization technique in React.

Try to solve them before looking at the solution.

---

## **Exercise 1: Spot unnecessary renders**

Create two components:

- `Parent.jsx` with a `count` state.
- `Child.jsx`, which only renders some text.

Add a `console.log` to `Child` to check how many times it renders when `count` changes.

<details><summary>Show solution</summary>

```js
function Child() {
  console.log("Child rendered");
  return <p>Child</p>;
}
```

</details>

---

## **Exercise 2: Use `React.memo`**

Wrap the `Child` component with `React.memo` to avoid unnecessary renders.

<details><summary>Show solution</summary>

```js
import { memo } from "react";

function Child() {
  console.log("Child rendered");
  return <p>Child</p>;
}

export default memo(Child);
```

</details>

---

## **Exercise 3: `React.memo` with props**

Modify `Child` so that it receives a `name` prop and displays `Hello {name}`.

Check when it re-renders.

<details><summary>Show solution</summary>

```js
function Child({ name }) {
  console.log("Child rendered");
  return <p>Hello {name}</p>;
}

export default memo(Child);
```

</details>

---

## **Exercise 4: Props that do not change**

In `Parent`, always pass the same `name` value to `Child` and observe the behavior.

<details><summary>Show solution</summary>

```js
<Child name="Sara" />
```

</details>

---

## **Exercise 5: Props that do change**

Modify `Parent` so that `name` depends on state, and watch `Child` re-render.

<details><summary>Show solution</summary>

```js
const [name, setName] = useState("Sara");
```

</details>

---

## **Exercise 6: The problem with objects as props**

Pass `Child` an `options={{ theme: "dark" }}` prop and watch the renders.

<details><summary>Show solution</summary>

Each render creates a new object, so `React.memo` does not prevent the render.

</details>

---

## **Exercise 7: Explain shallow comparison**

Explain why `React.memo` doesn't work well with objects created inline.

<details><summary>Show solution</summary>

Because it compares references, not the content of the object.

</details>

---

## **Exercise 8: When NOT to use `React.memo`**

Give an example of a component where `React.memo` does not provide benefits.

<details><summary>Show solution</summary>

Small components that are cheap to render and rarely update.

</details>

---

## **Exercise 9: `React.memo` and local state**

Does a memoized component re-render if its own state changes?

<details><summary>Show solution</summary>

Yes. `React.memo` only affects changes to props, not internal state.

</details>

---

## **Exercise 10: React.memo as an optimization**

Explain why you should not use `React.memo` indiscriminately.

<details><summary>Show solution</summary>

Because it can add unnecessary complexity and does not always improve performance.

</details>
