# **Topic 20: Protected Routes**

## **1. Introduction**

In many applications, not all pages must be accessible to any user. For example:

- A profile only for logged in users.
- An administration panel.
- Pages that require authentication.

In React Router, this behavior is implemented using **protected routes**: routes that are only rendered if a condition is met (typically being authenticated).

In this topic you will learn:

- What are protected routes.
- How to create a protective component.
- How to redirect to another route if the condition is not met.
- A simple and reusable pattern.

---

## **2. Protected Routes Key Idea**

A protected route:

- **Checks a condition** (for example, `isAuthenticated`).
- If met → shows the page.
- If it is not met → redirect to another route (login, home, etc.).

The protection **is not in the route**, but in an **intermediate component**.

---

## **3. Simulate authentication (state)**

To understand the concept, we will use a simple simulation of stateful authentication.

```js
import { useState } from "react";

function App() {
  const [isAuthenticated, setIsAuthenticated] = useState(false);

  return <div>App</div>;
}
```

In a real app, this value could come from:

-Context
- localStorage
- A token
- An API

---

## **4. Create an `ProtectedRoute`** component

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

Keys:

- `isAllowed`: access condition.
- `children`: the protected component.
- `Navigate`: redirect automatically.

---

## **5. Use `ProtectedRoute` on routes**

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

1. User enters `/profile`.
2. `ProtectedRoute` checks `isAuthenticated`.
3. If it is `false` → redirect to `/login`.
4. The user logs in.
5. The status is updated.
6. Navigate to `/profile`.

---

## **8. Protect multiple routes**

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

## **9. Typical errors**

### **9.1. Try to protect within the component**

It is not good practice to do the redirect directly on the page.

### **9.2. Forget `children`**

`ProtectedRoute` should render `{children}`.

### **9.3. Redirect with `useNavigate` instead of `Navigate`**

For protected routes, `Navigate` is the correct option.

---

## **10. Good practices**

- Uses a reusable `ProtectedRoute` component.
- Keep permissions logic off pages.
- Use clear names: `isAuthenticated`, `isAdmin`, etc.
- Later you can combine it with **Context**.

---

[![Protected Routes](https://img.youtube.com/vi/MlG-j-SXDnM/0.jpg)](https://www.youtube.com/watch?v=MlG-j-SXDnM&list=PLzA2VyZwsq_-dE3Jvunglxq8a6UcH6gnF)

---

[![Charge State Management](https://img.youtube.com/vi/SP1CIB_HnGA/0.jpg)](https://www.youtube.com/watch?v=SP1CIB_HnGA&list=PLzA2VyZwsq_-dE3Jvunglxq8a6UcH6gnF)

---

In the next topic you will learn how to work with **state management**.
