# **Exercises - Topic 12: API requests with `fetch()`**

Below you'll find 5 practical exercises on how to make HTTP requests using `fetch()` in JavaScript.

Try to solve them before looking at the solution.

---

### **Exercise 1: Make a `GET` request to a public API**

Make a `GET` request to the `https://jsonplaceholder.typicode.com/users/3` API and display the user's name in the console.

<details><summary>Show solution</summary>

```js
fetch("https://jsonplaceholder.typicode.com/users/3")
  .then((response) => response.json())
  .then((data) => console.log("Nombre del usuario:", data.name))
  .catch((error) => console.error("Error al obtener los datos", error));
```

</details>

---

### **Exercise 2: Make a `POST` request to create a new user**

Create a function `createUser` that makes a `POST` request to `https://jsonplaceholder.typicode.com/users`, sending an object with `name` and `email`. Display the response in the console.

<details><summary>Show solution</summary>

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

### **Exercise 3: Update a post's information with `PUT`**

Create a function `updatePost` that makes a `PUT` request to `https://jsonplaceholder.typicode.com/posts/2`, modifying the title and content of the post.

<details><summary>Show solution</summary>

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
      },
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

### **Exercise 4: Partially modify a post with `PATCH`**

Create a function `modifyPostTitle` that makes a `PATCH` request to `https://jsonplaceholder.typicode.com/posts/3`, modifying only the title.

<details><summary>Show solution</summary>

```js
async function modifyPostTitle() {
  try {
    const response = await fetch(
      "https://jsonplaceholder.typicode.com/posts/3",
      {
        method: "PATCH",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ title: "Nuevo título" }),
      },
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

### **Exercise 5: Delete a user with `DELETE`**

Create a function `deleteUser` that makes a `DELETE` request to `https://jsonplaceholder.typicode.com/users/5` and displays a message in the console confirming the deletion.

<details><summary>Show solution</summary>

```js
async function deleteUser() {
  try {
    const response = await fetch(
      "https://jsonplaceholder.typicode.com/users/5",
      {
        method: "DELETE",
      },
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
