# **Ejercicios - Tema 10: Vue Router y Router Links**

A continuación, encontrarás 5 ejercicios prácticos sobre Vue Router y Router Links.

Intenta resolverlos antes de consultar la solución.

---

## **Ejercicio 1: Crear un router con tres rutas básicas**

Crea un archivo `router.js` que defina tres rutas: `/`, `/services` y `/contact`, cada una apuntando a un componente diferente.

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 2: Crear un menú de navegación con RouterLink**

Crea un componente `MainMenu.vue` que contenga tres enlaces de navegación a las rutas `/`, `/services` y `/contact`.

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 3: Crear un botón que navegue a otra ruta programáticamente**

Crea un componente `GoToContact.vue` con un botón que redirija al usuario a `/contact` al hacer clic.

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 4: Crear una ruta con parámetro dinámico**

Crea una ruta `/product/:id` y un componente `ProductDetail.vue` que muestre el ID del producto recibido como parámetro.

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 5: Mostrar el componente RouterView dentro de App.vue**

Modifica `App.vue` para incluir el componente `RouterView`, que mostrará el componente asociado a la ruta actual.

<details><summary>Mostrar Solución</summary>

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
