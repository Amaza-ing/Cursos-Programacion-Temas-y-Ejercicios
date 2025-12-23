# **Tema 13: Props Hijo a Padre y Elevar el Estado**

## **1. Introducción**

Hasta ahora hemos visto cómo los datos bajan de un componente padre a un hijo mediante **props**. Pero en una app real también necesitas el camino contrario:

- El usuario interactúa en un componente hijo (por ejemplo, escribe en un input o pulsa un botón).
- Esa acción debe **afectar al estado** que vive en el padre.

En React, esto se consigue con un patrón muy común:

- El padre crea una **función**.
- Se la pasa al hijo como prop.
- El hijo la ejecuta para “avisar” al padre.

Cuando un estado se mueve hacia arriba para que lo compartan varios componentes, lo llamamos **elevar el estado** (_lifting state up_).

En este tema aprenderás:

- Cómo comunicar datos de **hijo → padre**.
- Cómo pasar funciones como props.
- Qué significa **elevar el estado** y cuándo hacerlo.
- Ejemplos típicos: botón que notifica, input que actualiza, lista con selección.

---

## **2. Idea clave: las props no suben, suben las funciones**

Las props son de **solo lectura** en el hijo. El hijo no puede “cambiar” el estado del padre directamente.

La forma correcta es:

1. El padre guarda el estado con `useState`.
2. El padre define una función que actualiza ese estado.
3. El padre pasa esa función al hijo.
4. El hijo llama a esa función cuando ocurra un evento.

---

## **3. Pasar una función del padre al hijo**

### **3.1. Ejemplo simple: el hijo avisa al padre**

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

Observa:

- El padre pasa `handleNotify` como `onNotify`.
- El hijo ejecuta `onNotify(...)` cuando el usuario hace click.

---

## **4. Patrón típico: input en el hijo, estado en el padre**

Una situación muy habitual:

- El input está en un componente hijo.
- El valor debe guardarse en el padre (porque otros componentes lo necesitan).

### **4.1. Padre con estado**

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

### **4.2. Hijo que notifica cambios**

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

Aquí el estado vive en el padre, pero el input está en el hijo:

- El padre controla el valor (`value`).
- El hijo avisa al padre (`onValueChange`).

---

## **5. Elevar el estado: cuándo tiene sentido**

Elevar el estado significa **mover el estado al componente padre común** cuando:

- Dos (o más) componentes hermanos necesitan los mismos datos.
- Un componente debe actualizar algo que otro componente muestra.

Ejemplo típico:

- `SearchInput` (hijo 1) actualiza la búsqueda.
- `ResultsList` (hijo 2) muestra resultados filtrados.

Ambos dependen de `query`, así que `query` debe estar en el padre.

---

## **6. Ejemplo completo: input + lista filtrada (estado elevado)**

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

Detalles:

- `SearchInput` y `ResultsList` son hermanos.
- Comparten el estado `query` que vive en el padre.

---

## **7. Enviar “selecciones” al padre (clic en un item)**

Otro caso muy común: el hijo muestra una lista y, al hacer click, debe decirle al padre qué elemento se ha seleccionado.

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

## **8. Buenas prácticas**

- Nombra las props de función con intención:

  - `onSelect`, `onChange`, `onSubmit`, `onClose`.

- En el hijo, no “inventes” estado si ese dato se necesita fuera.
- Si el estado se usa en un solo componente, mantenlo local.
- Si se comparte entre hermanos, **súbelo** al padre común.

---

## **9. Errores típicos**

### **9.1. Llamar a la función en vez de pasarla**

Incorrecto:

```js
<ItemList onSelect={handleSelect()} />
```

Correcto:

```js
<ItemList onSelect={handleSelect} />
```

---

### **9.2. Mutar props**

Las props no se modifican en el hijo.

Si el hijo necesita cambiar algo, debe:

- Tener estado propio (si es local), o
- Avisar al padre con una función.

---

## **10. A tener en cuenta**

- Comunicación hijo → padre: el padre pasa una función y el hijo la ejecuta.
- Elevar el estado: mover el estado al padre común cuando varios componentes lo necesitan.
- Patrón típico: `value` + `onValueChange` para inputs.

---

En el próximo tema veremos **useEffect()**, para reaccionar a cambios de estado y ejecutar efectos (fetch, timers, etc.).
