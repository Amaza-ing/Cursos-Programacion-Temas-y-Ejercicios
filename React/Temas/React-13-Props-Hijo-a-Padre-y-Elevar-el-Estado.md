# **Topic 13: Props Son to Father and Raising the State**

## **1. Introduction**

So far we have seen how data is moved down from a parent component to a child using **props**. But in a real app you also need the opposite way:

- The user interacts in a child component (for example, writes in an input or presses a button).
- That action must **affect the state** that the father lives in.

In React, this is achieved with a very common pattern:

- The parent creates a **function**.
- Passes it to the son as a prop.
- The son executes it to “warn” the father.

When a state is moved up to be shared by multiple components, we call it **lifting state up_.

In this topic you will learn:

- How to communicate data from **child → father**.
- How to pass functions as props.
- What does **raise status** mean and when to do it.
- Typical examples: button that notifies, input that updates, list with selection.

---

## **2. Key idea: props don't rise, functions rise**

Props are **read-only** in the child. The child cannot “change” the parent's status directly.

The correct way is:

1. The parent saves the state with `useState`.
2. The parent defines a function that updates that state.
3. The father passes that function to the son.
4. The child calls that function when an event occurs.

---

## **3. Pass a function from parent to child**

### **3.1. Simple example: son notifies father**

**`ChildButton.jsx`**

```js
function ChildButton({ onNotify }) {
  const handleClick = () => {
    onNotify("Hello from child");
  };

  return <button onClick={handleClick}>Notify parent</button>;
}

export default ChildButton;
```

**`App.jsx`**

```js
import ChildButton from "./components/ChildButton";

function App() {
  const handleNotify = (message) => {
    console.log(message);
  };

  return (
    <div>
      <ChildButton onNotify={handleNotify} />
    </div>
  );
}

export default App;
```

Observe:

- The parent passes `handleNotify` as `onNotify`.
- The child executes `onNotify(...)` when the user clicks.

---

## **4. Typical pattern: input in child, state in parent**

A very common situation:

- The input is in a child component.
- The value must be saved in the parent (because other components need it).

### **4.1. Father with status**

**`App.jsx`**

```js
import { useState } from "react";
import SearchInput from "./components/SearchInput";

function App() {
  const [query, setQuery] = useState("");

  const handleQueryChange = (newQuery) => {
    setQuery(newQuery);
  };

  return (
    <div>
      <SearchInput value={query} onValueChange={handleQueryChange} />
      <p>Searching: {query}</p>
    </div>
  );
}

export default App;
```

### **4.2. Child reporting changes**

**`SearchInput.jsx`**

```js
function SearchInput({ value, onValueChange }) {
  const handleChange = (event) => {
    onValueChange(event.target.value);
  };

  return <input value={value} onChange={handleChange} placeholder="Search" />;
}

export default SearchInput;
```

Here the state lives in the parent, but the input is in the child:

- The parent controls the value (`value`).
- The son notifies the father (`onValueChange`).

---

[![Props Son to Father](https://img.youtube.com/vi/A2hRoqV3z84/0.jpg)](https://www.youtube.com/watch?v=A2hRoqV3z84&list=PLzA2VyZwsq_-dE3Jvunglxq8a6UcH6gnF)

---

## **5. Raising Status: When It Makes Sense**

Raising state means **moving state to the common parent component** when:

- Two (or more) sibling components need the same data.
- A component must update something that another component displays.

Typical example:

- `SearchInput` (child 1) updates search.
- `ResultsList` (child 2) shows filtered results.

They both depend on `query`, so `query` must be in the parent.

---

## **6. Complete example: input + filtered list (elevated state)**

**`App.jsx`**

```js
import { useState } from "react";
import SearchInput from "./components/SearchInput";
import ResultsList from "./components/ResultsList";

function App() {
  const [query, setQuery] = useState("");

  const items = ["React", "Node", "CSS", "JavaScript"];

  const filteredItems = items.filter((item) =>
    item.toLowerCase().includes(query.toLowerCase())
  );

  return (
    <div>
      <SearchInput value={query} onValueChange={setQuery} />
      <ResultsList items={filteredItems} />
    </div>
  );
}

export default App;
```

**`ResultsList.jsx`**

```js
function ResultsList({ items }) {
  return (
    <ul>
      {items.map((item) => (
        <li key={item}>{item}</li>
      ))}
    </ul>
  );
}

export default ResultsList;
```

Details:

- `SearchInput` and `ResultsList` are brothers.
- They share the state `query` that lives on the parent.

---

## **7. Send “selections” to the parent (click on an item)**

Another very common case: the child displays a list and, upon clicking, must tell the parent which item has been selected.

**`ItemList.jsx`**

```js
function ItemList({ items, onSelect }) {
  return (
    <ul>
      {items.map((item) => (
        <li key={item}>
          <button onClick={() => onSelect(item)}>{item}</button>
        </li>
      ))}
    </ul>
  );
}

export default ItemList;
```

**`App.jsx`**
```js
import { useState } from "react";
import ItemList from "./components/ItemList";

function App() {
  const items = ["Small", "Medium", "Large"];
  const [selected, setSelected] = useState("Medium");

  const handleSelect = (value) => {
    setSelected(value);
  };

  return (
    <div>
      <p>Selected: {selected}</p>
      <ItemList items={items} onSelect={handleSelect} />
    </div>
  );
}

export default App;
```

---

## **8. Good practices**

- Name function props with intent:

  - `onSelect`, `onChange`, `onSubmit`, `onClose`.

- In the child, do not “invent” state if that data is needed outside.
- If state is used in a single component, keep it local.
- If shared between siblings, **upload** it to the common parent.

---

## **9. Typical errors**

### **9.1. Call function instead of passing it**

Incorrect:

```js
<ItemList onSelect={handleSelect()} />
```

Correct:

```js
<ItemList onSelect={handleSelect} />
```

---

### **9.2. Mutate props**

The props are not modified in the child.

If the child needs to change something, he must:

- Have its own state (if local), or
- Notify the parent with a function.

---

## **10. To take into account**

- Child → parent communication: the parent passes a function and the child executes it.
- Raise state: move state to the common parent when multiple components need it.
- Typical pattern: `value` + `onValueChange` for inputs.

---

[![Raise Status](https://img.youtube.com/vi/tLOeGTJudd4/0.jpg)](https://www.youtube.com/watch?v=tLOeGTJudd4&list=PLzA2VyZwsq_-dE3Jvunglxq8a6UcH6gnF)

---

In the next topic we will see **useEffect()**, to react to state changes and execute effects (fetch, timers, etc.).
