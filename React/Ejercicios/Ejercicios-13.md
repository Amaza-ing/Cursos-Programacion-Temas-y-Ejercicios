# **Exercises - Topic 13: Props from Child to Parent and Lifting State Up**

Below you will find **10 practical exercises** to learn how to send data from a **child → parent** component by passing **functions as props**, and how to **lift state up** when several components need it.

Try to solve them before looking at the solution.

---

## **Exercise 1: The child notifies the parent with a button**

Create a `NotifyButton.jsx` component that receives an `onNotify` prop.

- When clicked, it must call `onNotify("Clicked from child")`.

In `App.jsx`, create `handleNotify(message)` that does `console.log(message)` and pass it to the child.

<details><summary>Show solution</summary>

**`NotifyButton.jsx`**

```js
function NotifyButton({ onNotify }) {
  const handleClick = () => {
    onNotify("Clicked from child");
  };

  return <button onClick={handleClick}>Notify</button>;
}

export default NotifyButton;
```

**`App.jsx`**

```js
import NotifyButton from "./components/NotifyButton";

function App() {
  const handleNotify = (message) => {
    console.log(message);
  };

  return (
    <div>
      <NotifyButton onNotify={handleNotify} />
    </div>
  );
}

export default App;
```

</details>

---

## **Exercise 2: Pass data from the child to the parent (with a parameter)**

Create a `ColorPicker.jsx` component that receives `onPick`.

- It renders two buttons: **Blue** and **Purple**.
- When clicked, it calls `onPick("blue")` or `onPick("purple")`.

In the parent:

- Store `selectedColor` in state (initial value `"blue"`).
- Display a `p` with: **"Selected: ..."**.

<details><summary>Show solution</summary>

**`ColorPicker.jsx`**

```js
function ColorPicker({ onPick }) {
  return (
    <div>
      <button onClick={() => onPick("blue")}>Blue</button>
      <button onClick={() => onPick("purple")}>Purple</button>
    </div>
  );
}

export default ColorPicker;
```

**`App.jsx`**

```js
import { useState } from "react";
import ColorPicker from "./components/ColorPicker";

function App() {
  const [selectedColor, setSelectedColor] = useState("blue");

  const handlePick = (color) => {
    setSelectedColor(color);
  };

  return (
    <div>
      <p>Selected: {selectedColor}</p>
      <ColorPicker onPick={handlePick} />
    </div>
  );
}

export default App;
```

</details>

---

## **Exercise 3: Input in the child, state in the parent**

Create a `NameField.jsx` component that receives:

- `value`
- `onValueChange`

It must render a controlled input.

In the parent:

- Store `name` in state.
- Pass `value={name}`.
- Pass `onValueChange` to update the state.
- Show a `p` with: **"Hello, {name}"**.

<details><summary>Show solution</summary>

**`NameField.jsx`**

```js
function NameField({ value, onValueChange }) {
  const handleChange = (event) => {
    onValueChange(event.target.value);
  };

  return <input value={value} onChange={handleChange} placeholder="Name" />;
}

export default NameField;
```

**`App.jsx`**

```js
import { useState } from "react";
import NameField from "./components/NameField";

function App() {
  const [name, setName] = useState("");

  return (
    <div>
      <NameField value={name} onValueChange={setName} />
      <p>Hello, {name}</p>
    </div>
  );
}

export default App;
```

</details>

---

## **Exercise 4: Lift state up to share it between two components**

Create these components:

- `TextInput.jsx` (child): receives `value` and `onValueChange`.
- `TextPreview.jsx` (child): receives `text` and displays it inside a `p`.

In `App.jsx`:

- Store `text` in state.
- Pass the value and the handler to the input.
- Pass the text to `TextPreview`.

<details><summary>Show solution</summary>

**`TextInput.jsx`**

```js
function TextInput({ value, onValueChange }) {
  const handleChange = (event) => {
    onValueChange(event.target.value);
  };

  return <input value={value} onChange={handleChange} placeholder="Type..." />;
}

export default TextInput;
```

**`TextPreview.jsx`**

```js
function TextPreview({ text }) {
  return <p>Preview: {text}</p>;
}

export default TextPreview;
```

**`App.jsx`**

```js
import { useState } from "react";
import TextInput from "./components/TextInput";
import TextPreview from "./components/TextPreview";

function App() {
  const [text, setText] = useState("");

  return (
    <div>
      <TextInput value={text} onValueChange={setText} />
      <TextPreview text={text} />
    </div>
  );
}

export default App;
```

</details>

---

## **Exercise 5: List in the child, selection sent to the parent**

Create a `SizeList.jsx` component that receives:

- `sizes` (array of strings)
- `onSelect`

It must render a `ul` where each item is a button. When clicked, it calls `onSelect(size)`.

In `App.jsx`:

- Use `const sizes = ["S", "M", "L"];`
- Store `selectedSize` in state (initial value `"M"`).
- Display a `p` with: **"Size: {selectedSize}"**.

