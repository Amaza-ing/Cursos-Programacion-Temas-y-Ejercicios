# **Tema 18: React Router**

## **1. Introducción**

Hasta ahora todas las apps que has creado tenían una sola pantalla. En aplicaciones reales necesitas **navegar entre páginas**: home, login, perfil, detalle, etc.

En React, esta navegación se gestiona con **React Router**, una librería que permite crear aplicaciones de una sola página (SPA) con múltiples rutas.

En este tema aprenderás:

- Qué es React Router y para qué sirve.
- Cómo instalarlo.
- Cómo definir rutas.
- Cómo crear páginas.
- Cómo navegar entre rutas.
- Conceptos clave como `BrowserRouter`, `Routes` y `Route`.

---

## **2. ¿Qué es React Router?**

React Router es una librería que permite:

- Asociar una **URL** a un **componente**.
- Cambiar de página sin recargar el navegador.
- Mantener una experiencia fluida de SPA.

Ejemplo mental:

- `/` → Home
- `/login` → Login
- `/profile` → Profile

Cada ruta renderiza un componente distinto.

---

## **3. Instalación**

En un proyecto React:

```bash
npm install react-router-dom
```

---

## **4. Configuración básica**

Lo primero es envolver la aplicación con `BrowserRouter`.

Normalmente se hace en `main.jsx` o `index.jsx`.

```js
import React from "react";
import ReactDOM from "react-dom/client";
import { BrowserRouter } from "react-router-dom";
import App from "./App";

ReactDOM.createRoot(document.getElementById("root")).render(
  <BrowserRouter>
    <App />
  </BrowserRouter>
);
```

---

## **5. Definir rutas con `Routes` y `Route`**

Las rutas se definen normalmente en `App.jsx`.

```js
import { Routes, Route } from "react-router-dom";
import Home from "./pages/Home";
import About from "./pages/About";

function App() {
  return (
    <Routes>
      <Route path="/" element={<Home />} />
      <Route path="/about" element={<About />} />
    </Routes>
  );
}

export default App;
```

Claves:

- `Routes` agrupa las rutas.
- Cada `Route` tiene:

  - `path`: la URL.
  - `element`: el componente a renderizar.

---

## **6. Crear páginas (carpeta `pages`)**

Una práctica habitual es crear una carpeta `pages`.

Ejemplo:

```
src/
 ├─ pages/
 │   ├─ Home.jsx
 │   └─ About.jsx
```

**`Home.jsx`**

```js
function Home() {
  return <h2>Home</h2>;
}

export default Home;
```

---

## **7. Navegar entre páginas con `Link`**

Para cambiar de ruta **no se usan `<a>`**, sino el componente `Link`.

```js
import { Link } from "react-router-dom";

function Nav() {
  return (
    <nav>
      <Link to="/">Home</Link>
      <Link to="/about">About</Link>
    </nav>
  );
}

export default Nav;
```

Ventajas de `Link`:

- No recarga la página.
- Mantiene el estado de la app.

---

## **8. Ruta por defecto (404)**

Puedes crear una ruta para páginas inexistentes:

```js
<Route path="*" element={<NotFound />} />
```

**`NotFound.jsx`**

```js
function NotFound() {
  return <h2>Page not found</h2>;
}

export default NotFound;
```

---

## **9. `useNavigate`: navegación por código**

A veces necesitas navegar tras una acción (login, submit…).

```js
import { useNavigate } from "react-router-dom";

function Login() {
  const navigate = useNavigate();

  const handleLogin = () => {
    navigate("/");
  };

  return <button onClick={handleLogin}>Login</button>;
}

export default Login;
```

---

## **10. Errores típicos**

### **10.1. Usar `<a>` en lugar de `Link`**

Provoca recarga de página.

### **10.2. Olvidar `BrowserRouter`**

Las rutas no funcionarán.

### **10.3. Usar `component` en lugar de `element`**

En React Router v6 se usa:

```js
element={<Home />}
```

---

## **11. Buenas prácticas**

- Separa rutas y páginas.
- Usa `Link` para navegación.
- Mantén rutas simples y claras.
- Centraliza la navegación en `App.jsx`.

---

En el siguiente tema aprenderás a trabajar con **rutas paramétricas**.
