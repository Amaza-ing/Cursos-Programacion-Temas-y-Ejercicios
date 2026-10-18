# **Topic 15: Fetch API**

## **1. Introduction**

In most apps you need to **request data from an API** (users, products, posts...).

In React, the most common is:

- Make the request with **Fetch API**.
- Save data in **state** with `useState`.
- Execute the request in an **`useEffect`** (normally when mounting).

In this topic you will learn:

- What is Fetch and how it works.
- How to do a **GET**.
- How to handle typical states: **loading**, **error** and **data**.
- How to cancel/ignore responses when component is unmounted.
- How to do **POST** (basic).

---

## **2. What is Fetch API?**

`fetch` is a browser function for making HTTP requests.

- Returns a **Promise**.
- Normally you convert the response to JSON with `response.json()`.

Basic example:

```js
fetch("https://api.example.com/users")
  .then((response) => response.json())
  .then((data) => console.log(data));
```

In React, we usually use `async/await` because it is more readable.

---

## **3. GET with `useEffect` (when mounting)**

Complete example with state:

- `data` to save the answer.
- `isLoading` for loader.
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

`fetch` only automatically throws error if there is a network problem.

If the server responds with:

- 404
- 500

**no** error is thrown by default. That is why it is good practice to check:

```js
if (!response.ok) {
  throw new Error("Request failed");
}
```

---

## **5. Avoid updating state if component is unmounted**

A common problem:

- You make a fetch.
- The user changes screen.
- The answer arrives.
- You are trying to do `setState` on a component that is no longer there.

A simple way (“ignore flag” pattern):

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

> Later you will see other ways (for example, `AbortController`), but this pattern already protects you from many cases.

---

## **6. Basic POST with Fetch**

To send data:

- `POST` method
- `Content-Type: application/json` header
- `body` with `JSON.stringify(...)`

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

## **7. Good practices**

- Keep the state separate: `data`, `isLoading`, `error`.
- Use `try/catch/finally` for error control and loading.
- Check `response.ok`.
- If the component can be disassembled, avoid doing `setState` afterwards (flag or cancel).
- Keep the fetch logic in functions (`loadUsers`, `loadPosts`) to make the component easy to read.

---

## **8. To take into account**

- `fetch` returns a Promise.
- `response.json()` also returns a Promise.
- A typical pattern is: `useEffect` + `async function` + `loading/error/data` states.
- `fetch` does not throw an error for HTTP 4xx/5xx unless you check it.

---

[![Fetch API](https://img.youtube.com/vi/VkN96ZkyxzA/0.jpg)](https://www.youtube.com/watch?v=VkN96ZkyxzA&list=PLzA2VyZwsq_-dE3Jvunglxq8a6UcH6gnF)

---

In the next topic we will see **Axios**, an alternative to Fetch with a more comfortable API for many cases.
