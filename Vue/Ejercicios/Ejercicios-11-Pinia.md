# **Exercises - Topic 11: Global State Management with Pinia**

Below you'll find 6 practical exercises on global state management with Pinia.

Try to solve them before looking at the solution.

---

## **Exercise 1: Create a counter store**

Create a store called `counterStore` that has a `counter` state, an action to increment it and a getter that returns triple the counter.

<details><summary>Show solution</summary>

`stores/counter.js`

```javascript
import { defineStore } from "pinia";

export const useCounterStore = defineStore("counter", {
  state: () => ({
    counter: 0,
  }),
  actions: {
    increment() {
      this.counter++;
    },
  },
  getters: {
    tripleCount: (state) => state.counter * 3,
  },
});
```

</details>

---

## **Exercise 2: Show and update the counter in a component**

Create a `CounterDisplay.vue` component that displays the value of `counter` and has a button to increment it.

<details><summary>Show solution</summary>

`CounterDisplay.vue`

```vue
<script setup>
import { useCounterStore } from "../stores/counter";

const counterStore = useCounterStore();
</script>

<template>
  <div>
    <p>Contador: {{ counterStore.counter }}</p>
    <button @click="counterStore.increment">Incrementar</button>
  </div>
</template>

<style scoped>
button {
  padding: 8px 16px;
}
</style>
```

</details>

---

## **Exercise 3: Create a store for users**

Create a `userStore` store that manages a user's name, with an action to update it.

<details><summary>Show solution</summary>

`stores/user.js`

```javascript
import { defineStore } from "pinia";

export const useUserStore = defineStore("user", {
  state: () => ({
    name: "",
  }),
  actions: {
    setName(newName) {
      this.name = newName;
    },
  },
});
```

</details>

---

## **Exercise 4: Create a component that changes the user's name**

Create a `UserEditor.vue` component with an input and a button to save the name in the store.

<details><summary>Show solution</summary>

`UserEditor.vue`

```vue
<script setup>
import { ref } from "vue";
import { useUserStore } from "../stores/user";

const userStore = useUserStore();
const newName = ref("");

function saveName() {
  userStore.setName(newName.value);
}
</script>

<template>
  <div>
    <input v-model="newName" placeholder="Introduce tu nombre" />
    <button @click="saveName">Guardar nombre</button>
  </div>
</template>

<style scoped>
input,
button {
  margin-right: 8px;
}
</style>
```

</details>

---

## **Exercise 5: Show the saved name in another component**

Create a `UserGreeting.vue` component that accesses the store and displays a personalized greeting using the stored name.

<details><summary>Show solution</summary>

`UserGreeting.vue`

```vue
<script setup>
import { useUserStore } from "../stores/user";

const userStore = useUserStore();
</script>

<template>
  <p>Hola, {{ userStore.name || "invitado" }}!</p>
</template>

<style scoped>
p {
  font-weight: bold;
}
</style>
```

</details>

---

## **Exercise 6: Create a getter to calculate the length of the name**

Add a getter called `nameLength` to `userStore` that returns the number of characters in the current name.

<details><summary>Show solution</summary>

`stores/user.js`

```javascript
import { defineStore } from "pinia";

export const useUserStore = defineStore("user", {
  state: () => ({
    name: "",
  }),
  actions: {
    setName(newName) {
      this.name = newName;
    },
  },
  getters: {
    nameLength: (state) => state.name.length,
  },
});
```

</details>
