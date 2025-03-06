# **Ejercicios - Tema 5: Estructuras de Control Condicional y Listas dinámicas en Vue.js**

A continuación, encontrarás 10 ejercicios prácticos sobre las estructuras de control condicional y las listas dinámicas en Vue.

Intenta resolverlos antes de consultar la solución.

---

## **Ejercicio 1: Mostrar un mensaje de bienvenida solo si el usuario está logueado**

Crea un componente `WelcomeMessage.vue` que muestre un mensaje de bienvenida solo cuando `isLoggedIn` sea `true`.

<details><summary>Mostrar Solución</summary>

```vue
<script setup>
import { ref } from "vue";

const isLoggedIn = ref(true);
</script>

<template>
  <p v-if="isLoggedIn">Bienvenido al sistema</p>
</template>

<style scoped>
p {
  color: green;
}
</style>
```

</details>

---

## **Ejercicio 2: Alternar entre dos mensajes según el estado de conexión**

Crea un componente `ConnectionStatus.vue` que muestre "Conectado" o "Desconectado" según el valor de `isOnline`.

<details><summary>Mostrar Solución</summary>

```vue
<script setup>
import { ref } from "vue";

const isOnline = ref(false);
</script>

<template>
  <p v-if="isOnline">Conectado</p>
  <p v-else>Desconectado</p>
</template>

<style scoped>
p {
  font-weight: bold;
}
</style>
```

</details>

---

## **Ejercicio 3: Mostrar una lista de tareas**

Crea un componente `TaskList.vue` que muestre una lista de tareas.

<details><summary>Mostrar Solución</summary>

```vue
<script setup>
const tasks = ["Lavar ropa", "Comprar pan", "Hacer ejercicio"];
</script>

<template>
  <ul>
    <li v-for="(task, index) in tasks" :key="index">{{ task }}</li>
  </ul>
</template>

<style scoped>
li {
  margin: 4px 0;
}
</style>
```

</details>

---

## **Ejercicio 4: Mostrar solo productos en stock**

Crea un componente `ProductList.vue` que muestre solo productos cuyo `inStock` sea `true`.

<details><summary>Mostrar Solución</summary>

```vue
<script setup>
const products = [
  { name: "Camiseta", inStock: true },
  { name: "Zapatos", inStock: false },
  { name: "Gorra", inStock: true },
];
</script>

<template>
  <ul>
    <li
      v-for="(product, index) in products"
      :key="index"
      v-if="product.inStock"
    >
      {{ product.name }}
    </li>
  </ul>
</template>

<style scoped>
li {
  color: darkblue;
}
</style>
```

</details>

---

## **Ejercicio 5: Mostrar mensaje si la lista está vacía**

Crea un componente `EmptyList.vue` que muestre "No hay elementos" si la lista `items` está vacía.

<details><summary>Mostrar Solución</summary>

```vue
<script setup>
const items = [];
</script>

<template>
  <p v-if="items.length === 0">No hay elementos</p>
</template>

<style scoped>
p {
  color: red;
}
</style>
```

</details>

> Nota: También se podría usar el operador negación `!` para la condición: `v-if="!items.length"`

---

## **Ejercicio 6: Mostrar una tabla de usuarios**

Crea un componente `UserTable.vue` que muestre una tabla con nombre y edad de cada usuario.

<details><summary>Mostrar Solución</summary>

```vue
<script setup>
const users = [
  { name: "Laura", age: 25 },
  { name: "Pedro", age: 30 },
];
</script>

<template>
  <table>
    <tr>
      <th>Nombre</th>
      <th>Edad</th>
    </tr>
    <tr v-for="(user, index) in users" :key="index">
      <td>{{ user.name }}</td>
      <td>{{ user.age }}</td>
    </tr>
  </table>
</template>

<style scoped>
th,
td {
  padding: 8px;
  border: 1px solid #ddd;
}
</style>
```

</details>

---

## **Ejercicio 7: Mostrar mensaje de bienvenida según el rol**

Crea un componente `RoleMessage.vue` que muestre un mensaje diferente si el rol es `admin`, `user` o `guest`.

<details><summary>Mostrar Solución</summary>

```vue
<script setup>
import { ref } from "vue";

const role = ref("admin");
</script>

<template>
  <p v-if="role === 'admin'">Bienvenido, administrador</p>
  <p v-else-if="role === 'user'">Bienvenido, usuario registrado</p>
  <p v-else>Bienvenido, invitado</p>
</template>

<style scoped>
p {
  font-style: italic;
}
</style>
```

</details>

---

## **Ejercicio 8: Mostrar una lista de números pares**

Crea un componente `EvenNumbers.vue` que muestre solo los números pares de una lista.

<details><summary>Mostrar Solución</summary>

```vue
<script setup>
const numbers = [1, 2, 3, 4, 5, 6];
</script>

<template>
  <ul>
    <li v-for="(number, index) in numbers" :key="index" v-if="number % 2 === 0">
      {{ number }}
    </li>
  </ul>
</template>

<style scoped>
li {
  font-weight: bold;
}
</style>
```

</details>

---

## **Ejercicio 9: Mostrar detalles de un producto**

Crea un componente `ProductDetails.vue` que recorra un objeto `product` y muestre sus propiedades.

<details><summary>Mostrar Solución</summary>

```vue
<script setup>
const product = {
  name: "Mochila",
  price: 45,
  brand: "Deportiva",
};
</script>

<template>
  <ul>
    <li v-for="(value, key) in product" :key="key">{{ key }}: {{ value }}</li>
  </ul>
</template>

<style scoped>
li {
  text-transform: capitalize;
}
</style>
```

</details>

---

## **Ejercicio 10: Mostrar una lista de nombres en mayúsculas**

Crea un componente `UppercaseList.vue` que muestre una lista de nombres transformados a mayúsculas.

<details><summary>Mostrar Solución</summary>

```vue
<script setup>
const names = ["ana", "carlos", "maria"];
</script>

<template>
  <ul>
    <li v-for="(name, index) in names" :key="index">
      {{ name.toUpperCase() }}
    </li>
  </ul>
</template>

<style scoped>
li {
  font-size: 16px;
}
</style>
```

</details>
