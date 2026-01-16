# **Tema 15: Fetch API**

## **1. Introducción**

En la mayoría de apps necesitas **pedir datos a una API** (usuarios, productos, posts…).

En React, lo más habitual es:

- Hacer la petición con **Fetch API**.
- Guardar los datos en **estado** con `useState`.
- Ejecutar la petición en un **`useEffect`** (normalmente al montar).

En este tema aprenderás:

- Qué es Fetch y cómo funciona.
- Cómo hacer un **GET**.
- Cómo manejar estados típicos: **loading**, **error** y **data**.
- Cómo cancelar/ignorar respuestas cuando el componente se desmonta.
- Cómo hacer **POST** (básico).

---

## **2. ¿Qué es Fetch API?**

`fetch` es una función del navegador para hacer peticiones HTTP.

- Devuelve una **Promise**.
- Normalmente conviertes la respuesta a JSON con `response.json()`.

Ejemplo básico:

```js
fetch("https://api.example.com/users")
  .then((response) => response.json())
  .then((data) => console.log(data));
```

En React, solemos usar `async/await` porque es más legible.

---

## **3. GET con `useEffect` (al montar)**

Ejemplo completo con estado:

- `data` para guardar la respuesta.
- `isLoading` para loader.
- `error` para fallos.

```js
import { useEffect, useState } from "react";

function Users() {
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

        if (!response.ok) {
          throw new Error("Request failed");
        }

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

  if (isLoading) {
    return <p>Loading...</p>;
  }

  if (error) {
    return <p>Error: {error}</p>;
  }

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

## **4. Por qué usamos `response.ok`**

`fetch` solo lanza error automáticamente si hay un problema de red.

Si el servidor responde con:

- 404
- 500

**no** se lanza un error por defecto. Por eso es buena práctica comprobar:

```js
if (!response.ok) {
  throw new Error("Request failed");
}
```

---

## **5. Evitar actualizar estado si el componente se desmonta**

Un problema común:

- Haces un fetch.
- El usuario cambia de pantalla.
- Llega la respuesta.
- Intentas hacer `setState` en un componente que ya no está.

Una forma simple (patrón de “ignore flag”):

```js
import { useEffect, useState } from "react";

function Posts() {
  const [posts, setPosts] = useState([]);

  useEffect(() => {
    let shouldIgnore = false;

    const loadPosts = async () => {
      const response = await fetch(
        "https://jsonplaceholder.typicode.com/posts"
      );
      const data = await response.json();

      if (!shouldIgnore) {
        setPosts(data);
      }
    };

    loadPosts();

    return () => {
      shouldIgnore = true;
    };
  }, []);

  return (
    <ul>
      {posts.slice(0, 5).map((post) => (
        <li key={post.id}>{post.title}</li>
      ))}
    </ul>
  );
}

export default Posts;
```

> Más adelante verás otras formas (por ejemplo, `AbortController`), pero este patrón ya te protege de muchos casos.

---

## **6. POST básico con Fetch**

Para enviar datos:

- Método `POST`
- Cabecera `Content-Type: application/json`
- `body` con `JSON.stringify(...)`

```js
const createUser = async () => {
  const newUser = { name: "Alex", email: "alex@mail.com" };

  const response = await fetch("https://api.example.com/users", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify(newUser),
  });

  if (!response.ok) {
    throw new Error("Create failed");
  }

  const createdUser = await response.json();
  return createdUser;
};
```

---

## **7. Buenas prácticas**

- Mantén el estado separado: `data`, `isLoading`, `error`.
- Usa `try/catch/finally` para control de errores y loading.
- Comprueba `response.ok`.
- Si el componente puede desmontarse, evita hacer `setState` después (flag o cancelación).
- Mantén la lógica de fetch en funciones (`loadUsers`, `loadPosts`) para que el componente se lea fácil.

---

## **8. A tener en cuenta**

- `fetch` devuelve una Promise.
- `response.json()` también devuelve una Promise.
- Un patrón típico es: `useEffect` + `async function` + estados `loading/error/data`.
- `fetch` no lanza error por HTTP 4xx/5xx a menos que lo compruebes.

---

En el próximo tema veremos **Axios**, una alternativa a Fetch con una API más cómoda para muchos casos.
