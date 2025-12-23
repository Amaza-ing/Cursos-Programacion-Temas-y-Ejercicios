# **Ejercicios - Tema 8: Atributos Reactivos**

A continuación, encontrarás **10 ejercicios prácticos** sobre atributos reactivos (conectar estado/variables con atributos HTML).

Intenta resolverlos antes de consultar la solución.

---

## **Ejercicio 1: Botón `disabled` según longitud mínima**

Crea un componente `UsernameGate.jsx` con:

- Estado `userName` inicial `""`.
- Un input controlado.
- Un botón **Continue** que esté deshabilitado si `userName` tiene menos de 3 caracteres.

<details><summary>Mostrar Solución</summary>

```js
import { useState } from "react";

function UsernameGate() {
  const [userName, setUserName] = useState("");

  const handleChange = (event) => {
    setUserName(event.target.value);
  };

  const isDisabled = userName.trim().length < 3;

  return (
    <div>
      <input value={userName} onChange={handleChange} placeholder="Username" />
      <button disabled={isDisabled}>Continue</button>
    </div>
  );
}

export default UsernameGate;
```

</details>

---

## **Ejercicio 2: Checkbox que activa/desactiva un botón**

Crea un componente `ConfirmAction.jsx` con:

- Estado booleano `confirmed` inicial `false`.
- Un checkbox controlado.
- Un botón **Delete** que esté deshabilitado si `confirmed` es `false`.

<details><summary>Mostrar Solución</summary>

```js
import { useState } from "react";

function ConfirmAction() {
  const [confirmed, setConfirmed] = useState(false);

  const handleChange = (event) => {
    setConfirmed(event.target.checked);
  };

  return (
    <div>
      <label>
        <input type="checkbox" checked={confirmed} onChange={handleChange} />I
        understand the consequences
      </label>
      <button disabled={!confirmed}>Delete</button>
    </div>
  );
}

export default ConfirmAction;
```

</details>

---

## **Ejercicio 3: `placeholder` reactivo según estado**

Crea un componente `RoleSearch.jsx` con:

- Estado `role` inicial `"user"`.
- Un botón **Switch Role** que alterne entre `"user"` y `"admin"`.
- Un input cuyo `placeholder` sea:

  - **"Search"** si `role` es `"user"`
  - **"Search users"** si `role` es `"admin"`

<details><summary>Mostrar Solución</summary>

```js
import { useState } from "react";

function RoleSearch() {
  const [role, setRole] = useState("user");

  const handleSwitch = () => {
    setRole((prevRole) => (prevRole === "user" ? "admin" : "user"));
  };

  const placeholderText = role === "admin" ? "Search users" : "Search";

  return (
    <div>
      <button onClick={handleSwitch}>Switch Role</button>
      <input placeholder={placeholderText} />
    </div>
  );
}

export default RoleSearch;
```

</details>

---

## **Ejercicio 4: `title` reactivo en un icono**

Crea un componente `InfoIcon.jsx` que:

- Tenga estado `helpText` inicial `"Click for details"`.
- Renderice un `span` con texto **"i"**.
- Asigne `title={helpText}`.
- Un botón **Change tooltip** que cambie `helpText` a `"More info available"`.

<details><summary>Mostrar Solución</summary>

```js
import { useState } from "react";

function InfoIcon() {
  const [helpText, setHelpText] = useState("Click for details");

  const handleChange = () => {
    setHelpText("More info available");
  };

  return (
    <div>
      <span title={helpText}>i</span>
      <button onClick={handleChange}>Change tooltip</button>
    </div>
  );
}

export default InfoIcon;
```

</details>

---

## **Ejercicio 5: `src` reactivo con selector simple**

Crea un componente `ProductImage.jsx` con:

- Estado `size` inicial `"small"`.
- Un botón que alterne entre `"small"` y `"large"`.
- Un `img` cuyo `src` sea:

  - `"/product-small.png"` si `size` es `"small"`
  - `"/product-large.png"` si `size` es `"large"`

No hace falta que las imágenes existan, solo construye el código.

<details><summary>Mostrar Solución</summary>

