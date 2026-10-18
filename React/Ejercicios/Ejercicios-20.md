# **Exercises - Topic 20: Protected Routes**

Below you will find **10 practical exercises** to learn how to create protected routes with React Router using an `ProtectedRoute` component and redirects with `Navigate`.

Try to solve them before consulting the solution.

---

## **Exercise 1: Create the `ProtectedRoute` component**

Create `ProtectedRoute.jsx` that:

- Receive `isAllowed` and `children`.
- If `isAllowed` is `false`, redirect to `/login` using `Navigate`.
- If it is `true`, render `children`.

<details><summary>Show Solution</summary>

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

## **Exercise 2: Protect an `/profile` route**

In `App.jsx`, create these routes:

- `/login` → `Login`
- `/profile` → `Profile` (protected)

Use `ProtectedRoute`.

<details><summary>Show Solution</summary>

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

## **Exercise 3: Simulate stateful authentication**

In `App.jsx`:

- Use `useState` to create `isAuthenticated`.
- Initial value: `false`.

<details><summary>Show Solution</summary>

```js
import { useState } from "react";

const [isAuthenticated, setIsAuthenticated] = useState(false);
```

</details>

---

## **Exercise 4: Login from the `Login` page**

Create `Login.jsx` that:

- Receive an `onLogin` prop.
- By clicking a button, execute `onLogin()`.

<details><summary>Show Solution</summary>

```js
function Login({ onLogin }) {
  return <button onClick={onLogin}>Login</button>;
}

export default Login;
```

</details>

---

## **Exercise 5: Redirect to `/profile` after login**

Modify `Login.jsx`:

- Use `useNavigate`.
- When logging in:

  - Call `onLogin()`.
  - Navigate to `/profile`.

<details><summary>Show Solution</summary>

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

## **Exercise 6: Pass `onLogin` from `App`**

In `App.jsx`:

- Create a function `handleLogin` that puts `isAuthenticated` in `true`.
- Pass it as a prop to `Login`.

<details><summary>Show Solution</summary>

```js
const handleLogin = () => {
  setIsAuthenticated(true);
};

<Route path="/login" element={<Login onLogin={handleLogin} />} />;
```

</details>

---

## **Exercise 7: Protect another route `/admin`**

Create an `Admin.jsx` page and protect it using `ProtectedRoute`.

<details><summary>Show Solution</summary>

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

## **Exercise 8: Protect with another permission (`isAdmin`)**

In `App.jsx`:

- Create a variable `isAdmin`.
- Protect `/admin` by using `isAdmin` instead of `isAuthenticated`.

<details><summary>Show Solution</summary>

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

## **Exercise 9: Logout Button**

In `Profile.jsx`:

- Receive an `onLogout` prop.
- When clicked, execute `onLogout()`.

<details><summary>Show Solution</summary>

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

## **Exercise 10: Logout + redirection to `/login`**

Expand exercise 9:

- Use `useNavigate` in `Profile.jsx`.
- When the user logs out:

  - Run `onLogout()`.
  - Redirects to `/login`.

<details><summary>Show Solution</summary>

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
