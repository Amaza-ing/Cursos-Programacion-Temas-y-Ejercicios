# **Exercises - Topic 13: The Life Cycle of Components in Vue.js**

Below you will find 5 practical exercises on the life cycle of components in Vue.js.

Try to solve them before consulting the solution.

---

## **Exercise 1: Display a message when mounting the component**

Create an `WelcomeMessage.vue` component that displays a console message when mounted.

<details><summary>Show Solution</summary>

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

Create an `FormDraft.vue` component that temporarily saves a message when unmounted.

<details><summary>Show Solution</summary>

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

## **Exercise 3: Show message before and after updating**

Create an `ReactiveMessage.vue` component that displays a console message before and after updating its content.

<details><summary>Show Solution</summary>

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

## **Exercise 4: Initialize a timer on mount and clear it on unmount**

Create an `TimerComponent.vue` component that starts a counter on mount and stops it on unmount.

<details><summary>Show Solution</summary>

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

## **Exercise 5: Log in console when creating and deleting a component**

Create an `LifecycleLogger.vue` component that logs console messages upon creation and deletion.

<details><summary>Show Solution</summary>

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
