# **Ejercicios - Tema 8: Propiedades Computadas, watch y watchEffect en Vue.js**

A continuación, encontrarás 6 ejercicios prácticos sobre propiedades computadas, watch y watchEffect en Vue.

Intenta resolverlos antes de consultar la solución.

---

## **Ejercicio 1: Propiedad computada de precio con IVA**

Crea un componente `ProductPrice.vue` que tenga una variable reactiva `basePrice` y una propiedad computada `priceWithTax` que añada un 21% de IVA.

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 2: Watch que observa cambios de nombre**

Crea un componente `NameWatcher.vue` que tenga una variable `name`, y cada vez que cambie, muestre un mensaje en consola.

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 3: Computada para formatear un nombre completo**

Crea un componente `FullName.vue` que tenga `firstName` y `lastName`, y una computada `formattedName` que devuelva "Apellido, Nombre".

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 4: WatchEffect que reacciona a varios valores**

Crea un componente `CounterLogger.vue` con `count` y `step`, y usa un `watchEffect` para mostrar en consola cada cambio.

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 5: Computada para clasificar edad**

Crea un componente `AgeClassifier.vue` que tenga `age` y una computada `ageCategory` que devuelva "Menor", "Adulto" o "Mayor".

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 6: Watch que carga datos al cambiar un id**

Crea un componente `UserLoader.vue` que tenga `userId` y use `watch` para simular la carga de datos cuando cambia el id.

<details><summary>Mostrar Solución</summary>

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
