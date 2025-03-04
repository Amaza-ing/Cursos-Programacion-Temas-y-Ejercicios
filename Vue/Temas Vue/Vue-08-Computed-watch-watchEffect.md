# **Tema 8: Propiedades Computadas, watch y watchEffect en Vue.js**

## **1. Introducción**

En Vue 3, la reactividad es uno de los pilares clave. Además de las variables reactivas normales (`ref` o `reactive`), Vue nos proporciona herramientas avanzadas para manejar cambios:

- **Propiedades Computadas (`computed`)**: Derivan valores en función de otras variables reactivas.
- **watch**: Observa cambios específicos y ejecuta lógica cuando esos cambios ocurren.
- **watchEffect**: Reacciona automáticamente a cualquier dato reactivo utilizado dentro de su función.

---

## **2. Propiedades Computadas**

### ¿Qué es una propiedad computada?

Es un valor calculado automáticamente a partir de otras variables reactivas. Vue se encarga de actualizar el valor computado cuando cambian sus dependencias.

### Ejemplo

```vue
<script setup>
import { ref, computed } from "vue";

const firstName = ref("María");
const lastName = ref("Pérez");

const fullName = computed(() => `${firstName.value} ${lastName.value}`);
</script>

<template>
  <p>Nombre completo: {{ fullName }}</p>
</template>

<style scoped>
p {
  font-weight: bold;
}
</style>
```

Cuando alguna de las variables `firstName` o `lastName` cambien de valor, la propiedad `fullName` cambiará también de valor automáticamente.

---

[![Propiedades Computadas](https://img.youtube.com/vi/jeMaoz9-_tM/0.jpg)](https://www.youtube.com/watch?v=jeMaoz9-_tM&list=PLzA2VyZwsq_92Fnb4JEUnXUhSYfNHtcKx)

---

## **3. Observadores (`watch`)**

### ¿Qué es un watch?

`watch` permite ejecutar una función personalizada cada vez que cambia una variable reactiva concreta.

### Ejemplo

```vue
<script setup>
import { ref, watch } from "vue";

const age = ref(18);

watch(age, (newAge, oldAge) => {
  console.log(`La edad ha cambiado de ${oldAge} a ${newAge}`);
});
</script>

<template>
  <p>Edad: {{ age }}</p>
  <button @click="age++">Cumplir años</button>
</template>

<style scoped>
button {
  margin-top: 8px;
}
</style>
```

En este caso se está vigilando a la variable `age`;

---

[![watch en Vue.js](https://img.youtube.com/vi/WE9en_bio90/0.jpg)](https://www.youtube.com/watch?v=WE9en_bio90&list=PLzA2VyZwsq_92Fnb4JEUnXUhSYfNHtcKx)

---

## **4. Efectos Reactivos (`watchEffect`)**

### ¿Qué es watchEffect?

`watchEffect` es una función que se ejecuta inmediatamente y reacciona automáticamente a cualquier dato reactivo que use dentro de ella, sin necesidad de declararlos explícitamente.

### Ejemplo

```vue
<script setup>
import { ref, watchEffect } from "vue";

const message = ref("Hola");

watchEffect(() => {
  console.log(`El mensaje actual es: ${message.value}`);
});
</script>

<template>
  <input v-model="message" placeholder="Escribe algo" />
</template>

<style scoped>
input {
  padding: 6px;
}
</style>
```

---

[![watchEffect vs watch en Vue.js](https://img.youtube.com/vi/FLoweJBBbjs/0.jpg)](https://www.youtube.com/watch?v=FLoweJBBbjs&list=PLzA2VyZwsq_92Fnb4JEUnXUhSYfNHtcKx)

---

## **5. Diferencias entre computed, watch y watchEffect**

| Herramienta | Uso principal                                   | Reacciona a                |
| ----------- | ----------------------------------------------- | -------------------------- |
| computed    | Calcular un valor derivado                      | Dependencias específicas   |
| watch       | Ejecutar lógica cuando cambie un valor concreto | Variables observadas       |
| watchEffect | Ejecutar lógica al usar cualquier dato reactivo | Todas las reactivas usadas |

---

## Resumen práctico

| Caso                                                     | Recomendación |
| -------------------------------------------------------- | ------------- |
| Mostrar un valor calculado en el template                | computed      |
| Ejecutar un proceso tras un cambio concreto              | watch         |
| Sincronizar automáticamente con cualquier reactivo usado | watchEffect   |

---

En el próximo tema exploraremos cómo **Crear y Validar Formularios** de forma sencilla usando objetos, la directiva `v-model` y el evento `@submit.prevent`.
