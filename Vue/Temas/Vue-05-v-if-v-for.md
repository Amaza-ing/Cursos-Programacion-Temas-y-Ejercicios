# **Topic 5: Conditional Control Structures and Dynamic Lists in Vue.js**

## **1. Introduction**

In Vue.js, we can control which elements are displayed and how they are displayed using **conditional control structures** and **directives for dynamic lists**. These tools are essential for creating dynamic and adaptable interfaces.

---

## **2. Conditional directives: v-if, v-else-if and v-else**

Vue provides the `v-if` directive to conditionally show or hide elements.

### Basic example

```vue
<script setup>
import { ref } from "vue";

const isLoggedIn = ref(false);
</script>

<template>
  <div>
    <p v-if="isLoggedIn">Bienvenido, usuario.</p>
    <p v-else>No has iniciado sesión.</p>
  </div>
</template>

<style scoped>
p {
  font-size: 16px;
}
</style>
```

---

[![Directive v-if](https://img.youtube.com/vi/iSxPEkS4P2s/0.jpg)](https://www.youtube.com/watch?v=iSxPEkS4P2s&list=PLzA2VyZwsq_92Fnb4JEUnXUhSYfNHtcKx)

---

## **3. Show dynamic lists with v-for**

The `v-for` directive allows you to loop through arrays and display each element in the DOM.

### Basic example

```vue
<script setup>
const names = ["Ana", "Luis", "Carlos"];
</script>

<template>
  <ul>
    <li v-for="(name, index) in names" :key="index">{{ name }}</li>
  </ul>
</template>

<style scoped>
li {
  list-style: none;
}
</style>
```

When we use `v-for` it is important to give an appropriate value to the `key` property, since this property is what controls each element in the list. The key value must be unique for each element.

---

[![Dynamic lists v-for](https://img.youtube.com/vi/RUQ5RffUh5o/0.jpg)](https://www.youtube.com/watch?v=RUQ5RffUh5o&list=PLzA2VyZwsq_92Fnb4JEUnXUhSYfNHtcKx)

---

[![Index in v-for](https://img.youtube.com/vi/vqrNhPDhDnA/0.jpg)](https://www.youtube.com/watch?v=vqrNhPDhDnA&list=PLzA2VyZwsq_92Fnb4JEUnXUhSYfNHtcKx)

---

## **4. Object Lists and Complex Display**

Lists can contain objects with multiple properties, and we can display those properties easily.

### Example

```vue
<script setup>
const products = [
  { id: 1, name: "Teclado", price: 30 },
  { id: 2, name: "Ratón", price: 20 },
];
</script>

<template>
  <table>
    <thead>
      <tr>
        <th>Producto</th>
        <th>Precio</th>
      </tr>
    </thead>
    <tbody>
      <tr v-for="product in products" :key="product.id">
        <td>{{ product.name }}</td>
        <td>{{ product.price }} €</td>
      </tr>
    </tbody>
  </table>
</template>

<style scoped>
table {
  width: 100%;
  border-collapse: collapse;
}
th,
td {
  border: 1px solid #ddd;
  padding: 8px;
}
</style>
```

When we use `v-for` with objects it is very common to use the `id` field or another field that has a unique value for the `key` property.

---

[![Lists of objects with v-for](https://img.youtube.com/vi/jyTqcRGQpSY/0.jpg)](https://www.youtube.com/watch?v=jyTqcRGQpSY&list=PLzA2VyZwsq_92Fnb4JEUnXUhSYfNHtcKx)

---

## **5. v-for with objects (dynamic properties)**

`v-for` can also be used to loop through the properties of an object.

### Example

```vue
<script setup>
const user = {
  name: "Ana",
  age: 30,
  country: "España",
};
</script>

<template>
  <ul>
    <li v-for="(value, key) in user" :key="key">{{ key }}: {{ value }}</li>
  </ul>
</template>

<style scoped>
li {
  text-transform: capitalize;
}
</style>
```

---

## Summary

| Directive | Usage |
| ----------- | ---------------------------------------------------------------------- |
| `v-if` | Show or hide elements based on a condition |
| `v-else-if` | Chain alternative conditions |
| `v-else` | Defines the final block when the previous conditions are not met |
| `v-for` | Cycle through arrays or objects showing their elements |

---

In the next topic we will explore **Styling and Dynamic Classes in Vue.js**, to learn how to apply classes and styles conditionally and reactively.
