# **Topic 6: Style and Dynamic Classes in Vue.js**

## **1. Introduction**

In Vue.js, we can apply CSS classes and inline styles dynamically. This lets styles change based on reactive data, which is especially useful for highlighting elements, showing states or adapting the look of the page to user interaction.

---

## **2. Applying dynamic classes with v-bind:class**

The `v-bind:class` directive (or its shorthand `:class`) lets you bind one or more classes based on reactive variables.

### Basic example

```vue
<script setup>
import { ref } from "vue";

const isActive = ref(true);
</script>

<template>
  <p :class="{ active: isActive }">Este párrafo cambia su clase</p>
</template>

<style scoped>
.active {
  color: green;
  font-weight: bold;
}
</style>
```

Here, the `active` class will be applied to the `<p>` element if `isActive` is truthy.

---

## **3. Applying multiple conditional classes**

You can combine several dynamic classes in the same `:class`, using an object or an array.

### Example

```vue
<script setup>
import { ref } from "vue";

const isActive = ref(true);
const isHighlighted = ref(false);
</script>

<template>
  <p :class="{ active: isActive, highlighted: isHighlighted }">
    Texto con clases múltiples
  </p>
</template>

<style scoped>
.active {
  color: green;
}
.highlighted {
  background-color: yellow;
}
</style>
```

---

[![Dynamic classes](https://img.youtube.com/vi/8iLO9gra6RQ/0.jpg)](https://www.youtube.com/watch?v=8iLO9gra6RQ&list=PLzA2VyZwsq_92Fnb4JEUnXUhSYfNHtcKx)

---

## **4. Applying dynamic inline styles with v-bind:style**

Besides classes, you can also define CSS styles directly from reactive variables.

### Basic example

```vue
<script setup>
import { ref } from "vue";

const textColor = ref("blue");
const fontSize = ref("20px");
</script>

<template>
  <p :style="{ color: textColor, fontSize: fontSize }">
    Texto con estilo dinámico
  </p>
</template>

<style scoped>
p {
  margin: 10px 0;
}
</style>
```

---

## **5. Changing classes and styles from events**

It's very common to change classes or styles right after some interaction.

### Example

```vue
<script setup>
import { ref } from "vue";

const isDanger = ref(false);

function toggleDanger() {
  isDanger.value = !isDanger.value;
}
</script>

<template>
  <p :class="{ danger: isDanger }">Este texto puede ser peligroso</p>
  <button @click="toggleDanger">Cambiar estado</button>
</template>

<style scoped>
.danger {
  color: red;
}
button {
  margin-top: 10px;
}
</style>
```

---

## **6. Combining dynamic classes and inline styles**

Vue lets you mix both techniques on the same element.

### Example

```vue
<script setup>
import { ref } from "vue";

const isActive = ref(true);
const customColor = ref("purple");
</script>

<template>
  <p :class="{ active: isActive }" :style="{ color: customColor }">
    Texto con clase y estilo dinámico
  </p>
</template>

<style scoped>
.active {
  font-weight: bold;
}
</style>
```

---

## Summary

| Directive | Usage                               |
| --------- | ----------------------------------- |
| `:class`  | Adds dynamic classes                |
| `:style`  | Adds dynamic inline CSS styles      |

---

In the next topic, we'll explore **communication between components: props, component events and slots in Vue.js**, to learn how to pass data, emit events and create flexible components.
