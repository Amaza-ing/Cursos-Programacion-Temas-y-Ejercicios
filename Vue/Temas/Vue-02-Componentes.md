# **Topic 2: Components in Vue.js**

## **1. What is a component?**

In Vue.js, a **component** is a reusable, independent unit of the user interface. Each component manages its own content, logic and style.

With **Composition API** and the `<script setup>` syntax, working with components is even easier and more efficient.

---

## **2. Structure of a Vue component**

In Vue 3, each component is defined in an `.vue` file with the following basic structure:

```vue
<script setup>
import { ref } from "vue";

const message = ref("Bienvenido al componente");
</script>

<template>
  <div>
    <h1>{{ message }}</h1>
  </div>
</template>

<style scoped>
h1 {
  color: blue;
}
</style>
```

### Explanation

- `template`: Contains the HTML of the component.
- `script setup`: Defines the component logic using the Composition API.
- `style scoped`: Add local styles, applicable only to the component.

> Note: If we do not add the `scoped` attribute in the `style` label, the styles will be applicable to all components of the project.

---

## **3. Creating a component**

To create a component called `MyComponent.vue`, simply create the file inside `src/components`:

Component names must start in uppercase and use PascalCase (All words in the name start in uppercase).

```
src/components/MyComponent.vue
```

Component content:

```vue
<script setup>
import { ref } from "vue";

const message = ref("Este es mi componente");
</script>

<template>
  <div>
    <p>{{ message }}</p>
  </div>
</template>

<style scoped>
p {
  font-size: 18px;
}
</style>
```

> Note: In this example `ref()` is used to create a reactive variable, we will see this later.

---

## **4. Using one component inside another**

Once created, we can import and use the component within `App.vue` or other components.

Example in `App.vue`:

```vue
<script setup>
import MyComponent from "./components/MyComponent.vue";
</script>

<template>
  <div>
    <MyComponent />
  </div>
</template>
```

---

In the next topic, we will explore **Reactive Variables, Events and Binding in Vue.js**, to learn how to manage user interaction.
