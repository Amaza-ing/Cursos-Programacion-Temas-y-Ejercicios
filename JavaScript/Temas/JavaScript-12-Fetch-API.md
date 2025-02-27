# **Tema 12: Peticiones a una API con `fetch()` en JavaScript**

## **1. Introducción**

JavaScript permite realizar peticiones HTTP a servidores y APIs externas utilizando la función `fetch()`. Este método nos permite obtener datos de manera asincrónica y trabajar con ellos en nuestro código.

---

## **2. ¿Qué es `fetch()`?**

`fetch()` es una función integrada en JavaScript que permite hacer peticiones HTTP de manera sencilla y devuelve una **promesa** que se resuelve con la respuesta del servidor.

Para poder obtener los datos que necesitamos de esta respuesta debemos transformarla a su vez con la función `.json()` que devolverá otra promesa, así que típicamente una petición a una API usando `fetch()` se verá así:

### **Sintaxis básica**

```js
fetch(url)
  .then((response) => response.json())
  .then((data) => console.log(data))
  .catch((error) => console.error("Error en la petición", error));
```

### **Ejemplo de una petición a una API pública**

```js
fetch("https://jsonplaceholder.typicode.com/users/1")
  .then((response) => response.json())
  .then((data) => console.log(data))
  .catch((error) => console.error("Error al obtener datos", error));
```

---

## **3. Realizar una petición GET con `async/await`**

También podemos usar `async/await` para hacer el código más limpio y estructurado.

```js
async function fetchPost() {
  try {
    const response = await fetch(
      "https://jsonplaceholder.typicode.com/users/1"
    );
    const data = await response.json();
    console.log(data);
  } catch (error) {
    console.error("Error en la petición", error);
  }
}

fetchPost();
```

---

## **4. Enviar datos con una petición POST**

Para enviar datos a una API, podemos hacer una petición POST y agregar un cuerpo (`body`) en formato JSON.

```js
async function createUser() {
  try {
    const response = await fetch("https://jsonplaceholder.typicode.com/users", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        name: "Nuevo Nombre",
        email: "Nuevo Email",
      }),
    });
    const data = await response.json();
    console.log("Usuario creado:", data);
  } catch (error) {
    console.error("Error al crear el usuario", error);
  }
}

createUser();
```

---

## **5. Otras peticiones HTTP (`PUT`, `PATCH`, `DELETE`)**

### **5.1. Actualizar un post con `PUT`**

`PUT` reemplaza completamente un recurso existente.

```js
async function updateUser() {
  try {
    const response = await fetch(
      "https://jsonplaceholder.typicode.com/users/1",
      {
        method: "PUT",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          name: "Nombre actualizado",
          email: "Nuevo email",
        }),
      }
    );
    const data = await response.json();
    console.log("Usuario actualizado:", data);
  } catch (error) {
    console.error("Error al actualizar el usuario", error);
  }
}

updateUser();
```

### **5.2. Actualizar parcialmente con `PATCH`**

`PATCH` permite modificar solo algunas propiedades de un recurso sin reemplazarlo por completo.

```js
async function patchUser() {
  try {
    const response = await fetch(
      "https://jsonplaceholder.typicode.com/users/1",
      {
        method: "PATCH",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          name: "Nombre modificado",
        }),
      }
    );
    const data = await response.json();
    console.log("Usuario modificado:", data);
  } catch (error) {
    console.error("Error al modificar el usuario", error);
  }
}

patchUser();
```

### **5.3. Eliminar un recurso con `DELETE`**

```js
async function deleteUser() {
  try {
    const response = await fetch(
      "https://jsonplaceholder.typicode.com/users/1",
      {
        method: "DELETE",
      }
    );
    if (response.ok) {
      console.log("Usuario eliminado correctamente");
    }
  } catch (error) {
    console.error("Error al eliminar el usuario", error);
  }
}

deleteUser();
```

---

## **6. Manejo de Errores en `fetch()`**

El método `fetch()` **no lanza un error automáticamente** si la respuesta del servidor es un código de error (como 404 o 500). Es necesario manejar esto manualmente.

```js
async function fetchWithErrorHandling() {
  try {
    const response = await fetch(
      "https://jsonplaceholder.typicode.com/invalid-url"
    );
    if (!response.ok) {
      throw new Error(`HTTP error! Status: ${response.status}`);
    }
    const data = await response.json();
    console.log(data);
  } catch (error) {
    console.error("Error en la petición:", error);
  }
}

fetchWithErrorHandling();
```

---

## **7. Conclusión**

- `fetch()` es la forma estándar de realizar peticiones HTTP en JavaScript.
- Se pueden hacer peticiones `GET`, `POST`, `PUT`, `PATCH` y `DELETE`.
- `async/await` permite escribir código más claro y manejable.
- Es importante manejar errores correctamente para evitar fallos inesperados.

En el próximo tema, exploraremos cómo seleccionar, manipular y crear elementos en el DOM para tener páginas web dinámicas.
