# **Topic 8: Computed Properties, watch and watchEffect in Vue.js**

## **1. Introduction**

In Vue 3, reactivity is one of the key pillars. Besides normal reactive variables (`ref` or `reactive`), Vue gives us advanced tools to handle changes:

- **Computed properties (`computed`)**: Derive values from other reactive variables.
- **watch**: Watches specific changes and runs logic when those changes happen.
- **watchEffect**: Automatically reacts to any reactive data used inside its function.

---

## **2. Computed properties**

### What is a computed property?

It's a value calculated automatically from other reactive variables. Vue takes care of updating the computed value when its dependencies change.

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

When either the `firstName` or the `lastName` variable changes its value, the `fullName` property will automatically change its value too.

---

[![Computed properties](https://img.youtube.com/vi/jeMaoz9-_tM/0.jpg)](https://www.youtube.com/watch?v=jeMaoz9-_tM&list=PLzA2VyZwsq_92Fnb4JEUnXUhSYfNHtcKx)

---

## **3. Watchers (`watch`)**

### What is a watch?

`watch` lets you run a custom function every time a specific reactive variable changes.

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

In this case, the `age` variable is being watched.

---

[![watch in Vue.js](https://img.youtube.com/vi/WE9en_bio90/0.jpg)](https://www.youtube.com/watch?v=WE9en_bio90&list=PLzA2VyZwsq_92Fnb4JEUnXUhSYfNHtcKx)

---

## **4. Reactive effects (`watchEffect`)**

### What is watchEffect?

`watchEffect` is a function that runs immediately and automatically reacts to any reactive data used inside it, without you having to declare that data explicitly.

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

| Tool        | Main use                                        | Reacts to                  |
| ----------- | ----------------------------------------------- | -------------------------- |
| computed    | Calculate a derived value                       | Specific dependencies      |
| watch       | Run logic when a specific value changes         | Watched variables          |
| watchEffect | Run logic whenever any reactive data used changes | All the reactive data used |

---

## Practical summary

| Case                                                     | Recommendation |
| -------------------------------------------------------- | -------------- |
| Show a calculated value in the template                  | computed       |
| Run a process after a specific change                    | watch          |
| Sync automatically with any reactive data used           | watchEffect    |

---

In the next topic, we'll explore how to **create and validate forms** in a simple way using objects, the `v-model` directive and the `@submit.prevent` event.
