# **Exercises - Topic 24: React.memo**

Below you will find **10 practical exercises** to understand and apply `React.memo` as a rendering optimization technique in React.

Try to solve them before consulting the solution.

---

## **Exercise 1: Detect unnecessary renders**

Create two components:

- `Parent.jsx` with state `count`.
- `Child.jsx` to only render text.

Add an `console.log` to `Child` to check how many times it is rendered when changing `count`.

<details><summary>Show Solution</summary>

```js
function Child() {
  console.log("Child rendered");
  return <p>Child</p>;
}
```

</details>

---

## **Exercise 2: Use `React.memo`**

Wrap the `Child` component with `React.memo` to avoid unnecessary rendering.

<details><summary>Show Solution</summary>

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

Modify `Child` so that it receives an `name` prop and displays `Hello {name}`.

Checks when it renders again.

<details><summary>Show Solution</summary>

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

In `Parent`, always pass the same value from `name` to `Child` and observe the behavior.

<details><summary>Show Solution</summary>

```js
<Child name="Sara" />
```

</details>

---

## **Exercise 5: Props that do change**

Modify `Parent` to make `name` state dependent and watch `Child` re-render.

<details><summary>Show Solution</summary>

```js
const [name, setName] = useState("Sara");
```

</details>

---

## **Exercise 6: Problem with objects like props**

Pass `Child` an `options={{ theme: "dark" }}` prop and look at the renders.

<details><summary>Show Solution</summary>

Each render creates a new object, so `React.memo` does not prevent the render.

</details>

---

## **Exercise 7: Explain superficial comparison**

Explains why `React.memo` doesn't work well with inline created objects.

<details><summary>Show Solution</summary>

Because it compares references, not the content of the object.

</details>

---

## **Exercise 8: When NOT to use `React.memo`**

Give an example of a component where `React.memo` does not provide benefits.

<details><summary>Show Solution</summary>

Small components with cheap render and few updates.

</details>

---

## **Exercise 9: `React.memo` and local state**

Is a memoized component rendered if its own state changes?

<details><summary>Show Solution</summary>

Yes. `React.memo` only affects changes to props, not internal state.

</details>

---

## **Exercise 10: React.memo as optimization**

Explain why you should not use `React.memo` indiscriminately.

<details><summary>Show Solution</summary>

Because it can add unnecessary complexity and does not always improve performance.

</details>
