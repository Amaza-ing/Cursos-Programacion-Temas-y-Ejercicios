# **Topic 25: Lazy Loading in React**

## **1. Introduction**

When a React application grows, the size of the initial JavaScript also increases. Loading **all** the code from the start can make the app take longer to show up, especially on slow connections.

To improve performance, React lets you **load components only when they're needed**. This technique is called **Lazy Loading**.

In this topic you will learn:

- What Lazy Loading is.
- Why it improves performance.
- How to use `React.lazy` and `Suspense`.
- Lazy Loading with routes.
- Common mistakes and best practices.

---

## **2. What is Lazy Loading?**

Lazy Loading means:

> Don't load a component until it's actually going to be used.

Instead of downloading all the code at startup:

- The app is split into **chunks**.
- Each chunk is downloaded on demand.

This reduces:

- The initial load time.
- The size of the main bundle.

---

## **3. The problem without Lazy Loading**

Typical example:

```js
import Home from "./pages/Home";
import Profile from "./pages/Profile";
import Settings from "./pages/Settings";
```

Even if the user only visits `Home`, the browser downloads **everything**.

---

## **4. Lazy Loading with `React.lazy`**

`React.lazy` lets you import components dynamically.

```js
import { lazy } from "react";

const Home = lazy(() => import("./pages/Home"));
const Profile = lazy(() => import("./pages/Profile"));
```

Each component will only be loaded when it's rendered.

---

## **5. `Suspense`: showing a fallback**

Lazy components **must** be wrapped in `Suspense`.

```js
import { Suspense } from "react";

<Suspense fallback={<p>Loading...</p>}>
  <Home />
</Suspense>;
```

- `fallback` is what's displayed while the chunk downloads.

---

## **6. Lazy Loading with React Router**

The most common case is loading pages by route.

```js
import { Routes, Route } from "react-router-dom";
import { lazy, Suspense } from "react";

const Home = lazy(() => import("./pages/Home"));
const Profile = lazy(() => import("./pages/Profile"));

function App() {
  return (
    <Suspense fallback={<p>Loading page...</p>}>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/profile" element={<Profile />} />
      </Routes>
    </Suspense>
  );
}

export default App;
```

Each page is downloaded only when it's visited.

---

## **7. What can be lazy-loaded**

✔️ Ideal for:

- Pages.
- Large components.
- Rarely used sections.

❌ Not recommended for:

- Very small components.
- Components that are always displayed.

---

## **8. Lazy Loading vs React.memo**

Although both optimize performance, **they don't do the same thing**:

- `React.memo` → avoids unnecessary renders.
- Lazy Loading → avoids downloading unnecessary code.

They're complementary techniques.

---

## **9. Common mistakes**

### **9.1. Forgetting `Suspense`**

It causes a runtime error.

### **9.2. Using lazy for everything**

Too many small chunks can hurt performance.

### **9.3. Unclear fallback**

Always let the user know that something is loading.

---

## **10. Best practices**

- Apply lazy mainly to pages.
- Use `Suspense` at the route level.
- Keep fallbacks simple.
- Combine Lazy Loading with memoization when necessary.

---

[![Lazy Loading](https://img.youtube.com/vi/5WxFlccf5U8/0.jpg)](https://www.youtube.com/watch?v=5WxFlccf5U8&list=PLzA2VyZwsq_-dE3Jvunglxq8a6UcH6gnF)

---

In the next topic you'll learn how to write **tests in React**.
