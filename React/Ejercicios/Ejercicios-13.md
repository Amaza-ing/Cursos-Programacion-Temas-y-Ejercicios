# **Ejercicios - Tema 13: Props Hijo a Padre y Elevar el Estado**

A continuación, encontrarás **10 ejercicios prácticos** para aprender a comunicar datos de un componente **hijo → padre** pasando **funciones como props**, y a **elevar el estado** cuando varios componentes lo necesitan.

Intenta resolverlos antes de consultar la solución.

---

## **Ejercicio 1: El hijo avisa al padre con un botón**

Crea un componente `NotifyButton.jsx` que reciba una prop `onNotify`.

- Al hacer click, debe llamar a `onNotify("Clicked from child")`.

En `App.jsx`, crea `handleNotify(message)` que haga `console.log(message)` y pásalo al hijo.

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 2: Pasar un dato del hijo al padre (con parámetro)**

Crea un componente `ColorPicker.jsx` que reciba `onPick`.

- Renderiza dos botones: **Blue** y **Purple**.
- Al hacer click, llama a `onPick("blue")` o `onPick("purple")`.

En el padre:

- Guarda `selectedColor` en estado (inicial `"blue"`).
- Muestra `p` con: **"Selected: ..."**.

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 3: Input en el hijo, estado en el padre**

Crea un componente `NameField.jsx` que reciba:

- `value`
- `onValueChange`

Debe renderizar un input controlado.

En el padre:

- Guarda `name` en estado.
- Pasa `value={name}`.
- Pasa `onValueChange` para actualizar el estado.
- Muestra un `p` con: **"Hello, {name}"**.

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 4: Elevar el estado para compartirlo entre dos componentes**

Crea estos componentes:

- `TextInput.jsx` (hijo): recibe `value` y `onValueChange`.
- `TextPreview.jsx` (hijo): recibe `text` y lo muestra dentro de un `p`.

En `App.jsx`:

- Guarda `text` en estado.
- Pasa el valor y el handler al input.
- Pasa el texto a `TextPreview`.

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 5: Lista en el hijo y selección hacia el padre**

Crea un componente `SizeList.jsx` que reciba:

- `sizes` (array de strings)
- `onSelect`

Debe renderizar un `ul` donde cada item sea un botón. Al hacer click, llama a `onSelect(size)`.

En `App.jsx`:

- Usa `const sizes = ["S", "M", "L"];`
- Guarda `selectedSize` en estado (inicial `"M"`).
- Muestra `p` con: **"Size: {selectedSize}"**.

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 6: Corregir el error de “llamar” la función**

Este código ejecuta el handler al renderizar. Corrígelo:

```js
function App() {
  const handleSelect = (value) => console.log(value);

  return <Picker onSelect={handleSelect("A")} />;
}
```

<details><summary>Mostrar Solución</summary>

En React debes pasar la función, no llamarla. Si quieres pasar un valor fijo, usa una arrow function:

```js
function App() {
  const handleSelect = (value) => console.log(value);

  return <Picker onSelect={() => handleSelect("A")} />;
}

export default App;
```

</details>

---

## **Ejercicio 7: Elevar el estado para filtrar una lista**

Crea estos componentes:

- `FilterInput.jsx`: recibe `value` y `onValueChange`.
- `ItemsList.jsx`: recibe `items` y renderiza un `ul`.

En `App.jsx`:

- Guarda `query` en estado.
- Usa este array:

```js
const tools = ["React", "Vite", "ESLint", "Prettier"];
```

- Filtra `tools` con `query` (usa `.toLowerCase()` y `.includes()`).
- Pasa `query` al input y `setQuery` como `onValueChange`.
- Pasa la lista filtrada a `ItemsList`.

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 8: Hijo “cierra” un panel (callback)**

Crea un componente `Modal.jsx` que reciba `onClose`.

- Renderiza un `div` con un texto `p`: **"Modal content"**.
- Renderiza un botón **Close**.
- Al hacer click, llama a `onClose()`.

En el padre:

- Guarda `isOpen` en estado (inicial `true`).
- Renderiza el modal solo si `isOpen` es true.
- Pasa `onClose` para hacer `setIsOpen(false)`.

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 9: Pasar una función con nombre semántico**

Reescribe este código usando un nombre de prop más semántico.

```js
<Child onData={handleChange} />
```

El hijo representa un input, así que el nombre debería sugerir cambio de valor.

<details><summary>Mostrar Solución</summary>

Una opción típica:

```js
<Child onValueChange={handleChange} />
```

Otros nombres válidos según el contexto:

- `onChange`
- `onTextChange`

</details>

---

## **Ejercicio 10: Mini-caso (decidir si elevar el estado)**

Tienes:

- `SearchBar` (input)
- `Results` (lista filtrada)

Ambos necesitan `query`.

¿Dónde debería vivir el estado `query`?

- a) Dentro de `SearchBar`
- b) Dentro de `Results`
- c) En el padre común

Explica en una frase.

<details><summary>Mostrar Solución</summary>

La opción correcta es **c) en el padre común**.

Motivo: `query` afecta a dos componentes hermanos, así que debe estar en el padre para compartirlo y mantener una sola fuente de verdad.

</details>
