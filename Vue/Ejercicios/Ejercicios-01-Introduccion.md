# **Exercises - Topic 1: Introduction to Vue.js and Environment Setup**

Below you'll find 5 practical exercises on the basics of Vue.

Try to solve them before looking at the solution.

## **Exercise 1: Installing Node.js**

Install Node.js on your system and check that it's installed correctly.

<details><summary>Show solution</summary>

Download Node.js from [https://nodejs.org](https://nodejs.org) and install it. Then check the installation by running:

```sh
node -v
npm -v
```

</details>

---

## **Exercise 2: Create a new Vue project with Vite**

Create a project called `my-blog` using Vite.

<details><summary>Show solution</summary>

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

## **Exercise 3: Explaining the structure of a Vue project**

Briefly explain the purpose of the following files or folders:

- `src/main.js`
- `src/App.vue`
- `vite.config.js`
- `package.json`

<details><summary>Show solution</summary>

- `src/main.js`: The entry point, where the Vue application is created and mounted on the DOM.
- `src/App.vue`: The root component of the application.
- `vite.config.js`: Custom configuration for Vite (server, aliases, plugins, etc.).
- `package.json`: Defines the project's dependencies, scripts and metadata.

</details>

---

## **Exercise 4: Start the development server**

Start the development server and explain what happens when you modify `App.vue`.

<details><summary>Show solution</summary>

To start the server:

```sh
npm run dev
```

When you modify `App.vue`, the changes show up in the browser automatically, without having to refresh manually, thanks to Hot Module Replacement (HMR).

</details>

---

## **Exercise 5: Create a basic component in Vue**

Create a component called `HelloWorld.vue` inside the `src/components` folder that displays a welcome message.

<details><summary>Show solution</summary>

Create the `src/components/HelloWorld.vue` file with the following content:

```vue
<script setup>
const message = '¡Bienvenido a mi aplicación Vue!'
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
