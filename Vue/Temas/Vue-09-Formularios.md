# **Topic 9: Creating and Validating Forms in Vue.js**

## **1. Introduction**

Forms are a fundamental element in any web application, and in Vue.js we can manage them reactively and easily. Using the `v-model` directive, we can connect each field of a form directly to a reactive property. Additionally, with the `@submit.prevent` event, we control the submission of the form avoiding the default behavior.

In this topic we will learn to:

- Create forms with `v-model`
- Validate forms easily
- Show reactive error messages

---

## **2. Creating forms with v-model**

`v-model` creates **bidirectional binding**, which means that the value of the input will always reflect the value of the variable, and any change to the input will automatically update the variable.

Since the default behavior of the `submit` event is to reload the page, we must prevent this. This can be achieved by adding `.prevent` to the event listener. Leaving like this: `@submit.prevent`.

### Basic example

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

## **3. Basic Form Validation**

In Vue we can validate forms directly in the `handleSubmit` method, or even with computed properties.

### Example with manual validation

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

[![Forms](https://img.youtube.com/vi/_Ynr8bntF7A/0.jpg)](https://www.youtube.com/watch?v=_Ynr8bntF7A&list=PLzA2VyZwsq_92Fnb4JEUnXUhSYfNHtcKx)

---

## **4. Manage shipping status**

It is common to disable the submit button while the form is invalid or processing.

### Example

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

## **5. Real-time validation**

We can observe the changes in the fields and automatically validate with `watch`.

### Example

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

## Summary

| Technique | Purpose |
| ----------------- | ------------------------------------------------------------------ |
| `v-model` | Connect inputs with reactive variables |
| `@submit.prevent` | Control sending manually preventing page reload |
| `computed` | Calculate form validity |
| `watch` | Validate in real time |

---

In the next topic we will explore **Vue Router and Router Links**, for creating **views** and routes in a SPA project.
