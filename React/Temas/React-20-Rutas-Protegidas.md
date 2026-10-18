# **Topic 20: Protected Routes**

## **1. Introduction**

In many applications, not every page should be accessible to every user. For example:

- A profile only for logged-in users.
- An admin panel.
- Pages that require authentication.

In React Router, this behavior is implemented with **protected routes**: routes that are only rendered if a condition is met (usually, being authenticated).

In this topic you will learn:

- What protected routes are.
- How to create a guard component.
- How to redirect to another route if the condition isn't met.
- A simple, reusable pattern.

---

## **2. The key idea behind protected routes**

A protected route:

- **Checks a condition** (for example, `isAuthenticated`).
- If it's met → it shows the page.
- If it isn't met → it redirects to another route (login, home, etc.).

The protection **doesn't go in the route**, but in an **intermediate component**.

---

## **3. Simulating authentication (state)**

To understand the concept, we'll use a simple simulation of authentication with state.

```js
import { useState } from "react";

function App() {
  const [isAuthenticated, setIsAuthenticated] = useState(false);

  return <div>App</div>;
}
```

In a real app, this value could come from:

- Context
- localStorage
- A token
- An API

---

## **4. Creating a `ProtectedRoute` component**

This component decides what to display.

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

Key points:

- `isAllowed`: the access condition.
- `children`: the protected component.
- `Navigate`: redirects automatically.

---

## **5. Using `ProtectedRoute` in the routes**

Now we protect a specific route.

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

## **6. Login page (example)**

Very simple login example:

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

## **7. Complete example flow**

1. The user goes to `/profile`.
2. `ProtectedRoute` checks `isAuthenticated`.
3. If it's `false` → it redirects to `/login`.
4. The user logs in.
5. The state is updated.
6. The app navigates to `/profile`.

---

## **8. Protecting multiple routes**

You can reuse `ProtectedRoute` for as many routes as you want:

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

## **9. Common mistakes**

### **9.1. Trying to protect from inside the component**

It isn't good practice to do the redirect directly in the page.

### **9.2. Forgetting `children`**

`ProtectedRoute` must render `{children}`.

### **9.3. Redirecting with `useNavigate` instead of `Navigate`**

For protected routes, `Navigate` is the right option.

---

## **10. Best practices**

- Use a reusable `ProtectedRoute` component.
- Keep permission logic out of the pages.
- Use clear names: `isAuthenticated`, `isAdmin`, etc.
- Later you can combine it with **Context**.

---

[![Protected Routes](https://img.youtube.com/vi/MlG-j-SXDnM/0.jpg)](https://www.youtube.com/watch?v=MlG-j-SXDnM&list=PLzA2VyZwsq_-dE3Jvunglxq8a6UcH6gnF)

---

[![Managing Loading States](https://img.youtube.com/vi/SP1CIB_HnGA/0.jpg)](https://www.youtube.com/watch?v=SP1CIB_HnGA&list=PLzA2VyZwsq_-dE3Jvunglxq8a6UcH6gnF)

---

In the next topic you'll learn how to work with **state management**.
