# **Exercises - Topic 9: Creating and Validating Forms in Vue.js**

Below you will find 5 practical exercises on creating and validating forms in Vue.

Try to solve them before consulting the solution.

---

## **Exercise 1: Contact form with v-model**

Create an `ContactForm.vue` component with a contact form that has the fields `nombre`, `email`, and `mensaje`, all connected to `v-model`.

<details><summary>Show Solution</summary>

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

## **Exercise 2: Basic email validation**

Create an `EmailForm.vue` component that has an input for email and validates that it contains `@` when sent.

<details><summary>Show Solution</summary>

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

## **Exercise 3: Show message when submitting form**

Create an `SimpleForm.vue` component that displays a success message upon successful submission.

<details><summary>Show Solution</summary>

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

## **Exercise 4: Disable button if the form is invalid**

Create an `LoginForm.vue` component that only allows sending if `usuario` and `contraseña` are non-empty.

<details><summary>Show Solution</summary>

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

## **Exercise 5: Validate that the fields are complete before sending**

Create an `ProfileForm.vue` component that validates that `nombre`, `apellido`, and `edad` are complete before sending.

<details><summary>Show Solution</summary>

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
