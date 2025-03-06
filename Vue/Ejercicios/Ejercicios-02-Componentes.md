# **Ejercicios - Tema 2: Componentes en Vue.js**

A continuación, encontrarás 3 ejercicios prácticos sobre los componentes en Vue.

Intenta resolverlos antes de consultar la solución.

## **Ejercicio 1: Crear un componente básico**

Crea un componente llamado `WelcomeMessage.vue` que muestre un mensaje de bienvenida. Recuerda seguir la estructura: `<script setup>`, `<template>`, `<style>`.

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 2: Componente de botón**

Crea un componente llamado `BaseButton.vue` que reciba un texto como una variable y lo muestre dentro de un botón.

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 3: Componente padre-hijo**

Crea un componente `ParentComponent.vue` que muestre el componente `WelcomeMessage.vue`.

<details><summary>Mostrar Solución</summary>

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
