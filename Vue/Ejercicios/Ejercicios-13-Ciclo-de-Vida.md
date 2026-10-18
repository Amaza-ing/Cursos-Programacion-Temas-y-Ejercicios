# **Exercises - Topic 13: The Component Lifecycle in Vue.js**

Below you'll find 5 practical exercises on the component lifecycle in Vue.js.

Try to solve them before looking at the solution.

---

## **Exercise 1: Display a message when the component is mounted**

Create a `WelcomeMessage.vue` component that displays a message in the console when it's mounted.

<details><summary>Show solution</summary>

```vue
<script setup>
import { onMounted } from "vue";

onMounted(() => {
  console.log("¡Bienvenido! El componente ya está en el DOM.");
});
</script>

<template>
  <p>Bienvenido al sistema.</p>
</template>

<style scoped>
p {
  font-size: 18px;
}
</style>
```

</details>

---

## **Exercise 2: Save data before unmounting**

Create a `FormDraft.vue` component that temporarily saves a message when it's unmounted.

<details><summary>Show solution</summary>

```vue
<script setup>
import { ref, onUnmounted } from "vue";

const draftMessage = ref("");

onUnmounted(() => {
  localStorage.setItem("draft", draftMessage.value);
  console.log("Borrador guardado en localStorage");
});
</script>

<template>
  <textarea v-model="draftMessage" placeholder="Escribe algo..."></textarea>
</template>

<style scoped>
textarea {
  width: 100%;
  height: 100px;
}
</style>
```

</details>

---

## **Exercise 3: Show a message before and after updating**

Create a `ReactiveMessage.vue` component that displays a message in the console before and after its content is updated.

<details><summary>Show solution</summary>

```vue
<script setup>
import { ref, onBeforeUpdate, onUpdated } from "vue";

const message = ref("Hola Vue");

onBeforeUpdate(() => {
  console.log("El mensaje está a punto de actualizarse:", message.value);
});

onUpdated(() => {
  console.log("Mensaje actualizado:", message.value);
});
</script>

<template>
  <div>
    <input v-model="message" />
    <p>{{ message }}</p>
  </div>
</template>

<style scoped>
input {
  margin-bottom: 8px;
}
</style>
```

</details>

---

## **Exercise 4: Start a timer on mount and clear it on unmount**

Create a `TimerComponent.vue` component that starts a counter when it's mounted and stops it when it's unmounted.

<details><summary>Show solution</summary>

```vue
<script setup>
import { ref, onMounted, onUnmounted } from "vue";

const counter = ref(0);
let interval = null;

onMounted(() => {
  interval = setInterval(() => {
    counter.value++;
  }, 1000);
});

onUnmounted(() => {
  clearInterval(interval);
  console.log("Temporizador detenido");
});
</script>

<template>
  <p>Contador: {{ counter }}</p>
</template>

<style scoped>
p {
  font-size: 24px;
}
</style>
```

</details>

---

## **Exercise 5: Log to the console when a component is created and removed**

Create a `LifecycleLogger.vue` component that logs messages to the console when it's created and removed.

<details><summary>Show solution</summary>

```vue
<script setup>
import { onBeforeMount, onMounted, onBeforeUnmount, onUnmounted } from "vue";

onBeforeMount(() => {
  console.log("Componente está a punto de montarse");
});

onMounted(() => {
  console.log("Componente montado");
});

onBeforeUnmount(() => {
  console.log("Componente a punto de desmontarse");
});

onUnmounted(() => {
  console.log("Componente desmontado");
});
</script>

<template>
  <p>Este componente registra su ciclo de vida.</p>
</template>

<style scoped>
p {
  font-weight: bold;
}
</style>
```

</details>
