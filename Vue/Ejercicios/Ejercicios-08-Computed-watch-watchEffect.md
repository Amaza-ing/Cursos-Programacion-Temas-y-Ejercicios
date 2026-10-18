# **Exercises - Topic 8: Computed Properties, watch and watchEffect in Vue.js**

Below you'll find 6 practical exercises on computed properties, watch and watchEffect in Vue.

Try to solve them before looking at the solution.

---

## **Exercise 1: Computed property for a price with VAT**

Create a `ProductPrice.vue` component that has a reactive variable `basePrice` and a computed property `priceWithTax` that adds 21% VAT.

<details><summary>Show solution</summary>

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

## **Exercise 2: A watch that observes name changes**

Create a `NameWatcher.vue` component that has a `name` variable and, every time it changes, displays a message in the console.

<details><summary>Show solution</summary>

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

## **Exercise 3: A computed property to format a full name**

Create a `FullName.vue` component that has `firstName` and `lastName`, and a `formattedName` computed property that returns "LastName, FirstName".

<details><summary>Show solution</summary>

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

## **Exercise 4: A watchEffect that reacts to multiple values**

Create a `CounterLogger.vue` component with `count` and `step`, and use a `watchEffect` to display each change in the console.

<details><summary>Show solution</summary>

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

## **Exercise 5: A computed property to classify age**

Create an `AgeClassifier.vue` component that has `age` and an `ageCategory` computed property that returns "Menor" ("Minor"), "Adulto" ("Adult") or "Mayor" ("Senior").

<details><summary>Show solution</summary>

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

## **Exercise 6: A watch that loads data when an id changes**

Create a `UserLoader.vue` component that has `userId` and uses `watch` to simulate loading data when the id changes.

<details><summary>Show solution</summary>

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
