# **Topic 23: Users, Fetch and Context**

## **1. Introduction**

In real applications it's very common to combine **users**, **API requests** and **Context**. For example:

- Load users from an API.
- Store them in a global state.
- Access those users from any component.

In this topic you will learn how to:

- Manage users with Context.
- Load data with Fetch (or Axios) inside a Provider.
- Share data and functions globally.
- Keep a clear, scalable architecture.

---

## **2. The problem to solve**

Without Context:

- Each component makes its own fetch.
- Logic gets repeated.
- The state gets fragmented.

With Context:

- The fetch is done **only once**.
- The data is shared.
- Components only consume what they need.

---

## **3. Recommended architecture**

Typical structure:

```txt
src/
 ├─ context/
 │   └─ UsersContext.jsx
 ├─ pages/
 │   ├─ Users.jsx
 │   └─ UserDetail.jsx
 ├─ components/
 │   └─ UsersList.jsx
```

---

## **4. Creating the UsersContext**

We create the context that will share the users.

```js
import { createContext } from "react";

const UsersContext = createContext();

export default UsersContext;
```

---

## **5. Creating the UsersProvider with Fetch**

The Provider is in charge of:

- Making the request to the API.
- Storing the users in state.
- Managing `loading` and `error`.

```js
import { useEffect, useState } from "react";
import UsersContext from "./UsersContext";

function UsersProvider({ children }) {
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
        if (!response.ok) throw new Error("Request failed");

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

  return (
    <UsersContext.Provider value={{ users, isLoading, error }}>
      {children}
    </UsersContext.Provider>
  );
}

export default UsersProvider;
```

---

## **6. Wrapping the app with the Provider**

```js
import UsersProvider from "./context/UsersProvider";

function App() {
  return (
    <UsersProvider>
      <Routes />
    </UsersProvider>
  );
}

export default App;
```

Now any component can access the users.

---

## **7. Consuming users from Context**

Example of a user list:

```js
import { useContext } from "react";
import UsersContext from "../context/UsersContext";

function UsersList() {
  const { users, isLoading, error } = useContext(UsersContext);

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

export default UsersList;
```

---

## **8. Sharing functions in Context**

Context isn't only for data: it's also for functions.

```js
const addUser = (newUser) => {
  setUsers((prevUsers) => [...prevUsers, newUser]);
};

<UsersContext.Provider value={{ users, addUser }}>
```

This lets you modify the global state from any component.

---

## **9. Context + parametric routes (user detail)**

On a detail page:

```js
import { useParams } from "react-router-dom";
import { useContext } from "react";
import UsersContext from "../context/UsersContext";

function UserDetail() {
  const { id } = useParams();
  const { users } = useContext(UsersContext);

  const user = users.find((u) => u.id === Number(id));

  if (!user) return <p>User not found</p>;

  return <h2>{user.name}</h2>;
}

export default UserDetail;
```

There's no need to make a new fetch.

---

## **10. Common mistakes**

### **10.1. Fetching in every component**

It duplicates logic and calls.

### **10.2. A Context that's too large**

Several small contexts are better.

### **10.3. Not handling loading/error**

They should always be there.

---

## **11. Best practices**

- Do the fetch in the Provider.
- Share only what's necessary.
- Split Context by domain (users, auth, settings).
- Keep Providers simple and predictable.

---

[![Context Users Login/Logout](https://img.youtube.com/vi/nJzRGHUBK8o/0.jpg)](https://www.youtube.com/watch?v=nJzRGHUBK8o&list=PLzA2VyZwsq_-dE3Jvunglxq8a6UcH6gnF)

---

[![Fetch & Context](https://img.youtube.com/vi/P3Pt-VuWV4w/0.jpg)](https://www.youtube.com/watch?v=P3Pt-VuWV4w&list=PLzA2VyZwsq_-dE3Jvunglxq8a6UcH6gnF)

---

In the next topic you'll dive into **optimization with React Memo**.
