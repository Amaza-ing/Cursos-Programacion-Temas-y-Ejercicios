# **Exercises - Topic 19: Parametric Routes**

Below you will find **10 practical exercises** to work with dynamic routes in React Router using `:params` and `useParams`.

Try to solve them before looking at the solution.

---

## **Exercise 1: Create a parametric route**

In `App.jsx`, create a parametric route to display a user's details:

- Route: `/users/:id`
- Component: `UserDetail.jsx`

<details><summary>Show solution</summary>

```js
import { Routes, Route } from "react-router-dom";
import UserDetail from "./pages/UserDetail";

function App() {
  return (
    <Routes>
      <Route path="/users/:id" element={<UserDetail />} />
    </Routes>
  );
}

export default App;
```

</details>

---

## **Exercise 2: Read the parameter with `useParams`**

In `UserDetail.jsx`:

- Read the `id` parameter using `useParams`.
- Show a `p` with: **"User id: X"**.

<details><summary>Show solution</summary>

```js
import { useParams } from "react-router-dom";

function UserDetail() {
  const { id } = useParams();

  return <p>User id: {id}</p>;
}

export default UserDetail;
```

</details>

---

## **Exercise 3: Create links to parametric routes**

Create a `UsersLinks.jsx` component that displays a list with links to:

- `/users/1`
- `/users/2`
- `/users/3`

Use `Link`.

<details><summary>Show solution</summary>

```js
import { Link } from "react-router-dom";

function UsersLinks() {
  return (
    <ul>
      <li>
        <Link to="/users/1">User 1</Link>
      </li>
      <li>
        <Link to="/users/2">User 2</Link>
      </li>
      <li>
        <Link to="/users/3">User 3</Link>
      </li>
    </ul>
  );
}

export default UsersLinks;
```

</details>

---

## **Exercise 4: Load data with Axios using the parameter**

In `UserDetail.jsx`:

- Use Axios to make a GET request to:

  - `https://jsonplaceholder.typicode.com/users/{id}`

- Store the user in state.
- Show the user's name.

<details><summary>Show solution</summary>

```js
import { useEffect, useState } from "react";
import { useParams } from "react-router-dom";
import axios from "axios";

function UserDetail() {
  const { id } = useParams();
  const [user, setUser] = useState(null);

  useEffect(() => {
    const loadUser = async () => {
      const response = await axios.get(
        `https://jsonplaceholder.typicode.com/users/${id}`
      );
      setUser(response.data);
    };

    loadUser();
  }, [id]);

  if (!user) return <p>Loading...</p>;

  return <h2>{user.name}</h2>;
}

export default UserDetail;
```

</details>

---

## **Exercise 5: Add `loading` and `error`**

Extend the previous exercise to include:

- `isLoading`
- `error`

Behavior:

- It shows `Loading...` while it loads.
- If it fails, it shows `Error: ...`.

<details><summary>Show solution</summary>

```js
import { useEffect, useState } from "react";
import { useParams } from "react-router-dom";
import axios from "axios";

function UserDetail() {
  const { id } = useParams();
  const [user, setUser] = useState(null);
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState(null);

  useEffect(() => {
    const loadUser = async () => {
      try {
        setIsLoading(true);
        setError(null);

        const response = await axios.get(
          `https://jsonplaceholder.typicode.com/users/${id}`
        );

        setUser(response.data);
      } catch (err) {
        setError(err.message);
      } finally {
        setIsLoading(false);
      }
    };

    loadUser();
  }, [id]);

  if (isLoading) return <p>Loading...</p>;
  if (error) return <p>Error: {error}</p>;
  if (!user) return <p>No user</p>;

  return <h2>{user.name}</h2>;
}

export default UserDetail;
```

</details>

---

## **Exercise 6: Parameter as a number**

In `UserDetail.jsx`:

- Convert `id` to a number.
- Show a `p` with: **"Numeric id: X"**.

<details><summary>Show solution</summary>

```js
const numericId = Number(id);

return <p>Numeric id: {numericId}</p>;
```

</details>

---

## **Exercise 7: Route with two parameters**

Create a route:

- `/posts/:postId/comments/:commentId`

And a `CommentDetail.jsx` component that displays both values.

<details><summary>Show solution</summary>

```js
<Route path="/posts/:postId/comments/:commentId" element={<CommentDetail />} />
```

```js
import { useParams } from "react-router-dom";

function CommentDetail() {
  const { postId, commentId } = useParams();

  return (
    <p>
      Post: {postId} | Comment: {commentId}
    </p>
  );
}

export default CommentDetail;
```

</details>

---

## **Exercise 8: Generate dynamic links from an array**

Create a `ProductsLinks.jsx` component with this array:

```js
const products = [
  { id: 10, name: "Keyboard" },
  { id: 11, name: "Mouse" },
  { id: 12, name: "Monitor" },
];
```

- Render a `ul`.
- Use `.map()` to create links to `/products/{id}`.

<details><summary>Show solution</summary>

```js
import { Link } from "react-router-dom";

function ProductsLinks() {
  const products = [
    { id: 10, name: "Keyboard" },
    { id: 11, name: "Mouse" },
    { id: 12, name: "Monitor" },
  ];

  return (
    <ul>
      {products.map((product) => (
        <li key={product.id}>
          <Link to={`/products/${product.id}`}>{product.name}</Link>
        </li>
      ))}
    </ul>
  );
}

export default ProductsLinks;
```

</details>

---

## **Exercise 9: Back button**

On a detail page, create a **Back** button that returns to the previous page using `useNavigate`.

<details><summary>Show solution</summary>

```js
import { useNavigate } from "react-router-dom";

const navigate = useNavigate();

<button onClick={() => navigate(-1)}>Back</button>;
```

</details>

---

## **Exercise 10: 404 for non-existent detail routes**

Configure a `*` route that displays `NotFound`.

- Make sure that if the user goes to `/users/9999` (or an undefined route), the app doesn't break.

<details><summary>Show solution</summary>

```js
import NotFound from "./pages/NotFound";

<Route path="*" element={<NotFound />} />;
```

</details>
