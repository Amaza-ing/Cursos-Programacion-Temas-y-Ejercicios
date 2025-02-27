# **Ejercicios - Tema 12: Peticiones a una API con `fetch()`**

A continuación, encontrarás 5 ejercicios prácticos sobre cómo hacer peticiones HTTP utilizando `fetch()` en JavaScript.

Intenta resolverlos antes de consultar la solución.

---

### **Ejercicio 1: Hacer una petición `GET` a una API pública**

Realiza una petición `GET` a la API `https://jsonplaceholder.typicode.com/users/3` y muestra el nombre del usuario en la consola.

<details><summary>Mostrar solución</summary>

```js
fetch("https://jsonplaceholder.typicode.com/users/3")
  .then((response) => response.json())
  .then((data) => console.log("Nombre del usuario:", data.name))
  .catch((error) => console.error("Error al obtener los datos", error));
```

</details>

---

### **Ejercicio 2: Hacer una petición `POST` para crear un nuevo usuario**

Crea una función `createUser` que haga una petición `POST` a `https://jsonplaceholder.typicode.com/users` enviando un objeto con `name` y `email`. Muestra la respuesta en la consola.

<details><summary>Mostrar solución</summary>

```js
async function createUser() {
  try {
    const response = await fetch("https://jsonplaceholder.typicode.com/users", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        name: "María Pérez",
        email: "maria@example.com",
      }),
    });
    const data = await response.json();
    console.log("Usuario creado:", data);
  } catch (error) {
    console.error("Error al crear usuario", error);
  }
}

createUser();
```

</details>

---

### **Ejercicio 3: Actualizar información de un post con `PUT`**

Crea una función `updatePost` que haga una petición `PUT` a `https://jsonplaceholder.typicode.com/posts/2`, modificando el título y el contenido del post.

<details><summary>Mostrar solución</summary>

```js
async function updatePost() {
  try {
    const response = await fetch(
      "https://jsonplaceholder.typicode.com/posts/2",
      {
        method: "PUT",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          title: "Título actualizado",
          body: "Nuevo contenido del post",
          userId: 1,
        }),
      }
    );
    const data = await response.json();
    console.log("Post actualizado:", data);
  } catch (error) {
    console.error("Error al actualizar post", error);
  }
}

updatePost();
```

</details>

---

### **Ejercicio 4: Modificar parcialmente un post con `PATCH`**

Crea una función `modifyPostTitle` que haga una petición `PATCH` a `https://jsonplaceholder.typicode.com/posts/3`, modificando solo el título.

<details><summary>Mostrar solución</summary>

```js
async function modifyPostTitle() {
  try {
    const response = await fetch(
      "https://jsonplaceholder.typicode.com/posts/3",
      {
        method: "PATCH",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ title: "Nuevo título" }),
      }
    );
    const data = await response.json();
    console.log("Título modificado:", data);
  } catch (error) {
    console.error("Error al modificar título", error);
  }
}

modifyPostTitle();
```

</details>

---

### **Ejercicio 5: Eliminar un usuario con `DELETE`**

Crea una función `deleteUser` que haga una petición `DELETE` a `https://jsonplaceholder.typicode.com/users/5` y muestre un mensaje en la consola confirmando la eliminación.

<details><summary>Mostrar solución</summary>

```js
async function deleteUser() {
  try {
    const response = await fetch(
      "https://jsonplaceholder.typicode.com/users/5",
      {
        method: "DELETE",
      }
    );
    if (response.ok) {
      console.log("Usuario eliminado correctamente");
    }
  } catch (error) {
    console.error("Error al eliminar usuario", error);
  }
}

deleteUser();
```

</details>
