# **Topic 4: Composition API vs Option API in Vue.js**

## **1. Introduction**

In Vue 3, the **Composition API** was introduced, a new approach to defining component logic. Until then, Vue exclusively used the **Option API**, which is still available in Vue 3.

In this course we will only use the most modern and recommended syntax, that is, the **Composition API**, but it is essential to know the differences.

---

## **2. Option API: Traditional structure**

The **Option API** organizes a component's code into predefined sections (data, methods, computed, etc.). It is familiar to developers coming from Vue 2.

### Option API Example

```vue
<script>
export default {
  data() {
    return {
      counter: 0,
    };
  },
  methods: {
    increment() {
      this.counter++;
    },
  },
};
</script>

<template>
  <div>
    <p>Contador: {{ counter }}</p>
    <button @click="increment">Incrementar</button>
  </div>
</template>

<style scoped>
button {
  padding: 10px;
}
</style>
```

---

## **3. Composition API: New approach**

The **Composition API** allows you to organize logic by functionality, using composition functions such as `ref()` and `computed()`. This flexibility improves organization into complex components.

### Composition API Example

```vue
<script setup>
import { ref } from "vue";

const counter = ref(0);

function increment() {
  counter.value++;
}
</script>

<template>
  <div>
    <p>Contador: {{ counter }}</p>
    <button @click="increment">Incrementar</button>
  </div>
</template>

<style scoped>
button {
  padding: 10px;
}
</style>
```

---

## **4. Key differences**

| Appearance | Options API | Composition API |
| ------------------------ | ------------------------------------------- | -------------------------------------------- |
| **Structure** | Separated by options (data, methods, etc.) | Logic grouped by functionality |
| **Learning curve** | Easier for beginners | Requires knowing new functions |
| **Reactivity** | Implicit via `data()` | Manually defined with `ref()` and `reactive()` |
| **Composition** | Difficult to combine reusable logic | Easy to split into reusable functions |
| **Migration** | Compatible with Vue 2 | Vue 3 Exclusive |

---

## **5. When to use each one**

| Situation | Recommendation |
| ------------------------------------------- | -------------------------------------- |
| Small or simple applications | Option API is enough |
| Medium/Large Applications | Composition API improves organization |
| Reuse logic between components | Composition API is more efficient |
| You work with a team accustomed to Vue 2 | Option API may be more natural |

---

## **6. Complete comparative example**

### Component with Option API

```vue
<script>
export default {
  data() {
    return { message: "Hola desde Option API" };
  },
};
</script>

<template>
  <p>{{ message }}</p>
</template>

<style scoped>
p {
  color: blue;
}
</style>
```

### Component with Composition API

```vue
<script setup>
import { ref } from "vue";

const message = ref("Hola desde Composition API");
</script>

<template>
  <p>{{ message }}</p>
</template>

<style scoped>
p {
  color: blue;
}
</style>
```

---

In the next topic we will explore Conditional Control Structures and Dynamic Lists in Vue.js to display conditional content and loop through arrays.
