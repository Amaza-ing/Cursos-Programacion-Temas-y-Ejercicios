# **Topic 13: The Life Cycle of Components in Vue.js**

## **1. Introduction**

Each component in Vue goes through a series of phases or "stages" from its creation to its destruction. We call these phases the **component life cycle**. Knowing the lifecycle is key to knowing **when and where to execute specific code**, such as API requests, event subscriptions, or resource cleanup.

In Vue 3, the most important lifecycle functions are:

| Hook | Time of execution |
| ----------------- | --------------------------------------------------------- |
| `onBeforeMount` | Before the component is inserted into the DOM |
| `onMounted` | When the component is already in the DOM |
| `onBeforeUpdate` | Before the DOM is updated (by a reactive change) |
| `onUpdated` | Just after the DOM has been updated |
| `onBeforeUnmount` | Just before the component is removed from the DOM |
| `onUnmounted` | After removing the DOM component |

---

## **2. Life cycle in detail**

### Creation

1. **onBeforeMount:** The component has been created, but is not yet in the DOM.
2. **onMounted:** The component has already been added to the DOM. Here it is ideal to make `fetch`, observe the size of elements, or initialize external libraries.

### Update

1. **onBeforeUpdate:** A reactive change was detected, but the DOM does not yet reflect the change.
2. **onUpdated:** The DOM already reflects the new reactive values.

### Destruction

1. **onBeforeUnmount:** The component is about to be removed from the DOM.
2. **onUnmounted:** The component has already been removed. This is where we clean timers, events or connections.

---

## **3. Complete example with all hooks**

```vue
<script setup>
import {
  ref,
  onBeforeMount,
  onMounted,
  onBeforeUpdate,
  onUpdated,
  onBeforeUnmount,
  onUnmounted,
} from "vue";

const message = ref("Hola Mundo");

onBeforeMount(() => {
  console.log(
    "Antes de montar: el componente se ha creado, pero no está en el DOM",
  );
});

onMounted(() => {
  console.log("Montado: el componente ya está en el DOM");
});

onBeforeUpdate(() => {
  console.log("Antes de actualizar: el DOM aún no refleja los cambios");
});

onUpdated(() => {
  console.log("Actualizado: el DOM ya refleja los cambios");
});

onBeforeUnmount(() => {
  console.log("Antes de desmontar: el componente está a punto de eliminarse");
});

onUnmounted(() => {
  console.log("Desmontado: el componente ya se eliminó");
});
</script>

<template>
  <div>
    <p>{{ message }}</p>
    <button @click="message = 'Adiós Mundo'">Actualizar mensaje</button>
  </div>
</template>
```

---

## **4. When to use each hook**

| Hook | Typical use |
| --------------- | ------------------------------------------------------------------ |
| onBeforeMount | Initialize internal variables, prepare data |
| onMounted | Fetch, add global listeners, start external libraries |
| onBeforeUpdate | Review old values ​​before updating |
| onUpdated | Commit visual changes, execute callbacks |
| onBeforeUnmount | Save data, warn user |
| onUnmounted | Clear listeners, stop timers, close connections |

---

## **5. Basic diagram**

```
Creación:
  onBeforeMount → onMounted

Actualización:
  onBeforeUpdate → onUpdated

Destrucción:
  onBeforeUnmount → onUnmounted
```

---

[![Component Life Cycle](https://img.youtube.com/vi/68Vpwer3CHo/0.jpg)](https://www.youtube.com/watch?v=68Vpwer3CHo&list=PLzA2VyZwsq_92Fnb4JEUnXUhSYfNHtcKx)

---

## Summary

Understanding the life cycle allows us to create more efficient, cleaner components with better resource management. Using the correct hook at all times improves the performance and stability of the application.

In the next topic we will explore **How to perform Unit Tests using Vitest**.
