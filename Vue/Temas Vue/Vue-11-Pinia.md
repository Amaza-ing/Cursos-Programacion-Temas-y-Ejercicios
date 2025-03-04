# **Tema 11: Gestión de Estado Global con Pinia**

## **1. Introducción**

En aplicaciones complejas es habitual que múltiples componentes necesiten acceder o modificar el mismo estado. En lugar de pasar datos de componente en componente (prop drilling), Vue 3 recomienda usar **Pinia**, una librería oficial de gestión de estado global.

Pinia es sencilla, flexible y compatible con Composition API, lo que la hace perfecta para proyectos modernos de Vue 3.

---

## **2. Instalación de Pinia**

Si Pinia no se instaló al crear el proyecto, puedes añadirla fácilmente:

```sh
npm install pinia
```

Luego, en `main.js`, debes registrar Pinia en la aplicación:

```javascript
import { createApp } from "vue";
import { createPinia } from "pinia";
import App from "./App.vue";

const app = createApp(App);
app.use(createPinia());
app.mount("#app");
```

---

## **3. Creación de un Store**

Un **store** es un contenedor centralizado para el estado global. Se define como una función que devuelve un objeto con el estado, acciones y getters.

Ejemplo básico (`stores/counter.js`):

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

Como alternativa, podemos prescindir de usar `state`, `actions` y `getters`, y crear las variables y las funciones diréctamente dentro de la store:

Ejemplo básico (`stores/movie.js`):

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

## **4. Usar el Store en un Componente**

Para acceder al store desde un componente, usamos el composable que define el store:

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

## **5. Ventajas de Pinia**

| Característica                 | Descripción                            |
| ------------------------------ | -------------------------------------- |
| Reactividad completa           | Los stores son completamente reactivos |
| Compatible con Composition API | Usa el mismo flujo reactivo            |
| Soporte para Devtools          | Integración completa con Vue Devtools  |

---

## **6. Separación de Lógica**

Pinia permite organizar el estado en múltiples stores. Por ejemplo:

- `userStore`: Maneja datos de usuario.
- `cartStore`: Maneja el carrito de compras.
- `productStore`: Maneja el catálogo de productos.

Esto mantiene el código modular y escalable.

---

## **7. Acceso Global en cualquier Componente**

Como Pinia es global, cualquier componente puede importar y usar el mismo store, evitando problemas de sincronización entre componentes.

Ejemplo:

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

Si queremos, podemos instalar plugins que añadan funcionalidades a Pinia, como la posibilidad de guardar el estado en el `localStorage` del cliente con el plugin de **Pinia Persisted State**.

---

[![Pinia Persisted State](https://img.youtube.com/vi/B_KSnE8Du_k/0.jpg)](https://www.youtube.com/watch?v=B_KSnE8Du_k&list=PLzA2VyZwsq_92Fnb4JEUnXUhSYfNHtcKx)

---

## Resumen

| Concepto | Descripción                                        |
| -------- | -------------------------------------------------- |
| Pinia    | Librería oficial de estado global para Vue 3       |
| Store    | Objeto centralizado con estado, acciones y getters |
| Uso      | Importar el store en cualquier componente          |

---

En el próximo tema exploraremos **Cómo hacer fetch a una API**, usando la sintaxis de async/await para obtener datos de fuera de nuestro proyecto.
