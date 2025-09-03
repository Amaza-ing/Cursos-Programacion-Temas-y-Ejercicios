# **Ejercicios - Tema 12: Fetch a una API usando async/await**

A continuación, encontrarás 4 ejercicios prácticos sobre cómo hacer peticiones a una API externa usando `fetch` y `async/await` en Vue.

Intenta resolverlos antes de consultar la solución.

---

## **Ejercicio 1: Obtener y mostrar una lista de usuarios**

Crea un componente `UserList.vue` que haga una petición a `https://jsonplaceholder.typicode.com/users` al montarse, y muestre el nombre de cada usuario en una lista.

<details><summary>Mostrar Solución</summary>

`UserList.vue`

```vue
<script setup>
import { ref, onMounted } from "vue";

const users = ref([]);

async function fetchUsers() {
  const response = await fetch("https://jsonplaceholder.typicode.com/users");
  users.value = await response.json();
}

onMounted(() => {
  fetchUsers();
});
</script>

<template>
  <ul>
    <li v-for="user in users" :key="user.id">{{ user.name }}</li>
  </ul>
</template>

<style scoped>
ul {
  padding: 0;
  list-style: none;
}
</style>
```

</details>

---

## **Ejercicio 2: Mostrar estado de carga mientras se obtienen posts**

Crea un componente `PostLoader.vue` que haga un fetch a `https://jsonplaceholder.typicode.com/posts`, y mientras carga, muestre el mensaje "Cargando posts...".

<details><summary>Mostrar Solución</summary>

`PostLoader.vue`

```vue
<script setup>
import { ref, onMounted } from "vue";

const posts = ref([]);
const isLoading = ref(true);

async function fetchPosts() {
  const response = await fetch("https://jsonplaceholder.typicode.com/posts");
  posts.value = await response.json();
  isLoading.value = false;
}

onMounted(fetchPosts);
</script>

<template>
  <div>
    <p v-if="isLoading">Cargando posts...</p>
    <ul v-else>
      <li v-for="post in posts" :key="post.id">{{ post.title }}</li>
    </ul>
  </div>
</template>

<style scoped>
ul {
  padding: 0;
  list-style: none;
}
</style>
```

</details>

---

## **Ejercicio 3: Manejar errores al obtener datos de una API**

Crea un componente `ErrorHandler.vue` que intente hacer fetch a `https://api.fakeurl.com/data`, y si falla, muestre un mensaje de error.

<details><summary>Mostrar Solución</summary>

`ErrorHandler.vue`

```vue
<script setup>
import { ref, onMounted } from "vue";

const data = ref(null);
const error = ref(null);

async function fetchData() {
  try {
    const response = await fetch("https://api.fakeurl.com/data");
    if (!response.ok) {
      throw new Error("Error al cargar los datos");
    }
    data.value = await response.json();
  } catch (err) {
    error.value = err.message;
  }
}

onMounted(fetchData);
</script>

<template>
  <div>
    <p v-if="error" class="error">{{ error }}</p>
    <p v-else-if="data">Datos cargados correctamente</p>
  </div>
</template>

<style scoped>
.error {
  color: red;
}
</style>
```

</details>

---

## **Ejercicio 4: Botón para refrescar datos manualmente**

Crea un componente `RefreshableList.vue` que obtenga una lista de posts al montarse y tenga un botón para volver a hacer el fetch.

<details><summary>Mostrar Solución</summary>

`RefreshableList.vue`

```vue
<script setup>
import { ref, onMounted } from "vue";

const posts = ref([]);

async function fetchPosts() {
  const response = await fetch(
    "https://jsonplaceholder.typicode.com/posts?_limit=5",
  );
  posts.value = await response.json();
}

onMounted(fetchPosts);
</script>

<template>
  <div>
    <button @click="fetchPosts">Refrescar</button>
    <ul>
      <li v-for="post in posts" :key="post.id">{{ post.title }}</li>
    </ul>
  </div>
</template>

<style scoped>
button {
  margin-bottom: 10px;
}
</style>
```

</details>
