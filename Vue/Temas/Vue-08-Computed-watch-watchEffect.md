# **Topic 8: Computed Properties, watch and watchEffect in Vue.js**

## **1. Introduction**

In Vue 3, reactivity is one of the key pillars. In addition to the normal reactive variables (`ref` or `reactive`), Vue provides us with advanced tools to handle changes:

- **Computed Properties (`computed`)**: Derived values based on other reactive variables.
- **watch**: Observe specific changes and execute logic when those changes occur.
- **watchEffect**: Automatically react to any reactive data used within your function.

---

## **2. Computed Properties**

### What is a computed property?

It is a value calculated automatically from other reactive variables. Vue takes care of updating the computed value when its dependencies change.

### Example

```vue
<script setup>
import { ref, computed } from "vue";

const firstName = ref("María");
const lastName = ref("Pérez");

const fullName = computed(() => `${firstName.value} ${lastName.value}`);
</script>

<template>
  <p>Nombre completo: {{ fullName }}</p>
</template>

<style scoped>
p {
  font-weight: bold;
}
</style>
```

When any of the `firstName` or `lastName` variables change their value, the `fullName` property will also change its value automatically.

---

[![Computed Properties](https://img.youtube.com/vi/jeMaoz9-_tM/0.jpg)](https://www.youtube.com/watch?v=jeMaoz9-_tM&list=PLzA2VyZwsq_92Fnb4JEUnXUhSYfNHtcKx)

---

## **3. Observers (`watch`)**

### What is a watch?

`watch` allows you to run a custom function every time a specific reactive variable changes.

### Example

```vue
<script setup>
import { ref, watch } from "vue";

const age = ref(18);

watch(age, (newAge, oldAge) => {
  console.log(`La edad ha cambiado de ${oldAge} a ${newAge}`);
});
</script>

<template>
  <p>Edad: {{ age }}</p>
  <button @click="age++">Cumplir años</button>
</template>

<style scoped>
button {
  margin-top: 8px;
}
</style>
```

In this case the variable `age` is being monitored;

---

[![watch in Vue.js](https://img.youtube.com/vi/WE9en_bio90/0.jpg)](https://www.youtube.com/watch?v=WE9en_bio90&list=PLzA2VyZwsq_92Fnb4JEUnXUhSYfNHtcKx)

---

## **4. Reactive Effects (`watchEffect`)**

### What is watchEffect?

`watchEffect` is a function that runs immediately and automatically reacts to any reactive data you use within it, without needing to explicitly declare it.

### Example

```vue
<script setup>
import { ref, watchEffect } from "vue";

const message = ref("Hola");

watchEffect(() => {
  console.log(`El mensaje actual es: ${message.value}`);
});
</script>

<template>
  <input v-model="message" placeholder="Escribe algo" />
</template>

<style scoped>
input {
  padding: 6px;
}
</style>
```

---

[![watchEffect vs watch in Vue.js](https://img.youtube.com/vi/FLoweJBBbjs/0.jpg)](https://www.youtube.com/watch?v=FLoweJBBbjs&list=PLzA2VyZwsq_92Fnb4JEUnXUhSYfNHtcKx)

---

## **5. Differences between computed, watch and watchEffect**

| Tool | Main use | React to |
| ----------- | -------------------------------------------- | -------------------------- |
| computed | Calculate a derived value | Specific dependencies |
| watch | Run logic when a specific value changes | Observed variables |
| watchEffect | Execute logic when using any reactive data | All reagents used |

---

## Practical summary

| Case | Recommendation |
| -------------------------------------------------------- | ------------- |
| Show a calculated value in the template | computed |
| Run a process after a specific change | watch |
| Automatically sync with any used reagent | watchEffect |

---

In the next topic we will explore how to **Create and Validate Forms** in a simple way using objects, the `v-model` directive and the `@submit.prevent` event.
