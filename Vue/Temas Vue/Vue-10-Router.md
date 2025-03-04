# **Tema 10: Vue Router y Router Links - Creación de Views y Rutas en un Proyecto SPA**

## **1. Introducción**

Vue Router es la librería oficial de enrutamiento para Vue.js. Permite gestionar la navegación en aplicaciones **SPA** (Single Page Application), donde las páginas se cargan dinámicamente sin necesidad de recargar el navegador.

Con Vue Router, podemos:

- Definir rutas y asociarlas a componentes (views).
- Crear enlaces navegables con `RouterLink`.
- Controlar el historial de navegación.
- Aplicar rutas anidadas y dinámicas.

---

## **2. Instalación de Vue Router**

Si no has creado el proyecto con la opción de router habilitada, puedes añadir Vue Router manualmente:

```sh
npm install vue-router@4
```

---

## **3. Configuración básica de rutas**

### Crear el archivo de rutas

Dentro de la carpeta `src`, crea un archivo llamado `router.js` o `router/index.js`.

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

## **4. Integrar el router en la aplicación**

En `main.js`, importa el router y añádelo a la app.

```javascript
import { createApp } from "vue";
import App from "./App.vue";
import router from "./router";

const app = createApp(App);
app.use(router);
app.mount("#app");
```

---

## **5. Crear vistas (views)**

Crea una carpeta `views` dentro de `src` y añade un par de componentes que representarán páginas completas:

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

## **6. Mostrar las vistas en App.vue**

Vue Router utiliza un componente especial llamado `RouterView` para renderizar el componente de la ruta actual.

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

## **7. Navegación declarativa con RouterLink**

`RouterLink` es el componente de Vue Router para crear enlaces de navegación reactivos. Es una alternativa mejor que `a href` porque evita la recarga completa de la página.

Ejemplo:

```vue
<RouterLink to="/about">Ir a Sobre Nosotros</RouterLink>
```

---

[![RouterLink](https://img.youtube.com/vi/hruN7wrqebA/0.jpg)](https://www.youtube.com/watch?v=hruN7wrqebA&list=PLzA2VyZwsq_92Fnb4JEUnXUhSYfNHtcKx)

---

## **8. Navegación programática (desde la lógica)**

Puedes redirigir al usuario programáticamente usando el objeto `router`.

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

[![Navegación Programática](https://img.youtube.com/vi/BwvnFHQukag/0.jpg)](https://www.youtube.com/watch?v=BwvnFHQukag&list=PLzA2VyZwsq_92Fnb4JEUnXUhSYfNHtcKx)

---

## **9. Parámetros dinámicos en las rutas**

Vue Router permite definir rutas dinámicas para aceptar parámetros variables:

```javascript
{ path: '/user/:id', component: UserProfile }
```

Para acceder al parámetro `id`:

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

> Nota: No confundir `useRoute` con `useRouter`

---

[![Rutas Paramétricas](https://img.youtube.com/vi/R1YyM6jvBjk/0.jpg)](https://www.youtube.com/watch?v=R1YyM6jvBjk&list=PLzA2VyZwsq_92Fnb4JEUnXUhSYfNHtcKx)

---

## Resumen

| Elemento     | Función                                 |
| ------------ | --------------------------------------- |
| `RouterLink` | Crear enlaces internos                  |
| `RouterView` | Mostrar el componente de la ruta actual |
| `useRouter`  | Navegar programáticamente               |
| `useRoute`   | Obtener información de la ruta actual   |

---

En el próximo tema exploraremos **Cómo gestionar el Estado Global con Pinia**, la librería de gestión de estado recomendada en Vue 3.
