# **Topic 13: The Component Lifecycle in Vue.js**

## **1. Introduction**

Every component in Vue goes through a series of phases or "stages" from its creation to its destruction. We call these phases the **component lifecycle**. Knowing the lifecycle is key to knowing **when and where to run specific code**, such as API requests, event subscriptions or resource cleanup.

In Vue 3, the most important lifecycle functions are:

| Hook              | When it runs                                              |
| ----------------- | --------------------------------------------------------- |
| `onBeforeMount`   | Before the component is inserted into the DOM             |
| `onMounted`       | When the component is already in the DOM                  |
| `onBeforeUpdate`  | Before the DOM is updated (because of a reactive change)  |
| `onUpdated`       | Right after the DOM has been updated                      |
| `onBeforeUnmount` | Right before the component is removed from the DOM        |
| `onUnmounted`     | After the component has been removed from the DOM         |

---

## **2. The lifecycle in detail**

### Creation

1. **onBeforeMount:** The component has been created, but isn't in the DOM yet.
2. **onMounted:** The component has already been added to the DOM. This is the ideal place to call `fetch`, measure the size of elements or initialize external libraries.

### Update

1. **onBeforeUpdate:** A reactive change was detected, but the DOM doesn't reflect it yet.
2. **onUpdated:** The DOM now reflects the new reactive values.

### Destruction

1. **onBeforeUnmount:** The component is about to be removed from the DOM.
2. **onUnmounted:** The component has already been removed. This is where we clean up timers, events or connections.

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

| Hook            | Typical use                                                        |
| --------------- | ------------------------------------------------------------------ |
| onBeforeMount   | Initialize internal variables, prepare data                        |
| onMounted       | Fetch data, add global listeners, start external libraries         |
| onBeforeUpdate  | Check old values before updating                                   |
| onUpdated       | Confirm visual changes, run callbacks                              |
| onBeforeUnmount | Save data, warn the user                                           |
| onUnmounted     | Remove listeners, stop timers, close connections                   |

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

[![The component lifecycle](https://img.youtube.com/vi/68Vpwer3CHo/0.jpg)](https://www.youtube.com/watch?v=68Vpwer3CHo&list=PLzA2VyZwsq_92Fnb4JEUnXUhSYfNHtcKx)

---

## Summary

Understanding the lifecycle lets us create cleaner, more efficient components that manage resources better. Using the right hook at the right time improves the application's performance and stability.

In the next topic, we'll explore **how to write unit tests using Vitest**.
