# **Topic 10: Vue Router and Router Links - Creating Views and Routes in a SPA Project**

## **1. Introduction**

Vue Router is the official routing library for Vue.js. It lets you manage navigation in **SPA** (Single Page Application) applications, where pages are loaded dynamically without reloading the browser.

With Vue Router, we can:

- Define routes and map them to components (views).
- Create navigation links with `RouterLink`.
- Control the browsing history.
- Use nested and dynamic routes.

---

## **2. Installing Vue Router**

If you didn't create the project with the router option enabled, you can add Vue Router manually:

```sh
npm install vue-router@4
```

---

## **3. Creating views**

Create a `views` folder inside `src` and add a couple of components that will represent full pages:

`HomeView.vue`

```vue
<script setup></script>

<template>
  <h1>Página de inicio</h1>
</template>

<style scoped>
h1 {
  color: green;
}
</style>
```

`AboutView.vue`

```vue
<script setup></script>

<template>
  <h1>Sobre nosotros</h1>
</template>

<style scoped>
h1 {
  color: blue;
}
</style>
```

---

## **4. Basic route configuration**

### Creating the routes file

Inside the `src` folder, create a file called `router.js` or `router/index.js`.

```javascript
import { createRouter, createWebHistory } from "vue-router";
import HomeView from "../views/HomeView.vue";
import AboutView from "../views/AboutView.vue";

const routes = [
  { path: "/", component: HomeView },
  { path: "/about", component: AboutView },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;
```

---

## **5. Adding the router to the application**

In `main.js`, import the router and add it to the app.

```javascript
import { createApp } from "vue";
import App from "./App.vue";
import router from "./router";

const app = createApp(App);
app.use(router);
app.mount("#app");
```

---

## **6. Displaying the views in App.vue**

Vue Router uses a special component called `RouterView` to render the current route's component.

`App.vue`

```vue
<script setup></script>

<template>
  <nav>
    <RouterLink to="/">Inicio</RouterLink>
    <RouterLink to="/about">Sobre nosotros</RouterLink>
  </nav>

  <RouterView />
</template>

<style scoped>
nav {
  display: flex;
  gap: 12px;
  margin-bottom: 16px;
}
</style>
```

---

[![Vue Router](https://img.youtube.com/vi/t0_NyTNvYw0/0.jpg)](https://www.youtube.com/watch?v=t0_NyTNvYw0&list=PLzA2VyZwsq_92Fnb4JEUnXUhSYfNHtcKx)

---

## **7. Declarative navigation with RouterLink**

`RouterLink` is the Vue Router component for creating reactive navigation links. It's a better alternative to `a href` because it avoids reloading the whole page.

Example:

```vue
<RouterLink to="/about">Ir a Sobre Nosotros</RouterLink>
```

---

[![RouterLink](https://img.youtube.com/vi/hruN7wrqebA/0.jpg)](https://www.youtube.com/watch?v=hruN7wrqebA&list=PLzA2VyZwsq_92Fnb4JEUnXUhSYfNHtcKx)

---

## **8. Programmatic navigation (from logic)**

You can redirect the user programmatically using the `router` object.

```vue
<script setup>
import { useRouter } from "vue-router";

const router = useRouter();

function goToHome() {
  router.push("/");
}
</script>

<template>
  <button @click="goToHome">Ir a Inicio</button>
</template>
```

---

[![Programmatic navigation](https://img.youtube.com/vi/BwvnFHQukag/0.jpg)](https://www.youtube.com/watch?v=BwvnFHQukag&list=PLzA2VyZwsq_92Fnb4JEUnXUhSYfNHtcKx)

---

## **9. Dynamic route parameters**

Vue Router lets you define dynamic routes that accept variable parameters:

```javascript
{ path: '/user/:id', component: UserProfile }
```

To access the `id` parameter:

```vue
<script setup>
import { useRoute } from "vue-router";

const route = useRoute();
const userId = route.params.id;
</script>

<template>
  <p>ID del usuario: {{ userId }}</p>
</template>
```

> Note: Don't confuse `useRoute` with `useRouter`.

---

[![Route parameters](https://img.youtube.com/vi/R1YyM6jvBjk/0.jpg)](https://www.youtube.com/watch?v=R1YyM6jvBjk&list=PLzA2VyZwsq_92Fnb4JEUnXUhSYfNHtcKx)

---

## Summary

| Element      | Function                                |
| ------------ | --------------------------------------- |
| `RouterLink` | Create internal links                   |
| `RouterView` | Show the current route's component      |
| `useRouter`  | Navigate programmatically               |
| `useRoute`   | Get information about the current route |

---

In the next topic, we'll explore **how to manage global state with Pinia**, the recommended state management library for Vue 3.
