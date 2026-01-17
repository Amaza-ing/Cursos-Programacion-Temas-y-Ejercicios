# **Tema 22: Context en React**

## **1. Introducción**

A medida que una aplicación crece, aparece un problema habitual: **pasar props a través de muchos componentes intermedios** aunque estos no las necesiten directamente. A este problema se le llama **prop drilling**.

React ofrece una solución nativa para compartir estado y lógica de forma global: **Context**.

En este tema aprenderás:

- Qué es Context y cuándo usarlo.
- Cómo crear un Context.
- Cómo proveer valores con un Provider.
- Cómo consumir Context con `useContext`.
- Buenas prácticas y errores comunes.

---

## **2. ¿Qué problema resuelve Context?**

Ejemplo típico:

- `App` tiene el estado `user`.
- `Header` y `Profile` necesitan `user`.
- Entre medias hay varios componentes que **solo pasan props**.

Esto provoca:

- Código más verboso.
- Componentes menos claros.
- Dificultad para mantener el árbol.

Context permite **compartir datos sin pasar props manualmente**.

---

## **3. Idea clave de Context**

Context se basa en tres piezas:

1. **Crear el contexto** (`createContext`).
2. **Proveer un valor** (`Provider`).
3. **Consumir el valor** (`useContext`).

Regla mental:

> Context es como una “caja global” a la que pueden acceder ciertos componentes.

---

## **4. Crear un Context**

Primero, se crea el contexto.

```js
import { createContext } from "react";

const ThemeContext = createContext();

export default ThemeContext;
```

Normalmente este archivo se guarda en:

```txt
src/context/ThemeContext.js
```

---

## **5. Proveer el Context (`Provider`)**

El `Provider` envuelve a los componentes que necesitan acceso al contexto.

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

Claves:

- `value` es el dato compartido.
- Puede ser un valor simple o un objeto.

---

## **6. Consumir Context con `useContext`**

Para acceder al contexto desde cualquier componente hijo:

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

No necesitas pasar props desde el padre.

---

## **7. Context + estado**

Un patrón muy común es:

- El estado vive en el componente que provee el contexto.
- El contexto expone **estado + funciones**.

```js
value={{ user, login, logout }}
```

Esto se usa mucho para:

- Autenticación.
- Tema (light / dark).
- Idioma.

---

## **8. Crear un Provider personalizado**

Para mantener el código limpio, es habitual crear un Provider propio.

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

Uso:

```js
<AuthProvider>
  <App />
</AuthProvider>
```

---

## **9. Errores típicos**

### **9.1. Usar Context para todo**

Context **no sustituye** a `useState` local.

### **9.2. Olvidar envolver con el Provider**

`useContext` devolverá `undefined`.

### **9.3. Meter lógica compleja sin control**

Context debe ser claro y predecible.

---

## **10. Buenas prácticas**

- Usa Context solo cuando el estado se comparta entre muchos componentes.
- Crea un Context por responsabilidad (auth, theme, settings…).
- Extrae Providers a archivos separados.
- Mantén los valores del contexto simples.

---

[![Context](https://img.youtube.com/vi/qKJndLkZUIQ/0.jpg)](https://www.youtube.com/watch?v=qKJndLkZUIQ&list=PLzA2VyZwsq_-dE3Jvunglxq8a6UcH6gnF)

---

En el siguiente tema aprenderás a combinar **Context con usuarios** para gestionar autenticación global.
