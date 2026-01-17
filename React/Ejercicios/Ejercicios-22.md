# **Ejercicios - Tema 22: Context en React**

A continuación, encontrarás **10 ejercicios prácticos** para aprender a crear, proveer y consumir Context usando `createContext`, `useContext` y Providers personalizados.

Intenta resolverlos antes de consultar la solución.

---

## **Ejercicio 1: Crear un Context**

Crea un archivo `ThemeContext.js` que:

- Use `createContext`.
- Exporte el contexto.

<details><summary>Mostrar Solución</summary>

```js
import { createContext } from "react";

const ThemeContext = createContext();

export default ThemeContext;
```

</details>

---

## **Ejercicio 2: Proveer un valor con Provider**

En `App.jsx`:

- Crea estado `theme` con valor inicial `"light"`.
- Envuelve la app con `ThemeContext.Provider`.
- Pasa `{ theme }` como `value`.

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 3: Consumir Context con `useContext`**

Crea un componente `Header.jsx` que:

- Use `useContext`.
- Lea `theme` del `ThemeContext`.
- Muestre `Theme: light/dark`.

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 4: Context con estado y función**

Amplía el contexto para que incluya:

- `theme`
- `setTheme`

<details><summary>Mostrar Solución</summary>

```js
<ThemeContext.Provider value={{ theme, setTheme }}>
  {children}
</ThemeContext.Provider>
```

</details>

---

## **Ejercicio 5: Cambiar el valor del Context**

En `Header.jsx`:

- Añade un botón **Toggle theme**.
- Cambia entre `"light"` y `"dark"`.

<details><summary>Mostrar Solución</summary>

```js
<button onClick={() => setTheme(theme === "light" ? "dark" : "light")}>
  Toggle theme
</button>
```

</details>

---

## **Ejercicio 6: Crear un Provider personalizado**

Crea `ThemeProvider.jsx` que:

- Tenga el estado `theme`.
- Provea `{ theme, setTheme }`.
- Renderice `{children}`.

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 7: Usar el Provider personalizado**

Envuelve la app con `ThemeProvider`.

<details><summary>Mostrar Solución</summary>

```js
<ThemeProvider>
  <App />
</ThemeProvider>
```

</details>

---

## **Ejercicio 8: Error típico — olvidar el Provider**

¿Qué ocurre si usas `useContext(ThemeContext)` sin envolver con el Provider?

<details><summary>Mostrar Solución</summary>

El valor del contexto será `undefined` y puede provocar errores en tiempo de ejecución.

</details>

---

## **Ejercicio 9: Context vs estado local**

Explica cuándo **NO** deberías usar Context.

<details><summary>Mostrar Solución</summary>

Cuando el estado solo lo necesita un componente o un número muy reducido de ellos.

</details>

---

## **Ejercicio 10: Context para autenticación**

Describe qué valores tendría un `AuthContext` básico.

<details><summary>Mostrar Solución</summary>

```js
{
  user, login, logout;
}
```

</details>
