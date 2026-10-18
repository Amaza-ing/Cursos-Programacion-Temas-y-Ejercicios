# **Exercises - Topic 10: Vue Router and Router Links**

Below you'll find 5 practical exercises on Vue Router and Router Links.

Try to solve them before looking at the solution.

---

## **Exercise 1: Create a router with three basic routes**

Create a `router.js` file that defines three routes: `/`, `/services` and `/contact`, each pointing to a different component.

<details><summary>Show solution</summary>

`router.js`

```javascript
import { createRouter, createWebHistory } from "vue-router";
import HomeView from "../views/HomeView.vue";
import ServicesView from "../views/ServicesView.vue";
import ContactView from "../views/ContactView.vue";

const routes = [
  { path: "/", component: HomeView },
  { path: "/services", component: ServicesView },
  { path: "/contact", component: ContactView },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;
```

</details>

---

## **Exercise 2: Create a navigation menu with RouterLink**

Create a `MainMenu.vue` component that contains three navigation links to the routes `/`, `/services` and `/contact`.

<details><summary>Show solution</summary>

`MainMenu.vue`

```vue
<template>
  <nav>
    <RouterLink to="/">Inicio</RouterLink>
    <RouterLink to="/services">Servicios</RouterLink>
    <RouterLink to="/contact">Contacto</RouterLink>
  </nav>
</template>

<style scoped>
nav {
  display: flex;
  gap: 12px;
  margin-bottom: 16px;
}
</style>
```

</details>

---

## **Exercise 3: Create a button that navigates to another route programmatically**

Create a `GoToContact.vue` component with a button that redirects the user to `/contact` when clicked.

<details><summary>Show solution</summary>

`GoToContact.vue`

```vue
<script setup>
import { useRouter } from "vue-router";

const router = useRouter();

function goToContact() {
  router.push("/contact");
}
</script>

<template>
  <button @click="goToContact">Ir a Contacto</button>
</template>

<style scoped>
button {
  padding: 8px 16px;
  background-color: #42b983;
  color: white;
  border: none;
  cursor: pointer;
}
</style>
```

</details>

---

## **Exercise 4: Create a route with a dynamic parameter**

Create a `/product/:id` route and a `ProductDetail.vue` component that displays the ID of the product received as a parameter.

<details><summary>Show solution</summary>

`ProductDetail.vue`

```vue
<script setup>
import { useRoute } from "vue-router";

const route = useRoute();
const productId = route.params.id;
</script>

<template>
  <p>Detalles del producto con ID: {{ productId }}</p>
</template>

<style scoped>
p {
  font-size: 18px;
}
</style>
```

`router.js`

```javascript
{ path: '/product/:id', component: ProductDetail }
```

</details>

---

## **Exercise 5: Display the RouterView component inside App.vue**

Modify `App.vue` to include the `RouterView` component, which will display the component associated with the current route.

<details><summary>Show solution</summary>

`App.vue`

```vue
<script setup>
import MainMenu from "./components/MainMenu.vue";
</script>

<template>
  <div>
    <MainMenu />
    <RouterView />
  </div>
</template>

<style scoped>
div {
  padding: 16px;
}
</style>
```

</details>
