# **Topic 13: Props from Child to Parent and Lifting State Up**

## **1. Introduction**

So far we've seen how data flows down from a parent component to a child through **props**. But in a real app you also need to go the other way:

- The user interacts with a child component (for example, types into an input or presses a button).
- That action must **affect the state** that lives in the parent.

In React, this is done with a very common pattern:

- The parent creates a **function**.
- It passes it to the child as a prop.
- The child calls it to “notify” the parent.

When state is moved up so that several components can share it, we call it **lifting state up**.

In this topic you will learn:

- How to send data from **child → parent**.
- How to pass functions as props.
- What **lifting state up** means and when to do it.
- Typical examples: a button that notifies, an input that updates, a list with selection.

---

## **2. Key idea: props don't go up, functions do**

Props are **read-only** in the child. The child can't “change” the parent's state directly.

The correct way is:

1. The parent stores the state with `useState`.
2. The parent defines a function that updates that state.
3. The parent passes that function to the child.
4. The child calls that function when an event occurs.

---

## **3. Passing a function from parent to child**

### **3.1. Simple example: the child notifies the parent**

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

Notice:

- The parent passes `handleNotify` as `onNotify`.
- The child calls `onNotify(...)` when the user clicks.

---

## **4. Typical pattern: input in child, state in parent**

A very common situation:

- The input is in a child component.
- The value must be saved in the parent (because other components need it).

### **4.1. Parent with state**

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

### **4.2. Child that reports changes**

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
- The child notifies the parent (`onValueChange`).

---

[![Props from Child to Parent](https://img.youtube.com/vi/A2hRoqV3z84/0.jpg)](https://www.youtube.com/watch?v=A2hRoqV3z84&list=PLzA2VyZwsq_-dE3Jvunglxq8a6UcH6gnF)

---

## **5. Lifting state up: when it makes sense**

Lifting state up means **moving the state to the common parent component** when:

- Two (or more) sibling components need the same data.
- A component must update something that another component displays.

Typical example:

- `SearchInput` (child 1) updates the search.
- `ResultsList` (child 2) shows the filtered results.

Both depend on `query`, so `query` must live in the parent.

---

## **6. Complete example: input + filtered list (lifted state)**

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

- `SearchInput` and `ResultsList` are siblings.
- They share the `query` state, which lives in the parent.

---

## **7. Sending “selections” to the parent (clicking an item)**

Another very common case: the child displays a list and, when an item is clicked, it must tell the parent which item was selected.

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

## **8. Best practices**

- Name function props with intent:

  - `onSelect`, `onChange`, `onSubmit`, `onClose`.

- In the child, don't “invent” state if that data is needed outside it.
- If the state is used in a single component, keep it local.
- If it's shared between siblings, **lift** it to the common parent.

---

## **9. Common mistakes**

### **9.1. Calling the function instead of passing it**

Incorrect:

```js
<ItemList onSelect={handleSelect()} />
```

Correct:

```js
<ItemList onSelect={handleSelect} />
```

---

### **9.2. Mutating props**

Props aren't modified in the child.

If the child needs to change something, it must:

- Have its own state (if it's local), or
- Notify the parent with a function.

---

## **10. Things to keep in mind**

- Child → parent communication: the parent passes a function and the child calls it.
- Lifting state up: moving the state to the common parent when several components need it.
- Typical pattern: `value` + `onValueChange` for inputs.

---

[![Lifting State Up](https://img.youtube.com/vi/tLOeGTJudd4/0.jpg)](https://www.youtube.com/watch?v=tLOeGTJudd4&list=PLzA2VyZwsq_-dE3Jvunglxq8a6UcH6gnF)

---

In the next topic we'll look at **useEffect()**, to react to state changes and run effects (fetch, timers, etc.).