```js
import { useState } from "react";

function ProductImage() {
  const [size, setSize] = useState("small");

  const handleToggle = () => {
    setSize((prevSize) => (prevSize === "small" ? "large" : "small"));
  };

  const imageSrc =
    size === "small" ? "/product-small.png" : "/product-large.png";

  return (
    <div>
      <button onClick={handleToggle}>Toggle size</button>
      <img src={imageSrc} alt="Product" />
    </div>
  );
}

export default ProductImage;
```

</details>

---

## **Ejercicio 6: `value` reactivo con texto en mayúsculas (sin modificar el input)**

Crea un componente `UpperPreview.jsx` con:

- Estado `text` inicial `""`.
- Un input controlado (`value={text}` + `onChange`).
- Un `p` que muestre una vista previa en mayúsculas con `text.toUpperCase()`.

<details><summary>Mostrar Solución</summary>

```js
import { useState } from "react";

function UpperPreview() {
  const [text, setText] = useState("");

  const handleChange = (event) => {
    setText(event.target.value);
  };

  return (
    <div>
      <input value={text} onChange={handleChange} placeholder="Type..." />
      <p>{text.toUpperCase()}</p>
    </div>
  );
}

export default UpperPreview;
```

</details>

---

## **Ejercicio 7: `checked` y `disabled` combinados**

Crea un componente `EmailOptIn.jsx` con:

- Estado `optIn` inicial `false`.
- Checkbox controlado.
- Un input para email que esté **deshabilitado** si `optIn` es `false`.

<details><summary>Mostrar Solución</summary>

```js
import { useState } from "react";

function EmailOptIn() {
  const [optIn, setOptIn] = useState(false);

  const handleChange = (event) => {
    setOptIn(event.target.checked);
  };

  return (
    <div>
      <label>
        <input type="checkbox" checked={optIn} onChange={handleChange} />
        Receive emails
      </label>

      <input disabled={!optIn} placeholder="Email" />
    </div>
  );
}

export default EmailOptIn;
```

</details>

---

## **Ejercicio 8: `className` reactivo según estado**

Crea un componente `OnlineDot.jsx` con:

- Estado `isOnline` inicial `false`.
- Un botón **Toggle**.
- Un `span` con texto **"●"** y `className` dinámico:

  - `"dotOnline"` si `isOnline` es `true`
  - `"dotOffline"` si `isOnline` es `false`

<details><summary>Mostrar Solución</summary>

```js
import { useState } from "react";

function OnlineDot() {
  const [isOnline, setIsOnline] = useState(false);

  const handleToggle = () => {
    setIsOnline((prevIsOnline) => !prevIsOnline);
  };

  const dotClass = isOnline ? "dotOnline" : "dotOffline";

  return (
    <div>
      <button onClick={handleToggle}>Toggle</button>
      <span className={dotClass}>●</span>
    </div>
  );
}

export default OnlineDot;
```

</details>

---

## **Ejercicio 9: Corregir el error típico con checkbox**

Este componente intenta leer el checkbox, pero está mal. Corrígelo:

```js
import { useState } from "react";

function Agreement() {
  const [accepted, setAccepted] = useState(false);

  const handleChange = (event) => {
    setAccepted(event.target.value);
  };

  return (
    <label>
      <input type="checkbox" checked={accepted} onChange={handleChange} />
      Accept
    </label>
  );
}

export default Agreement;
```

<details><summary>Mostrar Solución</summary>

En checkbox se usa `event.target.checked` (booleano), no `value`:

```js
import { useState } from "react";

function Agreement() {
  const [accepted, setAccepted] = useState(false);

  const handleChange = (event) => {
    setAccepted(event.target.checked);
  };

  return (
    <label>
      <input type="checkbox" checked={accepted} onChange={handleChange} />
      Accept
    </label>
  );
}

export default Agreement;
```

</details>

---

## **Ejercicio 10: Mini-caso práctico (valor derivado para legibilidad)**

Tienes este botón:

```js
<button disabled={text.trim() === "" || text.length < 5}>Send</button>
```

Reescríbelo creando una variable `isDisabled` antes del `return` para mejorar legibilidad.

<details><summary>Mostrar Solución</summary>

```js
const isDisabled = text.trim() === "" || text.length < 5;

return <button disabled={isDisabled}>Send</button>;
```

</details>
