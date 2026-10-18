# **Exercises - Topic 21: State Management in React**

Below you will find **10 practical exercises** to strengthen your use of `useState`, local state, shared state, and the lifting state up pattern.

Try to solve them before looking at the solution.

---

## **Exercise 1: Basic local state**

Create a `Counter.jsx` component that:

- Has a `count` state with initial value `0`.
- Displays the value in a `p`.
- Has a **+1** button that increments the counter.

<details><summary>Show solution</summary>

```js
import { useState } from "react";

function Counter() {
  const [count, setCount] = useState(0);

  return (
    <div>
      <p>Count: {count}</p>
      <button onClick={() => setCount(count + 1)}>+1</button>
    </div>
  );
}

export default Counter;
```

</details>

---

## **Exercise 2: Boolean state**

Create a `Toggle.jsx` component that:

- Has an `isOn` state with initial value `false`.
- Shows `ON` or `OFF`.
- Changes the state when a button is pressed.

<details><summary>Show solution</summary>

```js
import { useState } from "react";

function Toggle() {
  const [isOn, setIsOn] = useState(false);

  return (
    <div>
      <p>{isOn ? "ON" : "OFF"}</p>
      <button onClick={() => setIsOn(!isOn)}>Toggle</button>
    </div>
  );
}

export default Toggle;
```

</details>

---

## **Exercise 3: State with a controlled input**

Create a `SearchInput.jsx` component that:

- Has a `query` state.
- Renders a controlled input.
- Shows a `p` with the current value.

<details><summary>Show solution</summary>

```js
import { useState } from "react";

function SearchInput() {
  const [query, setQuery] = useState("");

  return (
    <div>
      <input
        value={query}
        onChange={(e) => setQuery(e.target.value)}
        placeholder="Search"
      />
      <p>Query: {query}</p>
    </div>
  );
}

export default SearchInput;
```

</details>

---

## **Exercise 4: Lift state up (input + preview)**

Create:

- `TextInput.jsx` → controlled input.
- `TextPreview.jsx` → shows the text.

In `App.jsx`:

- Keep the `text` state.
- Pass it to both components.

<details><summary>Show solution</summary>

```js
function App() {
  const [text, setText] = useState("");

  return (
    <>
      <TextInput value={text} onChange={setText} />
      <TextPreview text={text} />
    </>
  );
}
```

</details>

---

## **Exercise 5: Shared state between siblings**

Create:

- `FilterInput.jsx`
- `ItemsList.jsx`

In `App.jsx`:

- Store `filter` in state.
- Filter a list of strings.

<details><summary>Show solution</summary>

```js
const filteredItems = items.filter((item) => item.includes(filter));
```

</details>

---

## **Exercise 6: State with an object**

Create a `ProfileForm.jsx` component with this state:

```js
{ name: "", email: "" }
```

- Two controlled inputs.
- Update the state using spread.

<details><summary>Show solution</summary>

```js
setProfile((prev) => ({ ...prev, name: e.target.value }));
```

</details>

---

## **Exercise 7: Derived state (do not use `useState`)**

Given:

```js
const numbers = [1, 2, 3, 4, 5];
```

- Create a `minValue` state.
- Calculate a filtered list without using another state.

<details><summary>Show solution</summary>

```js
const filtered = numbers.filter((n) => n >= minValue);
```

</details>

---

## **Exercise 8: Avoid duplicating state**

Explain why this state is incorrect:

```js
const [fullName, setFullName] = useState(firstName + " " + lastName);
```

<details><summary>Show solution</summary>

`fullName` is derived state and should not be stored in `useState`.

</details>

---

## **Exercise 9: Counter with reset**

Extend exercise 1:

- Add a **Reset** button.
- It sets the counter back to `0`.

<details><summary>Show solution</summary>

```js
<button onClick={() => setCount(0)}>Reset</button>
```

</details>

---

## **Exercise 10: Spot when to lift state up**

Given this situation:

- An input changes a value.
- Two components use it.

Explain where the state should live and why.

<details><summary>Show solution</summary>

The state must live in the common parent component to avoid duplication and keep everything in sync.

</details>
