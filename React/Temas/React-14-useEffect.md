# **Topic 14: useEffect()**

## **1. Introduction**

So far we have used `useState` to save data and update the interface. But there are situations where a component needs to do “extra things” besides rendering:

- Request data from an API.
- Read or write to `localStorage`.
- Configure an `setInterval` or an `setTimeout`.
- Subscribe to events (e.g. window `resize`).

React calls these types of actions **effects_. The main hook to manage them is **`useEffect`**.

In this topic you will learn:

- What is an effect.
- How `useEffect` works.
- What does the dependency list mean?
- How to execute an effect:

  - Only when riding.
  - Every time a variable changes.
  - With cleaning (_cleanup_).

---

## **2. What is an “effect”?**

An effect is any logic that:

- It does not belong directly to the render.
- Interacts with something “external” to the component.

Very useful mental rule:

- **Render**: generates JSX.
- **Effect**: does “secondary” work that occurs after rendering.

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

- If you don't put dependencies, it is executed **after each render**.

---

## **4. Dependencies: the second argument**

`useEffect` can take a second argument: an array of dependencies.

```js
useEffect(() => {
  // effect
}, [dependencyA, dependencyB]);
```

That array tells React:

- “Only rerun this effect if any of these variables change.”

---

## **5. Execute an effect only when mounted (equivalent to “on mount”)**

If you want an effect to run only **once**, when mounting the component, use an empty array:

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

This pattern is widely used for:

- Load data at startup.
- Initialize something only once.

---

## **6. Run an effect when a variable changes**

If you put a dependency, the effect is executed:

- When riding, and
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

## **7. Cleanup: clean an effect**

Some effects create “subscriptions” or timers. In these cases you have to clean when:

- The component is disassembled.
- Before running the effect again.

Cleanup is done by returning a function inside `useEffect`.

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

Without cleanup, the interval would continue to work even if the component disappears.

---

## **8. Typical case: read/write `localStorage`**

A very common practical case:

- When mounting: read a saved value.
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

## **9. Typical errors**

### **9.1. Forget dependencies**

If you use variables inside the effect, they should normally be in the dependencies array.

```js
useEffect(() => {
  console.log(query);
}, [query]);
```

### **9.2. Do “render work” within the effect**

The effect is not to generate JSX, but for secondary logic.

---

## **10. Good practices**

- Use `[]` if you only want to run on mount.
- Add dependencies when the effect depends on state/props.
- If you create timers or listeners, return a cleanup.
- Keep the effects small and with clear responsibility.

---
## **11. To take into account**

- `useEffect` is executed **after** the render.
- No dependencies: executed after each render.
- With `[]`: only when mounting.
- With `[x]`: when mounting and when changing `x`.
- The cleanup prevents leaks and unexpected behavior.

---

[![useEffect](https://img.youtube.com/vi/I9A4xAf_qMc/0.jpg)](https://www.youtube.com/watch?v=I9A4xAf_qMc&list=PLzA2VyZwsq_-dE3Jvunglxq8a6UcH6gnF)

---

In the next topic we will see **Fetch API**, to request data from an API and combine it with `useEffect`.
