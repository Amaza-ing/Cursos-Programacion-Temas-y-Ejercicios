# **Exercises - Topic 9: Conditional Rendering**

Below you will find **10 practical exercises** on conditional rendering in React.

Try to solve them before consulting the solution.

---

## **Exercise 1: Loader with `if` before return**

Creates an `DataBlock.jsx` component with an `isLoading = true` variable. If you are loading, you should return **only**:

- `p` with the text: **"Loading data..."**

If it is not loading, it should return:

- `div` with `h3` **"Data Ready"**

<details><summary>Show Solution</summary>

```js
function DataBlock() {
  const isLoading = true;

  if (isLoading) {
    return <p>Loading data...</p>;
  }

  return (
    <div>
      <h3>Data Ready</h3>
    </div>
  );
}

export default DataBlock;
```

</details>

---

## **Exercise 2: Ternary to display an access message**

Creates an `AccessMessage.jsx` component with an `hasAccess = false` variable.

- If `hasAccess` is `true`, displays: **"Access granted"**
- If `hasAccess` is `false`, it shows: **"Access denied"**

Do it with a ternary inside an `p`.

<details><summary>Show Solution</summary>

```js
function AccessMessage() {
  const hasAccess = false;

  return <p>{hasAccess ? "Access granted" : "Access denied"}</p>;
}

export default AccessMessage;
```

</details>

---

## **Exercise 3: Render a notice only if there is an error (`&&`)**

Creates an `ErrorNotice.jsx` component with an `hasError = true` variable.

- Always show an `h3` with: **"Profile"**
- Only if `hasError` is `true`, show an `p` with: **"Something went wrong"**

<details><summary>Show Solution</summary>

```js
function ErrorNotice() {
  const hasError = true;

  return (
    <div>
      <h3>Profile</h3>
      {hasError && <p>Something went wrong</p>}
    </div>
  );
}

export default ErrorNotice;
```

</details>

---

## **Exercise 4: Large blocks with ternary (two sections)**

Create an `AuthPanel.jsx` component with `isLoggedIn = true`.

- If logged in, render an `div` with:

  - `h2` **"Dashboard"**
  - `p` **"Welcome back"**

- If you are not logged in, render an `div` with:

  - `h2` **"Login"**
  - `p` **"Please sign in"**

<details><summary>Show Solution</summary>

```js
function AuthPanel() {
  const isLoggedIn = true;

  return (
    <div>
      {isLoggedIn ? (
        <div>
          <h2>Dashboard</h2>
          <p>Welcome back</p>
        </div>
      ) : (
        <div>
          <h2>Login</h2>
          <p>Please sign in</p>
        </div>
      )}
    </div>
  );
}

export default AuthPanel;
```

</details>

---

## **Exercise 5: Avoid the `0 && ...` problem**

Create an `CartCount.jsx` component with `itemsCount = 0`.

- Should only show `p` with **"Items: 0"** when `itemsCount > 0`.
- If `itemsCount` is 0, nothing should be rendered in that part (and the loose `0` should not appear).

<details><summary>Show Solution</summary>

```js
function CartCount() {
  const itemsCount = 0;

  return (
    <div>
      <h3>Cart</h3>
      {itemsCount > 0 && <p>Items: {itemsCount}</p>}
    </div>
  );
}

export default CartCount;
```

</details>

---

## **Exercise 6: Saving JSX in a variable**

Creates an `PaymentStatus.jsx` component with an `status = "pending"` variable.

- If `status` is `"success"`, save an `p` with **"Payment complete"** in a variable.
- If `status` is `"pending"`, save an `p` with **"Processing..."**.
- If `status` is `"error"`, save an `p` with **"Payment failed"**.

It then renders the `h3` **"Payment"** and the variable below it.

<details><summary>Show Solution</summary>

```js
function PaymentStatus() {
  const status = "pending";

  let message = null;

  if (status === "success") {
    message = <p>Payment complete</p>;
  } else if (status === "pending") {
    message = <p>Processing...</p>;
  } else if (status === "error") {
    message = <p>Payment failed</p>;
  }

  return (
    <div>
      <h3>Payment</h3>
      {message}
    </div>
  );
}

export default PaymentStatus;
```

</details>

---

## **Exercise 7: `&&` with compound condition**

Create an `Banner.jsx` component with:

- `hasPromo = true`
- `isNewUser = false`

Only show the `p` **"Special offer"** if **both** conditions are true.

<details><summary>Show Solution</summary>

```js
function Banner() {
  const hasPromo = true;
  const isNewUser = false;

  return (
    <div>
      <h3>Home</h3>
      {hasPromo && isNewUser && <p>Special offer</p>}
    </div>
  );
}

export default Banner;
```

</details>

---
## **Exercise 8: Extract condition to a variable for readability**

Rewrite this render by creating an `showWarning` variable before the return:

```js
{
  isAdmin && isExpired && <p>Action required</p>;
}
```

Suppose `isAdmin = true` and `isExpired = true`.

<details><summary>Show Solution</summary>

```js
function Example() {
  const isAdmin = true;
  const isExpired = true;

  const showWarning = isAdmin && isExpired;

  return <div>{showWarning && <p>Action required</p>}</div>;
}

export default Example;
```

</details>

---

## **Exercise 9: Choose correct technique (3 mini-cases)**

Indicate which technique you would use and write the JSX (one per case):

1. I want to return **only** a loader and nothing else when `isLoading` is true.
2. I want to display a text between two options: `"Dark"` or `"Light"` based on `isDarkMode`.
3. I want to show an `p` only if `hasNotifications` is true.

<details><summary>Show Solution</summary>

1. `if` before return:

```js
if (isLoading) {
  return <p>Loading...</p>;
}
```

2. ternary:

```js
<p>{isDarkMode ? "Dark" : "Light"}</p>
```

3. `&&`:

```js
{
  hasNotifications && <p>You have notifications</p>;
}
```

</details>

---

## **Exercise 10: Fix Overly Nested JSX (Simple Improvement)**

This code works, but it is poorly readable. Rewrite it by saving the block in an `content` variable:

```js
function App() {
  const state = "error";

  return (
    <div>
      {state === "success" ? (
        <p>Success</p>
      ) : state === "error" ? (
        <p>Error</p>
      ) : (
        <p>Pending</p>
      )}
    </div>
  );
}
```

<details><summary>Show Solution</summary>

```js
function App() {
  const state = "error";

  let content = <p>Pending</p>;

  if (state === "success") {
    content = <p>Success</p>;
  } else if (state === "error") {
    content = <p>Error</p>;
  }

  return <div>{content}</div>;
}

export default App;
```

</details>
