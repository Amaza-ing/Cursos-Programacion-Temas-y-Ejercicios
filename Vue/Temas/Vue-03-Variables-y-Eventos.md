# **Topic 3: Reactive Variables, Events and Binding in Vue.js**

## **1. Reactive variables in Vue 3**

In Vue 3, reactive variables are created using `ref()` or `reactive()` within `<script setup>`. These variables let the interface update automatically when their values change. To use `ref()`, you have to import it in `<script setup>`.

When we use reactive variables like `ref()`, keep in mind that in the `<script setup>` part we can't access their value directly as we would with a normal variable; instead, we have to access it through the `.value` property.

In the `<template>` part, however, we can access their value directly without using `.value`.

### Example with `ref()`

```vue
<script setup>
import { ref } from "vue";

const counter = ref(0);

setInterval(() => {
  counter.value++;
}, 1000);
</script>

<template>
  <p>Contador: {{ counter }}</p>
</template>

<style scoped>
p {
  font-size: 18px;
}
</style>
```

---

[![Variables and reactivity](https://img.youtube.com/vi/gC8metiacVg/0.jpg)](https://www.youtube.com/watch?v=gC8metiacVg&list=PLzA2VyZwsq_92Fnb4JEUnXUhSYfNHtcKx)

---

## **2. Events in Vue 3**

Events let the user interact with the application. Events are captured directly in the template using the `v-on:` directive, or its shorthand: the `@` prefix.

### Example: Handling clicks

```vue
<script setup>
import { ref } from "vue";

const message = ref("Haz clic en el botón");

function changeMessage() {
  message.value = "¡Has hecho clic!";
}
</script>

<template>
  <div>
    <p>{{ message }}</p>
    <button @click="changeMessage">Haz clic</button>
  </div>
</template>

<style scoped>
button {
  background-color: #42b983;
  color: white;
  border: none;
  padding: 10px 20px;
  cursor: pointer;
}
</style>
```

---

[![How to get started with Vue.js](https://img.youtube.com/vi/D-gokiIzbyw/0.jpg)](https://www.youtube.com/watch?v=D-gokiIzbyw&list=PLzA2VyZwsq_92Fnb4JEUnXUhSYfNHtcKx)

---

## **3. Attribute binding (v-bind)**

**Binding** lets you link HTML attributes to the value of reactive variables. You use the `v-bind` directive, or just `:` as a shorthand.

### Example: Changing the placeholder dynamically

```vue
<script setup>
import { ref } from "vue";

const placeholderText = ref("Escribe aquí");
</script>

<template>
  <input :placeholder="placeholderText" />
</template>

<style scoped>
input {
  padding: 8px;
  width: 100%;
}
</style>
```

---

[![The v-bind directive](https://img.youtube.com/vi/CpdZPw36i4A/0.jpg)](https://www.youtube.com/watch?v=CpdZPw36i4A&list=PLzA2VyZwsq_92Fnb4JEUnXUhSYfNHtcKx)

---

## **4. Two-way binding (v-model)**

`v-model` is a directive that creates a **two-way binding** between a variable and an input; that is, the input's value updates automatically when the variable changes, and vice versa.

### Example: Input connected to a variable

```vue
<script setup>
import { ref } from "vue";

const name = ref("");
</script>

<template>
  <div>
    <label>Nombre:</label>
    <input v-model="name" />
    <p>Hola, {{ name }}</p>
  </div>
</template>

<style scoped>
label {
  display: block;
  margin-bottom: 4px;
}
input {
  padding: 8px;
}
</style>
```

---

[![The v-model directive](https://img.youtube.com/vi/QQuXu1ingRo/0.jpg)](https://www.youtube.com/watch?v=QQuXu1ingRo&list=PLzA2VyZwsq_92Fnb4JEUnXUhSYfNHtcKx)

---

## **5. Events with arguments**

Sometimes we need to pass arguments, or the event itself, to the event handler.

### Example: Capturing the text entered

```vue
<script setup>
import { ref } from "vue";

const inputText = ref("");

function handleInput(event) {
  inputText.value = event.target.value;
}
</script>

<template>
  <div>
    <input @input="handleInput" />
    <p>Texto introducido: {{ inputText }}</p>
  </div>
</template>

<style scoped>
input {
  padding: 8px;
}
</style>
```

---

## Summary

| Concept               | Syntax      | Example                         |
| --------------------- | ----------- | ------------------------------- |
| Click event           | `@click`    | `<button @click='doSomething'>` |
| Attribute binding     | `:atributo` | `<img :src='imageUrl'>`         |
| Two-way binding       | `v-model`   | `<input v-model='name'>`        |

---

In the next topic, we'll explore **the differences between the Composition API and the Options API**.
