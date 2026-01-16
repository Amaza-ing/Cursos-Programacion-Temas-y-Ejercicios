# **Ejercicios - Tema 17: Formularios en React**

A continuación, encontrarás **10 ejercicios prácticos** para aprender a trabajar con **formularios controlados**, `useState`, `onChange` y `onSubmit`.

Intenta resolverlos antes de consultar la solución.

---

## **Ejercicio 1: Input controlado (texto)**

Crea un componente `NameField.jsx` que:

- Tenga estado `name` (inicial `""`).
- Renderice un input controlado.
- Muestre un `p` con: **"Hello, {name}"**.

<details><summary>Mostrar Solución</summary>

```js
import { useState } from "react";

function NameField() {
  const [name, setName] = useState("");

  return (
    <div>
      <input
        value={name}
        onChange={(event) => setName(event.target.value)}
        placeholder="Name"
      />
      <p>Hello, {name}</p>
    </div>
  );
}

export default NameField;
```

</details>

---

## **Ejercicio 2: `onSubmit` + `preventDefault`**

Crea un componente `EmailForm.jsx` que:

- Tenga estado `email`.
- Renderice un `<form>`.
- Al enviar, haga `console.log(email)`.
- No recargue la página.

<details><summary>Mostrar Solución</summary>

```js
import { useState } from "react";

function EmailForm() {
  const [email, setEmail] = useState("");

  const handleSubmit = (event) => {
    event.preventDefault();
    console.log(email);
  };

  return (
    <form onSubmit={handleSubmit}>
      <input
        type="email"
        value={email}
        onChange={(e) => setEmail(e.target.value)}
        placeholder="Email"
      />
      <button type="submit">Send</button>
    </form>
  );
}

export default EmailForm;
```

</details>

---

## **Ejercicio 3: Formulario con dos campos**

Crea un componente `LoginForm.jsx` con:

- Estado `email` y `password`.
- Un formulario con dos inputs controlados.
- Al enviar, muestra en consola un objeto `{ email, password }`.

<details><summary>Mostrar Solución</summary>

```js
import { useState } from "react";

function LoginForm() {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");

  const handleSubmit = (event) => {
    event.preventDefault();
    console.log({ email, password });
  };

  return (
    <form onSubmit={handleSubmit}>
      <input
        type="email"
        value={email}
        onChange={(e) => setEmail(e.target.value)}
        placeholder="Email"
      />
      <input
        type="password"
        value={password}
        onChange={(e) => setPassword(e.target.value)}
        placeholder="Password"
      />
      <button type="submit">Login</button>
    </form>
  );
}

export default LoginForm;
```

</details>

---

## **Ejercicio 4: Limpiar el formulario tras enviar**

A partir del ejercicio 3:

- Después de `console.log`, resetea `email` y `password` a `""`.

<details><summary>Mostrar Solución</summary>

```js
const handleSubmit = (event) => {
  event.preventDefault();
  console.log({ email, password });

  setEmail("");
  setPassword("");
};
```

</details>

---

## **Ejercicio 5: Checkbox controlado**

Crea un componente `TermsForm.jsx` que:

- Tenga estado `accepted` (booleano).
- Renderice un checkbox controlado.
- Muestre un `p` con: **"Accepted: Yes/No"**.

<details><summary>Mostrar Solución</summary>

```js
import { useState } from "react";

function TermsForm() {
  const [accepted, setAccepted] = useState(false);

  return (
    <div>
      <label>
        <input
          type="checkbox"
          checked={accepted}
          onChange={(e) => setAccepted(e.target.checked)}
        />
        Accept terms
      </label>
      <p>Accepted: {accepted ? "Yes" : "No"}</p>
    </div>
  );
}

export default TermsForm;
```

</details>

---

## **Ejercicio 6: Botón deshabilitado según checkbox**

A partir del ejercicio 5:

- Crea un botón **Continue**.
- Debe estar `disabled` si `accepted` es `false`.

<details><summary>Mostrar Solución</summary>

```js
<button disabled={!accepted}>Continue</button>
```

</details>

---

## **Ejercicio 7: Select controlado**

Crea un componente `RolePicker.jsx` que:

- Tenga estado `role` (inicial `"user"`).
- Renderice un `select` controlado con opciones `user` y `admin`.
- Muestre un `p` con: **"Role: ..."**.

<details><summary>Mostrar Solución</summary>

```js
import { useState } from "react";

function RolePicker() {
  const [role, setRole] = useState("user");

  return (
    <div>
      <select value={role} onChange={(e) => setRole(e.target.value)}>
        <option value="user">User</option>
        <option value="admin">Admin</option>
      </select>
      <p>Role: {role}</p>
    </div>
  );
}

export default RolePicker;
```

</details>

---

## **Ejercicio 8: Contador de caracteres en un textarea**

Crea un componente `BioField.jsx` que:

- Tenga estado `bio`.
- Renderice un `textarea` controlado.
- Muestre un `p` con: **"Chars: X"**.

<details><summary>Mostrar Solución</summary>

```js
import { useState } from "react";

function BioField() {
  const [bio, setBio] = useState("");

  return (
    <div>
      <textarea
        value={bio}
        onChange={(e) => setBio(e.target.value)}
        placeholder="Write your bio"
      />
      <p>Chars: {bio.length}</p>
    </div>
  );
}

export default BioField;
```

</details>

---

## **Ejercicio 9: Validación simple en submit**

Crea un componente `UsernameForm.jsx` que:

- Tenga estado `username`.
- En el submit:

  - Si `username.trim()` está vacío, muestra en pantalla: **"Username required"**.
  - Si no está vacío, muestra: **"Saved"**.

Pista: crea un estado `message`.

<details><summary>Mostrar Solución</summary>

```js
import { useState } from "react";

function UsernameForm() {
  const [username, setUsername] = useState("");
  const [message, setMessage] = useState("");

  const handleSubmit = (event) => {
    event.preventDefault();

    if (username.trim() === "") {
      setMessage("Username required");
      return;
    }

    setMessage("Saved");
  };

  return (
    <form onSubmit={handleSubmit}>
      <input
        value={username}
        onChange={(e) => setUsername(e.target.value)}
        placeholder="Username"
      />
      <button type="submit">Save</button>
      {message && <p>{message}</p>}
    </form>
  );
}

export default UsernameForm;
```

</details>

---

## **Ejercicio 10: Un solo estado para varios campos**

Crea un componente `ProfileForm.jsx` que:

- Use un único estado `form` con:

```js
{ fullName: "", email: "" }
```

- Renderice dos inputs controlados (`fullName` y `email`).
- Actualice el estado usando el spread (`...form`).
- En el submit, haz `console.log(form)`.

<details><summary>Mostrar Solución</summary>

```js
import { useState } from "react";

function ProfileForm() {
  const [form, setForm] = useState({ fullName: "", email: "" });

  const handleSubmit = (event) => {
    event.preventDefault();
    console.log(form);
  };

  return (
    <form onSubmit={handleSubmit}>
      <input
        value={form.fullName}
        onChange={(e) =>
          setForm((prevForm) => ({ ...prevForm, fullName: e.target.value }))
        }
        placeholder="Full name"
      />

      <input
        type="email"
        value={form.email}
        onChange={(e) =>
          setForm((prevForm) => ({ ...prevForm, email: e.target.value }))
        }
        placeholder="Email"
      />

      <button type="submit">Save</button>
    </form>
  );
}

export default ProfileForm;
```

</details>
