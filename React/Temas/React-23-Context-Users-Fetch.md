# **Topic 23: Users, Fetch and Context**

## **1. Introduction**

In real applications it is very common to combine **users**, **API requests** and **Context**. For example:

- Load users from an API.
- Save them in a global state.
- Access those users from any component.

In this topic you will learn to:

- Manage users with Context.
- Load data with Fetch (or Axios) within a Provider.
- Share data and functions globally.
- Maintain a clear and scalable architecture.

---

## **2. Problem to solve**

Without Context:

- Each component makes its own fetch.
- Logic is repeated.
- The state is fragmented.

With Context:

- The fetch is done **only once**.
- Data is shared.
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

## **4. Create the UsersContext**

We create the context that users will share.

```js
import { createContext } from "react";

const UsersContext = createContext();

export default UsersContext;
```

---

## **5. Create the UsersProvider with Fetch**

The Provider is responsible for:

- Make the request to the API.
- Save users in status.
- Manage `loading` and `error`.

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

## **6. Wrap the app with the Provider**

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

Now any component can access users.

---

## **7. Consume users from Context**

Example of user list:

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

## **8. Share functions in Context**

The Context is not only used for data, but also for functions.

```js
const addUser = (newUser) => {
  setUsers((prevUsers) => [...prevUsers, newUser]);
};

<UsersContext.Provider value={{ users, addUser }}>
```

This allows the global state to be modified from any component.

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

There is no need to make a new fetch.

---

## **10. Typical errors**

### **10.1. Fetch each component**

Duplicate logic and calls.

### **10.2. Context too large**

Better several small contexts.

### **10.3. Do not handle loading/error**

They must always exist.

---

## **11. Good practices**

- Do the fetch in the Provider.
- Share only what is necessary.
- Separate Context by domain (users, auth, settings).
- Keep Providers simple and predictable.

---

[![Context Users Login/Logout](https://img.youtube.com/vi/nJzRGHUBK8o/0.jpg)](https://www.youtube.com/watch?v=nJzRGHUBK8o&list=PLzA2VyZwsq_-dE3Jvunglxq8a6UcH6gnF)

---

[![Fetch & Context](https://img.youtube.com/vi/P3Pt-VuWV4w/0.jpg)](https://www.youtube.com/watch?v=P3Pt-VuWV4w&list=PLzA2VyZwsq_-dE3Jvunglxq8a6UcH6gnF)

---

In the next topic you will delve into **optimization with React Memo**.
