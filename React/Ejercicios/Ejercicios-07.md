# **Exercises - Topic 7: useState**

Below you will find **10 practical exercises** on `useState`.

Try to solve them before looking at the solution.

---

## **Exercise 1: Counter with decrement**

Create a `Stepper.jsx` component that has:

- A `count` state with initial value `5`.
- A **+** button that increments it.
- A **-** button that decrements it.

<details><summary>Show solution</summary>

```js
import { useState } from "react";

function Stepper() {
  const [count, setCount] = useState(5);

  const handleIncrease = () => {
    setCount((prevCount) => prevCount + 1);
  };

  const handleDecrease = () => {
    setCount((prevCount) => prevCount - 1);
  };

  return (
    <div>
      <button onClick={handleDecrease}>-</button>
      <span> {count} </span>
      <button onClick={handleIncrease}>+</button>
    </div>
  );
}

export default Stepper;
```

</details>

---

## **Exercise 2: Resetting the state**

Create a `ResettableCounter.jsx` component with:

- A `count` state with initial value `0`.
- An **Add** button that increments it.
- A **Reset** button that sets it to `0`.

<details><summary>Show solution</summary>

```js
import { useState } from "react";

function ResettableCounter() {
  const [count, setCount] = useState(0);

  const handleAdd = () => {
    setCount((prevCount) => prevCount + 1);
  };

  const handleReset = () => {
    setCount(0);
  };

  return (
    <div>
      <p>Count: {count}</p>
      <button onClick={handleAdd}>Add</button>
      <button onClick={handleReset}>Reset</button>
    </div>
  );
}

export default ResettableCounter;
```

</details>

---

## **Exercise 3: Toggle with dynamic text**

Create a `PowerSwitch.jsx` component with:

- A boolean `isOn` state with initial value `false`.
- A button that changes the state.
- A text that shows:

  - **"Power: ON"** if `isOn` is `true`.
  - **"Power: OFF"** if `isOn` is `false`.

<details><summary>Show solution</summary>

```js
import { useState } from "react";

function PowerSwitch() {
  const [isOn, setIsOn] = useState(false);

  const handleToggle = () => {
    setIsOn((prevIsOn) => !prevIsOn);
  };

  return (
    <div>
      <button onClick={handleToggle}>Toggle</button>
      <p>Power: {isOn ? "ON" : "OFF"}</p>
    </div>
  );
}

export default PowerSwitch;
```

</details>

---

## **Exercise 4: Controlled input with character counter**

Create a `BioInput.jsx` component with:

- A `bio` state with initial value `""`.
- A controlled input.
- A `p` showing: **"Chars: X"**, where X is `bio.length`.

<details><summary>Show solution</summary>

```js
import { useState } from "react";

function BioInput() {
  const [bio, setBio] = useState("");

  const handleChange = (event) => {
    setBio(event.target.value);
  };

  return (
    <div>
      <input value={bio} onChange={handleChange} placeholder="Write a bio" />
      <p>Chars: {bio.length}</p>
    </div>
  );
}

export default BioInput;
```

</details>

---

## **Exercise 5: Save a number from an input**

Create an `AgeInput.jsx` component with:

- An `age` state with initial value `0`.
- A controlled input of type `number`.
- A `p` showing: **"Age: {age}"**.

Hint: `event.target.value` arrives as a string.

<details><summary>Show solution</summary>

```js
import { useState } from "react";

function AgeInput() {
  const [age, setAge] = useState(0);

  const handleChange = (event) => {
    setAge(Number(event.target.value));
  };

  return (
    <div>
      <input type="number" value={age} onChange={handleChange} />
      <p>Age: {age}</p>
    </div>
  );
}

export default AgeInput;
```

</details>

---

## **Exercise 6: Incorrect update (fix the bug)**

This component tries to increment twice, but it doesn't always work as you expect:

```js
import { useState } from "react";

function DoubleAdd() {
  const [count, setCount] = useState(0);

  const handleClick = () => {
    setCount(count + 1);
    setCount(count + 1);
  };

  return <button onClick={handleClick}>Count: {count}</button>;
}

export default DoubleAdd;
```

Fix it so that it actually adds 2.

<details><summary>Show solution</summary>

You have to use the functional form:

```js
import { useState } from "react";

function DoubleAdd() {
  const [count, setCount] = useState(0);

  const handleClick = () => {
    setCount((prevCount) => prevCount + 1);
    setCount((prevCount) => prevCount + 1);
  };

  return <button onClick={handleClick}>Count: {count}</button>;
}

export default DoubleAdd;
```

</details>

---

## **Exercise 7: Clear an input with a button**

Create a `ClearableInput.jsx` component with:

- A `text` state with initial value `""`.
- A controlled input.
- A **Clear** button that sets `text` to `""`.

<details><summary>Show solution</summary>

```js
import { useState } from "react";

function ClearableInput() {
  const [text, setText] = useState("");

  const handleChange = (event) => {
    setText(event.target.value);
  };

  const handleClear = () => {
    setText("");
  };

  return (
    <div>
      <input value={text} onChange={handleChange} placeholder="Type..." />
      <button onClick={handleClear}>Clear</button>
    </div>
  );
}

export default ClearableInput;
```

</details>

---

## **Exercise 8: Switch between two texts**

Create a `LanguageToggle.jsx` component with:

- A `language` state with initial value `"EN"`.
- A button that toggles between `"EN"` and `"ES"`.
- A `p` showing: **"Language: EN"** or **"Language: ES"**.

<details><summary>Show solution</summary>

```js
import { useState } from "react";

function LanguageToggle() {
  const [language, setLanguage] = useState("EN");

  const handleToggle = () => {
    setLanguage((prevLanguage) => (prevLanguage === "EN" ? "ES" : "EN"));
  };

  return (
    <div>
      <button onClick={handleToggle}>Toggle</button>
      <p>Language: {language}</p>
    </div>
  );
}

export default LanguageToggle;
```

</details>

---

## **Exercise 9: Avoid negative state**

Create a `NonNegativeCounter.jsx` component with:

- A `count` state with initial value `0`.
- A **-** button that subtracts, but never lets the counter go below `0`.
<details><summary>Show solution</summary>

```js
import { useState } from "react";

function NonNegativeCounter() {
  const [count, setCount] = useState(0);

  const handleDecrease = () => {
    setCount((prevCount) => (prevCount > 0 ? prevCount - 1 : 0));
  };

  const handleIncrease = () => {
    setCount((prevCount) => prevCount + 1);
  };

  return (
    <div>
      <button onClick={handleDecrease}>-</button>
      <span> {count} </span>
      <button onClick={handleIncrease}>+</button>
    </div>
  );
}

export default NonNegativeCounter;
```

</details>

---

## **Exercise 10: Mini decision case (choose the best way)**

You want to update a `count` state based on its previous value.

Which is the most recommended way?

1.

```js
setCount(count + 1);
```

2.

```js
setCount((prevCount) => prevCount + 1);
```

<details><summary>Show solution</summary>

The most recommended way is **2**:

```js
setCount((prevCount) => prevCount + 1);
```

Reason: it is safer when the new state depends on the previous one.

</details>

---
