# **Ejercicios - Tema 15: Fetch API**

A continuación, encontrarás **10 ejercicios prácticos** para trabajar con **Fetch API** en React, combinándolo con `useEffect` y manejo de estados (`loading`, `error`, `data`).

Intenta resolverlos antes de consultar la solución.

---

## **Ejercicio 1: GET básico con estados (lista de títulos)**

Crea un componente `PostsTitles.jsx` que:

- Haga un GET a: `https://jsonplaceholder.typicode.com/posts`
- Guarde la respuesta en estado `posts`.
- Use `isLoading` y `error`.
- Renderice solo los **primeros 5 títulos** (`post.title`) en una lista.

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 2: `response.ok` obligatorio**

Completa este componente para que lance error si la respuesta no es OK:

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

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 3: Manejo de error (simular 404)**

Crea un componente `BrokenRequest.jsx` que haga un fetch a una URL incorrecta (por ejemplo: `https://jsonplaceholder.typicode.com/invalid-route`).

- Debe mostrar `Loading...` mientras carga.
- Si falla, debe mostrar: `Error: ...`.

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 4: Convertir `.then()` a `async/await`**

Reescribe este código usando `async/await` dentro de `useEffect`:

```js
useEffect(() => {
  fetch("https://jsonplaceholder.typicode.com/todos")
    .then((res) => res.json())
    .then((data) => setTodos(data));
}, []);
```

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 5: Evitar `setState` si se desmonta (ignore flag)**

Crea un componente `SafeAlbums.jsx` que:

- Haga fetch a `https://jsonplaceholder.typicode.com/albums`.
- Use un flag `shouldIgnore` para evitar `setAlbums(data)` si el componente se desmonta.
- Renderice `p` con: `Albums: X`.

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 6: `finally` para asegurar que loading se apaga**

Crea un componente `TodosCount.jsx` que:

- Haga GET a `https://jsonplaceholder.typicode.com/todos`.
- Muestre `Loading...` mientras carga.
- Use `try/catch/finally` para garantizar `setIsLoading(false)`.
- Al terminar, muestre `Todos: X`.

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 7: Fetch dependiente de estado (cambia el id)**

Crea un componente `UserById.jsx` con:

- Estado `userId` inicial `1`.
- Un botón **Next** que aumente `userId`.
- Un `useEffect` que haga fetch a:

  - `https://jsonplaceholder.typicode.com/users/{userId}`

- Renderiza el nombre del usuario.

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 8: POST (simulación) con JSON**

Crea una función `createPost` que haga un POST a:

- `https://jsonplaceholder.typicode.com/posts`

Enviando:

```js
{ title: "Hello", body: "World", userId: 1 }
```

Debes incluir:

- `method: "POST"`
- `headers` con `Content-Type`
- `body` con `JSON.stringify(...)`

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 9: Mostrar estados en el JSX (3 casos)**

Escribe el patrón de renderizado para:

- loading
- error
- success

En este orden, usando returns tempranos.

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 10: Corregir `useEffect` con async directo**

Este código es una mala práctica. Reescríbelo con el patrón recomendado:

```js
useEffect(async () => {
  const response = await fetch("https://jsonplaceholder.typicode.com/users");
  const data = await response.json();
  setUsers(data);
}, []);
```

<details><summary>Mostrar Solución</summary>

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
