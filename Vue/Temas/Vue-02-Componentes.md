# **Topic 2: Components in Vue.js**

## **1. What is a component?**

In Vue.js, a **component** is a reusable, independent unit of the user interface. Each component manages its own content, logic and style.

With the **Composition API** and the `<script setup>` syntax, working with components is even easier and more efficient.

---

## **2. Structure of a Vue component**

In Vue 3, each component is defined in a `.vue` file with the following basic structure:

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
- `script setup`: Defines the component's logic using the Composition API.
- `style scoped`: Adds local styles that only apply to this component.

> Note: If we don't add the `scoped` attribute to the `style` tag, the styles will apply to every component in the project.

---

## **3. Creating a component**

To create a component called `MyComponent.vue`, just create the file inside `src/components`:

Component names must start with a capital letter and use PascalCase (every word in the name starts with a capital letter).

```
src/components/MyComponent.vue
```

The component's content:

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

> Note: In this example, `ref()` is used to create a reactive variable; we'll cover this later.

---

## **4. Using one component inside another**

Once it's created, we can import and use the component in `App.vue` or in other components.

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

In the next topic, we'll explore **reactive variables, events and binding in Vue.js**, to learn how to handle user interaction.
