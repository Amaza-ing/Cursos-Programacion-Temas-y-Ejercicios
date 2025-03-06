# **Ejercicios - Tema 4: Composition API vs Option API**

A continuación, encontrarás 5 ejercicios prácticos sobre Composition API y Option API en Vue.

Intenta resolverlos antes de consultar la solución.

---

## **Ejercicio 1: Crear un componente contador con Option API**

Crea un componente llamado `CounterOption.vue` que use Option API para definir un contador que inicia en 5 y aumenta en 2 cada vez que se pulsa un botón.

<details><summary>Mostrar Solución</summary>

`CounterOption.vue`

```vue
<script>
export default {
  data() {
    return {
      counter: 5,
    };
  },
  methods: {
    addTwo() {
      this.counter += 2;
    },
  },
};
</script>

<template>
  <div>
    <p>Contador: {{ counter }}</p>
    <button @click="addTwo">Sumar 2</button>
  </div>
</template>

<style scoped>
button {
  background-color: #3498db;
  color: white;
  border: none;
  padding: 8px 16px;
}
</style>
```

</details>

---

## **Ejercicio 2: Crear un mensaje dinámico con Composition API**

Crea un componente llamado `DynamicMessage.vue` que use Composition API para mostrar un mensaje que cambia entre "Hola" y "Adiós" cada vez que se pulsa un botón.

<details><summary>Mostrar Solución</summary>

`DynamicMessage.vue`

```vue
<script setup>
import { ref } from "vue";

const message = ref("Hola");

function toggleMessage() {
  message.value = message.value === "Hola" ? "Adiós" : "Hola";
}
</script>

<template>
  <div>
    <p>{{ message }}</p>
    <button @click="toggleMessage">Cambiar mensaje</button>
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

## **Ejercicio 3: Mostrar una lista usando Option API**

Crea un componente llamado `NameListOption.vue` que use Option API para definir y mostrar una lista de nombres.

<details><summary>Mostrar Solución</summary>

`NameListOption.vue`

```vue
<script>
export default {
  data() {
    return {
      names: ["Ana", "Luis", "María"],
    };
  },
};
</script>

<template>
  <ul>
    <li v-for="(name, index) in names" :key="index">{{ name }}</li>
  </ul>
</template>

<style scoped>
li {
  margin: 5px 0;
}
</style>
```

</details>

---

## **Ejercicio 4: Crear un input controlado con Composition API**

Crea un componente llamado `NameInput.vue` que use Composition API para capturar el nombre introducido por el usuario y mostrarlo en pantalla.

<details><summary>Mostrar Solución</summary>

`NameInput.vue`

```vue
<script setup>
import { ref } from "vue";

const name = ref("");
</script>

<template>
  <div>
    <input v-model="name" placeholder="Introduce tu nombre" />
    <p>Nombre: {{ name }}</p>
  </div>
</template>

<style scoped>
input {
  padding: 8px;
  width: 100%;
}
</style>
```

</details>

---

## **Ejercicio 5: Comparar Option y Composition en un mismo archivo**

Crea un archivo llamado `CompareApis.vue` y define dos componentes dentro: uno con Option API y otro con Composition API, ambos mostrando un mensaje fijo.

<details><summary>Mostrar Solución</summary>

`CompareApis.vue`

```vue
<template>
  <div>
    <OptionMessage />
    <CompositionMessage />
  </div>
</template>

<script>
const OptionMessage = {
  template: "<p>Mensaje desde Option API</p>",
};

export default {
  components: { OptionMessage },
};
</script>

<script setup>
import { defineComponent, ref } from "vue";

const CompositionMessage = defineComponent({
  setup() {
    const message = ref("Mensaje desde Composition API");
    return { message };
  },
  template: "<p>{{ message }}</p>",
});
</script>

<style scoped>
p {
  color: #2c3e50;
}
</style>
```

</details>
