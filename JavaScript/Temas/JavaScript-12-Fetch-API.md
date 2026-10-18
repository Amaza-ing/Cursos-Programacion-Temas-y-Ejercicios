# **Topic 12: API requests with `fetch()` in JavaScript**

## **1. Introduction**

JavaScript lets you make HTTP requests to servers and external APIs using the `fetch()` function. This method lets us get data asynchronously and work with it in our code.

---

## **2. What is `fetch()`?**

`fetch()` is a function built into JavaScript that lets you make HTTP requests easily and returns a **promise** that resolves with the server's response.

To get the data we need from this response, we have to transform it with the `.json()` function, which returns another promise, so a request to an API using `fetch()` typically looks like this:

### **Basic syntax**

```js
fetch(url)
  .then((response) => response.json())
  .then((data) => console.log(data))
  .catch((error) => console.error("Error en la petición", error));
```

### **Example of a request to a public API**

```js
fetch("https://jsonplaceholder.typicode.com/users/1")
  .then((response) => response.json())
  .then((data) => console.log(data))
  .catch((error) => console.error("Error al obtener datos", error));
```

---

[![fetch()](https://img.youtube.com/vi/u3-jOnxJTdY/0.jpg)](https://www.youtube.com/watch?v=u3-jOnxJTdY&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

## **3. Making a GET request with `async/await`**

We can also use `async/await` to make the code cleaner and more structured.

```js
async function fetchPost() {
  try {
    const response = await fetch(
      "https://jsonplaceholder.typicode.com/users/1",
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

## **4. Sending data with a POST request**

To send data to an API, we can make a POST request and add a body (`body`) in JSON format.

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

## **5. Other HTTP requests (`PUT`, `PATCH`, `DELETE`)**

### **5.1. Updating a post with `PUT`**

`PUT` completely replaces an existing resource.

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
      },
    );
    const data = await response.json();
    console.log("Usuario actualizado:", data);
  } catch (error) {
    console.error("Error al actualizar el usuario", error);
  }
}

updateUser();
```

### **5.2. Partial updates with `PATCH`**

`PATCH` lets you modify just some properties of a resource without replacing it completely.

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
      },
    );
    const data = await response.json();
    console.log("Usuario modificado:", data);
  } catch (error) {
    console.error("Error al modificar el usuario", error);
  }
}

patchUser();
```

### **5.3. Deleting a resource with `DELETE`**

```js
async function deleteUser() {
  try {
    const response = await fetch(
      "https://jsonplaceholder.typicode.com/users/1",
      {
        method: "DELETE",
      },
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

## **6. Error handling in `fetch()`**

The `fetch()` method **doesn't automatically throw an error** if the server responds with an error code (such as 404 or 500). You need to handle this manually.

```js
async function fetchWithErrorHandling() {
  try {
    const response = await fetch(
      "https://jsonplaceholder.typicode.com/invalid-url",
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

## **7. Conclusion**

- `fetch()` is the standard way to make HTTP requests in JavaScript.
- You can make `GET`, `POST`, `PUT`, `PATCH` and `DELETE` requests.
- `async/await` lets you write clearer, more manageable code.
- It's important to handle errors properly to avoid unexpected failures.

In the next topic, we'll explore how to select, manipulate and create elements in the DOM to build dynamic web pages.
