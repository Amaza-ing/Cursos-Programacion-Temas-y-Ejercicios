# **Exercises - Topic 13: Props Son to Father and Elevate the Status**

Below you will find **10 practical exercises** to learn how to communicate data from a **child → parent** component by passing **functions as props**, and how to **raise state** when multiple components need it.

Try to solve them before consulting the solution.

---

## **Exercise 1: The son notifies the father with a button**

Create an `NotifyButton.jsx` component that receives an `onNotify` prop.

- When you click, you must call `onNotify("Clicked from child")`.

In `App.jsx`, create `handleNotify(message)` that makes `console.log(message)` and pass it to the child.

<details><summary>Show Solution</summary>

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

## **Exercise 2: Pass data from the child to the parent (with parameter)**

Create an `ColorPicker.jsx` component that receives `onPick`.

- Renders two buttons: **Blue** and **Purple**.
- When you click, it calls `onPick("blue")` or `onPick("purple")`.

On the father:

- Save `selectedColor` in state (initial `"blue"`).
- Displays `p` with: **"Selected: ..."**.

<details><summary>Show Solution</summary>

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

Create an `NameField.jsx` component that receives:

- `value`
- `onValueChange`

It must render a controlled input.

On the father:

- Save `name` in status.
- Pass `value={name}`.
- Pass `onValueChange` to update the status.
- Shows an `p` with: **"Hello, {name}"**.

<details><summary>Show Solution</summary>

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

## **Exercise 4: Raise state to share between two components**

Create these components:

- `TextInput.jsx` (child): receives `value` and `onValueChange`.
- `TextPreview.jsx` (child): receives `text` and displays it inside an `p`.

In `App.jsx`:

- Save `text` in status.
- Pass the value and the handler to the input.
- Pass the text to `TextPreview`.

<details><summary>Show Solution</summary>

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

## **Exercise 5: List in the child and selection towards the parent**

Create an `SizeList.jsx` component that receives:

- `sizes` (array of strings)
- `onSelect`

You must render an `ul` where each item is a button. When you click, it calls `onSelect(size)`.

In `App.jsx`:

- Use `const sizes = ["S", "M", "L"];`
- Save `selectedSize` in state (initial `"M"`).
- Displays `p` with: **"Size: {selectedSize}"**.

<details><summary>Show Solution</summary>

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

## **Exercise 6: Correct the error of “calling” the function**

This code runs the handler when rendering. Correct it:

```js
function App() {
  const handleSelect = (value) => console.log(value);

  return <Picker onSelect={handleSelect("A")} />;
}
```

<details><summary>Show Solution</summary>
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

## **Exercise 7: Raise the state to filter a list**

Create these components:

- `FilterInput.jsx`: receive `value` and `onValueChange`.
- `ItemsList.jsx`: Receives `items` and renders an `ul`.

In `App.jsx`:

- Save `query` in status.
- Use this array:

```js
const tools = ["React", "Vite", "ESLint", "Prettier"];
```

- Filter `tools` with `query` (use `.toLowerCase()` and `.includes()`).
- Pass `query` to the input and `setQuery` as `onValueChange`.
- Pass the filtered list to `ItemsList`.

<details><summary>Show Solution</summary>

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

## **Exercise 8: Son “closes” a panel (callback)**

Create an `Modal.jsx` component that receives `onClose`.

- Renders an `div` with a text `p`: **"Modal content"**.
- Renders a **Close** button.
- When you click, it calls `onClose()`.

On the father:

- Save `isOpen` in state (initial `true`).
- Render the modal only if `isOpen` is true.
- Pass `onClose` to make `setIsOpen(false)`.

<details><summary>Show Solution</summary>

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

## **Exercise 9: Passing a function with a semantic name**

Rewrite this code using a more semantic prop name.

```js
<Child onData={handleChange} />
```

The child represents an input, so the name should suggest value change.

<details><summary>Show Solution</summary>

A typical option:

```js
<Child onValueChange={handleChange} />
```

Other valid names depending on the context:

- `onChange`
- `onTextChange`

</details>

---

## **Exercise 10: Mini-case (deciding whether to raise the status)**

You have:

- `SearchBar` (input)
- `Results` (leaked list)

Both need `query`.

Where should `query` status live?

- a) Inside `SearchBar`
- b) Inside `Results`
- c) In the common father

Explain in one sentence.

<details><summary>Show Solution</summary>

The correct option is **c) on the common parent**.

Reason: `query` affects two sibling components, so it must be on the parent to share it and maintain a single source of truth.

</details>
