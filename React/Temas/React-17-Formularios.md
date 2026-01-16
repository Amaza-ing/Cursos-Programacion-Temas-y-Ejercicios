# **Tema 17: Formularios en React**

## **1. Introducción**

Los formularios son una parte fundamental de cualquier aplicación web: login, registro, búsqueda, envío de datos… En React, los formularios se gestionan de una forma ligeramente distinta al HTML tradicional, porque el estado del formulario suele vivir dentro del componente.

En este tema aprenderás:

- Qué es un formulario controlado.
- Cómo manejar inputs con `useState`.
- Cómo trabajar con distintos tipos de campos.
- Cómo manejar el evento `onSubmit`.
- Buenas prácticas al trabajar con formularios en React.

---

## **2. Formularios en React: idea clave**

En React, lo habitual es que:

- El valor del input venga del **estado**.
- Cada cambio del input actualice ese estado.

A esto se le llama **componente controlado**.

Regla mental:

> El estado es la fuente de la verdad.

---

## **3. Input controlado básico**

Ejemplo de un input de texto controlado:

```js
import { useState } from "react";

function NameForm() {
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

export default NameForm;
```

Claves importantes:

- `value` conecta el input con el estado.
- `onChange` actualiza el estado.
- Sin `onChange`, el input sería de solo lectura.

---

## **4. Manejar el envío del formulario (`onSubmit`)**

En React no se suele usar el evento `onClick` del botón para enviar formularios, sino `onSubmit` del `<form>`.

```js
function LoginForm() {
  const [email, setEmail] = useState("");

  const handleSubmit = (event) => {
    event.preventDefault();
    console.log("Email:", email);
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

export default LoginForm;
```

Importante:

- `event.preventDefault()` evita que el navegador recargue la página.

---

## **5. Formularios con varios campos**

Cuando hay varios inputs, lo normal es tener un estado por campo:

```js
import { useState } from "react";

function RegisterForm() {
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");

  const handleSubmit = (event) => {
    event.preventDefault();
    console.log({ username, password });
  };

  return (
    <form onSubmit={handleSubmit}>
      <input
        value={username}
        onChange={(e) => setUsername(e.target.value)}
        placeholder="Username"
      />
      <input
        type="password"
        value={password}
        onChange={(e) => setPassword(e.target.value)}
        placeholder="Password"
      />
      <button type="submit">Register</button>
    </form>
  );
}

export default RegisterForm;
```

---

## **6. Checkbox controlado**

Los checkbox se controlan con la propiedad `checked`:

```js
import { useState } from "react";

function TermsCheckbox() {
  const [accepted, setAccepted] = useState(false);

  return (
    <label>
      <input
        type="checkbox"
        checked={accepted}
        onChange={(e) => setAccepted(e.target.checked)}
      />
      Accept terms
    </label>
  );
}

export default TermsCheckbox;
```

---

## **7. Select controlado**

```js
import { useState } from "react";

function RoleSelect() {
  const [role, setRole] = useState("user");

  return (
    <select value={role} onChange={(e) => setRole(e.target.value)}>
      <option value="user">User</option>
      <option value="admin">Admin</option>
    </select>
  );
}

export default RoleSelect;
```

---

## **8. Limpiar el formulario tras enviar**

Después de enviar un formulario, es común resetear los campos:

```js
const handleSubmit = (event) => {
  event.preventDefault();

  console.log(name, email);

  setName("");
  setEmail("");
};
```

---

## **9. Errores típicos**

### **9.1. Olvidar `preventDefault`**

Provoca recarga de página.

### **9.2. No controlar el input**

```js
<input />
```

No es un input controlado.

### **9.3. Usar `onClick` en lugar de `onSubmit`**

Hace el formulario menos accesible.

---

## **10. Buenas prácticas**

- Usa siempre formularios controlados.
- Centraliza la lógica en `onSubmit`.
- Mantén los componentes simples.
- Valida antes de enviar (lo verás más adelante).

---

En el siguiente tema aprenderás a trabajar con **React Router** para crear aplicaciones con múltiples páginas.
