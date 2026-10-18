# **Topic 18: React Router**

## **1. Introduction**

So far, all the apps you've created have had a single screen. In real applications you need to **navigate between pages**: home, login, profile, details, etc.

In React, this navigation is handled with **React Router**, a library that lets you create single-page applications (SPAs) with multiple routes.

In this topic you will learn:

- What React Router is and what it's for.
- How to install it.
- How to define routes.
- How to create pages.
- How to navigate between routes.
- Key concepts such as `BrowserRouter`, `Routes` and `Route`.

---

## **2. What is React Router?**

React Router is a library that lets you:

- Associate a **URL** with a **component**.
- Change pages without reloading the browser.
- Keep a smooth SPA experience.

Think of it like this:

- `/` → Home
- `/login` → Login
- `/profile` → Profile

Each route renders a different component.

---

## **3. Installation**

In a React project:

```bash
npm install react-router-dom
```

---

## **4. Basic configuration**

The first step is to wrap the application with `BrowserRouter`.

This is usually done in `main.jsx` or `index.jsx`.

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

## **5. Defining routes with `Routes` and `Route`**

Routes are usually defined in `App.jsx`.

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

Key points:

- `Routes` groups the routes.
- Each `Route` has:

  - `path`: the URL.
  - `element`: the component to render.

---

## **6. Creating pages (`pages` folder)**

A common practice is to create a `pages` folder.

Example:

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

[![Router](https://img.youtube.com/vi/zYr6Z6yQ-_0/0.jpg)](https://www.youtube.com/watch?v=zYr6Z6yQ-_0&list=PLzA2VyZwsq_-dE3Jvunglxq8a6UcH6gnF)

---

## **7. Navigating between pages with `Link`**

To change routes, **you don't use `<a>`**, but the `Link` component.

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

Advantages of `Link`:

- It doesn't reload the page.
- It keeps the app's state.

---

[![Links](https://img.youtube.com/vi/Jm9LWjEvS78/0.jpg)](https://www.youtube.com/watch?v=Jm9LWjEvS78&list=PLzA2VyZwsq_-dE3Jvunglxq8a6UcH6gnF)

---

## **8. Default route (404)**

You can create a route for non-existent pages:

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

## **9. `useNavigate`: navigating from code**

Sometimes you need to navigate after an action (login, submit...).

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

## **10. Common mistakes**

### **10.1. Using `<a>` instead of `Link`**

It causes a page reload.

### **10.2. Forgetting `BrowserRouter`**

The routes won't work.

### **10.3. Using `component` instead of `element`**

In React Router v6 you use:

```js
element={<Home />}
```

---

## **11. Best practices**

- Separate routes and pages.
- Use `Link` for navigation.
- Keep routes simple and clear.
- Centralize navigation in `App.jsx`.

---

[![Pages and APIs](https://img.youtube.com/vi/u-axNHE7bPQ/0.jpg)](https://www.youtube.com/watch?v=u-axNHE7bPQ&list=PLzA2VyZwsq_-dE3Jvunglxq8a6UcH6gnF)

---

In the next topic you'll learn how to work with **parametric routes**.
