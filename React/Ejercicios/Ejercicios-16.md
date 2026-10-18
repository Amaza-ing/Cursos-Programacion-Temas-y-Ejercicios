# **Exercises - Topic 16: Axios**

Below you will find **10 practical exercises** to work with **Axios in React**, using `useEffect`, state management and HTTP requests.

Try to solve them before looking at the solution.

---

## **Exercise 1: Basic GET with Axios**

Create a `UsersList.jsx` component that:

- Makes a GET request to `https://jsonplaceholder.typicode.com/users` using **Axios**.
- Shows the array of users in the console.

<details><summary>Show solution</summary>

```js
import axios from "axios";

function UsersList() {
  const loadUsers = async () => {
    const response = await axios.get(
      "https://jsonplaceholder.typicode.com/users"
    );
    console.log(response.data);
  };

  loadUsers();

  return <p>Check console</p>;
}

export default UsersList;
```

</details>

---

## **Exercise 2: GET with `useEffect` (only on mount)**

Modify the previous exercise so that the request:

- Runs **only when the component mounts**.

<details><summary>Show solution</summary>

```js
import { useEffect } from "react";
import axios from "axios";

function UsersList() {
  useEffect(() => {
    const loadUsers = async () => {
      const response = await axios.get(
        "https://jsonplaceholder.typicode.com/users"
      );
      console.log(response.data);
    };

    loadUsers();
  }, []);

  return <p>Check console</p>;
}

export default UsersList;
```

</details>

---

## **Exercise 3: Store data in state**

Create a `PostsList.jsx` component that:

- Makes a GET request to `https://jsonplaceholder.typicode.com/posts`.
- Stores the data in a `posts` state.
- Shows the total number of posts.

<details><summary>Show solution</summary>

```js
import { useEffect, useState } from "react";
import axios from "axios";

function PostsList() {
  const [posts, setPosts] = useState([]);

  useEffect(() => {
    const loadPosts = async () => {
      const response = await axios.get(
        "https://jsonplaceholder.typicode.com/posts"
      );
      setPosts(response.data);
    };

    loadPosts();
  }, []);

  return <p>Posts: {posts.length}</p>;
}

export default PostsList;
```

</details>

---

## **Exercise 4: Loading state (`loading`)**

Extend the previous exercise:

- Add an `isLoading` state.
- Show `Loading...` while the data is loading.

<details><summary>Show solution</summary>

```js
import { useEffect, useState } from "react";
import axios from "axios";

function PostsList() {
  const [posts, setPosts] = useState([]);
  const [isLoading, setIsLoading] = useState(false);

  useEffect(() => {
    const loadPosts = async () => {
      setIsLoading(true);
      const response = await axios.get(
        "https://jsonplaceholder.typicode.com/posts"
      );
      setPosts(response.data);
      setIsLoading(false);
    };

    loadPosts();
  }, []);

  if (isLoading) return <p>Loading...</p>;

  return <p>Posts: {posts.length}</p>;
}

export default PostsList;
```

</details>

---

## **Exercise 5: Error handling**

Create a `BrokenRequest.jsx` component that:

- Makes a GET request to an incorrect URL.
- Catches the error with `try/catch`.
- Shows `Error: ...` if it fails.

<details><summary>Show solution</summary>

```js
import { useEffect, useState } from "react";
import axios from "axios";

function BrokenRequest() {
  const [error, setError] = useState(null);

  useEffect(() => {
    const run = async () => {
      try {
        await axios.get("https://jsonplaceholder.typicode.com/wrong-url");
      } catch (err) {
        setError(err.message);
      }
    };

    run();
  }, []);

  if (error) return <p>Error: {error}</p>;

  return <p>No error</p>;
}

export default BrokenRequest;
```

</details>

---

## **Exercise 6: `finally` to turn off loading**

Refactor exercise 4 so that:

- `isLoading` is turned off using `finally`.

<details><summary>Show solution</summary>

```js
useEffect(() => {
  const loadPosts = async () => {
    try {
      setIsLoading(true);
      const response = await axios.get(
        "https://jsonplaceholder.typicode.com/posts"
      );
      setPosts(response.data);
    } finally {
      setIsLoading(false);
    }
  };

  loadPosts();
}, []);
```

</details>

---

## **Exercise 7: POST with Axios**

Create a `createPost` function that:

- Makes a POST request to `https://jsonplaceholder.typicode.com/posts`.
- Sends `{ title: "Hello", body: "World", userId: 1 }`.

<details><summary>Show solution</summary>

```js
import axios from "axios";

const createPost = async () => {
  const payload = { title: "Hello", body: "World", userId: 1 };

  const response = await axios.post(
    "https://jsonplaceholder.typicode.com/posts",
    payload
  );

  console.log(response.data);
};
```

</details>

---

## **Exercise 8: Axios with a `useEffect` dependency**

Create a `UserById.jsx` component that:

- Has a `userId` state with initial value `1`.
- Makes a GET request to `/users/{userId}` every time `userId` changes.

<details><summary>Show solution</summary>

```js
import { useEffect, useState } from "react";
import axios from "axios";

function UserById() {
  const [userId, setUserId] = useState(1);
  const [user, setUser] = useState(null);

  useEffect(() => {
    const loadUser = async () => {
      const response = await axios.get(
        `https://jsonplaceholder.typicode.com/users/${userId}`
      );
      setUser(response.data);
    };

    loadUser();
  }, [userId]);

  return (
    <div>
      <button onClick={() => setUserId((id) => id + 1)}>Next</button>
      <p>User: {user ? user.name : "-"}</p>
    </div>
  );
}

export default UserById;
```

</details>

---

## **Exercise 9: Create an Axios instance**

Create an `api.js` file that:

- Uses `axios.create`.
- Sets `baseURL` to `https://jsonplaceholder.typicode.com`.

<details><summary>Show solution</summary>

```js
import axios from "axios";

const api = axios.create({
  baseURL: "https://jsonplaceholder.typicode.com",
});

export default api;
```

</details>

---

## **Exercise 10: Use the Axios instance**

Use the instance from the previous exercise to:

- Make a GET request to `/todos`.
- Show how many todos there are.

<details><summary>Show solution</summary>

```js
import { useEffect, useState } from "react";
import api from "./api";

function TodosCount() {
  const [todos, setTodos] = useState([]);

  useEffect(() => {
    const loadTodos = async () => {
      const response = await api.get("/todos");
      setTodos(response.data);
    };

    loadTodos();
  }, []);

  return <p>Todos: {todos.length}</p>;
}

export default TodosCount;
```

</details>
