# **Exercises - Topic 21: State Management in React**

Below you will find **10 practical exercises** to strengthen your use of `useState`, the local state, the shared state, and the raising state pattern.

Try to solve them before consulting the solution.

---

## **Exercise 1: Basic local state**

Create an `Counter.jsx` component that:

- Have initial status `count` `0`.
- Display the value in an `p`.
- Have a **+1** button that increments the counter.

<details><summary>Show Solution</summary>

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

Create an `Toggle.jsx` component that:

- Have initial status `isOn` `false`.
- Show `ON` or `OFF`.
- Change status by pressing a button.

<details><summary>Show Solution</summary>

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

## **Exercise 3: State with controlled input**

Create an `SearchInput.jsx` component that:

- Have status `query`.
- Render a controlled input.
- Show an `p` with the current value.

<details><summary>Show Solution</summary>

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

## **Exercise 4: Raise the state (input + preview)**

Create:

- `TextInput.jsx` → controlled input.
- `TextPreview.jsx` → shows text.

In `App.jsx`:

- Saves `text` state.
- Pass it to both components.

<details><summary>Show Solution</summary>

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

- Save `filter` in status.
- Filters a list of strings.

<details><summary>Show Solution</summary>

```js
const filteredItems = items.filter((item) => item.includes(filter));
```

</details>

---

## **Exercise 6: State with object**

Create a stateful `ProfileForm.jsx` component:

```js
{ name: "", email: "" }
```

- Two controlled inputs.
- Update status using spread.

<details><summary>Show Solution</summary>

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

- Create `minValue` state.
- Calculates a filtered list without using another state.

<details><summary>Show Solution</summary>

```js
const filtered = numbers.filter((n) => n >= minValue);
```

</details>

---

## **Exercise 8: Avoid duplicating state**

Explain why this status is incorrect:

```js
const [fullName, setFullName] = useState(firstName + " " + lastName);
```

<details><summary>Show Solution</summary>

`fullName` is a derived state and should not be stored in `useState`.

</details>

---

## **Exercise 9: Counter with reset**

Expand exercise 1:

- Add a **Reset** button.
- Returns the counter to `0`.

<details><summary>Show Solution</summary>

```js
<button onClick={() => setCount(0)}>Reset</button>
```

</details>

---

## **Exercise 10: Detect when to raise the status**

Given this situation:

- An input changes a value.
- Two components use it.

Explain where the state should live and why.

<details><summary>Show Solution</summary>

The state must live in the common parent component to avoid duplication and maintain synchronization.

</details>
