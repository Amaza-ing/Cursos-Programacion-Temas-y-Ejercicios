# **Exercises - Topic 4: Composition API vs Options API**

Below you'll find 5 practical exercises on the Composition API and the Options API in Vue.

Try to solve them before looking at the solution.

---

## **Exercise 1: Create a counter component with the Options API**

Create a component called `CounterOption.vue` that uses the Options API to define a counter that starts at 5 and goes up by 2 each time a button is clicked.

<details><summary>Show solution</summary>

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

## **Exercise 2: Create a dynamic message with the Composition API**

Create a component called `DynamicMessage.vue` that uses the Composition API to display a message that switches between "Hola" ("Hello") and "Adiós" ("Goodbye") each time a button is clicked.

<details><summary>Show solution</summary>

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

## **Exercise 3: Display a list using the Options API**

Create a component called `NameListOption.vue` that uses the Options API to define and display a list of names.

<details><summary>Show solution</summary>

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

## **Exercise 4: Create a controlled input with the Composition API**

Create a component called `NameInput.vue` that uses the Composition API to capture the name entered by the user and display it on the screen.

<details><summary>Show solution</summary>

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

## **Exercise 5: Compare Options and Composition in the same file**

Create a file called `CompareApis.vue` and define two components inside it: one with the Options API and one with the Composition API, both displaying a fixed message.

<details><summary>Show solution</summary>

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
