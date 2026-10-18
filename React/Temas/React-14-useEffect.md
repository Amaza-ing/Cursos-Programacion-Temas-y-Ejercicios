# **Topic 14: useEffect()**

## **1. Introduction**

So far we've used `useState` to store data and update the interface. But there are situations where a component needs to do “extra things” besides rendering:

- Request data from an API.
- Read from or write to `localStorage`.
- Set up a `setInterval` or a `setTimeout`.
- Subscribe to events (for example, the window's `resize`).

React calls these kinds of actions **effects**. The main hook to manage them is **`useEffect`**.

In this topic you will learn:

- What an effect is.
- How `useEffect` works.
- What the dependency list means.
- How to run an effect:

  - Only on mount.
  - Every time a variable changes.
  - With a _cleanup_.

---

## **2. What is an “effect”?**

An effect is any logic that:

- Doesn't belong directly to the render.
- Interacts with something “external” to the component.

A very useful rule of thumb:

- **Render**: generates JSX.
- **Effect**: does “secondary” work that happens after rendering.

---

## **3. Basic syntax of `useEffect`**

First, you import it:

```js
import { useEffect } from "react";
```

Then you use it with a function:

```js
useEffect(() => {
  console.log("Effect runs");
});
```

Important:

- If you don't add dependencies, it runs **after every render**.

---

## **4. Dependencies: the second argument**

`useEffect` can take a second argument: an array of dependencies.

```js
useEffect(() => {
  // effect
}, [dependencyA, dependencyB]);
```

That array tells React:

- “Only run this effect again if any of these variables change.”

---

## **5. Running an effect only when the component mounts (“on mount”)**

If you want an effect to run only **once**, when the component mounts, use an empty array:

```js
import { useEffect } from "react";

function App() {
  useEffect(() => {
    console.log("Mounted");
  }, []);

  return <h2>App</h2>;
}

export default App;
```

This pattern is widely used to:

- Load data at startup.
- Initialize something only once.

---

## **6. Running an effect when a variable changes**

If you add a dependency, the effect runs:

- On mount, and
- Every time that dependency changes.

Example:

```js
import { useEffect, useState } from "react";

function CounterWatcher() {
  const [count, setCount] = useState(0);

  useEffect(() => {
    console.log("Count changed:", count);
  }, [count]);

  return (
    <button onClick={() => setCount((prevCount) => prevCount + 1)}>Add</button>
  );
}

export default CounterWatcher;
```

---

## **7. Cleanup: cleaning up an effect**

Some effects create “subscriptions” or timers. In those cases you have to clean up:

- When the component unmounts.
- Before running the effect again.

Cleanup is done by returning a function inside the `useEffect`.

### **7.1. Example: `setInterval` with cleanup**

```js
import { useEffect, useState } from "react";

function Timer() {
  const [seconds, setSeconds] = useState(0);

  useEffect(() => {
    const intervalId = setInterval(() => {
      setSeconds((prevSeconds) => prevSeconds + 1);
    }, 1000);

    return () => {
      clearInterval(intervalId);
    };
  }, []);

  return <p>Seconds: {seconds}</p>;
}

export default Timer;
```

Without cleanup, the interval would keep running even after the component disappears.

---

## **8. Typical case: reading/writing `localStorage`**

A very common practical case:

- On mount: read a saved value.
- When the state changes: save it.

Example:

```js
import { useEffect, useState } from "react";

function ThemeSaver() {
  const [theme, setTheme] = useState("light");

  useEffect(() => {
    const storedTheme = localStorage.getItem("theme");
    if (storedTheme) {
      setTheme(storedTheme);
    }
  }, []);

  useEffect(() => {
    localStorage.setItem("theme", theme);
  }, [theme]);

  return (
    <div>
      <p>Theme: {theme}</p>
      <button
        onClick={() =>
          setTheme((prevTheme) => (prevTheme === "light" ? "dark" : "light"))
        }
      >
        Toggle
      </button>
    </div>
  );
}

export default ThemeSaver;
```

---

## **9. Common mistakes**

### **9.1. Forgetting dependencies**

If you use variables inside the effect, they should normally be in the dependency array.

```js
useEffect(() => {
  console.log(query);
}, [query]);
```

### **9.2. Doing “render work” inside the effect**

Effects aren't for generating JSX, but for secondary logic.

---

## **10. Best practices**

- Use `[]` if you only want it to run on mount.
- Add dependencies when the effect depends on state/props.
- If you create timers or listeners, return a cleanup.
- Keep effects small, with a clear responsibility.

---
## **11. Things to keep in mind**

- `useEffect` runs **after** the render.
- No dependencies: it runs after every render.
- With `[]`: only on mount.
- With `[x]`: on mount and whenever `x` changes.
- Cleanup prevents leaks and unexpected behavior.

---

[![useEffect](https://img.youtube.com/vi/I9A4xAf_qMc/0.jpg)](https://www.youtube.com/watch?v=I9A4xAf_qMc&list=PLzA2VyZwsq_-dE3Jvunglxq8a6UcH6gnF)

---

In the next topic we'll look at the **Fetch API**, to request data from an API and combine it with `useEffect`.
