# **Exercises - Topic 22: Context in React**

Below you will find **10 practical exercises** to learn how to create, provide and consume Context using `createContext`, `useContext` and custom Providers.

Try to solve them before consulting the solution.

---

## **Exercise 1: Create a Context**

Create an `ThemeContext.js` file that:

- Use `createContext`.
- Export the context.

<details><summary>Show Solution</summary>

```js
import { createContext } from "react";

const ThemeContext = createContext();

export default ThemeContext;
```

</details>

---

## **Exercise 2: Provide a value with Provider**

In `App.jsx`:

- Create state `theme` with initial value `"light"`.
- Wrap the app with `ThemeContext.Provider`.
- Passes `{ theme }` as `value`.

<details><summary>Show Solution</summary>

```js
import { useState } from "react";
import ThemeContext from "./context/ThemeContext";

function App() {
  const [theme, setTheme] = useState("light");

  return (
    <ThemeContext.Provider value={{ theme }}>
      <Layout />
    </ThemeContext.Provider>
  );
}

export default App;
```

</details>

---

## **Exercise 3: Consume Context with `useContext`**

Create an `Header.jsx` component that:

- Use `useContext`.
- Read `theme` from `ThemeContext`.
- Show `Theme: light/dark`.

<details><summary>Show Solution</summary>

```js
import { useContext } from "react";
import ThemeContext from "../context/ThemeContext";

function Header() {
  const { theme } = useContext(ThemeContext);

  return <p>Theme: {theme}</p>;
}

export default Header;
```

</details>

---

## **Exercise 4: Context with state and function**

Expand the context to include:

- `theme`
- `setTheme`

<details><summary>Show Solution</summary>

```js
<ThemeContext.Provider value={{ theme, setTheme }}>
  {children}
</ThemeContext.Provider>
```

</details>

---

## **Exercise 5: Change the Context value**

In `Header.jsx`:

- Add a **Toggle theme** button.
- Switch between `"light"` and `"dark"`.

<details><summary>Show Solution</summary>

```js
<button onClick={() => setTheme(theme === "light" ? "dark" : "light")}>
  Toggle theme
</button>
```

</details>

---

## **Exercise 6: Create a custom Provider**

Create `ThemeProvider.jsx` that:

- Have the status `theme`.
- Provide `{ theme, setTheme }`.
- Render `{children}`.

<details><summary>Show Solution</summary>

```js
import { createContext, useState } from "react";

export const ThemeContext = createContext();

function ThemeProvider({ children }) {
  const [theme, setTheme] = useState("light");

  return (
    <ThemeContext.Provider value={{ theme, setTheme }}>
      {children}
    </ThemeContext.Provider>
  );
}

export default ThemeProvider;
```

</details>

---

## **Exercise 7: Using the Custom Provider**

Wrap the app with `ThemeProvider`.

<details><summary>Show Solution</summary>

```js
<ThemeProvider>
  <App />
</ThemeProvider>
```

</details>

---

## **Exercise 8: Typical error — forgetting the Provider**

What happens if you use `useContext(ThemeContext)` unwrapped with the Provider?

<details><summary>Show Solution</summary>

The context value will be `undefined` and may cause runtime errors.

</details>

---

## **Exercise 9: Context vs local state**

Explain when you should **NOT** use Context.

<details><summary>Show Solution</summary>

When the state only needs one component or a very small number of them.

</details>

---

## **Exercise 10: Context for authentication**

Describes what values a basic `AuthContext` would have.

<details><summary>Show Solution</summary>

```js
{
  user, login, logout;
}
```

</details>
