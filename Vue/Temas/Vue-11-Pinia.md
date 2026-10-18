# **Topic 11: Global State Management with Pinia**

## **1. Introduction**

In complex applications, it's common for several components to need to access or modify the same state. Instead of passing data from component to component (prop drilling), Vue 3 recommends using **Pinia**, an official global state management library.

Pinia is simple, flexible and compatible with the Composition API, which makes it perfect for modern Vue 3 projects.

---

## **2. Installing Pinia**

If Pinia wasn't installed when you created the project, you can easily add it:

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

## **3. Creating a store**

A **store** is a centralized container for global state. It's defined as a function that returns an object with state, actions and getters.

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

Alternatively, we can skip `state`, `actions` and `getters`, and create the variables and functions directly inside the store:

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

## **4. Using the store in a component**

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

| Feature                         | Description                            |
| ------------------------------- | -------------------------------------- |
| Full reactivity                 | Stores are fully reactive              |
| Compatible with Composition API | Uses the same reactive flow            |
| Devtools support                | Full integration with Vue Devtools     |

---

## **6. Separating logic**

Pinia lets you organize state into multiple stores. For example:

- `userStore`: Manages user data.
- `cartStore`: Manages the shopping cart.
- `productStore`: Manages the product catalog.

This keeps the code modular and scalable.

---

## **7. Global access from any component**

Since Pinia is global, any component can import and use the same store, which avoids synchronization problems between components.

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

## **8. The Persisted State plugin**

If we want, we can install plugins that add features to Pinia, such as saving the state in the client's `localStorage` with the **Pinia Persisted State** plugin.

---

[![Pinia Persisted State](https://img.youtube.com/vi/B_KSnE8Du_k/0.jpg)](https://www.youtube.com/watch?v=B_KSnE8Du_k&list=PLzA2VyZwsq_92Fnb4JEUnXUhSYfNHtcKx)

---

## Summary

| Concept  | Description                                        |
| -------- | -------------------------------------------------- |
| Pinia    | Official global state library for Vue 3            |
| Store    | Centralized object with state, actions and getters |
| Usage    | Import the store in any component                  |

---

In the next topic, we'll explore **how to fetch data from an API**, using the async/await syntax to get data from outside our project.
