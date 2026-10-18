# **Exercises - Topic 8: Reactive Attributes**

Below you will find **10 practical exercises** on reactive attributes (connecting state/variables with HTML attributes).

Try to solve them before looking at the solution.

---

## **Exercise 1: `disabled` button based on minimum length**

Create a `UsernameGate.jsx` component with:

- A `userName` state with initial value `""`.
- A controlled input.
- A **Continue** button that is disabled if `userName` has fewer than 3 characters.

<details><summary>Show solution</summary>

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

## **Exercise 2: Checkbox that enables/disables a button**

Create a `ConfirmAction.jsx` component with:

- A boolean `confirmed` state with initial value `false`.
- A controlled checkbox.
- A **Delete** button that is disabled if `confirmed` is `false`.

<details><summary>Show solution</summary>

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

## **Exercise 3: Reactive `placeholder` based on state**

Create a `RoleSearch.jsx` component with:

- A `role` state with initial value `"user"`.
- A **Switch Role** button that toggles between `"user"` and `"admin"`.
- An input whose `placeholder` is:

  - **"Search"** if `role` is `"user"`
  - **"Search users"** if `role` is `"admin"`

<details><summary>Show solution</summary>

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

## **Exercise 4: Reactive `title` on an icon**

Create an `InfoIcon.jsx` component that:

- Has a `helpText` state with initial value `"Click for details"`.
- Renders a `span` with the text **"i"**.
- Assigns `title={helpText}`.
- Has a **Change tooltip** button that changes `helpText` to `"More info available"`.

<details><summary>Show solution</summary>

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

## **Exercise 5: Reactive `src` with a simple selector**

Create a `ProductImage.jsx` component with:

- A `size` state with initial value `"small"`.
- A button that toggles between `"small"` and `"large"`.
- An `img` whose `src` is:

  - `"/product-small.png"` if `size` is `"small"`
  - `"/product-large.png"` if `size` is `"large"`

The images don't need to exist; just write the code.

<details><summary>Show solution</summary>

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

## **Exercise 6: Reactive `value` with uppercase text (without modifying the input)**

Create an `UpperPreview.jsx` component with:

- A `text` state with initial value `""`.
- A controlled input (`value={text}` + `onChange`).
- A `p` showing an uppercase preview with `text.toUpperCase()`.

<details><summary>Show solution</summary>

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

## **Exercise 7: `checked` and `disabled` combined**

Create an `EmailOptIn.jsx` component with:

- An `optIn` state with initial value `false`.
- A controlled checkbox.
- An email input that is **disabled** if `optIn` is `false`.

<details><summary>Show solution</summary>

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

## **Exercise 8: Reactive `className` based on state**
Create an `OnlineDot.jsx` component with:

- An `isOnline` state with initial value `false`.
- A **Toggle** button.
- A `span` with the text **"●"** and a dynamic `className`:

  - `"dotOnline"` if `isOnline` is `true`
  - `"dotOffline"` if `isOnline` is `false`

<details><summary>Show solution</summary>

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

## **Exercise 9: Fix the typical checkbox mistake**

This component tries to read the checkbox, but it's wrong. Fix it:

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

<details><summary>Show solution</summary>

With a checkbox you use `event.target.checked` (a boolean), not `value`:

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

## **Exercise 10: Mini practical case (derived value for readability)**

You have this button:

```js
<button disabled={text.trim() === "" || text.length < 5}>Send</button>
```

Rewrite it by creating an `isDisabled` variable before the `return` to improve readability.

<details><summary>Show solution</summary>

```js
const isDisabled = text.trim() === "" || text.length < 5;

return <button disabled={isDisabled}>Send</button>;
```

</details>
