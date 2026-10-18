# **Topic 12: Fetch an API in Vue.js using async/await**

## **1. Introduction**

Many web applications need to get data from a server or an external API. In Vue.js, the most modern and recommended way to do this is to use `fetch` combined with the `async/await` syntax. This lets you write clearer, easier-to-read asynchronous code.

In this topic, we'll learn:

- How to make an HTTP request.
- Where to run the request inside a Vue component.
- How to manage the loading state and possible errors.

---

## **2. fetch basics**

`fetch()` is a native JavaScript function that lets you make HTTP requests.

Basic example:

```javascript
const response = await fetch("https://jsonplaceholder.typicode.com/posts");
const data = await response.json();
```

`fetch` returns a promise, so we can use `await` to wait for the response and then convert it to JSON with `.json()`.

---

## **3. Where should you fetch in a Vue component?**

In a Vue component, requests are usually made when the component is **mounted**, that is, once the component is already in the DOM. In Vue 3 with the Composition API, the most common approach is to fetch inside `onMounted()`.

> Note: `onMounted()` is one of the component lifecycle hooks (methods). We'll cover this in the next topic.

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

## **4. Handling the loading state and errors**

It's important to display a loading indicator, or an error message if the request fails.

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

If the application needs to share the data between multiple components, it's better to fetch it inside a Pinia store.

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

| Task                                            | Best place                    |
| ----------------------------------------------- | ----------------------------- |
| Load data when the component is mounted         | `onMounted()`                 |
| Show the loading state and errors               | Reactive variables (`ref()`)  |
| Reuse fetch logic across components             | Store actions (Pinia)         |

---

In the next topic, we'll explore **the component lifecycle**, so we can run code at the right moment in each case.
