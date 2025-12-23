# **Ejercicios - Tema 7: useState**

A continuación, encontrarás **10 ejercicios prácticos** sobre `useState`.

Intenta resolverlos antes de consultar la solución.

---

## **Ejercicio 1: Contador con decremento**

Crea un componente `Stepper.jsx` que tenga:

- Un estado `count` con valor inicial `5`.
- Un botón **+** que incremente.
- Un botón **-** que decrementa.

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 2: Reset del estado**

Crea un componente `ResettableCounter.jsx` con:

- Estado `count` inicial `0`.
- Botón **Add** que incremente.
- Botón **Reset** que lo ponga en `0`.

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 3: Toggle con texto dinámico**

Crea un componente `PowerSwitch.jsx` con:

- Estado booleano `isOn` inicial `false`.
- Un botón que cambie el estado.
- Un texto que muestre:

  - **"Power: ON"** si `isOn` es `true`.
  - **"Power: OFF"** si `isOn` es `false`.

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 4: Input controlado con contador de caracteres**

Crea un componente `BioInput.jsx` con:

- Estado `bio` inicial `""`.
- Un input controlado.
- Un `p` que muestre: **"Chars: X"**, donde X es `bio.length`.

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 5: Guardar un número desde un input**

Crea un componente `AgeInput.jsx` con:

- Estado `age` inicial `0`.
- Un input de tipo `number` controlado.
- Un `p` que muestre: **"Age: {age}"**.

Pista: `event.target.value` llega como string.

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 6: Actualización incorrecta (corrige el bug)**

Este componente intenta incrementar 2 veces, pero no siempre funciona como esperas:

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

Corrígelo para que realmente sume 2.

<details><summary>Mostrar Solución</summary>

Hay que usar la forma funcional:

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

## **Ejercicio 7: Limpiar un input con un botón**

Crea un componente `ClearableInput.jsx` con:

- Estado `text` inicial `""`.
- Input controlado.
- Botón **Clear** que ponga `text` en `""`.

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 8: Alternar entre dos textos**

Crea un componente `LanguageToggle.jsx` con:

- Estado `language` inicial `"EN"`.
- Un botón que alterne entre `"EN"` y `"ES"`.
- Un `p` que muestre: **"Language: EN"** o **"Language: ES"**.

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 9: Evitar estado negativo**

Crea un componente `NonNegativeCounter.jsx` con:

- Estado `count` inicial `0`.
- Botón **-** que reste, pero nunca deje el contador por debajo de `0`.

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 10: Mini-caso de decisión (elige la mejor forma)**

Quieres actualizar un estado `count` basándote en el valor anterior.

¿Cuál es la forma más recomendable?

1.

```js
setCount(count + 1);
```

2.

```js
setCount((prevCount) => prevCount + 1);
```

<details><summary>Mostrar Solución</summary>

La forma más recomendable es la **2**:

```js
setCount((prevCount) => prevCount + 1);
```

Motivo: es más segura cuando el nuevo estado depende del anterior.

</details>

---
