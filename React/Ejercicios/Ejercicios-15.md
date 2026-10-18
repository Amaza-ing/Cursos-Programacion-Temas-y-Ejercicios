# **Exercises - Topic 15: Fetch API**

Below you will find **10 practical exercises** to work with the **Fetch API** in React, combining it with `useEffect` and state management (`loading`, `error`, `data`).

Try to solve them before looking at the solution.

---

## **Exercise 1: Basic GET with states (list of titles)**

Create a `PostsTitles.jsx` component that:

- Makes a GET request to: `https://jsonplaceholder.typicode.com/posts`
- Stores the response in a `posts` state.
- Uses `isLoading` and `error`.
- Renders only the **first 5 titles** (`post.title`) in a list.

<details><summary>Show solution</summary>

```js
import { useEffect, useState } from "react";

function PostsTitles() {
  const [posts, setPosts] = useState([]);
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState(null);

  useEffect(() => {
    const loadPosts = async () => {
      try {
        setIsLoading(true);
        setError(null);

        const response = await fetch(
          "https://jsonplaceholder.typicode.com/posts"
        );
        if (!response.ok) throw new Error("Request failed");

        const data = await response.json();
        setPosts(data);
      } catch (err) {
        setError(err.message);
      } finally {
        setIsLoading(false);
      }
    };

    loadPosts();
  }, []);

  if (isLoading) return <p>Loading...</p>;
  if (error) return <p>Error: {error}</p>;

  return (
    <ul>
      {posts.slice(0, 5).map((post) => (
        <li key={post.id}>{post.title}</li>
      ))}
    </ul>
  );
}

export default PostsTitles;
```

</details>

---

## **Exercise 2: `response.ok` required**

Complete this component so that it throws an error if the response is not OK:

```js
import { useEffect, useState } from "react";

function UsersLoader() {
  const [users, setUsers] = useState([]);

  useEffect(() => {
    const run = async () => {
      const response = await fetch(
        "https://jsonplaceholder.typicode.com/users"
      );
      // TODO: comprobar response.ok y lanzar error
      const data = await response.json();
      setUsers(data);
    };

    run();
  }, []);

  return <p>Users: {users.length}</p>;
}

export default UsersLoader;
```

<details><summary>Show solution</summary>

```js
import { useEffect, useState } from "react";

function UsersLoader() {
  const [users, setUsers] = useState([]);

  useEffect(() => {
    const run = async () => {
      const response = await fetch(
        "https://jsonplaceholder.typicode.com/users"
      );

      if (!response.ok) {
        throw new Error("Request failed");
      }

      const data = await response.json();
      setUsers(data);
    };

    run();
  }, []);

  return <p>Users: {users.length}</p>;
}

export default UsersLoader;
```

</details>

---

## **Exercise 3: Error handling (simulate a 404)**

Create a `BrokenRequest.jsx` component that fetches an incorrect URL (for example: `https://jsonplaceholder.typicode.com/invalid-route`).

- It should show `Loading...` while it loads.
- If it fails, it should display: `Error: ...`.

<details><summary>Show solution</summary>

```js
import { useEffect, useState } from "react";

function BrokenRequest() {
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState(null);

  useEffect(() => {
    const run = async () => {
      try {
        setIsLoading(true);
        setError(null);

        const response = await fetch(
          "https://jsonplaceholder.typicode.com/invalid-route"
        );
        if (!response.ok) throw new Error("Request failed");

        await response.json();
      } catch (err) {
        setError(err.message);
      } finally {
        setIsLoading(false);
      }
    };

    run();
  }, []);

  if (isLoading) return <p>Loading...</p>;
  if (error) return <p>Error: {error}</p>;

  return <p>Done</p>;
}

export default BrokenRequest;
```

</details>

---

## **Exercise 4: Convert `.then()` to `async/await`**

Rewrite this code using `async/await` inside `useEffect`:

```js
useEffect(() => {
  fetch("https://jsonplaceholder.typicode.com/todos")
    .then((res) => res.json())
    .then((data) => setTodos(data));
}, []);
```

<details><summary>Show solution</summary>

```js
useEffect(() => {
  const run = async () => {
    const response = await fetch("https://jsonplaceholder.typicode.com/todos");
    const data = await response.json();
    setTodos(data);
  };

  run();
}, []);
```

</details>

---

## **Exercise 5: Avoid `setState` after unmounting (ignore flag)**

Create a `SafeAlbums.jsx` component that:

- Fetches `https://jsonplaceholder.typicode.com/albums`.
- Uses a `shouldIgnore` flag to avoid `setAlbums(data)` if the component unmounts.
- Renders a `p` with: `Albums: X`.

