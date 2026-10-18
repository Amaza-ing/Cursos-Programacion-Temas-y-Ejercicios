# **Exercises - Topic 16: Axios**

Below you will find **10 practical exercises** to work with **Axios in React**, using `useEffect`, state management and HTTP requests.

Try to solve them before consulting the solution.

---

## **Exercise 1: Basic GET with Axios**

Create an `UsersList.jsx` component that:

- Make a GET request to `https://jsonplaceholder.typicode.com/users` using **Axios**.
- Show the user array in the console.

<details><summary>Show Solution</summary>

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

## **Exercise 2: GET with `useEffect` (only when mounting)**

Modify the previous exercise so that the request:

- Run **only when mounting** the component.

<details><summary>Show Solution</summary>

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

## **Exercise 3: Save data in state**

Create an `PostsList.jsx` component that:

- GET `https://jsonplaceholder.typicode.com/posts`.
- Save data in `posts` state.
- Show the total number of posts.

<details><summary>Show Solution</summary>

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

## **Exercise 4: Loading status (`loading`)**

Expand the previous exercise:

- Add `isLoading` status.
- Shows `Loading...` while data is loading.

<details><summary>Show Solution</summary>

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

## **Exercise 5: Error Handling**

Create an `BrokenRequest.jsx` component that:

- Make a GET request to an incorrect URL.
- Capture the error with `try/catch`.
- Show `Error: ...` if it fails.

<details><summary>Show Solution</summary>

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

<details><summary>Show Solution</summary>

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

Create a function `createPost` that:

- Make a POST to `https://jsonplaceholder.typicode.com/posts`.
- Send `{ title: "Hello", body: "World", userId: 1 }`.

<details><summary>Show Solution</summary>

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

## **Exercise 8: Axios with dependency on `useEffect`**

Create an `UserById.jsx` component that:

- Have initial status `userId` `1`.
- Do GET to `/users/{userId}` every time you change `userId`.

<details><summary>Show Solution</summary>

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

- Use `axios.create`.
- Set `baseURL` to `https://jsonplaceholder.typicode.com`.

<details><summary>Show Solution</summary>

```js
import axios from "axios";

const api = axios.create({
  baseURL: "https://jsonplaceholder.typicode.com",
});

export default api;
```

</details>

---

## **Exercise 10: Using the Axios instance**

Use the instance from the previous exercise to:

- Make GET to `/todos`.
- Show how many all there are.

<details><summary>Show Solution</summary>

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
