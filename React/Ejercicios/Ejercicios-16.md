# **Ejercicios - Tema 16: Axios**

Ejercicios - Tema 16: Axios. A continuación, encontrarás **10 ejercicios prácticos** para trabajar con **Axios en React**, usando `useEffect`, manejo de estado y peticiones HTTP.

Intenta resolverlos antes de consultar la solución.

---

## **Ejercicio 1: GET básico con Axios**

Crea un componente `UsersList.jsx` que:

- Haga una petición GET a `https://jsonplaceholder.typicode.com/users` usando **Axios**.
- Muestre en consola el array de usuarios.

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 2: GET con `useEffect` (solo al montar)**

Modifica el ejercicio anterior para que la petición:

- Se ejecute **solo al montar** el componente.

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 3: Guardar datos en estado**

Crea un componente `PostsList.jsx` que:

- Haga GET a `https://jsonplaceholder.typicode.com/posts`.
- Guarde los datos en estado `posts`.
- Muestre el número total de posts.

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 4: Estado de carga (`loading`)**

Amplía el ejercicio anterior:

- Añade estado `isLoading`.
- Muestra `Loading...` mientras se cargan los datos.

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 5: Manejo de errores**

Crea un componente `BrokenRequest.jsx` que:

- Haga una petición GET a una URL incorrecta.
- Capture el error con `try/catch`.
- Muestre `Error: ...` si falla.

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 6: `finally` para apagar loading**

Refactoriza el ejercicio 4 para que:

- `isLoading` se apague usando `finally`.

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 7: POST con Axios**

Crea una función `createPost` que:

- Haga un POST a `https://jsonplaceholder.typicode.com/posts`.
- Envíe `{ title: "Hello", body: "World", userId: 1 }`.

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 8: Axios con dependencia en `useEffect`**

Crea un componente `UserById.jsx` que:

- Tenga estado `userId` inicial `1`.
- Haga GET a `/users/{userId}` cada vez que cambie `userId`.

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 9: Crear una instancia de Axios**

Crea un archivo `api.js` que:

- Use `axios.create`.
- Configure `baseURL` a `https://jsonplaceholder.typicode.com`.

<details><summary>Mostrar Solución</summary>

```js
import axios from "axios";

const api = axios.create({
  baseURL: "https://jsonplaceholder.typicode.com",
});

export default api;
```

</details>

---

## **Ejercicio 10: Usar la instancia de Axios**

Usa la instancia del ejercicio anterior para:

- Hacer GET a `/todos`.
- Mostrar cuántos todos hay.

<details><summary>Mostrar Solución</summary>

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
