# **Topic 16: Axios**

## **1. Introduction**

In the previous topic you learned how to make HTTP requests using **Fetch API**. Although Fetch is native to the browser, many React projects use an external library called **Axios**, which greatly simplifies the code and error handling.

In this topic you will learn:

- What is Axios and why it is used.
- How to install Axios in a React project.
- How to make **GET** and **POST** requests.
- How to handle typical states: `loading`, `error` and `data`.
- Key differences between **Fetch** and **Axios**.

---

## **2. What is Axios?**

Axios is a library for making HTTP requests based on Promises.

Main advantages over Fetch:

- Automatically convert the response to JSON.
- Automatically throws errors when the answer is not correct (404, 500...).
- Allows you to configure default values ​​(baseURL, headers).
- Shorter and more readable code.

---

## **3. Installing Axios**

In a React project created with Vite or similar:

```bash
npm install axios
```

Then you import it where you need it:

```js
import axios from "axios";
```

---

## **4. Basic GET with Axios**

Simple example of a GET request:

```js
axios.get("https://jsonplaceholder.typicode.com/users").then((response) => {
  console.log(response.data);
});
```

Key points:

- Axios returns an `response` object.
- The data already comes in `response.data`.
- No need to call `.json()`.

---

## **5. GET with `useEffect` and status**

The pattern in React is very similar to what you already know with Fetch.

```js
import { useEffect, useState } from "react";
import axios from "axios";

function Users() {
  const [users, setUsers] = useState([]);
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState(null);

  useEffect(() => {
    const loadUsers = async () => {
      try {
        setIsLoading(true);
        setError(null);

        const response = await axios.get(
          "https://jsonplaceholder.typicode.com/users"
        );

        setUsers(response.data);
      } catch (err) {
        setError(err.message);
      } finally {
        setIsLoading(false);
      }
    };

    loadUsers();
  }, []);

  if (isLoading) return <p>Loading...</p>;
  if (error) return <p>Error: {error}</p>;

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

## **6. Error Handling in Axios**

Unlike Fetch:

- Axios **automatically throws error** if the status is not 2xx.
- You don't need to check `response.ok`.

That's why this code is enough:

```js
try {
  const response = await axios.get(url);
} catch (err) {
  console.log(err.message);
}
```

---

## **7. POST with Axios**

For sending data, Axios is more direct than Fetch.

```js
const createUser = async () => {
  const newUser = {
    name: "Alex",
    email: "alex@mail.com",
  };

  const response = await axios.post(
    "https://jsonplaceholder.typicode.com/users",
    newUser
  );

  return response.data;
};
```

Note that:

- You don't need `JSON.stringify`.
- You don't need to manually configure headers for JSON (Axios does it for you).

---

## **8. Set up an Axios instance (optional but common)**

In medium or large projects it is common to create an instance:

```js
import axios from "axios";

const api = axios.create({
  baseURL: "https://jsonplaceholder.typicode.com",
});

export default api;
```

Then you use it like this:

```js
import api from "./api";

const response = await api.get("/users");
```

Advantages:

- Do not repeat the base URL.
- You can configure common headers.

---

## **9. Quick Comparison: Fetch vs Axios**

| Fetch | Axios |
| -------------------------- | --------------------------- |
| Browser Native | External library |
| Need `response.json()` | automatic JSON |
| Does not throw error at 404/500 | Automatically throws error |
| More verbose | Cleaner |

Both are valid, but Axios is often preferred in real projects.

---

## **10. Good practices**

- Keep `data`, `isLoading` and `error` separate.
- Use `try / catch / finally`.
- Centralize Axios in one instance if the project grows.
- Don't mix UI logic with excessive request logic.

---

[![Axios](https://img.youtube.com/vi/YrHoDmH2CjA/0.jpg)](https://www.youtube.com/watch?v=YrHoDmH2CjA&list=PLzA2VyZwsq_-dE3Jvunglxq8a6UcH6gnF)

---

In the next topic you will learn how to work with **forms in React**, combining them with state and HTTP requests.
