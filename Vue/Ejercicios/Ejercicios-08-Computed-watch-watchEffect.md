# **Exercises - Topic 8: Computed Properties, watch and watchEffect in Vue.js**

Below you will find 6 practical exercises on computed properties, watch and watchEffect in Vue.

Try to solve them before consulting the solution.

---

## **Exercise 1: Property computed price with VAT**

Create a component `ProductPrice.vue` that has a reactive variable `basePrice` and a computed property `priceWithTax` that adds 21% VAT.

<details><summary>Show Solution</summary>

```vue
<script setup>
import { ref, computed } from "vue";

const basePrice = ref(100);

const priceWithTax = computed(() => basePrice.value * 1.21);
</script>

<template>
  <p>Precio base: {{ basePrice }} €</p>
  <p>Precio con IVA: {{ priceWithTax.toFixed(2) }} €</p>
</template>

<style scoped>
p {
  font-size: 16px;
}
</style>
```

</details>

---

## **Exercise 2: Watch observing name changes**

Create a component `NameWatcher.vue` that has a variable `name`, and every time it changes, display a message in the console.

<details><summary>Show Solution</summary>

```vue
<script setup>
import { ref, watch } from "vue";

const name = ref("");

watch(name, (newName, oldName) => {
  console.log(`El nombre cambió de "${oldName}" a "${newName}"`);
});
</script>

<template>
  <input v-model="name" placeholder="Introduce tu nombre" />
</template>

<style scoped>
input {
  padding: 8px;
}
</style>
```

</details>

---

## **Exercise 3: Computed to format a full name**

Create an `FullName.vue` component that has `firstName` and `lastName`, and an `formattedName` compute that returns "LastName, FirstName".

<details><summary>Show Solution</summary>

```vue
<script setup>
import { ref, computed } from "vue";

const firstName = ref("Ana");
const lastName = ref("García");

const formattedName = computed(() => `${lastName.value}, ${firstName.value}`);
</script>

<template>
  <p>Nombre completo: {{ formattedName }}</p>
</template>

<style scoped>
p {
  font-style: italic;
}
</style>
```

</details>

---

## **Exercise 4: WatchEffect reacting to multiple values**

Create an `CounterLogger.vue` component with `count` and `step`, and use an `watchEffect` to display each change in the console.

<details><summary>Show Solution</summary>

```vue
<script setup>
import { ref, watchEffect } from "vue";

const count = ref(0);
const step = ref(1);

watchEffect(() => {
  console.log(`Count: ${count.value}, Step: ${step.value}`);
});
</script>

<template>
  <div>
    <button @click="count += step">Incrementar</button>
    <input v-model.number="step" type="number" placeholder="Paso" />
  </div>
</template>

<style scoped>
button,
input {
  margin-right: 8px;
}
</style>
```

</details>

---

## **Exercise 5: Computed to classify age**

Create an `AgeClassifier.vue` component that has `age` and an `ageCategory` compute that returns "Minor", "Adult", or "Major".

<details><summary>Show Solution</summary>

```vue
<script setup>
import { ref, computed } from "vue";

const age = ref(25);

const ageCategory = computed(() => {
  if (age.value < 18) return "Menor";
  else if (age.value < 65) return "Adulto";
  return "Mayor";
});
</script>

<template>
  <p>Edad: {{ age }} años</p>
  <p>Categoría: {{ ageCategory }}</p>
</template>

<style scoped>
p {
  margin: 4px 0;
}
</style>
```

</details>

---

## **Exercise 6: Watch that loads data when changing an id**

Create an `UserLoader.vue` component that has `userId` and uses `watch` to simulate loading data when the id changes.

<details><summary>Show Solution</summary>

```vue
<script setup>
import { ref, watch } from "vue";

const userId = ref(1);
const userData = ref("");

watch(userId, (newId) => {
  userData.value = `Cargando datos del usuario ${newId}...`;
  setTimeout(() => {
    userData.value = `Datos cargados para usuario ${newId}`;
  }, 1000);
});
</script>

<template>
  <div>
    <input v-model.number="userId" type="number" min="1" />
    <p>{{ userData }}</p>
  </div>
</template>

<style scoped>
input {
  margin-bottom: 8px;
}
</style>
```

</details>
