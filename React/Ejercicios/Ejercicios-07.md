# **Exercises - Topic 7: useState**

Below you will find **10 practical exercises** on `useState`.

Try to solve them before consulting the solution.

---

## **Exercise 1: Counter with decrement**

Create an `Stepper.jsx` component that has:

- A state `count` with initial value `5`.
- A *+** button that increases.
- A **-** button that decreases.

<details><summary>Show Solution</summary>

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

## **Exercise 2: State reset**

Create an `ResettableCounter.jsx` component with:

- Initial `count` state `0`.
- **Add** button that increases.
- **Reset** button to set it to `0`.

<details><summary>Show Solution</summary>

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

Create an `PowerSwitch.jsx` component with:

- Initial `isOn` boolean state `false`.
- A button that changes the state.
- A text that shows:

  - **"Power: ON"** if `isOn` is `true`.
  - **"Power: OFF"** if `isOn` is `false`.

<details><summary>Show Solution</summary>

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

Create an `BioInput.jsx` component with:

- Initial `bio` state `""`.
- A controlled input.
- An `p` showing: **"Chars: X"**, where X is `bio.length`.

<details><summary>Show Solution</summary>

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

- Initial `age` state `0`.
- A controlled `number` type input.
- An `p` showing: **"Age: {age}"**.

Hint: `event.target.value` arrives as a string.

<details><summary>Show Solution</summary>

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

## **Exercise 6: Incorrect update (fixes the bug)**

This component tries to increment 2 times, but it doesn't always work as you expect:

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

Correct it so that it actually adds up to 2.

<details><summary>Show Solution</summary>

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

Create an `ClearableInput.jsx` component with:

- Initial `text` state `""`.
- Controlled input.
- **Clear** button that puts `text` in `""`.

<details><summary>Show Solution</summary>

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

Create an `LanguageToggle.jsx` component with:

- Initial `language` state `"EN"`.
- A button that toggles between `"EN"` and `"ES"`.
- An `p` showing: **"Language: EN"** or **"Language: ES"**.

<details><summary>Show Solution</summary>

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

Create an `NonNegativeCounter.jsx` component with:

- Initial `count` state `0`.
- **-** button that subtracts, but never leave the counter below `0`.
<details><summary>Show Solution</summary>

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

## **Exercise 10: Mini-decision case (choose the best way)**

You want to update an `count` status based on the previous value.

What is the most recommended way?

1.

```js
setCount(count + 1);
```

2.

```js
setCount((prevCount) => prevCount + 1);
```

<details><summary>Show Solution</summary>

The most recommended way is **2**:

```js
setCount((prevCount) => prevCount + 1);
```

Reason: It is safer when the new state depends on the previous one.

</details>

---
