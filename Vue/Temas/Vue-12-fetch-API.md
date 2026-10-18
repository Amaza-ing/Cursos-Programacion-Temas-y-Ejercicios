# **Topic 12: Fetch an API in Vue.js using async/await**

## **1. Introduction**

In many web applications it is necessary to obtain data from a server or external API. In Vue.js, the most recommended and modern way to do this is by using `fetch` combined with the `async/await` syntax. This allows you to write clearer, easier-to-read asynchronous code.

In this topic we will learn:

- How to make an HTTP request.
- Where to execute the request within a Vue component.
- How to manage the charging status and possible errors.

---

## **2. fetch basics**

`fetch()` is a native JavaScript function that allows you to make HTTP requests.

Basic example:

```javascript
const response = await fetch("https://jsonplaceholder.typicode.com/posts");
const data = await response.json();
```

`fetch` returns a promise, so we can use `await` to wait for the response and then convert it to JSON with `.json()`.

---

## **3. Where to perform the fetch in a Vue component?**

In a Vue component, requests are usually made when the component is mounted, that is, when the component is already in the DOM. In Vue 3 with Composition API, the most common thing is to do the fetch inside `onMounted()`.

> Note: `onMounted()` is one of the hooks (methods) of the component life cycle. We will see this in the next topic.

```vue
<script setup>
import { ref, onMounted } from "vue";

const posts = ref([]);

async function fetchPosts() {
  const response = await fetch("https://jsonplaceholder.typicode.com/posts");
  posts.value = await response.json();
}

onMounted(() => {
  fetchPosts();
});
</script>

<template>
  <ul>
    <li v-for="post in posts" :key="post.id">{{ post.title }}</li>
  </ul>
</template>
```

---

## **4. Manage loading status and errors**

It is important to display a loading indicator or an error message if the request fails.

### Complete example

```vue
<script setup>
import { ref, onMounted } from "vue";

const posts = ref([]);
const isLoading = ref(true);
const error = ref(null);

async function fetchPosts() {
  isLoading.value = true;
  error.value = null;

  try {
    const response = await fetch("https://jsonplaceholder.typicode.com/posts");
    if (!response.ok) {
      throw new Error("Error al obtener los posts");
    }
    posts.value = await response.json();
  } catch (err) {
    error.value = err.message;
  } finally {
    isLoading.value = false;
  }
}

onMounted(fetchPosts);
</script>

<template>
  <div>
    <p v-if="isLoading">Cargando posts...</p>
    <p v-else-if="error">Error: {{ error }}</p>
    <ul v-else>
      <li v-for="post in posts" :key="post.id">{{ post.title }}</li>
    </ul>
  </div>
</template>
```

---

## **5. Fetch inside a store action**

If the application needs to share data between multiple components, it is best to do the fetch within a Pinia store.

### Example of a store with fetch

```javascript
import { defineStore } from "pinia";

export const usePostStore = defineStore("post", {
  state: () => ({
    posts: [],
    isLoading: false,
    error: null,
  }),
  actions: {
    async fetchPosts() {
      this.isLoading = true;
      this.error = null;
      try {
        const response = await fetch(
          "https://jsonplaceholder.typicode.com/posts",
        );
        if (!response.ok) {
          throw new Error("Error al cargar los posts");
        }
        this.posts = await response.json();
      } catch (err) {
        this.error = err.message;
      } finally {
        this.isLoading = false;
      }
    },
  },
});
```

---

[![Fetch an API](https://img.youtube.com/vi/4XMDamSRt4o/0.jpg)](https://www.youtube.com/watch?v=4XMDamSRt4o&list=PLzA2VyZwsq_92Fnb4JEUnXUhSYfNHtcKx)

---

## **6. Summary**

| Task | Best place |
| -------------------------------------------- | -------------------------- |
| Load data when mounting component | `onMounted()` |
| Show loading and errors | Reactive variables (`ref()`) |
| Reuse fetch logic between components | Actions of a store (Pinia) |

---

In the next topic we will explore **The Life Cycle of Components**, to execute code at the appropriate times in each case.
