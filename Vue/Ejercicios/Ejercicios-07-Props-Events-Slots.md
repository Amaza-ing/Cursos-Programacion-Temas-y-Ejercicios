# **Exercises - Topic 7: Communication between Components - Props, Component Events and Slots**

Below you'll find 7 practical exercises on communication between components in Vue.

Try to solve them before looking at the solution.

---

## **Exercise 1: Child component with a title prop**

Create a `TitleCard.vue` component that receives a `title` prop and displays it as a heading.

<details><summary>Show solution</summary>

```vue
<script setup>
const props = defineProps({
  title: String,
});
</script>

<template>
  <h3>{{ props.title }}</h3>
</template>

<style scoped>
h3 {
  color: navy;
}
</style>
```

</details>

---

## **Exercise 2: Send an event from the child to the parent**

Create an `AlertButton.vue` component that emits an event called `alertClicked` when the button is clicked.

<details><summary>Show solution</summary>

```vue
<script setup>
const emit = defineEmits(["alertClicked"]);

function sendAlert() {
  emit("alertClicked");
}
</script>

<template>
  <button @click="sendAlert">Enviar alerta</button>
</template>

<style scoped>
button {
  background-color: orange;
  border: none;
  padding: 8px 16px;
}
</style>
```

</details>

---

## **Exercise 3: Parent component showing the received event**

Create an `AlertContainer.vue` component that listens to the `alertClicked` event of a child component and displays a message.

<details><summary>Show solution</summary>

```vue
<script setup>
import { ref } from "vue";
import AlertButton from "./AlertButton.vue";

const message = ref("");

function handleAlert() {
  message.value = "¡Botón presionado desde el hijo!";
}
</script>

<template>
  <div>
    <AlertButton @alertClicked="handleAlert" />
    <p>{{ message }}</p>
  </div>
</template>

<style scoped>
p {
  color: green;
}
</style>
```

</details>

---

## **Exercise 4: Child component with custom content in a slot**

Create a `CardContainer.vue` component that wraps a generic slot.

<details><summary>Show solution</summary>

```vue
<template>
  <div class="card">
    <slot></slot>
  </div>
</template>

<style scoped>
.card {
  border: 1px solid #ccc;
  padding: 16px;
  border-radius: 8px;
}
</style>
```

</details>

---

## **Exercise 5: Using a named slot for a footer**

Create a `CustomCard.vue` component that has a slot named `footer`.

<details><summary>Show solution</summary>

```vue
<template>
  <div class="card">
    <slot></slot>
    <footer>
      <slot name="footer"></slot>
    </footer>
  </div>
</template>

<style scoped>
.card {
  border: 1px solid gray;
  padding: 12px;
}
footer {
  margin-top: 12px;
  text-align: right;
}
</style>
```

Usage:

```vue
<CustomCard>
  <p>Contenido principal</p>
  <template #footer>
    <button>Cerrar</button>
  </template>
</CustomCard>
```

</details>

---

## **Exercise 6: Child component that receives two props and displays them**

Create a `ProfileCard.vue` component that receives `name` and `age` as props and displays them.

<details><summary>Show solution</summary>

```vue
<script setup>
const props = defineProps({
  name: String,
  age: Number,
});
</script>

<template>
  <div>
    <p>Nombre: {{ props.name }}</p>
    <p>Edad: {{ props.age }} años</p>
  </div>
</template>

<style scoped>
p {
  margin: 4px 0;
}
</style>
```

</details>

---

## **Exercise 7: Child component that emits an event with data**

Create a `CounterButton.vue` component that has an internal counter and emits the updated value each time the button is clicked.

<details><summary>Show solution</summary>

```vue
<script setup>
import { ref } from "vue";

const emit = defineEmits(["updateCount"]);
const count = ref(0);

function increment() {
  count.value++;
  emit("updateCount", count.value);
}
</script>

<template>
  <button @click="increment">Contador: {{ count }}</button>
</template>

<style scoped>
button {
  background-color: lightgreen;
}
</style>
```

</details>
