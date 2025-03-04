# **Ejercicios - Tema 11: Gestión de Estado Global con Pinia**

A continuación, encontrarás 6 ejercicios prácticos sobre la gestión de estado global con Pinia.

Intenta resolverlos antes de consultar la solución.

---

## **Ejercicio 1: Crear un store de contador**

Crea un store llamado `counterStore` que tenga un estado `counter`, una acción para incrementarlo y un getter que devuelva el triple del contador.

<details><summary>Mostrar Solución</summary>

`stores/counter.js`

```javascript
import { defineStore } from "pinia";

export const useCounterStore = defineStore("counter", {
  state: () => ({
    counter: 0,
  }),
  actions: {
    increment() {
      this.counter++;
    },
  },
  getters: {
    tripleCount: (state) => state.counter * 3,
  },
});
```

</details>

---

## **Ejercicio 2: Mostrar y actualizar el contador en un componente**

Crea un componente `CounterDisplay.vue` que muestre el valor de `counter` y tenga un botón para incrementarlo.

<details><summary>Mostrar Solución</summary>

`CounterDisplay.vue`

```vue
<script setup>
import { useCounterStore } from "../stores/counter";

const counterStore = useCounterStore();
</script>

<template>
  <div>
    <p>Contador: {{ counterStore.counter }}</p>
    <button @click="counterStore.increment">Incrementar</button>
  </div>
</template>

<style scoped>
button {
  padding: 8px 16px;
}
</style>
```

</details>

---

## **Ejercicio 3: Crear un store para usuarios**

Crea un store `userStore` que gestione el nombre de un usuario y una acción para actualizarlo.

<details><summary>Mostrar Solución</summary>

`stores/user.js`

```javascript
import { defineStore } from "pinia";

export const useUserStore = defineStore("user", {
  state: () => ({
    name: "",
  }),
  actions: {
    setName(newName) {
      this.name = newName;
    },
  },
});
```

</details>

---

## **Ejercicio 4: Crear un componente que modifique el nombre del usuario**

Crea un componente `UserEditor.vue` con un input y un botón para guardar el nombre en el store.

<details><summary>Mostrar Solución</summary>

`UserEditor.vue`

```vue
<script setup>
import { ref } from "vue";
import { useUserStore } from "../stores/user";

const userStore = useUserStore();
const newName = ref("");

function saveName() {
  userStore.setName(newName.value);
}
</script>

<template>
  <div>
    <input v-model="newName" placeholder="Introduce tu nombre" />
    <button @click="saveName">Guardar nombre</button>
  </div>
</template>

<style scoped>
input,
button {
  margin-right: 8px;
}
</style>
```

</details>

---

## **Ejercicio 5: Mostrar el nombre guardado en otro componente**

Crea un componente `UserGreeting.vue` que acceda al store y muestre un saludo personalizado usando el nombre almacenado.

<details><summary>Mostrar Solución</summary>

`UserGreeting.vue`

```vue
<script setup>
import { useUserStore } from "../stores/user";

const userStore = useUserStore();
</script>

<template>
  <p>Hola, {{ userStore.name || "invitado" }}!</p>
</template>

<style scoped>
p {
  font-weight: bold;
}
</style>
```

</details>

---

## **Ejercicio 6: Crear un getter para calcular la longitud del nombre**

Añade un getter al `userStore` llamado `nameLength` que devuelva la cantidad de caracteres del nombre actual.

<details><summary>Mostrar Solución</summary>

`stores/user.js`

```javascript
import { defineStore } from "pinia";

export const useUserStore = defineStore("user", {
  state: () => ({
    name: "",
  }),
  actions: {
    setName(newName) {
      this.name = newName;
    },
  },
  getters: {
    nameLength: (state) => state.name.length,
  },
});
```

</details>
