# **Ejercicios - Tema 9: Creación y Validación de Formularios en Vue.js**

A continuación, encontrarás 5 ejercicios prácticos sobre la creación y validación de formularios en Vue.

Intenta resolverlos antes de consultar la solución.

---

## **Ejercicio 1: Formulario de contacto con v-model**

Crea un componente `ContactForm.vue` con un formulario de contacto que tenga los campos `nombre`, `email` y `mensaje`, todos conectados con `v-model`.

<details><summary>Mostrar Solución</summary>

```vue
<script setup>
import { ref } from "vue";

const form = ref({
  name: "",
  email: "",
  message: "",
});

function handleSubmit() {
  console.log("Formulario de contacto:", form.value);
}
</script>

<template>
  <form @submit.prevent="handleSubmit">
    <label>Nombre:</label>
    <input v-model="form.name" type="text" />

    <label>Email:</label>
    <input v-model="form.email" type="email" />

    <label>Mensaje:</label>
    <textarea v-model="form.message"></textarea>

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
textarea,
button {
  padding: 8px;
}
</style>
```

</details>

---

## **Ejercicio 2: Validación básica de email**

Crea un componente `EmailForm.vue` que tenga un input para email y valide que contenga `@` al enviarse.

<details><summary>Mostrar Solución</summary>

```vue
<script setup>
import { ref } from "vue";

const email = ref("");
const error = ref("");

function handleSubmit() {
  if (!email.value.includes("@")) {
    error.value = "Debe ser un email válido";
  } else {
    error.value = "";
    console.log("Email enviado:", email.value);
  }
}
</script>

<template>
  <form @submit.prevent="handleSubmit">
    <label>Email:</label>
    <input v-model="email" type="email" />
    <p v-if="error" class="error">{{ error }}</p>

    <button type="submit">Enviar</button>
  </form>
</template>

<style scoped>
.error {
  color: red;
}
</style>
```

</details>

---

## **Ejercicio 3: Mostrar mensaje al enviar formulario**

Crea un componente `SimpleForm.vue` que muestre un mensaje de éxito al enviarse correctamente.

<details><summary>Mostrar Solución</summary>

```vue
<script setup>
import { ref } from "vue";

const name = ref("");
const submitted = ref(false);

function handleSubmit() {
  submitted.value = true;
}
</script>

<template>
  <form @submit.prevent="handleSubmit">
    <label>Nombre:</label>
    <input v-model="name" type="text" />

    <button type="submit">Enviar</button>
  </form>
  <p v-if="submitted">Formulario enviado correctamente</p>
</template>

<style scoped>
form,
p {
  margin: 10px 0;
}
</style>
```

</details>

---

## **Ejercicio 4: Deshabilitar botón si el formulario es inválido**

Crea un componente `LoginForm.vue` que solo permita enviar si `usuario` y `contraseña` no están vacíos.

<details><summary>Mostrar Solución</summary>

```vue
<script setup>
import { ref, computed } from "vue";

const form = ref({
  username: "",
  password: "",
});

const isValid = computed(() => form.value.username && form.value.password);
</script>

<template>
  <form @submit.prevent="console.log('Login exitoso')">
    <label>Usuario:</label>
    <input v-model="form.username" type="text" />

    <label>Contraseña:</label>
    <input v-model="form.password" type="password" />

    <button type="submit" :disabled="!isValid">Iniciar sesión</button>
  </form>
</template>

<style scoped>
button:disabled {
  background-color: lightgray;
}
</style>
```

</details>

---

## **Ejercicio 5: Validar que los campos estén completos antes de enviar**

Crea un componente `ProfileForm.vue` que valide que `nombre`, `apellido` y `edad` estén completos antes de enviar.

<details><summary>Mostrar Solución</summary>

```vue
<script setup>
import { ref } from "vue";

const form = ref({
  firstName: "",
  lastName: "",
  age: "",
});

const errors = ref([]);

function handleSubmit() {
  errors.value = [];

  if (!form.value.firstName) errors.value.push("El nombre es obligatorio");
  if (!form.value.lastName) errors.value.push("El apellido es obligatorio");
  if (!form.value.age) errors.value.push("La edad es obligatoria");

  if (errors.value.length === 0) {
    console.log("Perfil enviado:", form.value);
  }
}
</script>

<template>
  <form @submit.prevent="handleSubmit">
    <label>Nombre:</label>
    <input v-model="form.firstName" type="text" />

    <label>Apellido:</label>
    <input v-model="form.lastName" type="text" />

    <label>Edad:</label>
    <input v-model="form.age" type="number" />

    <ul v-if="errors.length">
      <li v-for="(error, index) in errors" :key="index">{{ error }}</li>
    </ul>

    <button type="submit">Guardar perfil</button>
  </form>
</template>

<style scoped>
ul {
  color: red;
}
</style>
```

</details>
