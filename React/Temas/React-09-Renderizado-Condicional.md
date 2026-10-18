# **Topic 9: Conditional Rendering**

## **1. Introduction**

In a real interface, not everything is always displayed:

- Sometimes there's a loader while data is loading.
- Sometimes an error message appears.
- Sometimes one button or another is shown depending on the state.

In React, this is achieved with **conditional rendering**: deciding which JSX is rendered based on a condition.

In this topic you will learn:

- Conditionals with `if`.
- Conditionals with the ternary operator.
- Conditional rendering with `&&`.
- Best practices to keep the code clean.

---

## **2. The basic idea: conditions inside JSX**

In React, inside JSX you can use JavaScript expressions with `{}`.

But remember:

- `if` can't be placed directly inside JSX as a statement.
- But you can use operators or prepare variables before the `return`.

---

## **3. Conditional rendering with `if` (before the return)**

When the condition is complex, it's common to use `if` before the `return`.

Example: showing a loader.

```js
function Page() {
  const isLoading = true;

  if (isLoading) {
    return <p>Loading...</p>;
  }

  return <h2>Content loaded</h2>;
}

export default Page;
```

This is used a lot in:

- Data-dependent screens
- Loading states
- Error states

---

## **4. Conditional rendering with the ternary operator**

The ternary operator is very useful when you want to choose between **two options**.

```js
function StatusText() {
  const isOnline = false;

  return <p>{isOnline ? "Online" : "Offline"}</p>;
}

export default StatusText;
```

You can also use it to render JSX blocks:

```js
function Welcome() {
  const isLoggedIn = true;

  return (
    <div>{isLoggedIn ? <h2>Welcome back</h2> : <h2>Please sign in</h2>}</div>
  );
}

export default Welcome;
```

---

## **5. Conditional rendering with `&&`**

If you only want to render something when the condition is `true`, you can use `&&`.

```js
function Warning() {
  const hasWarning = true;

  return (
    <div>
      <h3>Dashboard</h3>
      {hasWarning && <p>Action required</p>}
    </div>
  );
}

export default Warning;
```

If `hasWarning` is `false`, React doesn't render anything in that part.

---

## **6. Conditions with “falsy” values (important detail)**

In JavaScript, these values are “falsy”:

- `false`
- `0`
- `""` (empty string)
- `null`
- `undefined`
- `NaN`

This matters because with `&&`:

- If the left part is `0`, React can render `0`.

Example:

```js
const count = 0;
return <div>{count && <p>Count is {count}</p>}</div>;
```

Here `0` is rendered, which is usually not what you want.

Typical solution: use a more explicit condition:

```js
{
  count > 0 && <p>Count is {count}</p>;
}
```

---

## **7. Saving JSX in variables to improve readability**

If a `return` fills up with conditions, you can save the JSX in a variable.

```js
function Result() {
  const status = "success";

  let message = null;

  if (status === "success") {
    message = <p>Success</p>;
  } else if (status === "error") {
    message = <p>Error</p>;
  }

  return (
    <div>
      <h3>Status</h3>
      {message}
    </div>
  );
}

export default Result;
```

---

## **8. Best practices**

- For two clear options, use the ternary operator.
- To “show it if the condition is met”, use `&&`.
- For complex conditions, use `if` before the return.
- Avoid overly nested JSX.
- If the JSX becomes hard to read, extract components.

---

## **9. Things to keep in mind**

- Conditional rendering = deciding which JSX is displayed based on a condition.
- Main techniques:

  - `if` before the `return`
  - the ternary `cond ? A : B`
  - `cond && A`

- Be careful with `0 && ...` because it can render `0`.

---

[![Conditional Rendering](https://img.youtube.com/vi/183eqNQNz3U/0.jpg)](https://www.youtube.com/watch?v=183eqNQNz3U&list=PLzA2VyZwsq_-dE3Jvunglxq8a6UcH6gnF)

---

In the next topic we'll look at **Lists**, to render collections of elements using `.map()`.
