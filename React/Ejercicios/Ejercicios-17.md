# **Exercises - Topic 17: Forms in React**

Below you will find **10 practical exercises** to learn how to work with **controlled forms**, `useState`, `onChange` and `onSubmit`.

Try to solve them before looking at the solution.

---

## **Exercise 1: Controlled input (text)**

Create a `NameField.jsx` component that:

- Has a `name` state (initial value `""`).
- Renders a controlled input.
- Shows a `p` with: **"Hello, {name}"**.

<details><summary>Show solution</summary>

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

## **Exercise 2: `onSubmit` + `preventDefault`**

Create an `EmailForm.jsx` component that:

- Has an `email` state.
- Renders a `<form>`.
- On submit, does `console.log(email)`.
- Doesn't reload the page.

<details><summary>Show solution</summary>

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

## **Exercise 3: Form with two fields**

Create a `LoginForm.jsx` component with:

- `email` and `password` state.
- A form with two controlled inputs.
- On submit, it displays an `{ email, password }` object in the console.

<details><summary>Show solution</summary>

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

## **Exercise 4: Clear the form after submitting**

Starting from exercise 3:

- After `console.log`, reset `email` and `password` to `""`.

<details><summary>Show solution</summary>

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

## **Exercise 5: Controlled checkbox**

Create a `TermsForm.jsx` component that:

- Has an `accepted` state (boolean).
- Renders a controlled checkbox.
- Shows a `p` with: **"Accepted: Yes/No"**.

<details><summary>Show solution</summary>

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

## **Exercise 6: Button disabled based on a checkbox**

Starting from exercise 5:

- Create a **Continue** button.
- It must be `disabled` if `accepted` is `false`.

<details><summary>Show solution</summary>

```js
<button disabled={!accepted}>Continue</button>
```

</details>

---

## **Exercise 7: Controlled select**

Create a `RolePicker.jsx` component that:

- Has a `role` state (initial value `"user"`).
- Renders a controlled `select` with the options `user` and `admin`.
- Shows a `p` with: **"Role: ..."**.

<details><summary>Show solution</summary>

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

## **Exercise 8: Character counter in a textarea**

Create a `BioField.jsx` component that:

- Has a `bio` state.
- Renders a controlled `textarea`.
- Shows a `p` with: **"Chars: X"**.

<details><summary>Show solution</summary>

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

## **Exercise 9: Simple validation on submit**

Create a `UsernameForm.jsx` component that:

- Has a `username` state.
- On submit:

  - If `username.trim()` is empty, it displays on screen: **"Username required"**.
  - If it isn't empty, it displays: **"Saved"**.

Hint: create a `message` state.

<details><summary>Show solution</summary>

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
## **Exercise 10: A single state for multiple fields**

Create a `ProfileForm.jsx` component that:

- Uses a single `form` state with:

```js
{ fullName: "", email: "" }
```

- Renders two controlled inputs (`fullName` and `email`).
- Updates the state using the spread operator (`...form`).
- On submit, does `console.log(form)`.

<details><summary>Show solution</summary>

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
