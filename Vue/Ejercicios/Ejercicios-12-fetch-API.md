# **Exercises - Topic 12: Fetch an API using async/await**

Below you'll find 4 practical exercises on making requests to an external API using `fetch` and `async/await` in Vue.

Try to solve them before looking at the solution.

---

## **Exercise 1: Get and display a list of users**

Create a `UserList.vue` component that makes a request to `https://jsonplaceholder.typicode.com/users` when it's mounted, and displays each user's name in a list.

<details><summary>Show solution</summary>

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

## **Exercise 2: Show a loading state while fetching posts**

Create a `PostLoader.vue` component that fetches `https://jsonplaceholder.typicode.com/posts` and, while it's loading, displays the message "Cargando posts..." ("Loading posts...").

<details><summary>Show solution</summary>

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

## **Exercise 3: Handle errors when getting data from an API**

Create an `ErrorHandler.vue` component that tries to fetch `https://api.fakeurl.com/data` and, if it fails, displays an error message.

<details><summary>Show solution</summary>

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

## **Exercise 4: A button to refresh the data manually**

Create a `RefreshableList.vue` component that gets a list of posts when it's mounted and has a button to fetch them again.

<details><summary>Show solution</summary>

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
