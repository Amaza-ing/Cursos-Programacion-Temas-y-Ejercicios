# **Ejercicios - Tema 1: Introducción a Vue.js y Configuración del Entorno**

A continuación, encontrarás 5 ejercicios prácticos sobre los aspectos básicos de Vue.

Intenta resolverlos antes de consultar la solución.

## **Ejercicio 1: Instalación de Node.js**

Instala Node.js en tu sistema y verifica que esté correctamente instalado.

<details><summary>Mostrar Solución</summary>

Descarga Node.js desde [https://nodejs.org](https://nodejs.org) e instálalo. Luego, verifica la instalación ejecutando:

```sh
node -v
npm -v
```

</details>

---

## **Ejercicio 2: Crear un nuevo proyecto Vue con Vite**

Crea un proyecto llamado `my-blog` utilizando Vite.

<details><summary>Mostrar Solución</summary>

Ejecuta el siguiente comando:

```sh
npm create vue@latest
```

Durante la instalación, elige `my-blog` como nombre de carpeta y selecciona Vue 3 como framework. Luego:

```sh
cd my-blog
npm install
```

</details>

---

## **Ejercicio 3: Explicación de la estructura de un proyecto Vue**

Explica brevemente la función de los siguientes archivos o carpetas:

- `src/main.js`
- `src/App.vue`
- `vite.config.js`
- `package.json`

<details><summary>Mostrar Solución</summary>

- `src/main.js`: Es el punto de entrada donde se crea la aplicación Vue y se monta sobre el DOM.
- `src/App.vue`: Es el componente raíz de la aplicación.
- `vite.config.js`: Configuración personalizada para Vite (servidor, alias, plugins, etc).
- `package.json`: Define las dependencias, scripts y metadatos del proyecto.

</details>

---

## **Ejercicio 4: Levantar el servidor de desarrollo**

Arranca el servidor de desarrollo y explica qué ocurre al modificar `App.vue`.

<details><summary>Mostrar Solución</summary>

Para iniciar el servidor:

```sh
npm run dev
```

Al modificar `App.vue`, los cambios se reflejan automáticamente en el navegador sin necesidad de refrescar manualmente, gracias al Hot Module Replacement (HMR).

</details>

---

## **Ejercicio 5: Crear un componente básico en Vue**

Crea un componente llamado `HelloWorld.vue` dentro de la carpeta `src/components` que muestre un mensaje de bienvenida.

<details><summary>Mostrar Solución</summary>

Crea el archivo `src/components/HelloWorld.vue` con el siguiente contenido:

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

Luego, impórtalo y úsalo en `App.vue`:

```vue
<script setup>
import HelloWorld from "./components/HelloWorld.vue";
</script>

<template>
  <HelloWorld />
</template>
```

</details>
