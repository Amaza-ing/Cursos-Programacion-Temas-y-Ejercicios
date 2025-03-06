# **Ejercicios - Tema 13: El Ciclo de Vida de los Componentes en Vue.js**

A continuación, encontrarás 5 ejercicios prácticos sobre el ciclo de vida de los componentes en Vue.js.

Intenta resolverlos antes de consultar la solución.

---

## **Ejercicio 1: Mostrar un mensaje al montar el componente**

Crea un componente `WelcomeMessage.vue` que muestre un mensaje en consola al montarse.

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 2: Guardar datos antes de desmontar**

Crea un componente `FormDraft.vue` que al desmontarse guarde un mensaje temporalmente.

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 3: Mostrar mensaje antes y después de actualizar**

Crea un componente `ReactiveMessage.vue` que muestre un mensaje en consola antes y después de actualizar su contenido.

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 4: Inicializar un temporizador al montar y limpiarlo al desmontar**

Crea un componente `TimerComponent.vue` que inicie un contador al montarse y lo detenga al desmontarse.

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 5: Log en consola al crear y eliminar un componente**

Crea un componente `LifecycleLogger.vue` que registre mensajes en consola al crearse y eliminarse.

<details><summary>Mostrar Solución</summary>

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
