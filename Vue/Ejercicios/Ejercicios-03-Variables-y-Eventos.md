# **Ejercicios - Tema 3: Variables Reactivas, Eventos y Binding en Vue.js**

A continuación, encontrarás 5 ejercicios prácticos sobre variables reactivas, eventos y binding en Vue.

Intenta resolverlos antes de consultar la solución.

---

## **Ejercicio 1: Crear una variable reactiva y mostrarla**

Crea un componente `DisplayMessage.vue` que defina una variable reactiva llamada `message` y la muestre en pantalla.

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 2: Manejar un evento con un método**

Crea un componente `ClickCounter.vue` que cuente cuántas veces se ha pulsado un botón.

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 3: Cambiar un atributo dinámicamente**

Crea un componente `DynamicImage.vue` que muestre una imagen, y permita cambiar la imagen al hacer clic en un botón.

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 4: Input con v-model**

Crea un componente `UserInput.vue` que tenga un input donde el usuario pueda escribir su nombre, y lo muestre en pantalla.

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 5: Capturar un evento y mostrar el valor**

Crea un componente `TrackInput.vue` que capture cada tecla pulsada en un input y lo muestre en pantalla.

<details><summary>Mostrar Solución</summary>

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
