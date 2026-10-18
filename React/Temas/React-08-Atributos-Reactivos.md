# **Topic 8: Reactive Attributes**

## **1. Introduction**

In React, a big part of interaction is **connecting state to interface**.

This not only means displaying text on the screen, but also controlling **HTML attributes** such as:

- `disabled`
- `checked`
- `value`
- `placeholder`
- `src`
- `title`

When an attribute depends on state (or variables), we say that it is a **reactive attribute**: it changes automatically when the state changes.

In this topic you will learn:

- How to link state with attributes.
- How to use boolean attributes (like `disabled` either `checked`).
- How to control `value` in inputs.
- Typical cases and good practices.

---

## **2. Reminder: JSX uses braces `{}` for expressions**

In React, to assign a dynamic value to an attribute, curly braces are used:

```js
<img src={imageUrl} />
```

This goes for:

- Variables
- Expressions
- Conditions
- Status

---

## **3. Attribute `disabled` (buttons disabled)**

`disabled` is a boolean attribute. In React you can activate or deactivate it with an expression.

### **Example: disable a button if the input is empty**

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

Here:

- `disabled={isDisabled}` changes automatically.
- If the user types, the button is activated.

---

## **4. Attribute `checked` (checkbox controlled)**

A checkbox is controlled with `checked`.

### **Example: controlled checkbox**

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

Here:

- `checked={accepted}` It depends on the state.
- `event.target.checked` returns `true/false`.

---

## **5. Attribute `value` (controlled inputs)**

A controlled input is the most frequent case of a reactive attribute:

- `value` It depends on the state.
- `onChange` updates the status.

Example:

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

## **6. Dynamic attributes: `placeholder`, `title` and `src`**

Any attribute can be dynamic.

### **6.1. `placeholder` dynamic**

```js
function SearchInput() {
  const isAdmin = true;
  const placeholderText = isAdmin ? "Search users" : "Search";

  return <input placeholder={placeholderText} />;
}

export default SearchInput;
```

### **6.2. `title` dynamic**

```js
function HelpIcon() {
  const tooltip = "Click for help";

  return <span title={tooltip}>?</span>;
}

export default HelpIcon;
```

### **6.3. `src` dynamic**

```js
function Avatar() {
  const avatarUrl = "https://example.com/avatar.png";

  return <img src={avatarUrl} alt="Avatar" />;
}

export default Avatar;
```

---

## **7. Reactive classes with `className`**

Although we already saw the issue of styles, `className` It is also an attribute and can be reactive.

Example:

```js
function Status() {
  const isOnline = false;

  return <p className={isOnline ? "online" : "offline"}>Status</p>;
}

export default Status;
```

---

## **8. Good practices**

- For boolean attributes, always pass a boolean (`true/false`).
- For inputs, avoid mixing controlled and uncontrolled.
- Calculates derived values ​​(such as `isDisabled`) in variables to improve readability.
- Remember:

  - `event.target.value` for text
  - `event.target.checked` for checkbox

---

## **9. To take into account**

- A reactive attribute is an attribute whose value depends on the state or variables.
- React automatically updates the UI when the state changes.
- `disabled`, `checked` and `value` They are the most common.

---

[![Reactive Attributes](https://img.youtube.com/vi/xF3J25ka1yk/0.jpg)](https://www.youtube.com/watch?v=xF3J25ka1yk&list=PLzA2VyZwsq_-dE3Jvunglxq8a6UcH6gnF)

---

In the next topic we will see **conditional rendering**, to show or hide elements in the UI depending on the state.
