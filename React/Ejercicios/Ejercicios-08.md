# **Exercises - Topic 8: Reactive Attributes**

Below you will find **10 practical exercises** on reactive attributes (connecting state/variables with HTML attributes).

Try to solve them before consulting the solution.

---

## **Exercise 1: `disabled` button according to minimum length**

Create an `UsernameGate.jsx` component with:

- Initial `userName` state `""`.
- A controlled input.
- A **Continue** button that is disabled if `userName` is less than 3 characters.

<details><summary>Show Solution</summary>

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

## **Exercise 2: Checkbox that activates/deactivates a button**

Create an `ConfirmAction.jsx` component with:

- Initial `confirmed` boolean state `false`.
- A controlled checkbox.
- A **Delete** button that is disabled if `confirmed` is `false`.

<details><summary>Show Solution</summary>

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

## **Exercise 3: `placeholder` reactive according to status**

Create an `RoleSearch.jsx` component with:

- Initial `role` state `"user"`.
- A **Switch Role** button that toggles between `"user"` and `"admin"`.
- An input whose `placeholder` is:

  - **"Search"** if `role` is `"user"`
  - **"Search users"** if `role` is `"admin"`

<details><summary>Show Solution</summary>

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

## **Exercise 4: `title` reactive on an icon**

Create an `InfoIcon.jsx` component that:

- Have initial status `helpText` `"Click for details"`.
- Render an `span` with **"i"** text.
- Assign `title={helpText}`.
- A **Change tooltip** button that changes `helpText` to `"More info available"`.

<details><summary>Show Solution</summary>

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

## **Exercise 5: Reactive `src` with simple selector**

Create an `ProductImage.jsx` component with:

- Initial `size` state `"small"`.
- A button that toggles between `"small"` and `"large"`.
- An `img` whose `src` is:

  - `"/product-small.png"` if `size` is `"small"`
  - `"/product-large.png"` if `size` is `"large"`

The images do not need to exist, just build the code.

<details><summary>Show Solution</summary>

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

## **Exercise 6: `value` reactive with uppercase text (without modifying the input)**

Create an `UpperPreview.jsx` component with:

- Initial `text` state `""`.
- A controlled input (`value={text}` + `onChange`).
- An `p` showing a preview in all caps with `text.toUpperCase()`.

<details><summary>Show Solution</summary>

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

- Initial `optIn` state `false`.
- Controlled checkbox.
- An input for email that is **disabled** if `optIn` is `false`.

<details><summary>Show Solution</summary>

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

## **Exercise 8: `className` reactive according to status**
Create an `OnlineDot.jsx` component with:

- Initial `isOnline` state `false`.
- A **Toggle** button.
- An `span` with **"●"** text and dynamic `className`:

  - `"dotOnline"` if `isOnline` is `true`
  - `"dotOffline"` if `isOnline` is `false`

<details><summary>Show Solution</summary>

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

## **Exercise 9: Correct the typical error with checkbox**

This component tries to read the checkbox, but it is wrong. Correct it:

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

<details><summary>Show Solution</summary>

`event.target.checked` (boolean) is used in the checkbox, not `value`:

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

## **Exercise 10: Mini-case study (derived value for readability)**

You have this button:

```js
<button disabled={text.trim() === "" || text.length < 5}>Send</button>
```

Rewrite it by creating an `isDisabled` variable before the `return` to improve readability.

<details><summary>Show Solution</summary>

```js
const isDisabled = text.trim() === "" || text.length < 5;

return <button disabled={isDisabled}>Send</button>;
```

</details>
