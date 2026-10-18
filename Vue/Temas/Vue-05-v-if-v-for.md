# **Topic 5: Conditional Control Structures and Dynamic Lists in Vue.js**

## **1. Introduction**

In Vue.js, we can control which elements are displayed, and how, using **conditional control structures** and **directives for dynamic lists**. These tools are essential for building dynamic, adaptable interfaces.

---

## **2. Conditional directives: v-if, v-else-if and v-else**

Vue provides the `v-if` directive to show or hide elements conditionally.

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

[![The v-if directive](https://img.youtube.com/vi/iSxPEkS4P2s/0.jpg)](https://www.youtube.com/watch?v=iSxPEkS4P2s&list=PLzA2VyZwsq_92Fnb4JEUnXUhSYfNHtcKx)

---

## **3. Displaying dynamic lists with v-for**

The `v-for` directive lets you loop through arrays and display each element in the DOM.

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

When we use `v-for`, it's important to give the `key` attribute a suitable value, since this attribute is what Vue uses to keep track of each item in the list. The key value must be unique for each item.

---

[![Dynamic lists v-for](https://img.youtube.com/vi/RUQ5RffUh5o/0.jpg)](https://www.youtube.com/watch?v=RUQ5RffUh5o&list=PLzA2VyZwsq_92Fnb4JEUnXUhSYfNHtcKx)

---

[![Index in v-for](https://img.youtube.com/vi/vqrNhPDhDnA/0.jpg)](https://www.youtube.com/watch?v=vqrNhPDhDnA&list=PLzA2VyZwsq_92Fnb4JEUnXUhSYfNHtcKx)

---

## **4. Lists of objects and complex display**

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

When we use `v-for` with objects, it's very common to use the `id` field, or another field with a unique value, for the `key` attribute.

---

[![Lists of objects with v-for](https://img.youtube.com/vi/jyTqcRGQpSY/0.jpg)](https://www.youtube.com/watch?v=jyTqcRGQpSY&list=PLzA2VyZwsq_92Fnb4JEUnXUhSYfNHtcKx)

---

## **5. v-for with objects (dynamic properties)**

You can also use `v-for` to loop through the properties of an object.

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

| Directive   | Usage                                                                  |
| ----------- | ---------------------------------------------------------------------- |
| `v-if`      | Shows or hides elements based on a condition                           |
| `v-else-if` | Chains alternative conditions                                          |
| `v-else`    | Defines the final block when none of the previous conditions are met   |
| `v-for`     | Loops through arrays or objects, displaying their elements             |

---

In the next topic, we'll explore **style and dynamic classes in Vue.js**, to learn how to apply classes and styles conditionally and reactively.
