# **Topic 25: Lazy Loading in React**

## **1. Introduction**

When a React application grows, the size of the initial JavaScript also increases. Loading **all** code from the beginning can cause the app to take longer to display, especially on slow connections.

To improve performance, React allows you to **load components only when they are needed**. This technique is called **Lazy Loading**.

In this topic you will learn:

- What is Lazy Loading.
- Why it improves performance.
- How to use `React.lazy` and `Suspense`.
- Lazy Loading with routes.
- Common errors and good practices.

---

## **2. What is Lazy Loading?**

Lazy Loading means:

> Do not load a component until it is actually going to be used.

Instead of downloading all the code at startup:

- The app is divided into **chunks**.
- Each chunk is downloaded on demand.

This reduces:

- Initial loading time.
- The size of the main bundle.

---

## **3. Problem without Lazy Loading**

Typical example:

```js
import Home from "./pages/Home";
import Profile from "./pages/Profile";
import Settings from "./pages/Settings";
```

Even if the user only visits `Home`, the browser downloads **everything**.

---

## **4. Lazy Loading with `React.lazy`**

`React.lazy` allows you to import components dynamically.

```js
import { lazy } from "react";

const Home = lazy(() => import("./pages/Home"));
const Profile = lazy(() => import("./pages/Profile"));
```

Each component will be loaded only when it is rendered.

---

## **5. `Suspense`: show a fallback**

Lazy components **must** be wrapped in `Suspense`.

```js
import { Suspense } from "react";

<Suspense fallback={<p>Loading...</p>}>
  <Home />
</Suspense>;
```

- `fallback` is what is displayed while the chunk is downloading.

---

## **6. Lazy Loading with React Router**

The most common case is to load pages by path.

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

Each page is downloaded only when visited.

---

## **7. What can be loaded lazy**

✔️ Ideal for:

- Pages.
- Large components.
- Little used sections.

❌ Not recommended for:

- Very small components.
- Components that are always displayed.

---

## **8. Lazy Loading vs React.memo**

Although both optimize performance, **they do not do the same thing**:

- `React.memo` → avoid unnecessary renders.
- Lazy Loading → avoid downloading unnecessary code.

They are complementary techniques.

---

## **9. Typical errors**

### **9.1. Forget `Suspense`**

Causes error at runtime.

### **9.2. Use lazy in everything**

Too many small chunks can worsen performance.

### **9.3. Unclear fallback**

Always informs the user that something is loading.

---

## **10. Good practices**

- Applies lazy mainly to pages.
- Use `Suspense` at the route level.
- Keep fallbacks simple.
- Combine Lazy Loading with memoization when necessary.

---

[![Lazy Loading](https://img.youtube.com/vi/5WxFlccf5U8/0.jpg)](https://www.youtube.com/watch?v=5WxFlccf5U8&list=PLzA2VyZwsq_-dE3Jvunglxq8a6UcH6gnF)

---

In the next topic you will learn how to write **tests in React**.