<details><summary>Show solution</summary>

```js
import { useEffect, useState } from "react";

function SafeAlbums() {
  const [albums, setAlbums] = useState([]);

  useEffect(() => {
    let shouldIgnore = false;

    const run = async () => {
      const response = await fetch(
        "https://jsonplaceholder.typicode.com/albums"
      );
      const data = await response.json();

      if (!shouldIgnore) {
        setAlbums(data);
      }
    };

    run();

    return () => {
      shouldIgnore = true;
    };
  }, []);

  return <p>Albums: {albums.length}</p>;
}

export default SafeAlbums;
```

</details>

---

## **Exercise 6: `finally` to ensure loading is turned off**

Create a `TodosCount.jsx` component that:

- Makes a GET request to `https://jsonplaceholder.typicode.com/todos`.
- Shows `Loading...` while it loads.
- Uses `try/catch/finally` to guarantee `setIsLoading(false)`.
- When finished, displays `Todos: X`.

<details><summary>Show solution</summary>

```js
import { useEffect, useState } from "react";

function TodosCount() {
  const [todos, setTodos] = useState([]);
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState(null);

  useEffect(() => {
    const run = async () => {
      try {
        setIsLoading(true);
        setError(null);

        const response = await fetch(
          "https://jsonplaceholder.typicode.com/todos"
        );
        if (!response.ok) throw new Error("Request failed");

        const data = await response.json();
        setTodos(data);
      } catch (err) {
        setError(err.message);
      } finally {
        setIsLoading(false);
      }
    };

    run();
  }, []);

  if (isLoading) return <p>Loading...</p>;
  if (error) return <p>Error: {error}</p>;

  return <p>Todos: {todos.length}</p>;
}

export default TodosCount;
```

</details>

---

## **Exercise 7: State-dependent fetch (change the id)**

Create a `UserById.jsx` component with:

- A `userId` state with initial value `1`.
- A **Next** button that increments `userId`.
- A `useEffect` that fetches:

  - `https://jsonplaceholder.typicode.com/users/{userId}`

- The user's name rendered on screen.

<details><summary>Show solution</summary>

```js
import { useEffect, useState } from "react";

function UserById() {
  const [userId, setUserId] = useState(1);
  const [user, setUser] = useState(null);
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState(null);

  useEffect(() => {
    const run = async () => {
      try {
        setIsLoading(true);
        setError(null);

        const response = await fetch(
          `https://jsonplaceholder.typicode.com/users/${userId}`
        );
        if (!response.ok) throw new Error("Request failed");

        const data = await response.json();
        setUser(data);
      } catch (err) {
        setError(err.message);
      } finally {
        setIsLoading(false);
      }
    };

    run();
  }, [userId]);

  if (isLoading) return <p>Loading...</p>;
  if (error) return <p>Error: {error}</p>;

  return (
    <div>
      <button onClick={() => setUserId((prevId) => prevId + 1)}>Next</button>
      <p>User: {user ? user.name : "-"}</p>
    </div>
  );
}

export default UserById;
```

</details>

---

## **Exercise 8: POST (simulation) with JSON**

Create a `createPost` function that makes a POST request to:

- `https://jsonplaceholder.typicode.com/posts`

Sending:

```js
{ title: "Hello", body: "World", userId: 1 }
```

You must include:

- `method: "POST"`
- `headers` with `Content-Type`
- `body` with `JSON.stringify(...)`

<details><summary>Show solution</summary>

```js
const createPost = async () => {
  const payload = { title: "Hello", body: "World", userId: 1 };

  const response = await fetch("https://jsonplaceholder.typicode.com/posts", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify(payload),
  });

  if (!response.ok) {
    throw new Error("Create failed");
  }

  const created = await response.json();
  return created;
};
```

</details>

---

## **Exercise 9: Show states in the JSX (3 cases)**

Write the rendering pattern for:

- loading
- error
- success

In this order, using early returns.
<details><summary>Show solution</summary>

```js
if (isLoading) {
  return <p>Loading...</p>;
}

if (error) {
  return <p>Error: {error}</p>;
}

return <div>Success</div>;
```

</details>

---

## **Exercise 10: Fix a `useEffect` with a direct async callback**

This code is bad practice. Rewrite it with the recommended pattern:

```js
useEffect(async () => {
  const response = await fetch("https://jsonplaceholder.typicode.com/users");
  const data = await response.json();
  setUsers(data);
}, []);
```

<details><summary>Show solution</summary>

```js
useEffect(() => {
  const run = async () => {
    const response = await fetch("https://jsonplaceholder.typicode.com/users");
    const data = await response.json();
    setUsers(data);
  };

  run();
}, []);
```

</details>
