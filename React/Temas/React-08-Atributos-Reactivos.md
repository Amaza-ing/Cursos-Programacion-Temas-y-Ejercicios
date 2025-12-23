# **Tema 8: Atributos Reactivos**

## **1. Introducción**

En React, una gran parte de la interacción consiste en **conectar el estado con la interfaz**.

Esto no solo significa mostrar texto en pantalla, sino también controlar **atributos HTML** como:

- `disabled`
- `checked`
- `value`
- `placeholder`
- `src`
- `title`

Cuando un atributo depende del estado (o de variables), decimos que es un **atributo reactivo**: cambia automáticamente cuando cambia el estado.

En este tema aprenderás:

- Cómo enlazar estado con atributos.
- Cómo usar atributos booleanos (como `disabled` o `checked`).
- Cómo controlar `value` en inputs.
- Casos típicos y buenas prácticas.

---

## **2. Recordatorio: JSX usa llaves `{}` para expresiones**

En React, para asignar un valor dinámico a un atributo, se usan llaves:

```js
<img src={imageUrl} />
```

Esto vale para:

- Variables
- Expresiones
- Condiciones
- Estado

---

## **3. Atributo `disabled` (botones desactivados)**

`disabled` es un atributo booleano. En React puedes activarlo o desactivarlo con una expresión.

### **Ejemplo: desactivar un botón si el input está vacío**

```js
import { useState } from "react";

function SaveButton() {
  const [title, setTitle] = useState("");

  const handleChange = (event) => {
    setTitle(event.target.value);
  };

  const isDisabled = title.trim() === "";

  return (
    <div>
      <input value={title} onChange={handleChange} placeholder="Title" />
      <button disabled={isDisabled}>Save</button>
    </div>
  );
}

export default SaveButton;
```

Aquí:

- `disabled={isDisabled}` cambia automáticamente.
- Si el usuario escribe, el botón se activa.

---

## **4. Atributo `checked` (checkbox controlado)**

Un checkbox se controla con `checked`.

### **Ejemplo: checkbox controlado**

```js
import { useState } from "react";

function TermsCheckbox() {
  const [accepted, setAccepted] = useState(false);

  const handleChange = (event) => {
    setAccepted(event.target.checked);
  };

  return (
    <label>
      <input type="checkbox" checked={accepted} onChange={handleChange} />
      Accept terms
    </label>
  );
}

export default TermsCheckbox;
```

Aquí:

- `checked={accepted}` depende del estado.
- `event.target.checked` devuelve `true/false`.

---

## **5. Atributo `value` (inputs controlados)**

Un input controlado es el caso más frecuente de atributo reactivo:

- `value` depende del estado.
- `onChange` actualiza el estado.

Ejemplo:

```js
import { useState } from "react";

function EmailInput() {
  const [email, setEmail] = useState("");

  const handleChange = (event) => {
    setEmail(event.target.value);
  };

  return <input value={email} onChange={handleChange} placeholder="Email" />;
}

export default EmailInput;
```

---

## **6. Atributos dinámicos: `placeholder`, `title` y `src`**

Cualquier atributo puede ser dinámico.

### **6.1. `placeholder` dinámico**

```js
function SearchInput() {
  const isAdmin = true;
  const placeholderText = isAdmin ? "Search users" : "Search";

  return <input placeholder={placeholderText} />;
}

export default SearchInput;
```

### **6.2. `title` dinámico**

```js
function HelpIcon() {
  const tooltip = "Click for help";

  return <span title={tooltip}>?</span>;
}

export default HelpIcon;
```

### **6.3. `src` dinámico**

```js
function Avatar() {
  const avatarUrl = "https://example.com/avatar.png";

  return <img src={avatarUrl} alt="Avatar" />;
}

export default Avatar;
```

---

## **7. Clases reactivas con `className`**

Aunque el tema de estilos ya lo vimos, `className` también es un atributo y puede ser reactivo.

Ejemplo:

```js
function Status() {
  const isOnline = false;

  return <p className={isOnline ? "online" : "offline"}>Status</p>;
}

export default Status;
```

---

## **8. Buenas prácticas**

- Para atributos booleanos, pasa siempre un booleano (`true/false`).
- Para inputs, evita mezclar controlado y no controlado.
- Calcula valores derivados (como `isDisabled`) en variables para mejorar legibilidad.
- Recuerda:

  - `event.target.value` para texto
  - `event.target.checked` para checkbox

---

## **9. A tener en cuenta**

- Un atributo reactivo es un atributo cuyo valor depende del estado o variables.
- React actualiza automáticamente la UI cuando cambia el estado.
- `disabled`, `checked` y `value` son los más comunes.

---

En el próximo tema veremos **renderizado condicional**, para mostrar u ocultar elementos en la UI dependiendo del estado.
