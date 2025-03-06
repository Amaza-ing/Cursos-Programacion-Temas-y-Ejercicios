# **Ejercicios - Tema 7: Comunicación entre Componentes - Props, Component Events y Slots**

A continuación, encontrarás 7 ejercicios prácticos sobre comunicación entre componentes en Vue.

Intenta resolverlos antes de consultar la solución.

---

## **Ejercicio 1: Componente hijo con prop de título**

Crea un componente `TitleCard.vue` que reciba una prop `title` y la muestre como un encabezado.

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 2: Enviar evento desde el hijo al padre**

Crea un componente `AlertButton.vue` que emita un evento llamado `alertClicked` cuando se presione el botón.

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 3: Componente padre mostrando el evento recibido**

Crea un componente `AlertContainer.vue` que escuche el evento `alertClicked` de un componente hijo y muestre un mensaje.

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 4: Componente hijo con contenido personalizado en slot**

Crea un componente `CardContainer.vue` que envuelva un slot genérico.

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 5: Usar un slot con nombre para un footer**

Crea un componente `CustomCard.vue` que tenga un slot con nombre `footer`.

<details><summary>Mostrar Solución</summary>

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

Uso:

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

## **Ejercicio 6: Componente hijo que recibe dos props y las muestra**

Crea un componente `ProfileCard.vue` que reciba `name` y `age` como props y las muestre.

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 7: Componente hijo que emite un evento con datos**

Crea un componente `CounterButton.vue` que tenga un contador interno y emita el valor actualizado cada vez que se presiona el botón.

<details><summary>Mostrar Solución</summary>

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
