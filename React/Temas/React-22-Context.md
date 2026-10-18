# **Topic 22: Context in React**

## **1. Introduction**

As an application grows, a common problem arises: **passing props through many intermediate components** even though they don't need them directly. This problem is called **prop drilling**.

React offers a native solution for sharing state and logic globally: **Context**.

In this topic you will learn:

- What Context is and when to use it.
- How to create a Context.
- How to provide values with a Provider.
- How to consume Context with `useContext`.
- Best practices and common mistakes.

---

## **2. What problem does Context solve?**

Typical example:

- `App` has the `user` state.
- `Header` and `Profile` need `user`.
- In between there are several components that **only pass props**.

This causes:

- More verbose code.
- Components that are less clear.
- A tree that's harder to maintain.

Context lets you **share data without passing props manually**.

---

## **3. The key idea behind Context**

Context is based on three pieces:

1. **Create the context** (`createContext`).
2. **Provide a value** (`Provider`).
3. **Consume the value** (`useContext`).

Rule of thumb:

> Context is like a “global box” that can be accessed by certain components.

---

## **4. Creating a Context**

First, you create the context.

```js
import { createContext } from "react";

const ThemeContext = createContext();

export default ThemeContext;
```

This file is usually saved in:

```txt
src/context/ThemeContext.js
```

---

## **5. Providing the Context (`Provider`)**

The `Provider` wraps the components that need access to the context.

```js
import { useState } from "react";
import ThemeContext from "./context/ThemeContext";

function App() {
  const [theme, setTheme] = useState("light");

  return (
    <ThemeContext.Provider value={{ theme, setTheme }}>
      <Layout />
    </ThemeContext.Provider>
  );
}

export default App;
```

Key points:

- `value` is the shared data.
- It can be a simple value or an object.

---

## **6. Consuming Context with `useContext`**

To access the context from any child component:

```js
import { useContext } from "react";
import ThemeContext from "../context/ThemeContext";

function Header() {
  const { theme, setTheme } = useContext(ThemeContext);

  return (
    <header>
      <p>Theme: {theme}</p>
      <button onClick={() => setTheme("dark")}>Dark</button>
    </header>
  );
}

export default Header;
```

You don't need to pass props from the parent.

---

## **7. Context + state**

A very common pattern is:

- The state lives in the component that provides the context.
- The context exposes **state + functions**.

```js
value={{ user, login, logout }}
```

This is widely used for:

- Authentication.
- Theme (light / dark).
- Language.

---

## **8. Creating a custom Provider**

To keep the code clean, it's common to create your own Provider.

```js
import { createContext, useState } from "react";

const AuthContext = createContext();

function AuthProvider({ children }) {
  const [user, setUser] = useState(null);

  const login = (userData) => setUser(userData);
  const logout = () => setUser(null);

  return (
    <AuthContext.Provider value={{ user, login, logout }}>
      {children}
    </AuthContext.Provider>
  );
}

export { AuthProvider, AuthContext };
```

Usage:

```js
<AuthProvider>
  <App />
</AuthProvider>
```

---

## **9. Common mistakes**

### **9.1. Using Context for everything**

Context **doesn't replace** local `useState`.

### **9.2. Forgetting to wrap with the Provider**

`useContext` will return `undefined`.

### **9.3. Adding complex logic without any control**

Context should be clear and predictable.

---

## **10. Best practices**

- Use Context only when the state is shared between many components.
- Create one Context per responsibility (auth, theme, settings...).
- Extract Providers into separate files.
- Keep context values simple.

---

[![Context](https://img.youtube.com/vi/qKJndLkZUIQ/0.jpg)](https://www.youtube.com/watch?v=qKJndLkZUIQ&list=PLzA2VyZwsq_-dE3Jvunglxq8a6UcH6gnF)

---

In the next topic you'll learn how to combine **Context with users** to manage global authentication.
