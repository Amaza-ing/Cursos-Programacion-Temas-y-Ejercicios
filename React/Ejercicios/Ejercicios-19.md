# **Ejercicios - Tema 19: Rutas Paramétricas**

A continuación, encontrarás **10 ejercicios prácticos** para trabajar con rutas dinámicas en React Router usando `:params` y `useParams`.

Intenta resolverlos antes de consultar la solución.

---

## **Ejercicio 1: Crear una ruta paramétrica**

En `App.jsx`, crea una ruta paramétrica para mostrar el detalle de un usuario:

- Ruta: `/users/:id`
- Componente: `UserDetail.jsx`

<details><summary>Mostrar Solución</summary>

```js
import { Routes, Route } from "react-router-dom";
import UserDetail from "./pages/UserDetail";

function App() {
  return (
    <Routes>
      <Route path="/users/:id" element={<UserDetail />} />
    </Routes>
  );
}

export default App;
```

</details>

---

## **Ejercicio 2: Leer el parámetro con `useParams`**

En `UserDetail.jsx`:

- Lee el parámetro `id` usando `useParams`.
- Muestra un `p` con: **"User id: X"**.

<details><summary>Mostrar Solución</summary>

```js
import { useParams } from "react-router-dom";

function UserDetail() {
  const { id } = useParams();

  return <p>User id: {id}</p>;
}

export default UserDetail;
```

</details>

---

## **Ejercicio 3: Crear enlaces hacia rutas paramétricas**

Crea un componente `UsersLinks.jsx` que muestre una lista con enlaces a:

- `/users/1`
- `/users/2`
- `/users/3`

Usa `Link`.

<details><summary>Mostrar Solución</summary>

```js
import { Link } from "react-router-dom";

function UsersLinks() {
  return (
    <ul>
      <li>
        <Link to="/users/1">User 1</Link>
      </li>
      <li>
        <Link to="/users/2">User 2</Link>
      </li>
      <li>
        <Link to="/users/3">User 3</Link>
      </li>
    </ul>
  );
}

export default UsersLinks;
```

</details>

---

## **Ejercicio 4: Cargar datos con Axios usando el parámetro**

En `UserDetail.jsx`:

- Usa Axios para hacer GET a:

  - `https://jsonplaceholder.typicode.com/users/{id}`

- Guarda el usuario en estado.
- Muestra el nombre del usuario.

<details><summary>Mostrar Solución</summary>

```js
import { useEffect, useState } from "react";
import { useParams } from "react-router-dom";
import axios from "axios";

function UserDetail() {
  const { id } = useParams();
  const [user, setUser] = useState(null);

  useEffect(() => {
    const loadUser = async () => {
      const response = await axios.get(
        `https://jsonplaceholder.typicode.com/users/${id}`
      );
      setUser(response.data);
    };

    loadUser();
  }, [id]);

  if (!user) return <p>Loading...</p>;

  return <h2>{user.name}</h2>;
}

export default UserDetail;
```

</details>

---

## **Ejercicio 5: Añadir `loading` y `error`**

Amplía el ejercicio anterior para incluir:

- `isLoading`
- `error`

Comportamiento:

- Muestra `Loading...` mientras carga.
- Si falla, muestra `Error: ...`.

<details><summary>Mostrar Solución</summary>

```js
import { useEffect, useState } from "react";
import { useParams } from "react-router-dom";
import axios from "axios";

function UserDetail() {
  const { id } = useParams();
  const [user, setUser] = useState(null);
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState(null);

  useEffect(() => {
    const loadUser = async () => {
      try {
        setIsLoading(true);
        setError(null);

        const response = await axios.get(
          `https://jsonplaceholder.typicode.com/users/${id}`
        );

        setUser(response.data);
      } catch (err) {
        setError(err.message);
      } finally {
        setIsLoading(false);
      }
    };

    loadUser();
  }, [id]);

  if (isLoading) return <p>Loading...</p>;
  if (error) return <p>Error: {error}</p>;
  if (!user) return <p>No user</p>;

  return <h2>{user.name}</h2>;
}

export default UserDetail;
```

</details>

---

## **Ejercicio 6: Parámetro como número**

En `UserDetail.jsx`:

- Convierte `id` a número.
- Muestra un `p` con: **"Numeric id: X"**.

<details><summary>Mostrar Solución</summary>

```js
const numericId = Number(id);

return <p>Numeric id: {numericId}</p>;
```

</details>

---

## **Ejercicio 7: Ruta con dos parámetros**

Crea una ruta:

- `/posts/:postId/comments/:commentId`

Y un componente `CommentDetail.jsx` que muestre ambos valores.

<details><summary>Mostrar Solución</summary>

```js
<Route path="/posts/:postId/comments/:commentId" element={<CommentDetail />} />
```

```js
import { useParams } from "react-router-dom";

function CommentDetail() {
  const { postId, commentId } = useParams();

  return (
    <p>
      Post: {postId} | Comment: {commentId}
    </p>
  );
}

export default CommentDetail;
```

</details>

---

## **Ejercicio 8: Generar links dinámicos desde un array**

Crea un componente `ProductsLinks.jsx` con este array:

```js
const products = [
  { id: 10, name: "Keyboard" },
  { id: 11, name: "Mouse" },
  { id: 12, name: "Monitor" },
];
```

- Renderiza un `ul`.
- Usa `.map()` para crear enlaces a `/products/{id}`.

<details><summary>Mostrar Solución</summary>

```js
import { Link } from "react-router-dom";

function ProductsLinks() {
  const products = [
    { id: 10, name: "Keyboard" },
    { id: 11, name: "Mouse" },
    { id: 12, name: "Monitor" },
  ];

  return (
    <ul>
      {products.map((product) => (
        <li key={product.id}>
          <Link to={`/products/${product.id}`}>{product.name}</Link>
        </li>
      ))}
    </ul>
  );
}

export default ProductsLinks;
```

</details>

---

## **Ejercicio 9: Botón para volver atrás**

En una página de detalle, crea un botón **Back** que vuelva a la página anterior usando `useNavigate`.

<details><summary>Mostrar Solución</summary>

```js
import { useNavigate } from "react-router-dom";

const navigate = useNavigate();

<button onClick={() => navigate(-1)}>Back</button>;
```

</details>

---

## **Ejercicio 10: 404 para rutas de detalle inexistentes**

Configura una ruta `*` que muestre `NotFound`.

- Asegúrate de que si el usuario entra a `/users/9999` (o una ruta no definida), la app no se rompa.

<details><summary>Mostrar Solución</summary>

```js
import NotFound from "./pages/NotFound";

<Route path="*" element={<NotFound />} />;
```

</details>
