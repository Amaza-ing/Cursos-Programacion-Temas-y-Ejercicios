# **Ejercicios - Tema 21: Gestión de Estado en React**

A continuación, encontrarás **10 ejercicios prácticos** para afianzar el uso de `useState`, el estado local, el estado compartido y el patrón de elevar el estado.

Intenta resolverlos antes de consultar la solución.

---

## **Ejercicio 1: Estado local básico**

Crea un componente `Counter.jsx` que:

- Tenga estado `count` inicial `0`.
- Muestre el valor en un `p`.
- Tenga un botón **+1** que incremente el contador.

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 2: Estado booleano**

Crea un componente `Toggle.jsx` que:

- Tenga estado `isOn` inicial `false`.
- Muestre `ON` o `OFF`.
- Cambie el estado al pulsar un botón.

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 3: Estado con input controlado**

Crea un componente `SearchInput.jsx` que:

- Tenga estado `query`.
- Renderice un input controlado.
- Muestre un `p` con el valor actual.

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 4: Elevar el estado (input + preview)**

Crea:

- `TextInput.jsx` → input controlado.
- `TextPreview.jsx` → muestra texto.

En `App.jsx`:

- Guarda el estado `text`.
- Pásalo a ambos componentes.

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 5: Estado compartido entre hermanos**

Crea:

- `FilterInput.jsx`
- `ItemsList.jsx`

En `App.jsx`:

- Guarda `filter` en estado.
- Filtra una lista de strings.

<details><summary>Mostrar Solución</summary>

```js
const filteredItems = items.filter((item) => item.includes(filter));
```

</details>

---

## **Ejercicio 6: Estado con objeto**

Crea un componente `ProfileForm.jsx` con estado:

```js
{ name: "", email: "" }
```

- Dos inputs controlados.
- Actualiza el estado usando spread.

<details><summary>Mostrar Solución</summary>

```js
setProfile((prev) => ({ ...prev, name: e.target.value }));
```

</details>

---

## **Ejercicio 7: Estado derivado (no usar `useState`)**

Dado:

```js
const numbers = [1, 2, 3, 4, 5];
```

- Crea estado `minValue`.
- Calcula una lista filtrada sin usar otro estado.

<details><summary>Mostrar Solución</summary>

```js
const filtered = numbers.filter((n) => n >= minValue);
```

</details>

---

## **Ejercicio 8: Evitar duplicar estado**

Explica por qué este estado es incorrecto:

```js
const [fullName, setFullName] = useState(firstName + " " + lastName);
```

<details><summary>Mostrar Solución</summary>

`fullName` es un estado derivado y no debería almacenarse en `useState`.

</details>

---

## **Ejercicio 9: Contador con reset**

Amplía el ejercicio 1:

- Añade un botón **Reset**.
- Vuelve el contador a `0`.

<details><summary>Mostrar Solución</summary>

```js
<button onClick={() => setCount(0)}>Reset</button>
```

</details>

---

## **Ejercicio 10: Detectar cuándo elevar el estado**

Dada esta situación:

- Un input cambia un valor.
- Dos componentes lo usan.

Explica dónde debe vivir el estado y por qué.

<details><summary>Mostrar Solución</summary>

El estado debe vivir en el componente padre común para evitar duplicación y mantener sincronización.

</details>
