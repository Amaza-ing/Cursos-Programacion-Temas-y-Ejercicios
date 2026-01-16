# **Tema 16: Axios**

## **1. Introducción**

En el tema anterior aprendiste a hacer peticiones HTTP usando **Fetch API**. Aunque Fetch es nativo del navegador, en muchos proyectos de React se utiliza una librería externa llamada **Axios**, que simplifica bastante el código y el manejo de errores.

En este tema aprenderás:

- Qué es Axios y por qué se usa.
- Cómo instalar Axios en un proyecto React.
- Cómo hacer peticiones **GET** y **POST**.
- Cómo manejar estados típicos: `loading`, `error` y `data`.
- Diferencias clave entre **Fetch** y **Axios**.

---

## **2. ¿Qué es Axios?**

Axios es una librería para hacer peticiones HTTP basada en Promises.

Ventajas principales frente a Fetch:

- Convierte automáticamente la respuesta a JSON.
- Lanza errores automáticamente cuando la respuesta no es correcta (404, 500…).
- Permite configurar valores por defecto (baseURL, headers).
- Código más corto y legible.

---

## **3. Instalación de Axios**

En un proyecto React creado con Vite o similar:

```bash
npm install axios
```

Luego lo importas donde lo necesites:

```js
import axios from "axios";
```

---

## **4. GET básico con Axios**

Ejemplo simple de una petición GET:

```js
axios.get("https://jsonplaceholder.typicode.com/users").then((response) => {
  console.log(response.data);
});
```

Puntos clave:

- Axios devuelve un objeto `response`.
- Los datos ya vienen en `response.data`.
- No es necesario llamar a `.json()`.

---

## **5. GET con `useEffect` y estado**

El patrón en React es muy similar al que ya conoces con Fetch.

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

## **6. Manejo de errores en Axios**

A diferencia de Fetch:

- Axios **lanza error automáticamente** si el status no es 2xx.
- No necesitas comprobar `response.ok`.

Por eso este código es suficiente:

```js
try {
  const response = await axios.get(url);
} catch (err) {
  console.log(err.message);
}
```

---

## **7. POST con Axios**

Para enviar datos, Axios es más directo que Fetch.

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

Observa que:

- No necesitas `JSON.stringify`.
- No necesitas configurar headers manualmente para JSON (Axios lo hace por ti).

---

## **8. Configurar una instancia de Axios (opcional pero común)**

En proyectos medianos o grandes es habitual crear una instancia:

```js
import axios from "axios";

const api = axios.create({
  baseURL: "https://jsonplaceholder.typicode.com",
});

export default api;
```

Luego la usas así:

```js
import api from "./api";

const response = await api.get("/users");
```

Ventajas:

- No repites la URL base.
- Puedes configurar headers comunes.

---

## **9. Comparación rápida: Fetch vs Axios**

| Fetch                      | Axios                       |
| -------------------------- | --------------------------- |
| Nativo del navegador       | Librería externa            |
| Necesita `response.json()` | JSON automático             |
| No lanza error en 404/500  | Lanza error automáticamente |
| Más verboso                | Más limpio                  |

Ambos son válidos, pero Axios suele ser preferido en proyectos reales.

---

## **10. Buenas prácticas**

- Mantén separados `data`, `isLoading` y `error`.
- Usa `try / catch / finally`.
- Centraliza Axios en una instancia si el proyecto crece.
- No mezcles lógica de UI con lógica de petición en exceso.

---

En el siguiente tema aprenderás a trabajar con **formularios en React**, combinándolos con estado y peticiones HTTP.
