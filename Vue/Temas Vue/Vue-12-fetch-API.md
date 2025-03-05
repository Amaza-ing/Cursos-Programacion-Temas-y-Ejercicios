# **Tema 12: Fetch a una API en Vue.js usando async/await**

## **1. Introducción**

En muchas aplicaciones web es necesario obtener datos desde un servidor o API externa. En Vue.js, la forma más recomendada y moderna de hacerlo es utilizando `fetch` combinado con la sintaxis de `async/await`. Esto permite escribir código asíncrono más claro y fácil de leer.

En este tema aprenderemos:

- Cómo realizar una petición HTTP.
- Dónde ejecutar la petición dentro de un componente Vue.
- Cómo gestionar el estado de carga y posibles errores.

---

## **2. Conceptos básicos de fetch**

`fetch()` es una función nativa de JavaScript que permite realizar peticiones HTTP.

Ejemplo básico:

```javascript
const response = await fetch("https://jsonplaceholder.typicode.com/posts");
const data = await response.json();
```

`fetch` devuelve una promesa, por lo que podemos usar `await` para esperar la respuesta y después convertirla en JSON con `.json()`.

---

## **3. ¿Dónde realizar el fetch en un componente Vue?**

En un componente Vue, las peticiones suelen hacerse al **montarse** el componente, es decir, cuando el componente ya está en el DOM. En Vue 3 con Composition API, lo más común es hacer el fetch dentro de `onMounted()`.

> Nota: `onMounted()` es uno de los hooks (métodos) del ciclo de vida de los componentes. Esto lo veremos en el próximo tema.

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

## **4. Manejar estado de carga y errores**

Es importante mostrar un indicador de carga o un mensaje de error si la petición falla.

### Ejemplo completo

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

## **5. Fetch dentro de una acción de un store**

Si la aplicación necesita compartir los datos entre múltiples componentes, es mejor hacer el fetch dentro de un store de Pinia.

### Ejemplo de un store con fetch

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
          "https://jsonplaceholder.typicode.com/posts"
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

[![Fetch a una API](https://img.youtube.com/vi/4XMDamSRt4o/0.jpg)](https://www.youtube.com/watch?v=4XMDamSRt4o&list=PLzA2VyZwsq_92Fnb4JEUnXUhSYfNHtcKx)

---

## **6. Resumen**

| Tarea                                           | Mejor lugar                   |
| ----------------------------------------------- | ----------------------------- |
| Cargar datos al montar el componente            | `onMounted()`                 |
| Mostrar carga y errores                         | Variables reactivas (`ref()`) |
| Reutilizar la lógica de fetch entre componentes | Acciones de un store (Pinia)  |

---

En el próximo tema exploraremos **El Ciclo de Vida de los Componentes**, para ejecutar código en los momentos adecuados en cada caso.
