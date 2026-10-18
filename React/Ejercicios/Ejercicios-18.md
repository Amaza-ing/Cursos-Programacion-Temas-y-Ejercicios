# **Exercises - Topic 18: React Router**

Below, you will find **10 practical exercises** to learn how to work with **React Router v6**, defining routes, pages and navigation.

Try to solve them before consulting the solution.

---

## **Exercise 1: Install and configure React Router**

Install React Router in your project and configure `BrowserRouter` by wrapping the app in `main.jsx` or `index.jsx`.

<details><summary>Show Solution</summary>

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

## **Exercise 2: Create two pages**

Create an `pages` folder with two components:

- `Home.jsx` → shows `Home page`
- `About.jsx` → shows `About page`

<details><summary>Show Solution</summary>

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

## **Exercise 3: Define basic routes**

Configure the routes in `App.jsx`:

- `/` → `Home`
- `/about` → `About`

<details><summary>Show Solution</summary>

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

## **Exercise 4: Browse with `Link`**

Create an `Nav.jsx` component that:

- Have two links: **Home** and **About**.
- Use `Link` (not `<a>`).

<details><summary>Show Solution</summary>

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

## **Exercise 5: Show navigation on all pages**

Include `Nav` in `App.jsx` so that it is always displayed, regardless of the path.

<details><summary>Show Solution</summary>

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

## **Exercise 6: Route 404**

Create an `NotFound.jsx` component and configure it to display when the route does not exist.

<details><summary>Show Solution</summary>

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

## **Exercise 7: Programmatic navigation with `useNavigate`**

Create an `Login.jsx` component with a **Login** button that, when clicked, redirects to `/`.

<details><summary>Show Solution</summary>

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

## **Exercise 8: Add a new route**

Add an `Profile.jsx` page and create the route `/profile`.

<details><summary>Show Solution</summary>

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

## **Exercise 9: Redirect after an action**

Modify the `Login.jsx` component so that, after login, it redirects to `/profile`.

<details><summary>Show Solution</summary>

```js
const handleLogin = () => {
  navigate("/profile");
};
```

</details>

---

## **Exercise 10: Mini-structure of an app with routes**

Describes the folder structure of a React Router app that has:

- `Home`
- `Login`
- `Profile`
- `NotFound`

<details><summary>Show Solution</summary>

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
