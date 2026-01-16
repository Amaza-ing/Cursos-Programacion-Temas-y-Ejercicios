# **Ejercicios - Tema 18: React Router**

A continuación, encontrarás **10 ejercicios prácticos** para aprender a trabajar con **React Router v6**, definiendo rutas, páginas y navegación.

Intenta resolverlos antes de consultar la solución.

---

## **Ejercicio 1: Instalar y configurar React Router**

Instala React Router en tu proyecto y configura `BrowserRouter` envolviendo la app en `main.jsx` o `index.jsx`.

<details><summary>Mostrar Solución</summary>

```bash
npm install react-router-dom
```

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

</details>

---

## **Ejercicio 2: Crear dos páginas**

Crea una carpeta `pages` con dos componentes:

- `Home.jsx` → muestra `Home page`
- `About.jsx` → muestra `About page`

<details><summary>Mostrar Solución</summary>

```js
function Home() {
  return <h2>Home page</h2>;
}

export default Home;
```

```js
function About() {
  return <h2>About page</h2>;
}

export default About;
```

</details>

---

## **Ejercicio 3: Definir rutas básicas**

Configura las rutas en `App.jsx`:

- `/` → `Home`
- `/about` → `About`

<details><summary>Mostrar Solución</summary>

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

</details>

---

## **Ejercicio 4: Navegar con `Link`**

Crea un componente `Nav.jsx` que:

- Tenga dos enlaces: **Home** y **About**.
- Use `Link` (no `<a>`).

<details><summary>Mostrar Solución</summary>

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

</details>

---

## **Ejercicio 5: Mostrar la navegación en todas las páginas**

Incluye `Nav` en `App.jsx` para que se muestre siempre, independientemente de la ruta.

<details><summary>Mostrar Solución</summary>

```js
function App() {
  return (
    <>
      <Nav />
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/about" element={<About />} />
      </Routes>
    </>
  );
}
```

</details>

---

## **Ejercicio 6: Ruta 404**

Crea un componente `NotFound.jsx` y configúralo para que se muestre cuando la ruta no exista.

<details><summary>Mostrar Solución</summary>

```js
function NotFound() {
  return <h2>Page not found</h2>;
}

export default NotFound;
```

```js
<Route path="*" element={<NotFound />} />
```

</details>

---

## **Ejercicio 7: Navegación programática con `useNavigate`**

Crea un componente `Login.jsx` con un botón **Login** que, al hacer click, redirija a `/`.

<details><summary>Mostrar Solución</summary>

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

</details>

---

## **Ejercicio 8: Añadir una nueva ruta**

Añade una página `Profile.jsx` y crea la ruta `/profile`.

<details><summary>Mostrar Solución</summary>

```js
function Profile() {
  return <h2>Profile</h2>;
}

export default Profile;
```

```js
<Route path="/profile" element={<Profile />} />
```

</details>

---

## **Ejercicio 9: Redirigir tras una acción**

Modifica el componente `Login.jsx` para que, tras hacer login, redirija a `/profile`.

<details><summary>Mostrar Solución</summary>

```js
const handleLogin = () => {
  navigate("/profile");
};
```

</details>

---

## **Ejercicio 10: Mini‑estructura de una app con rutas**

Describe la estructura de carpetas de una app con React Router que tenga:

- `Home`
- `Login`
- `Profile`
- `NotFound`

<details><summary>Mostrar Solución</summary>

```
src/
 ├─ pages/
 │   ├─ Home.jsx
 │   ├─ Login.jsx
 │   ├─ Profile.jsx
 │   └─ NotFound.jsx
 ├─ components/
 │   └─ Nav.jsx
 ├─ App.jsx
 └─ main.jsx
```

</details>
