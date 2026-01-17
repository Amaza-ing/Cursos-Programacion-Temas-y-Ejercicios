# **Ejercicios - Tema 23: Users, Fetch y Context**

A continuación, encontrarás **10 ejercicios prácticos** para trabajar la gestión de usuarios combinando **Context**, **Fetch** y consumo global de datos.

Intenta resolverlos antes de consultar la solución.

---

## **Ejercicio 1: Crear `UsersContext`**

Crea un archivo `UsersContext.jsx` que:

- Use `createContext`.
- Exporte el contexto por defecto.

<details><summary>Mostrar Solución</summary>

```js
import { createContext } from "react";

const UsersContext = createContext();

export default UsersContext;
```

</details>

---

## **Ejercicio 2: Crear `UsersProvider` con estado**

Crea `UsersProvider.jsx` que tenga:

- Estado `users` inicial `[]`.
- Estado `isLoading`.
- Estado `error`.

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 3: Fetch de usuarios en el Provider**

Amplía `UsersProvider` para que:

- Haga fetch a `https://jsonplaceholder.typicode.com/users`.
- Se ejecute al montar.
- Guarde los usuarios en estado.

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 4: Manejar errores en el fetch**

Añade manejo de errores al fetch usando `try/catch`.

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 5: Envolver la app con `UsersProvider`**

Envuelve tu aplicación con `UsersProvider` en `App.jsx` o `main.jsx`.

<details><summary>Mostrar Solución</summary>

```js
<UsersProvider>
  <App />
</UsersProvider>
```

</details>

---

## **Ejercicio 6: Consumir usuarios desde Context**

Crea `UsersList.jsx` que:

- Use `useContext(UsersContext)`.
- Muestre `Loading...`, `Error` o la lista de usuarios.

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 7: Añadir una función al Context**

Amplía el Context para incluir una función `addUser`.

<details><summary>Mostrar Solución</summary>

```js
const addUser = (newUser) => {
  setUsers((prev) => [...prev, newUser]);
};

<UsersContext.Provider value={{ users, addUser }}>
```

</details>

---

## **Ejercicio 8: Usar la función del Context**

Crea un componente `AddUser.jsx` que:

- Use `addUser` desde el Context.
- Añada un usuario ficticio al pulsar un botón.

<details><summary>Mostrar Solución</summary>

```js
const newUser = { id: Date.now(), name: "New user" };
addUser(newUser);
```

</details>

---

## **Ejercicio 9: Detalle de usuario sin nuevo fetch**

Crea `UserDetail.jsx` que:

- Lea `id` desde `useParams`.
- Busque el usuario en `users` del Context.
- Muestre su nombre.

<details><summary>Mostrar Solución</summary>

```js
const user = users.find((u) => u.id === Number(id));
```

</details>

---

## **Ejercicio 10: Ventajas de Fetch + Context**

Explica dos ventajas de hacer el fetch dentro del Provider.

<details><summary>Mostrar Solución</summary>

- El fetch se realiza una sola vez.
- Los datos se comparten globalmente sin repetir lógica.

</details>
