# **Tema 9: Creación y Validación de Formularios en Vue.js**

## **1. Introducción**

Los formularios son un elemento fundamental en cualquier aplicación web, y en Vue.js podemos gestionarlos de forma reactiva y sencilla. Usando la directiva `v-model`, podemos conectar cada campo de un formulario directamente con una propiedad reactiva. Además, con el evento `@submit.prevent`, controlamos el envío del formulario evitando el comportamiento por defecto.

En este tema aprenderemos a:

- Crear formularios con `v-model`
- Validar formularios de forma sencilla
- Mostrar mensajes de error reactivos

---

## **2. Creación de formularios con v-model**

`v-model` crea un **binding bidireccional**, lo que significa que el valor del input siempre reflejará el valor de la variable, y cualquier cambio en el input actualizará automáticamente la variable.

Como el comportamiento por defecto del evento `submit` es recargar la página debemos prevenirlo. Esto se puede conseguir añadiendo `.prevent` al event listener. Quedando así: `@submit.prevent`.

### Ejemplo básico

```vue
<script setup>
import { ref } from "vue";

const formData = ref({
  name: "",
  email: "",
});

function handleSubmit() {
  console.log("Formulario enviado:", formData.value);
}
</script>

<template>
  <form @submit.prevent="handleSubmit">
    <label for="name">Nombre:</label>
    <input id="name" v-model="formData.name" type="text" />

    <label for="email">Email:</label>
    <input id="email" v-model="formData.email" type="email" />

    <button>Enviar</button>
  </form>
</template>

<style scoped>
form {
  display: flex;
  flex-direction: column;
  gap: 10px;
}
input,
button {
  padding: 8px;
}
</style>
```

---

## **3. Validación de formularios básica**

En Vue podemos validar los formularios directamente en el método `handleSubmit`, o incluso con propiedades computadas.

### Ejemplo con validación manual

```vue
<script setup>
import { ref } from "vue";

const formData = ref({
  name: "",
  email: "",
});

const errors = ref([]);

function validateForm() {
  errors.value = [];

  if (!formData.value.name) {
    errors.value.push("El nombre es obligatorio.");
  }

  if (!formData.value.email.includes("@")) {
    errors.value.push("El email debe ser válido.");
  }
}

function handleSubmit() {
  validateForm();

  if (errors.value.length === 0) {
    console.log("Formulario válido:", formData.value);
  }
}
</script>

<template>
  <form @submit.prevent="handleSubmit">
    <label for="name">Nombre:</label>
    <input id="name" v-model="formData.name" type="text" />

    <label for="email">Email:</label>
    <input id="email" v-model="formData.email" type="email" />

    <ul v-if="errors.length">
      <li v-for="(error, index) in errors" :key="index">{{ error }}</li>
    </ul>

    <button type="submit">Enviar</button>
  </form>
</template>

<style scoped>
form {
  display: flex;
  flex-direction: column;
  gap: 10px;
}
input,
button {
  padding: 8px;
}
ul {
  color: red;
  margin: 0;
  padding: 0;
  list-style: none;
}
</style>
```

---

[![Formularios](https://img.youtube.com/vi/_Ynr8bntF7A/0.jpg)](https://www.youtube.com/watch?v=_Ynr8bntF7A&list=PLzA2VyZwsq_92Fnb4JEUnXUhSYfNHtcKx)

---

## **4. Manejar el estado de envío**

Es habitual deshabilitar el botón de enviar mientras el formulario es inválido o está procesando.

### Ejemplo

```vue
<script setup>
import { ref, computed } from "vue";

const formData = ref({
  name: "",
  email: "",
});

const isFormValid = computed(() => {
  return formData.value.name && formData.value.email.includes("@");
});

function handleSubmit() {
  console.log("Formulario enviado:", formData.value);
}
</script>

<template>
  <form @submit.prevent="handleSubmit">
    <label for="name">Nombre:</label>
    <input id="name" v-model="formData.name" type="text" />

    <label for="email">Email:</label>
    <input id="email" v-model="formData.email" type="email" />

    <button type="submit" :disabled="!isFormValid">Enviar</button>
  </form>
</template>

<style scoped>
button:disabled {
  background-color: lightgray;
  cursor: not-allowed;
}
</style>
```

---

## **5. Validación en tiempo real**

Podemos observar los cambios de los campos y validar automáticamente con `watch`.

### Ejemplo

```vue
<script setup>
import { ref, watch } from "vue";

const email = ref("");
const emailError = ref("");

watch(email, (newValue) => {
  if (!newValue.includes("@")) {
    emailError.value = "El email debe ser válido";
  } else {
    emailError.value = "";
  }
});
</script>

<template>
  <div>
    <label>Email:</label>
    <input v-model="email" type="email" />
    <p v-if="emailError" class="error">{{ emailError }}</p>
  </div>
</template>

<style scoped>
.error {
  color: red;
}
</style>
```

---

## Resumen

| Técnica           | Propósito                                                          |
| ----------------- | ------------------------------------------------------------------ |
| `v-model`         | Conectar inputs con variables reactivas                            |
| `@submit.prevent` | Controlar el envío manualmente previniendo la recarga de la página |
| `computed`        | Calcular validez de formulario                                     |
| `watch`           | Validar en tiempo real                                             |

---

En el próximo tema exploraremos **Vue Router y Router Links**, para la creación de **views** y rutas en un proyecto SPA.
