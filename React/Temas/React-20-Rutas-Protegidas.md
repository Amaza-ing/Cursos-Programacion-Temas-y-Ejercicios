# **Tema 20: Rutas Protegidas**

## **1. Introducción**

En muchas aplicaciones no todas las páginas deben ser accesibles para cualquier usuario. Por ejemplo:

- Un perfil solo para usuarios logueados.
- Un panel de administración.
- Páginas que requieren autenticación.

En React Router, este comportamiento se implementa mediante **rutas protegidas**: rutas que solo se renderizan si se cumple una condición (normalmente, estar autenticado).

En este tema aprenderás:

- Qué son las rutas protegidas.
- Cómo crear un componente protector.
- Cómo redirigir a otra ruta si no se cumple la condición.
- Un patrón simple y reutilizable.

---

## **2. Idea clave de las rutas protegidas**

Una ruta protegida:

- **Comprueba una condición** (por ejemplo, `isAuthenticated`).
- Si se cumple → muestra la página.
- Si no se cumple → redirige a otra ruta (login, home, etc.).

La protección **no va en la ruta**, sino en un **componente intermedio**.

---

## **3. Simular autenticación (estado)**

Para entender el concepto, usaremos una simulación simple de autenticación con estado.

```js
import { useState } from "react";

function App() {
  const [isAuthenticated, setIsAuthenticated] = useState(false);

  return <div>App</div>;
}
```

En una app real, este valor podría venir de:

- Context
- localStorage
- Un token
- Una API

---

## **4. Crear un componente `ProtectedRoute`**

Este componente decide qué mostrar.

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

Claves:

- `isAllowed`: condición de acceso.
- `children`: el componente protegido.
- `Navigate`: redirige automáticamente.

---

## **5. Usar `ProtectedRoute` en las rutas**

Ahora protegemos una ruta concreta.

```js
import { Routes, Route } from "react-router-dom";
import ProtectedRoute from "./components/ProtectedRoute";
import Profile from "./pages/Profile";
import Login from "./pages/Login";

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

---

## **6. Página de Login (ejemplo)**

Ejemplo muy simple de login:

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

---

## **7. Flujo completo de ejemplo**

1. Usuario entra a `/profile`.
2. `ProtectedRoute` comprueba `isAuthenticated`.
3. Si es `false` → redirige a `/login`.
4. El usuario hace login.
5. Se actualiza el estado.
6. Navega a `/profile`.

---

## **8. Proteger varias rutas**

Puedes reutilizar `ProtectedRoute` para tantas rutas como quieras:

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

---

## **9. Errores típicos**

### **9.1. Intentar proteger dentro del componente**

No es buena práctica hacer la redirección directamente en la página.

### **9.2. Olvidar `children`**

`ProtectedRoute` debe renderizar `{children}`.

### **9.3. Redirigir con `useNavigate` en lugar de `Navigate`**

Para rutas protegidas, `Navigate` es la opción correcta.

---

## **10. Buenas prácticas**

- Usa un componente `ProtectedRoute` reutilizable.
- Mantén la lógica de permisos fuera de las páginas.
- Usa nombres claros: `isAuthenticated`, `isAdmin`, etc.
- Más adelante puedes combinarlo con **Context**.

---

En el siguiente tema aprenderás a trabajar con **gestión de estado**.
