# **Tema 23: Users, Fetch y Context**

## **1. Introducción**

En aplicaciones reales es muy común combinar **usuarios**, **peticiones a APIs** y **Context**. Por ejemplo:

- Cargar usuarios desde una API.
- Guardarlos en un estado global.
- Acceder a esos usuarios desde cualquier componente.

En este tema aprenderás a:

- Gestionar usuarios con Context.
- Cargar datos con Fetch (o Axios) dentro de un Provider.
- Compartir datos y funciones globalmente.
- Mantener una arquitectura clara y escalable.

---

## **2. Problema a resolver**

Sin Context:

- Cada componente hace su propio fetch.
- Se repite lógica.
- El estado se fragmenta.

Con Context:

- El fetch se hace **una sola vez**.
- Los datos se comparten.
- Los componentes solo consumen lo que necesitan.

---

## **3. Arquitectura recomendada**

Estructura típica:

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

## **4. Crear el UsersContext**

Creamos el contexto que compartirá los usuarios.

```js
import { createContext } from "react";

const UsersContext = createContext();

export default UsersContext;
```

---

## **5. Crear el UsersProvider con Fetch**

El Provider se encarga de:

- Hacer la petición a la API.
- Guardar los usuarios en estado.
- Gestionar `loading` y `error`.

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

## **6. Envolver la app con el Provider**

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

Ahora cualquier componente puede acceder a los usuarios.

---

## **7. Consumir usuarios desde Context**

Ejemplo de lista de usuarios:

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

## **8. Compartir funciones en Context**

El Context no solo sirve para datos, también para funciones.

```js
const addUser = (newUser) => {
  setUsers((prevUsers) => [...prevUsers, newUser]);
};

<UsersContext.Provider value={{ users, addUser }}>
```

Esto permite modificar el estado global desde cualquier componente.

---

## **9. Context + rutas paramétricas (detalle de usuario)**

En una página de detalle:

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

No hace falta hacer un nuevo fetch.

---

## **10. Errores típicos**

### **10.1. Hacer fetch en cada componente**

Duplica lógica y llamadas.

### **10.2. Context demasiado grande**

Mejor varios contextos pequeños.

### **10.3. No manejar loading/error**

Siempre deben existir.

---

## **11. Buenas prácticas**

- Haz el fetch en el Provider.
- Comparte solo lo necesario.
- Separa Context por dominio (users, auth, settings).
- Mantén Providers simples y predecibles.

---

[![Context Users Login/Logout](https://img.youtube.com/vi/nJzRGHUBK8o/0.jpg)](https://www.youtube.com/watch?v=nJzRGHUBK8o&list=PLzA2VyZwsq_-dE3Jvunglxq8a6UcH6gnF)

---

[![Fetch & Context](https://img.youtube.com/vi/P3Pt-VuWV4w/0.jpg)](https://www.youtube.com/watch?v=P3Pt-VuWV4w&list=PLzA2VyZwsq_-dE3Jvunglxq8a6UcH6gnF)

---

En el siguiente tema profundizarás en **optimización con React Memo**.
