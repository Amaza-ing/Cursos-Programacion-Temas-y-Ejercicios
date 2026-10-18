# **Exercises - Topic 1: Introduction to Vue.js and Environment Configuration**

Below you will find 5 practical exercises on the basics of Vue.

Try to solve them before consulting the solution.

## **Exercise 1: Installing Node.js**

Install Node.js on your system and verify that it is installed correctly.

<details><summary>Show Solution</summary>

Download Node.js from [https://nodejs.org](https://nodejs.org) and install it. Then, verify the installation by running:

```sh
node -v
npm -v
```

</details>

---

## **Exercise 2: Create a new Vue project with Vite**

Create a project called `my-blog` using Vite.

<details><summary>Show Solution</summary>

Run the following command:

```sh
npm create vue@latest
```

During installation, choose `my-blog` as the folder name and select Vue 3 as the framework. Then:

```sh
cd my-blog
npm install
```

</details>

---

## **Exercise 3: Explanation of the structure of a Vue project**

Briefly explain the function of the following files or folders:

- `src/main.js`
- `src/App.vue`
- `vite.config.js`
- `package.json`

<details><summary>Show Solution</summary>

- `src/main.js`: It is the entry point where the Vue application is created and mounted on the DOM.
- `src/App.vue`: It is the root component of the application.
- `vite.config.js`: Custom configuration for Vite (server, aliases, plugins, etc.).
- `package.json`: Defines the dependencies, scripts and metadata of the project.

</details>

---

## **Exercise 4: Stand up the development server**

Start the development server and explain what happens when you modify `App.vue`.

<details><summary>Show Solution</summary>

To start the server:

```sh
npm run dev
```

When modifying `App.vue`, the changes are automatically reflected in the browser without the need to refresh manually, thanks to Hot Module Replacement (HMR).

</details>

---

## **Exercise 5: Create a basic component in Vue**

Create a component called `HelloWorld.vue` inside the `src/components` folder that displays a welcome message.

<details><summary>Show Solution</summary>

Create the `src/components/HelloWorld.vue` file with the following content:

```vue
<script setup>
const message: '¡Bienvenido a mi aplicación Vue!'
</script>

<template>
  <h1>{{ message }}</h1>
</template>

<style scoped>
h1 {
  color: green;
}
</style>
```

Then import it and use it in `App.vue`:

```vue
<script setup>
import HelloWorld from "./components/HelloWorld.vue";
</script>

<template>
  <HelloWorld />
</template>
```

</details>