<details><summary>Show solution</summary>

**`SizeList.jsx`**

```js
function SizeList({ sizes, onSelect }) {
  return (
    <ul>
      {sizes.map((size) => (
        <li key={size}>
          <button onClick={() => onSelect(size)}>{size}</button>
        </li>
      ))}
    </ul>
  );
}

export default SizeList;
```

**`App.jsx`**

```js
import { useState } from "react";
import SizeList from "./components/SizeList";

function App() {
  const sizes = ["S", "M", "L"];
  const [selectedSize, setSelectedSize] = useState("M");

  return (
    <div>
      <p>Size: {selectedSize}</p>
      <SizeList sizes={sizes} onSelect={setSelectedSize} />
    </div>
  );
}

export default App;
```

</details>

---

## **Exercise 6: Fix the mistake of “calling” the function**

This code runs the handler on render. Fix it:

```js
function App() {
  const handleSelect = (value) => console.log(value);

  return <Picker onSelect={handleSelect("A")} />;
}
```

<details><summary>Show solution</summary>
In React you must pass the function, not call it. If you want to pass a fixed value, use an arrow function:

```js
function App() {
  const handleSelect = (value) => console.log(value);

  return <Picker onSelect={() => handleSelect("A")} />;
}

export default App;
```

</details>

---

## **Exercise 7: Lift state up to filter a list**

Create these components:

- `FilterInput.jsx`: receives `value` and `onValueChange`.
- `ItemsList.jsx`: receives `items` and renders a `ul`.

In `App.jsx`:

- Store `query` in state.
- Use this array:

```js
const tools = ["React", "Vite", "ESLint", "Prettier"];
```

- Filter `tools` with `query` (use `.toLowerCase()` and `.includes()`).
- Pass `query` to the input and `setQuery` as `onValueChange`.
- Pass the filtered list to `ItemsList`.

<details><summary>Show solution</summary>

**`FilterInput.jsx`**

```js
function FilterInput({ value, onValueChange }) {
  const handleChange = (event) => {
    onValueChange(event.target.value);
  };

  return <input value={value} onChange={handleChange} placeholder="Filter" />;
}

export default FilterInput;
```

**`ItemsList.jsx`**

```js
function ItemsList({ items }) {
  return (
    <ul>
      {items.map((item) => (
        <li key={item}>{item}</li>
      ))}
    </ul>
  );
}

export default ItemsList;
```

**`App.jsx`**

```js
import { useState } from "react";
import FilterInput from "./components/FilterInput";
import ItemsList from "./components/ItemsList";

function App() {
  const [query, setQuery] = useState("");
  const tools = ["React", "Vite", "ESLint", "Prettier"];

  const filteredTools = tools.filter((tool) =>
    tool.toLowerCase().includes(query.toLowerCase())
  );

  return (
    <div>
      <FilterInput value={query} onValueChange={setQuery} />
      <ItemsList items={filteredTools} />
    </div>
  );
}

export default App;
```

</details>

---

## **Exercise 8: The child “closes” a panel (callback)**

Create a `Modal.jsx` component that receives `onClose`.

- It renders a `div` with a text `p`: **"Modal content"**.
- It renders a **Close** button.
- When clicked, it calls `onClose()`.

In the parent:

- Store `isOpen` in state (initial value `true`).
- Render the modal only if `isOpen` is true.
- Pass `onClose` so that it does `setIsOpen(false)`.

<details><summary>Show solution</summary>

**`Modal.jsx`**

```js
function Modal({ onClose }) {
  return (
    <div>
      <p>Modal content</p>
      <button onClick={onClose}>Close</button>
    </div>
  );
}

export default Modal;
```

**`App.jsx`**

```js
import { useState } from "react";
import Modal from "./components/Modal";

function App() {
  const [isOpen, setIsOpen] = useState(true);

  const handleClose = () => {
    setIsOpen(false);
  };

  return <div>{isOpen && <Modal onClose={handleClose} />}</div>;
}

export default App;
```

</details>

---

## **Exercise 9: Pass a function with a semantic name**

Rewrite this code using a more semantic prop name.

```js
<Child onData={handleChange} />
```

The child represents an input, so the name should suggest a change of value.

<details><summary>Show solution</summary>

A typical option:

```js
<Child onValueChange={handleChange} />
```

Other valid names depending on the context:

- `onChange`
- `onTextChange`

</details>

---

## **Exercise 10: Mini-case (deciding whether to lift state up)**

You have:

- `SearchBar` (input)
- `Results` (filtered list)

Both need `query`.

Where should the `query` state live?

- a) Inside `SearchBar`
- b) Inside `Results`
- c) In the common parent

Explain in one sentence.

<details><summary>Show solution</summary>

The correct option is **c) in the common parent**.

Reason: `query` affects two sibling components, so it must live in the parent to share it and keep a single source of truth.

</details>
