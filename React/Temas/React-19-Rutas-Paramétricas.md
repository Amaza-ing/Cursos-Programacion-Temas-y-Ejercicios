# **Topic 19: Parametric Routes**

## **1. Introduction**

In many applications not all pages have a fixed URL. You often need routes that change according to an **identifier**: the id of a user, a product, a post, etc.

Typical examples:

- `/users/1`
- `/users/42`
- `/products/10`

These types of routes are called **parametric routes**.

In this topic you will learn:

- What are parametric routes.
- How to define parameters in a route.
- How to read those parameters with `useParams`.
- How to use them to load dynamic data.

---

## **2. What is a parametric route?**

A parametric route is a route that contains **variables** in the URL.

Example:

```txt
/users/:id
```

Here:

- `:id` is a **parameter**.
- Its value depends on the actual URL.

If the user enters:

```txt
/users/5
```

So:

- `id = "5"`

---

## **3. Define a parametric route**

Parametric routes are defined the same as normal routes, but using `:`.

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

---

## **4. Read parameters with `useParams`**

To access the URL parameters, the `useParams` hook is used.

```js
import { useParams } from "react-router-dom";

function UserDetail() {
  const params = useParams();

  return <p>User id: {params.id}</p>;
}

export default UserDetail;
```

Most common way using destructuring:

```js
const { id } = useParams();
```

---

## **5. Full Parametric Path – Simple Example**

### **5.1. Page `UserDetail.jsx`**

```js
import { useParams } from "react-router-dom";

function UserDetail() {
  const { id } = useParams();

  return <h2>User detail for id: {id}</h2>;
}

export default UserDetail;
```

### **5.2. Link to the parametric route**

```js
import { Link } from "react-router-dom";

function UsersList() {
  return (
    <ul>
      <li>
        <Link to="/users/1">User 1</Link>
      </li>
      <li>
        <Link to="/users/2">User 2</Link>
      </li>
    </ul>
  );
}

export default UsersList;
```

---

## **6. Use parameters to load data**

A very common use is to combine parametric routes with requests to an API.

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

Important key:

- The `useEffect` depends on `id`.

---

## **7. Multiple parameters in a route**

A route can have more than one parameter:

```txt
/posts/:postId/comments/:commentId
```

```js
const { postId, commentId } = useParams();
```

---

## **8. Parameters are always strings**

The values obtained with `useParams`:

- They are always **strings**.

If you need a number:

```js
const numericId = Number(id);
```

---

## **9. Typical errors**

### **9.1. Forget the colon `:`**

Incorrect:

```js
<Route path="/users/id" />
```

Correct:

```js
<Route path="/users/:id" />
```

---

### **9.2. Do not use parameter in dependencies**

If you use the parameter in an `useEffect`, it must be in the dependencies array.

---

## **10. Good practices**

- Use clear names for parameters (`id`, `userId`, `productId`).
- Keep routes simple.
- Use parametric routes only when the content is dynamic.
- Combine them with APIs for detail views.

---

[![Parametric Routes](https://img.youtube.com/vi/iC8whY8noHI/0.jpg)](https://www.youtube.com/watch?v=iC8whY8noHI&list=PLzA2VyZwsq_-dE3Jvunglxq8a6UcH6gnF)

---

In the next topic you will learn how to work with **protected routes**.
