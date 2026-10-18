# **Exercises - Topic 25: Lazy Loading in React**

Below you will find **10 practical exercises** to learn how to apply Lazy Loading using `React.lazy` and `Suspense`, especially in combination with React Router.

Try to solve them before looking at the solution.

---

## **Exercise 1: Import a component lazily**

Convert this normal import into a lazy import:

```js
import Profile from "./pages/Profile";
```

<details><summary>Show solution</summary>

```js
import { lazy } from "react";

const Profile = lazy(() => import("./pages/Profile"));
```

</details>

---

## **Exercise 2: Use `Suspense` correctly**

Wrap a lazy component with `Suspense` and display the text **"Loading..."** while it loads.

<details><summary>Show solution</summary>

```js
import { Suspense } from "react";

<Suspense fallback={<p>Loading...</p>}>
  <Profile />
</Suspense>;
```

</details>

---

## **Exercise 3: Typical error without `Suspense`**

What happens if you try to render a lazy component without `Suspense`?

<details><summary>Show solution</summary>

An error occurs at runtime indicating that a `Suspense` is missing.

</details>

---

## **Exercise 4: Lazy Loading with React Router**

Create a `/settings` route that loads the `Settings` component lazily.

<details><summary>Show solution</summary>

```js
const Settings = lazy(() => import("./pages/Settings"));

<Suspense fallback={<p>Loading page...</p>}>
  <Routes>
    <Route path="/settings" element={<Settings />} />
  </Routes>
</Suspense>;
```

</details>

---

## **Exercise 5: Lazy Loading only on pages**

Explain why it is good practice to apply lazy loading mainly to pages and not to small components.

<details><summary>Show solution</summary>

Because pages are usually heavier and are not always visited, while small components are usually always rendered.

</details>

---

## **Exercise 6: Custom fallback**

Change the `fallback` of `Suspense` to display a `Spinner` component.

<details><summary>Show solution</summary>

```js
<Suspense fallback={<Spinner />}>
  <Profile />
</Suspense>
```

</details>

---

## **Exercise 7: Unnecessary Lazy Loading**

Give an example of a component where it would **not** make sense to use Lazy Loading.

<details><summary>Show solution</summary>

A button, an input or a header that is always displayed.

</details>

---

## **Exercise 8: Lazy Loading vs React.memo**

Indicate which technique you would use in each case:

- Avoid downloading unnecessary code.
- Avoid unnecessary renders.

<details><summary>Show solution</summary>

- Lazy Loading → avoid downloading unnecessary code.
- React.memo → avoid unnecessary renders.

</details>

---

## **Exercise 9: Suspense at the App level**

Why is it usually a good idea to place `Suspense` around the routes rather than around each individual component?

<details><summary>Show solution</summary>

Because it centralizes the handling of page loading and avoids duplicating code.

</details>

---

## **Exercise 10: Lazy Loading as an optimization**

Explain why Lazy Loading is an optimization that is applied when the app starts to grow.

<details><summary>Show solution</summary>

Because in small apps the cost of splitting the code is not worth it, but in large apps it clearly improves initial performance.

</details>
