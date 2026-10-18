# **Exercises - Topic 25: Lazy Loading in React**

Below you will find **10 practical exercises** to learn how to apply Lazy Loading using `React.lazy` and `Suspense`, especially in combination with React Router.

Try to solve them before consulting the solution.

---

## **Exercise 1: Import a component lazy**

Convert this normal import into a lazy import:

```js
import Profile from "./pages/Profile";
```

<details><summary>Show Solution</summary>

```js
import { lazy } from "react";

const Profile = lazy(() => import("./pages/Profile"));
```

</details>

---

## **Exercise 2: Using `Suspense` correctly**

Wraps a lazy component with `Suspense` and displays a **"Loading..."** text while it loads.

<details><summary>Show Solution</summary>

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

<details><summary>Show Solution</summary>

An error occurs at run time indicating that an `Suspense` is missing.

</details>

---

## **Exercise 4: Lazy Loading with React Router**

Create an `/settings` route that loads the `Settings` component lazy.

<details><summary>Show Solution</summary>

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

Explain why it is good practice to apply lazy primarily to pages and not to small components.

<details><summary>Show Solution</summary>

Because pages are usually heavier and are not always visited, while small components are usually always rendered.

</details>

---

## **Exercise 6: Custom Fallback**

Change the `fallback` to `Suspense` to display an `Spinner` component.

<details><summary>Show Solution</summary>

```js
<Suspense fallback={<Spinner />}>
  <Profile />
</Suspense>
```

</details>

---

## **Exercise 7: Unnecessary Lazy Loading**

Give an example of a component where it would **not** make sense to use Lazy Loading.

<details><summary>Show Solution</summary>

A button, input or header that is always displayed.

</details>

---

## **Exercise 8: Lazy Loading vs React.memo**

Indicate which technique you would use in each case:

- Avoid downloading unnecessary code.
- Avoid unnecessary renderings.

<details><summary>Show Solution</summary>

- Lazy Loading → avoid downloading unnecessary code.
- React.memo → avoid unnecessary rendering.

</details>

---

## **Exercise 9: App-level suspense**

Why is it usually a good idea to place `Suspense` wrapping the routes and not each individual component?

<details><summary>Show Solution</summary>

Because it centralizes page loading management and avoids duplicating code.

</details>

---

## **Exercise 10: Lazy Loading as optimization**

Explain why Lazy Loading is an optimization that is applied when the app starts to grow.

<details><summary>Show Solution</summary>

Because in small apps the cost of splitting the code is not worth it, but in large apps it clearly improves initial performance.

</details>
