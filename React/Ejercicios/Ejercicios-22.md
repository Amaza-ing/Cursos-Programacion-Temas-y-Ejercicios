# **Exercises - Topic 22: Context in React**

Below you will find **10 practical exercises** to learn how to create, provide and consume Context using `createContext`, `useContext` and custom Providers.

Try to solve them before looking at the solution.

---

## **Exercise 1: Create a Context**

Create a `ThemeContext.js` file that:

- Uses `createContext`.
- Exports the context.

<details><summary>Show solution</summary>

```js
import { createContext } from "react";

const ThemeContext = createContext();

export default ThemeContext;
```

</details>

---

## **Exercise 2: Provide a value with a Provider**

In `App.jsx`:

- Create a `theme` state with initial value `"light"`.
- Wrap the app with `ThemeContext.Provider`.
- Pass `{ theme }` as `value`.

<details><summary>Show solution</summary>

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

Create a `Header.jsx` component that:

- Uses `useContext`.
- Reads `theme` from `ThemeContext`.
- Shows `Theme: light/dark`.

<details><summary>Show solution</summary>

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

## **Exercise 4: Context with state and a function**

Extend the context to include:

- `theme`
- `setTheme`

<details><summary>Show solution</summary>

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
- Make it switch between `"light"` and `"dark"`.

<details><summary>Show solution</summary>

```js
<button onClick={() => setTheme(theme === "light" ? "dark" : "light")}>
  Toggle theme
</button>
```

</details>

---

## **Exercise 6: Create a custom Provider**

Create `ThemeProvider.jsx` that:

- Holds the `theme` state.
- Provides `{ theme, setTheme }`.
- Renders `{children}`.

<details><summary>Show solution</summary>

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

## **Exercise 7: Use the custom Provider**

Wrap the app with `ThemeProvider`.

<details><summary>Show solution</summary>

```js
<ThemeProvider>
  <App />
</ThemeProvider>
```

</details>

---

## **Exercise 8: Typical error — forgetting the Provider**

What happens if you use `useContext(ThemeContext)` without wrapping the component in the Provider?

<details><summary>Show solution</summary>

The context value will be `undefined`, which can cause runtime errors.

</details>

---

## **Exercise 9: Context vs local state**

Explain when you should **NOT** use Context.

<details><summary>Show solution</summary>

When the state is only needed by one component or a very small number of them.

</details>

---

## **Exercise 10: Context for authentication**

Describe what values a basic `AuthContext` would have.

<details><summary>Show solution</summary>

```js
{
  user, login, logout;
}
```

</details>
