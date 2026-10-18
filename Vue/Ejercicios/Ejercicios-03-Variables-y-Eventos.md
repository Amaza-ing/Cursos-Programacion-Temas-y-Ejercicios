# **Exercises - Topic 3: Reactive Variables, Events and Binding in Vue.js**

Below you'll find 5 practical exercises on reactive variables, events and binding in Vue.

Try to solve them before looking at the solution.

---

## **Exercise 1: Create a reactive variable and display it**

Create a `DisplayMessage.vue` component that defines a reactive variable called `message` and displays it on the screen.

<details><summary>Show solution</summary>

`DisplayMessage.vue`

```vue
<script setup>
import { ref } from "vue";

const message = ref("¡Bienvenido al mundo Vue!");
</script>

<template>
  <p>{{ message }}</p>
</template>

<style scoped>
p {
  font-size: 18px;
  color: darkslateblue;
}
</style>
```

</details>

---

## **Exercise 2: Handle an event with a method**

Create a `ClickCounter.vue` component that counts how many times a button has been clicked.

<details><summary>Show solution</summary>

`ClickCounter.vue`

```vue
<script setup>
import { ref } from "vue";

const count = ref(0);

function increment() {
  count.value++;
}
</script>

<template>
  <div>
    <button @click="increment">Haz clic</button>
    <p>Has hecho clic {{ count }} veces.</p>
  </div>
</template>

<style scoped>
button {
  background-color: #42b983;
  color: white;
  border: none;
  padding: 8px 16px;
}
</style>
```

</details>

---

## **Exercise 3: Change an attribute dynamically**

Create a `DynamicImage.vue` component that displays an image and lets you change it by clicking a button.

<details><summary>Show solution</summary>

`DynamicImage.vue`

```vue
<script setup>
import { ref } from "vue";

const imageUrl = ref("https://via.placeholder.com/150");

function changeImage() {
  imageUrl.value = "https://via.placeholder.com/200";
}
</script>

<template>
  <div>
    <img :src="imageUrl" alt="Imagen dinámica" />
    <button @click="changeImage">Cambiar imagen</button>
  </div>
</template>

<style scoped>
img {
  display: block;
  margin-bottom: 10px;
}
</style>
```

</details>

---

## **Exercise 4: Input with v-model**

Create a `UserInput.vue` component with an input where the user can type their name, and display it on the screen.

<details><summary>Show solution</summary>

`UserInput.vue`

```vue
<script setup>
import { ref } from "vue";

const name = ref("");
</script>

<template>
  <div>
    <label>Nombre:</label>
    <input v-model="name" />
    <p>Hola, {{ name }}!</p>
  </div>
</template>

<style scoped>
label {
  display: block;
  margin-bottom: 5px;
}
input {
  padding: 8px;
}
</style>
```

</details>

---

## **Exercise 5: Capture an event and display the value**

Create a `TrackInput.vue` component that captures each key pressed in an input and displays it on the screen.

<details><summary>Show solution</summary>

`TrackInput.vue`

```vue
<script setup>
import { ref } from "vue";

const lastKey = ref("");

function captureKey(event) {
  lastKey.value = event.key;
}
</script>

<template>
  <div>
    <input @keydown="captureKey" />
    <p>Última tecla pulsada: {{ lastKey }}</p>
  </div>
</template>

<style scoped>
input {
  padding: 8px;
}
</style>
```

</details>
