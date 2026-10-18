# **Topic 17: Forms in React**

## **1. Introduction**

Forms are a fundamental part of any web application: login, registration, search, data submission... In React, forms are managed in a slightly different way than traditional HTML, because the state of the form usually lives within the component.

In this topic you will learn:

- What is a controlled form.
- How to manage inputs with `useState`.
- How to work with different types of fields.
- How to handle the `onSubmit` event.
- Good practices when working with forms in React.

---

## **2. Forms in React: key idea**

In React, the usual thing is that:

- The value of the input comes from **state**.
- Each input change updates that state.

This is called **controlled component**.

Mental rule:

> The state is the source of truth.

---

## **3. Basic controlled input**

Example of a controlled text input:

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

Important keys:

- `value` connects the input to the state.
- `onChange` updates status.
- Without `onChange`, the input would be read-only.

---

## **4. Handle form submission (`onSubmit`)**

In React, the `onClick` event of the button to submit forms is not usually used, but `onSubmit` of the `<form>`.

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

Important:

- `event.preventDefault()` prevents the browser from reloading the page.

---

## **5. Forms with multiple fields**

When there are several inputs, it is normal to have one state per field:

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

## **6. Controlled checkbox**

Checkboxes are controlled with the `checked` property:

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

## **7. Select controlled**

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

## **8. Clear the form after submit**

After submitting a form, it is common to reset the fields:

```js
const handleSubmit = (event) => {
  event.preventDefault();

  console.log(name, email);

  setName("");
  setEmail("");
};
```

---

## **9. Typical errors**

### **9.1. Forget `preventDefault`**

Causes page reload.

### **9.2. Not controlling the input**

```js
<input />
```

It is not a controlled input.

### **9.3. Use `onClick` instead of `onSubmit`**

Makes the form less accessible.

---

## **10. Good practices**

- Always use controlled forms.
- Centralize the logic in `onSubmit`.
- Keep the components simple.
- Validate before sending (you will see it later).

---

[![Forms](https://img.youtube.com/vi/8OQHGp6peSY/0.jpg)](https://www.youtube.com/watch?v=8OQHGp6peSY&list=PLzA2VyZwsq_-dE3Jvunglxq8a6UcH6gnF)

---

In the next topic you will learn how to work with **React Router** to create applications with multiple pages.
