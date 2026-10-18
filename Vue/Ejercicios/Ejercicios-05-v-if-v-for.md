# **Exercises - Topic 5: Conditional Control Structures and Dynamic Lists in Vue.js**

Below you'll find 10 practical exercises on conditional control structures and dynamic lists in Vue.

Try to solve them before looking at the solution.

---

## **Exercise 1: Show a welcome message only if the user is logged in**

Create a `WelcomeMessage.vue` component that displays a welcome message only when `isLoggedIn` is `true`.

<details><summary>Show solution</summary>

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

## **Exercise 2: Switch between two messages based on the connection state**

Create a `ConnectionStatus.vue` component that displays "Conectado" ("Connected") or "Desconectado" ("Disconnected") depending on the value of `isOnline`.

<details><summary>Show solution</summary>

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

## **Exercise 3: Show a list of tasks**

Create a `TaskList.vue` component that displays a list of tasks.

<details><summary>Show solution</summary>

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

## **Exercise 4: Show only products in stock**

Create a `ProductList.vue` component that displays only the products whose `inStock` is `true`.

<details><summary>Show solution</summary>

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

## **Exercise 5: Show a message if the list is empty**

Create an `EmptyList.vue` component that displays "No hay elementos" ("No items") if the `items` list is empty.

<details><summary>Show solution</summary>

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

> Note: You could also use the `!` negation operator for the condition: `v-if="!items.length"`

---

## **Exercise 6: Show a table of users**

Create a `UserTable.vue` component that displays a table with the name and age of each user.

<details><summary>Show solution</summary>

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

## **Exercise 7: Show a welcome message based on the role**

Create a `RoleMessage.vue` component that displays a different message depending on whether the role is `admin`, `user` or `guest`.

<details><summary>Show solution</summary>

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

## **Exercise 8: Show a list of even numbers**

Create an `EvenNumbers.vue` component that displays only the even numbers from a list.

<details><summary>Show solution</summary>

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

## **Exercise 9: Show a product's details**

Create a `ProductDetails.vue` component that loops through a `product` object and displays its properties.

<details><summary>Show solution</summary>

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

## **Exercise 10: Display a list of names in uppercase**

Create an `UppercaseList.vue` component that displays a list of names converted to uppercase.

<details><summary>Show solution</summary>

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
