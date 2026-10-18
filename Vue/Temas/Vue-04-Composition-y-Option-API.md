# **Topic 4: Composition API vs Options API in Vue.js**

## **1. Introduction**

Vue 3 introduced the **Composition API**, a new approach to defining component logic. Until then, Vue used only the **Options API**, which is still available in Vue 3.

In this course, we'll only use the most modern and recommended syntax, the **Composition API**, but it's essential to know the differences.

---

## **2. Options API: The traditional structure**

The **Options API** organizes a component's code into predefined sections (data, methods, computed, etc.). It's familiar to developers coming from Vue 2.

### Options API example

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

## **3. Composition API: The new approach**

The **Composition API** lets you organize logic by feature, using composition functions such as `ref()` and `computed()`. This flexibility makes complex components better organized.

### Composition API example

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

| Aspect                   | Options API                                 | Composition API                                 |
| ------------------------ | ------------------------------------------- | ----------------------------------------------- |
| **Structure**            | Split into options (data, methods, etc.)    | Logic grouped by feature                        |
| **Learning curve**       | Easier for beginners                        | Requires learning new functions                 |
| **Reactivity**           | Implicit through `data()`                   | Defined manually with `ref()` and `reactive()`  |
| **Composition**          | Hard to combine reusable logic              | Easy to split into reusable functions           |
| **Migration**            | Compatible with Vue 2                       | Vue 3 only                                      |

---

## **5. When to use each one**

| Situation                                   | Recommendation                         |
| ------------------------------------------- | -------------------------------------- |
| Small or simple applications                | The Options API is enough              |
| Medium/large applications                   | The Composition API improves organization |
| Reusing logic across components             | The Composition API is more efficient  |
| You work with a team used to Vue 2          | The Options API may feel more natural  |

---

## **6. Full side-by-side example**

### Component with the Options API

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

### Component with the Composition API

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

In the next topic, we'll explore **conditional control structures and dynamic lists in Vue.js**, to display content conditionally and loop through arrays.
