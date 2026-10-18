# **Topic 1: Introduction to Vue.js and Environment Setup with Vite**

## **1. What is Vue.js?**

Vue.js is a **progressive framework** for building user interfaces. It was created by **Evan You** and stands out for its:

- **Simplicity and gentle learning curve**.
- **Approach based on reusable components**.
- **Declarative reactivity** that updates the interface automatically.
- **Flexibility** to fit into new or existing projects.
- **Small size** and **fast performance**.

---

## **2. Installing Node.js**

Vue requires Node.js to manage dependencies and run scripts. Download Node.js from [nodejs.org](https://nodejs.org/).

To verify the installation:

```sh
node -v
npm -v
```

---

## **3. Creating a new Vue project with Vite**

**Vite** is a project manager. Vue recommends using **Vite** as a development tool because it's fast and easy to configure.

To create a new Vue project with Vite, run:

```sh
npm create vue@latest
```

### The creation process

1. The wizard will ask you for the project name. For example:

```
Project name: my-vue-project
```

2. Select the optional features (pinia, router, testing, etc.) or keep the default options to get started.

3. Go to the project directory:

- From the terminal:

```sh
cd my-vue-project
```

- Or by opening the folder directly: File -> Open Folder -> my-vue-project

4. Install the dependencies:

```sh
npm install
```

---

## **4. Folder structure of a Vue project with Vite**

A Vue project created with Vite will have this structure:

```
my-vue-project/
│── node_modules/        # Dependencias
│── public/              # Recursos estáticos
│── src/                 # Código fuente
│   ├── assets/          # Imágenes y otros assets
│   ├── components/      # Componentes reutilizables
│   ├── App.vue          # Componente principal
│   └── main.js          # Punto de entrada
│── git.ignore           # Ignora ficheros en el repositorio
│── index.html           # HTML del proyecto
│── package.json         # Configuración del proyecto
│── README.md            # Documentación inicial
│── vite.config.js       # Configuración de Vite
```

---

## **5. Starting the development server**

To start the development server, run:

```sh
npm run dev
```

The application will be available at:

```
http://localhost:5173/
```

---

## **6. The basic makeup of a Vue component**

Vue uses a format called **Single File Component (SFC)**, which combines logic (JavaScript), the template (HTML) and styles (CSS) in a single `.vue` file.

Example:

```vue
<script setup>
let message = "Hola desde Vue!";
</script>

<template>
  <p>{{ message }}</p>
</template>

<style scoped>
p {
  color: green;
}
</style>
```

---

## **7. Recommended extensions for Visual Studio Code**

To improve the development experience, install the following extensions:

- **Vue - Official**: The official extension for Vue 3.
- **ESLint**: Checks the quality of your code.
- **Prettier**: A code formatter.

> Note: The Vue - Official extension is especially important to make .vue files display correctly.

---

[![How to get started with Vue.js](https://img.youtube.com/vi/PqJeA7p2R-Y/0.jpg)](https://www.youtube.com/watch?v=PqJeA7p2R-Y&list=PLzA2VyZwsq_92Fnb4JEUnXUhSYfNHtcKx)

---

## Important commands

Create a Vue project with Vite:

```sh
npm create vue@latest
```

Go to the project and install the dependencies:

```sh
cd my-vue-project
npm install
```

Start the development server:

```sh
npm run dev
```

---

In the next topic, we'll explore **components in Vue.js**.
