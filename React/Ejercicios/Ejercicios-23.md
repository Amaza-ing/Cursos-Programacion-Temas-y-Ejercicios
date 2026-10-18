# **Exercises - Topic 23: Users, Fetch and Context**

Below, you will find **10 practical exercises** to work on user management combining **Context**, **Fetch** and global data consumption.

Try to solve them before consulting the solution.

---

## **Exercise 1: Create `UsersContext`**

Create an `UsersContext.jsx` file that:

- Use `createContext`.
- Export the default context.

<details><summary>Show Solution</summary>

```js
import { createContext } from "react";

const UsersContext = createContext();

export default UsersContext;
```

</details>

---

## **Exercise 2: Create `UsersProvider` with state**

Create `UsersProvider.jsx` that has:

- Initial `users` state `[]`.
- `isLoading` status.
- `error` status.

<details><summary>Show Solution</summary>

```js
import { useState } from "react";
import UsersContext from "./UsersContext";

function UsersProvider({ children }) {
  const [users, setUsers] = useState([]);
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState(null);

  return (
    <UsersContext.Provider value={{ users, isLoading, error }}>
      {children}
    </UsersContext.Provider>
  );
}

export default UsersProvider;
```

</details>

---

## **Exercise 3: Fetch users in the Provider**

Extends `UsersProvider` so that:

- Fetch `https://jsonplaceholder.typicode.com/users`.
- Run when mounting.
- Save users in status.

<details><summary>Show Solution</summary>

```js
useEffect(() => {
  const loadUsers = async () => {
    setIsLoading(true);

    const response = await fetch("https://jsonplaceholder.typicode.com/users");
    const data = await response.json();

    setUsers(data);
    setIsLoading(false);
  };

  loadUsers();
}, []);
```

</details>

---

## **Exercise 4: Handle errors in the fetch**

Add error handling to the fetch using `try/catch`.

<details><summary>Show Solution</summary>

```js
try {
  const response = await fetch(url);
  if (!response.ok) throw new Error("Request failed");
  const data = await response.json();
  setUsers(data);
} catch (err) {
  setError(err.message);
}
```

</details>

---

## **Exercise 5: Wrap the app with `UsersProvider`**

Wrap your application with `UsersProvider` in `App.jsx` or `main.jsx`.

<details><summary>Show Solution</summary>

```js
<UsersProvider>
  <App />
</UsersProvider>
```

</details>

---

## **Exercise 6: Consume users from Context**

Create `UsersList.jsx` that:

- Use `useContext(UsersContext)`.
- Show `Loading...`, `Error` or the user list.

<details><summary>Show Solution</summary>

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

</details>

---

## **Exercise 7: Add a function to the Context**

Extends the Context to include an `addUser` function.

<details><summary>Show Solution</summary>

```js
const addUser = (newUser) => {
  setUsers((prev) => [...prev, newUser]);
};

<UsersContext.Provider value={{ users, addUser }}>
```

</details>

---

## **Exercise 8: Use the Context function**

Create an `AddUser.jsx` component that:

- Use `addUser` from the Context.
- Add a dummy user when you press a button.

<details><summary>Show Solution</summary>

```js
const newUser = { id: Date.now(), name: "New user" };
addUser(newUser);
```

</details>

---

## **Exercise 9: User detail without new fetch**

Create `UserDetail.jsx` that:

- Read `id` from `useParams`.
- Find the user in `users` of the Context.
- Show your name.

<details><summary>Show Solution</summary>

```js
const user = users.find((u) => u.id === Number(id));
```

</details>

---

## **Exercise 10: Advantages of Fetch + Context**

Explain two advantages of doing the fetch within the Provider.

<details><summary>Show Solution</summary>

- The fetch is done only once.
- Data is shared globally without repeating logic.

</details>
