# **Exercises - Topic 3: Components in React**

Below you will find **8 practical exercises** on components in React.

Try to solve them before consulting the solution.

---

## **Exercise 1: Create an `Logo` component**

Create a component called `Logo.jsx` inside `src/components/` that displays:

- An `h2` with the text: **"MyCompany"**
- An `p` with the text: **"Building UI with React"**

Then use it inside `App.jsx`.

<details><summary>Show Solution</summary>

**`src/components/Logo.jsx`**

```js
function Logo() {
  return (
    <div>
      <h2>MyCompany</h2>
      <p>Building UI with React</p>
    </div>
  );
}

export default Logo;
```

**`src/App.jsx`**

```js
import Logo from "./components/Logo";

function App() {
  return (
    <div>
      <Logo />
    </div>
  );
}

export default App;
```

</details>

---

## **Exercise 2: Correct the “only parent element” error**

This component gives an error. Fix it to work:

```js
function Greeting() {
  return (
    <h1>Hello</h1>
    <p>Welcome to React</p>
  );
}

export default Greeting;
```

<details><summary>Show Solution</summary>

```js
function Greeting() {
  return (
    <div>
      <h1>Hello</h1>
      <p>Welcome to React</p>
    </div>
  );
}

export default Greeting;
```

</details>

---

## **Exercise 3: Create `UserBadge` with variables within JSX**

Create an `UserBadge.jsx` component in `src/components/` that:

- Declare a variable `userName` with the value `"Alex"`.
- Declare a variable `userRole` with the value `"Admin"`.
- Show in JSX:

  - `h3`: **"User: Alex"**
  - `p`: **"Role: Admin"**

Then use it on `App.jsx`.

<details><summary>Show Solution</summary>

**`src/components/UserBadge.jsx`**

```js
function UserBadge() {
  const userName = "Alex";
  const userRole = "Admin";

  return (
    <section>
      <h3>User: {userName}</h3>
      <p>Role: {userRole}</p>
    </section>
  );
}

export default UserBadge;
```

**`src/App.jsx`**

```js
import UserBadge from "./components/UserBadge";

function App() {
  return (
    <div>
      <UserBadge />
    </div>
  );
}

export default App;
```

</details>

---

## **Exercise 4: Composition - `Layout` with `Header` and `Footer`**

Create these components in `src/components/`:

- `Header.jsx` with an `header` and an `h1` that says **"Dashboard"**.
- `Footer.jsx` with an `footer` and an `small` that says **"All rights reserved"**.
- `Layout.jsx` that uses `Header` and `Footer` and also includes an `main` with an `p` that says: **"Content goes here"**.

Finally, render `Layout` to `App.jsx`.

<details><summary>Show Solution</summary>

**`src/components/Header.jsx`**

```js
function Header() {
  return (
    <header>
      <h1>Dashboard</h1>
    </header>
  );
}

export default Header;
```

**`src/components/Footer.jsx`**

```js
function Footer() {
  return (
    <footer>
      <small>All rights reserved</small>
    </footer>
  );
}

export default Footer;
```

**`src/components/Layout.jsx`**

```js
import Header from "./Header";
import Footer from "./Footer";

function Layout() {
  return (
    <div>
      <Header />
      <main>
        <p>Content goes here</p>
      </main>
      <Footer />
    </div>
  );
}

export default Layout;
```

**`src/App.jsx`**

```js
import Layout from "./components/Layout";

function App() {
  return (
    <div>
      <Layout />
    </div>
  );
}

export default App;
```

</details>

---

## **Exercise 5: Successful import (detect the problem)**

You have this component:

```js
function Card() {
  return <div>Card</div>;
}

export default Card;
```

And you are importing it like this in `App.jsx`:

```js
import { Card } from "./components/Card";
```

Fix the import so it works.

<details><summary>Show Solution</summary>

Since the component is exported with `export default`, the import must be keyless:

```js
import Card from "./components/Card";
```

</details>

---

## **Exercise 6: Create an `Stats` component with simple calculation**

Create an `Stats.jsx` component that:

- Declare two variables: `visits = 120` and `signups = 45`.
- Show both in JSX.
- Calculate and display in an `p` the sum: **"Total: 165"** using `{}`.

<details><summary>Show Solution</summary>

```js
function Stats() {
  const visits = 120;
  const signups = 45;

  return (
    <section>
      <p>Visits: {visits}</p>
      <p>Signups: {signups}</p>
      <p>Total: {visits + signups}</p>
    </section>
  );
}

export default Stats;
```

</details>

---

## **Exercise 7: Reuse a component multiple times**

Create an `Tag.jsx` component that displays an `span` with the text **"New"**.

Then on `App.jsx` use it **three times** in a row.

<details><summary>Show Solution</summary>

**`src/components/Tag.jsx`**
```js
function Tag() {
  return <span>New</span>;
}

export default Tag;
```

**`src/App.jsx`**

```js
import Tag from "./components/Tag";

function App() {
  return (
    <div>
      <Tag />
      <Tag />
      <Tag />
    </div>
  );
}

export default App;
```

</details>

---

## **Exercise 8: Good practices (choose the correct option)**

Mark the most recommended option in each case:

1. Component name:

   - a) `navbar.jsx`
   - b) `Navbar.jsx`
   - c) `navBar.jsx`

2. How many components per file is recommended when starting out?

   - a) Many, to have fewer files
   - b) One per file
   - c) It doesn't matter

3. A component should:

   - a) Have many responsibilities to save code
   - b) Be small and with a clear responsibility
   - c) Do not import other components

<details><summary>Show Solution</summary>

1. b) `Navbar.jsx` (PascalCase).
2. b) One per file.
3. b) Be small and with clear responsibility.

</details>
