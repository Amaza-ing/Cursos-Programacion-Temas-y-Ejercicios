# **Topic 11: Global State Management with Pinia**

## **1. Introduction**

In complex applications it is common for multiple components to need to access or modify the same state. Instead of passing data from component to component (prop drilling), Vue 3 recommends using **Pinia**, an official global state management library.

Pinia is simple, flexible, and compatible with the Composition API, making it perfect for modern Vue 3 projects.

---

## **2. Pinia Installation**

If Pinia was not installed when creating the project, you can easily add it:

```sh
npm install pinia
```

Then, in `main.js`, you need to register Pinia in the app:

```javascript
import { createApp } from "vue";
import { createPinia } from "pinia";
import App from "./App.vue";

const app = createApp(App);
app.use(createPinia());
app.mount("#app");
```

---

## **3. Creation of a Store**

A **store** is a centralized container for global state. It is defined as a function that returns an object with state, actions and getters.

Basic example (`stores/counter.js`):

```javascript
import { defineStore } from "pinia";

export const useCounterStore = defineStore("counter", {
  state: () => ({
    count: 0,
  }),
  actions: {
    increment() {
      this.count++;
    },
  },
  getters: {
    doubleCount: (state) => state.count * 2,
  },
});
```

Alternatively, we can skip using `state`, `actions` and `getters`, and create the variables and functions directly within the store:

Basic example (`stores/movie.js`):

```javascript
import { defineStore } from "pinia";
import { ref } from "vue";

export const useMovieStore = defineStore("movie", () => {
  const movies = ref([
    { title: "Inception", duration: "148 min", director: "Christopher Nolan" },
    {
      title: "The Lord of the Rings",
      duration: "201 min",
      director: "Peter Jackson",
    },
    {
      title: "Interstellar",
      duration: "169 min",
      director: "Christopher Nolan",
    },
  ]);

  const addMovie = (movie) => movies.value.push(movie);

  return {
    movies,
    addMovie,
  };
});
```

---

## **4. Use the Store in a Component**

To access the store from a component, we use the composable that defines the store:

```vue
<script setup>
import { useCounterStore } from "../stores/counter";

const counterStore = useCounterStore();
</script>

<template>
  <div>
    <p>Contador: {{ counterStore.count }}</p>
    <button @click="counterStore.increment">Incrementar</button>
  </div>
</template>

<style scoped>
button {
  padding: 8px 16px;
}
</style>
```

---

[![Pinia](https://img.youtube.com/vi/RUJ2l6FNTvo/0.jpg)](https://www.youtube.com/watch?v=RUJ2l6FNTvo&list=PLzA2VyZwsq_92Fnb4JEUnXUhSYfNHtcKx)

---

## **5. Advantages of Pinia**

| Feature | Description |
| --------------------------- | -------------------------------------- |
| Complete reactivity | Stores are completely reactive |
| Compatible with Composition API | Use the same reagent flow |
| Devtools Support | Full integration with Vue Devtools |

---

## **6. Logic Separation**

Pinia allows you to organize the state in multiple stores. For example:

- `userStore`: Manages user data.
- `cartStore`: Manage the shopping cart.
- `productStore`: Manage the product catalog.

This keeps the code modular and scalable.

---

## **7. Global Access on any Component**

As Pinia is global, any component can import and use the same store, avoiding synchronization problems between components.

Example:

```vue
<script setup>
import { useUserStore } from "../stores/user";

const userStore = useUserStore();
</script>

<template>
  <p>Bienvenido, {{ userStore.userName }}</p>
</template>
```

---

## **8. Plugin Persisted State**

If we want, we can install plugins that add functionality to Pinia, such as the possibility of saving the state in the client's `localStorage` with the **Pinia Persisted State** plugin.

---

[![Pinia Persisted State](https://img.youtube.com/vi/B_KSnE8Du_k/0.jpg)](https://www.youtube.com/watch?v=B_KSnE8Du_k&list=PLzA2VyZwsq_92Fnb4JEUnXUhSYfNHtcKx)

---

## Summary

| Concept | Description |
| -------- | -------------------------------------------------- |
| Pinia | Official Global Status Library for Vue 3 |
| Store | Centralized object with state, actions and getters |
| Usage | Import the store in any component |

---

In the next topic we will explore **How to fetch an API**, using the async/await syntax to obtain data from outside our project.
