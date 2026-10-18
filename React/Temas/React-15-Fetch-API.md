# **Topic 15: Fetch API**

## **1. Introduction**

In most apps you need to **request data from an API** (users, products, posts...).

In React, the most common approach is to:

- Make the request with the **Fetch API**.
- Store the data in **state** with `useState`.
- Run the request in a **`useEffect`** (usually on mount).

In this topic you will learn:

- What Fetch is and how it works.
- How to make a **GET** request.
- How to handle typical states: **loading**, **error** and **data**.
- How to cancel/ignore responses when the component unmounts.
- How to make a **POST** request (basic).

---

## **2. What is the Fetch API?**

`fetch` is a browser function for making HTTP requests.

- It returns a **Promise**.
- Normally you convert the response to JSON with `response.json()`.

Basic example:

```js
fetch("https://api.example.com/users")
  .then((response) => response.json())
  .then((data) => console.log(data));
```

In React, we usually use `async/await` because it's more readable.

---

## **3. GET with `useEffect` (on mount)**

Complete example with state:

- `data` to store the response.
- `isLoading` for the loader.
- `error` for failures.

```js
import { useEffect, useState } from "react";

function Users() {
  const [users, setUsers] = useState([]);
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState(null);

  useEffect(() => {
    const loadUsers = async () => {
      try {
        setIsLoading(true);
        setError(null);

        const response = await fetch(
          "https://jsonplaceholder.typicode.com/users"
        );

        if (!response.ok) {
          throw new Error("Request failed");
        }

        const data = await response.json();
        setUsers(data);
      } catch (err) {
        setError(err.message);
      } finally {
        setIsLoading(false);
      }
    };

    loadUsers();
  }, []);

  if (isLoading) {
    return <p>Loading...</p>;
  }

  if (error) {
    return <p>Error: {error}</p>;
  }

  return (
    <ul>
      {users.map((user) => (
        <li key={user.id}>{user.name}</li>
      ))}
    </ul>
  );
}

export default Users;
```

---

## **4. Why we use `response.ok`**

`fetch` only throws an error automatically if there's a network problem.

If the server responds with:

- 404
- 500

**no** error is thrown by default. That's why it's good practice to check:

```js
if (!response.ok) {
  throw new Error("Request failed");
}
```

---

## **5. Avoiding state updates if the component unmounts**

A common problem:

- You make a fetch request.
- The user switches screens.
- The response arrives.
- You try to call `setState` on a component that's no longer there.

A simple way (the “ignore flag” pattern):

```js
import { useEffect, useState } from "react";

function Posts() {
  const [posts, setPosts] = useState([]);

  useEffect(() => {
    let shouldIgnore = false;

    const loadPosts = async () => {
      const response = await fetch(
        "https://jsonplaceholder.typicode.com/posts"
      );
      const data = await response.json();

      if (!shouldIgnore) {
        setPosts(data);
      }
    };

    loadPosts();

    return () => {
      shouldIgnore = true;
    };
  }, []);

  return (
    <ul>
      {posts.slice(0, 5).map((post) => (
        <li key={post.id}>{post.title}</li>
      ))}
    </ul>
  );
}

export default Posts;
```

> Later you'll see other ways (for example, `AbortController`), but this pattern already protects you in many cases.

---

## **6. Basic POST with Fetch**

To send data:

- The `POST` method
- A `Content-Type: application/json` header
- A `body` with `JSON.stringify(...)`

```js
const createUser = async () => {
  const newUser = { name: "Alex", email: "alex@mail.com" };

  const response = await fetch("https://api.example.com/users", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify(newUser),
  });

  if (!response.ok) {
    throw new Error("Create failed");
  }

  const createdUser = await response.json();
  return createdUser;
};
```

---

## **7. Best practices**

- Keep the state separate: `data`, `isLoading`, `error`.
- Use `try/catch/finally` to handle errors and loading.
- Check `response.ok`.
- If the component can unmount, avoid calling `setState` afterwards (flag or cancellation).
- Keep the fetch logic in functions (`loadUsers`, `loadPosts`) so the component is easy to read.

---

## **8. Things to keep in mind**

- `fetch` returns a Promise.
- `response.json()` also returns a Promise.
- A typical pattern is: `useEffect` + `async function` + `loading/error/data` states.
- `fetch` doesn't throw an error for HTTP 4xx/5xx unless you check for it.

---

[![Fetch API](https://img.youtube.com/vi/VkN96ZkyxzA/0.jpg)](https://www.youtube.com/watch?v=VkN96ZkyxzA&list=PLzA2VyZwsq_-dE3Jvunglxq8a6UcH6gnF)

---

In the next topic we'll look at **Axios**, an alternative to Fetch with a more convenient API for many cases.
