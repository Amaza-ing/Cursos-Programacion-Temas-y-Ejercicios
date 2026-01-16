# **Ejercicios - Tema 20: Rutas Protegidas**

A continuación, encontrarás **10 ejercicios prácticos** para aprender a crear rutas protegidas con React Router usando un componente `ProtectedRoute` y redirecciones con `Navigate`.

Intenta resolverlos antes de consultar la solución.

---

## **Ejercicio 1: Crear el componente `ProtectedRoute`**

Crea `ProtectedRoute.jsx` que:

- Reciba `isAllowed` y `children`.
- Si `isAllowed` es `false`, redirija a `/login` usando `Navigate`.
- Si es `true`, renderice `children`.

<details><summary>Mostrar Solución</summary>

```js
import { Navigate } from "react-router-dom";

function ProtectedRoute({ isAllowed, children }) {
  if (!isAllowed) {
    return <Navigate to="/login" />;
  }

  return children;
}

export default ProtectedRoute;
```

</details>

---

## **Ejercicio 2: Proteger una ruta `/profile`**

En `App.jsx`, crea estas rutas:

- `/login` → `Login`
- `/profile` → `Profile` (protegida)

Usa `ProtectedRoute`.

<details><summary>Mostrar Solución</summary>

```js
import { Routes, Route } from "react-router-dom";
import ProtectedRoute from "./components/ProtectedRoute";
import Login from "./pages/Login";
import Profile from "./pages/Profile";

function App() {
  const isAuthenticated = false;

  return (
    <Routes>
      <Route path="/login" element={<Login />} />

      <Route
        path="/profile"
        element={
          <ProtectedRoute isAllowed={isAuthenticated}>
            <Profile />
          </ProtectedRoute>
        }
      />
    </Routes>
  );
}

export default App;
```

</details>

---

## **Ejercicio 3: Simular autenticación con estado**

En `App.jsx`:

- Usa `useState` para crear `isAuthenticated`.
- Valor inicial: `false`.

<details><summary>Mostrar Solución</summary>

```js
import { useState } from "react";

const [isAuthenticated, setIsAuthenticated] = useState(false);
```

</details>

---

## **Ejercicio 4: Hacer login desde la página `Login`**

Crea `Login.jsx` que:

- Reciba una prop `onLogin`.
- Al hacer click en un botón, ejecute `onLogin()`.

<details><summary>Mostrar Solución</summary>

```js
function Login({ onLogin }) {
  return <button onClick={onLogin}>Login</button>;
}

export default Login;
```

</details>

---

## **Ejercicio 5: Redirigir a `/profile` tras login**

Modifica `Login.jsx`:

- Usa `useNavigate`.
- Al hacer login:

  - Llama a `onLogin()`.
  - Navega a `/profile`.

<details><summary>Mostrar Solución</summary>

```js
import { useNavigate } from "react-router-dom";

function Login({ onLogin }) {
  const navigate = useNavigate();

  const handleLogin = () => {
    onLogin();
    navigate("/profile");
  };

  return <button onClick={handleLogin}>Login</button>;
}

export default Login;
```

</details>

---

## **Ejercicio 6: Pasar `onLogin` desde `App`**

En `App.jsx`:

- Crea una función `handleLogin` que ponga `isAuthenticated` en `true`.
- Pásala como prop a `Login`.

<details><summary>Mostrar Solución</summary>

```js
const handleLogin = () => {
  setIsAuthenticated(true);
};

<Route path="/login" element={<Login onLogin={handleLogin} />} />;
```

</details>

---

## **Ejercicio 7: Proteger otra ruta `/admin`**

Crea una página `Admin.jsx` y protégela usando `ProtectedRoute`.

<details><summary>Mostrar Solución</summary>

```js
<Route
  path="/admin"
  element={
    <ProtectedRoute isAllowed={isAuthenticated}>
      <Admin />
    </ProtectedRoute>
  }
/>
```

</details>

---

## **Ejercicio 8: Proteger con otro permiso (`isAdmin`)**

En `App.jsx`:

- Crea una variable `isAdmin`.
- Protege `/admin` usando `isAdmin` en lugar de `isAuthenticated`.

<details><summary>Mostrar Solución</summary>

```js
const isAdmin = false;

<Route
  path="/admin"
  element={
    <ProtectedRoute isAllowed={isAdmin}>
      <Admin />
    </ProtectedRoute>
  }
/>;
```

</details>

---

## **Ejercicio 9: Botón Logout**

En `Profile.jsx`:

- Recibe una prop `onLogout`.
- Al hacer click, ejecuta `onLogout()`.

<details><summary>Mostrar Solución</summary>

```js
function Profile({ onLogout }) {
  return (
    <div>
      <h2>Profile</h2>
      <button onClick={onLogout}>Logout</button>
    </div>
  );
}

export default Profile;
```

</details>

---

## **Ejercicio 10: Logout + redirección a `/login`**

Amplía el ejercicio 9:

- Usa `useNavigate` en `Profile.jsx`.
- Cuando el usuario haga logout:

  - Ejecuta `onLogout()`.
  - Redirige a `/login`.

<details><summary>Mostrar Solución</summary>

```js
import { useNavigate } from "react-router-dom";

function Profile({ onLogout }) {
  const navigate = useNavigate();

  const handleLogout = () => {
    onLogout();
    navigate("/login");
  };

  return (
    <div>
      <h2>Profile</h2>
      <button onClick={handleLogout}>Logout</button>
    </div>
  );
}

export default Profile;
```

</details>
