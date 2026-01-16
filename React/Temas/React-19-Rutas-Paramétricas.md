# **Tema 19: Rutas Paramétricas**

## **1. Introducción**

En muchas aplicaciones no todas las páginas tienen una URL fija. A menudo necesitas rutas que cambian según un **identificador**: el id de un usuario, de un producto, de un post, etc.

Ejemplos típicos:

- `/users/1`
- `/users/42`
- `/products/10`

Este tipo de rutas se llaman **rutas paramétricas**.

En este tema aprenderás:

- Qué son las rutas paramétricas.
- Cómo definir parámetros en una ruta.
- Cómo leer esos parámetros con `useParams`.
- Cómo usarlos para cargar datos dinámicos.

---

## **2. ¿Qué es una ruta paramétrica?**

Una ruta paramétrica es una ruta que contiene **variables** en la URL.

Ejemplo:

```txt
/users/:id
```

Aquí:

- `:id` es un **parámetro**.
- Su valor depende de la URL real.

Si el usuario entra en:

```txt
/users/5
```

Entonces:

- `id = "5"`

---

## **3. Definir una ruta paramétrica**

Las rutas paramétricas se definen igual que las normales, pero usando `:`.

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

---

## **4. Leer parámetros con `useParams`**

Para acceder a los parámetros de la URL se usa el hook `useParams`.

```js
import { useParams } from "react-router-dom";

function UserDetail() {
  const params = useParams();

  return <p>User id: {params.id}</p>;
}

export default UserDetail;
```

Forma más común usando destructuring:

```js
const { id } = useParams();
```

---

## **5. Ruta paramétrica completa: ejemplo simple**

### **5.1. Página `UserDetail.jsx`**

```js
import { useParams } from "react-router-dom";

function UserDetail() {
  const { id } = useParams();

  return <h2>User detail for id: {id}</h2>;
}

export default UserDetail;
```

### **5.2. Enlace hacia la ruta paramétrica**

```js
import { Link } from "react-router-dom";

function UsersList() {
  return (
    <ul>
      <li>
        <Link to="/users/1">User 1</Link>
      </li>
      <li>
        <Link to="/users/2">User 2</Link>
      </li>
    </ul>
  );
}

export default UsersList;
```

---

## **6. Usar parámetros para cargar datos**

Un uso muy común es combinar rutas paramétricas con peticiones a una API.

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

Clave importante:

- El `useEffect` depende de `id`.

---

## **7. Múltiples parámetros en una ruta**

Una ruta puede tener más de un parámetro:

```txt
/posts/:postId/comments/:commentId
```

```js
const { postId, commentId } = useParams();
```

---

## **8. Parámetros siempre son strings**

Los valores obtenidos con `useParams`:

- Siempre son **strings**.

Si necesitas un número:

```js
const numericId = Number(id);
```

---

## **9. Errores típicos**

### **9.1. Olvidar los dos puntos `:`**

Incorrecto:

```js
<Route path="/users/id" />
```

Correcto:

```js
<Route path="/users/:id" />
```

---

### **9.2. No usar el parámetro en dependencias**

Si usas el parámetro en un `useEffect`, debe estar en el array de dependencias.

---

## **10. Buenas prácticas**

- Usa nombres claros para los parámetros (`id`, `userId`, `productId`).
- Mantén las rutas simples.
- Usa rutas paramétricas solo cuando el contenido sea dinámico.
- Combínalas con APIs para vistas de detalle.

---

En el siguiente tema aprenderás a trabajar con **rutas protegidas**.
