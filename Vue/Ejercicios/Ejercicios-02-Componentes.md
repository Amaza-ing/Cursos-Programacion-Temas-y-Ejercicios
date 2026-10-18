# **Exercises - Topic 2: Components in Vue.js**

Below you'll find 3 practical exercises on components in Vue.

Try to solve them before looking at the solution.

## **Exercise 1: Create a basic component**

Create a component called `WelcomeMessage.vue` that displays a welcome message. Remember to follow the structure: `<script setup>`, `<template>`, `<style>`.

<details><summary>Show solution</summary>

`WelcomeMessage.vue`

```vue
<script setup>
import { ref } from "vue";

const welcomeText = ref("¡Bienvenido al curso de Vue 3!");
</script>

<template>
  <h1>{{ welcomeText }}</h1>
</template>

<style scoped>
h1 {
  color: teal;
  font-weight: bold;
}
</style>
```

</details>

---

## **Exercise 2: Button component**

Create a component called `BaseButton.vue` that takes a text as a variable and displays it inside a button.

<details><summary>Show solution</summary>

`BaseButton.vue`

```vue
<script setup>
const label = ref("Click me!");
</script>

<template>
  <button>{{ label }}</button>
</template>

<style scoped>
button {
  padding: 10px 20px;
  background-color: #42b983;
  color: white;
  border: none;
  cursor: pointer;
}
</style>
```

</details>

---

## **Exercise 3: Parent-child component**

Create a `ParentComponent.vue` component that displays the `WelcomeMessage.vue` component.

<details><summary>Show solution</summary>

`ParentComponent.vue`

```vue
<script setup>
import WelcomeMessage from "./WelcomeMessage.vue";
</script>

<template>
  <div>
    <WelcomeMessage />
  </div>
</template>

<style scoped>
div {
  border: 1px solid #ddd;
  padding: 16px;
}
</style>
```

</details>
