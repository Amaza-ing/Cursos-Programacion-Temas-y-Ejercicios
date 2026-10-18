# **Exercises - Topic 9: Conditional Rendering**

Below you will find **10 practical exercises** on conditional rendering in React.

Try to solve them before looking at the solution.

---

## **Exercise 1: Loader with `if` before return**

Create a `DataBlock.jsx` component with an `isLoading = true` variable. If it is loading, it should return **only**:

- `p` with the text: **"Loading data..."**

If it is not loading, it should return:

- `div` with `h3` **"Data Ready"**

<details><summary>Show solution</summary>

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

Create an `AccessMessage.jsx` component with a `hasAccess = false` variable.

- If `hasAccess` is `true`, it shows: **"Access granted"**
- If `hasAccess` is `false`, it shows: **"Access denied"**

Do it with a ternary inside a `p`.

<details><summary>Show solution</summary>

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

Create an `ErrorNotice.jsx` component with a `hasError = true` variable.

- It always shows an `h3` with: **"Profile"**
- Only if `hasError` is `true`, it shows a `p` with: **"Something went wrong"**

<details><summary>Show solution</summary>

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

## **Exercise 4: Large blocks with a ternary (two sections)**

Create an `AuthPanel.jsx` component with `isLoggedIn = true`.

- If the user is logged in, render a `div` with:

  - `h2` **"Dashboard"**
  - `p` **"Welcome back"**

- If the user is not logged in, render a `div` with:

  - `h2` **"Login"**
  - `p` **"Please sign in"**

<details><summary>Show solution</summary>

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

Create a `CartCount.jsx` component with `itemsCount = 0`.

- It should only show a `p` with **"Items: 0"** when `itemsCount > 0`.
- If `itemsCount` is 0, nothing should be rendered in that part (and a stray `0` must not appear).

<details><summary>Show solution</summary>

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

## **Exercise 6: Store JSX in a variable**

Create a `PaymentStatus.jsx` component with a `status = "pending"` variable.

- If `status` is `"success"`, store a `p` with **"Payment complete"** in a variable.
- If `status` is `"pending"`, store a `p` with **"Processing..."**.
- If `status` is `"error"`, store a `p` with **"Payment failed"**.

Then render the `h3` **"Payment"** and the variable below it.

<details><summary>Show solution</summary>

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

## **Exercise 7: `&&` with a compound condition**

Create a `Banner.jsx` component with:

- `hasPromo = true`
- `isNewUser = false`

Only show the `p` **"Special offer"** if **both** conditions are true.

<details><summary>Show solution</summary>

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
## **Exercise 8: Extract the condition into a variable for readability**

Rewrite this render by creating a `showWarning` variable before the return:

```js
{
  isAdmin && isExpired && <p>Action required</p>;
}
```

Suppose `isAdmin = true` and `isExpired = true`.

<details><summary>Show solution</summary>

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

## **Exercise 9: Choose the right technique (3 mini-cases)**

Indicate which technique you would use and write the JSX (one per case):

1. I want to return **only** a loader and nothing else when `isLoading` is true.
2. I want to display one of two texts, `"Dark"` or `"Light"`, based on `isDarkMode`.
3. I want to show a `p` only if `hasNotifications` is true.

<details><summary>Show solution</summary>

1. `if` before return:

```js
if (isLoading) {
  return <p>Loading...</p>;
}
```

2. Ternary:

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

## **Exercise 10: Fix overly nested JSX (simple improvement)**

This code works, but it's hard to read. Rewrite it by storing the block in a `content` variable:

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

<details><summary>Show solution</summary>

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
