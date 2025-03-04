# **Tema 3: Variables Reactivas, Eventos y Binding en Vue.js**

## **1. Variables reactivas en Vue 3**

En Vue 3, las variables reactivas se crean utilizando `ref()` o `reactive()` dentro de `<script setup>`. Estas variables permiten que la interfaz se actualice automáticamente cuando cambian sus valores. Para utilizar `ref()` hay que importarlo desde el `<script setup>`.

Cuando usamos variables reactivas como `ref()` debemos tener en cuenta que no podemos acceder a su valor directamente como en una variable normal en la parte del `<script setup>` sino que debemos acceder usando la propiedad `.value`.

En la parte del `<template>` sí podemos acceder a su valor directamente sin usar `.value`.

### Ejemplo con `ref()`

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

[![Variables y Reactividad](https://img.youtube.com/vi/gC8metiacVg/0.jpg)](https://www.youtube.com/watch?v=gC8metiacVg&list=PLzA2VyZwsq_92Fnb4JEUnXUhSYfNHtcKx)

---

## **2. Eventos en Vue 3**

Los eventos permiten que el usuario interactúe con la aplicación. Los eventos se capturan directamente en el template usando la directiva `v-on:`, o en su versión resumida: el prefijo `@`.

### Ejemplo: Manejar clics

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

[![Cómo empezar con Vue.js](https://img.youtube.com/vi/D-gokiIzbyw/0.jpg)](https://www.youtube.com/watch?v=D-gokiIzbyw&list=PLzA2VyZwsq_92Fnb4JEUnXUhSYfNHtcKx)

---

## **3. Binding de atributos (v-bind)**

El **binding** permite enlazar atributos HTML al valor de variables reactivas. Se usa la directiva `v-bind` o directamente `:` como atajo.

### Ejemplo: Cambiar el placeholder dinámicamente

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

[![Directiva v-bind](https://img.youtube.com/vi/CpdZPw36i4A/0.jpg)](https://www.youtube.com/watch?v=CpdZPw36i4A&list=PLzA2VyZwsq_92Fnb4JEUnXUhSYfNHtcKx)

---

## **4. Binding bidireccional (v-model)**

`v-model` es una directiva que crea un **binding bidireccional** entre una variable y un input, es decir, el valor del input se actualiza automáticamente cuando la variable cambia, y viceversa.

### Ejemplo: Input conectado a una variable

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

[![Directiva v-model](https://img.youtube.com/vi/QQuXu1ingRo/0.jpg)](https://www.youtube.com/watch?v=QQuXu1ingRo&list=PLzA2VyZwsq_92Fnb4JEUnXUhSYfNHtcKx)

---

## **5. Eventos con argumentos**

Algunas veces necesitamos pasar argumentos o el propio evento al manejador de eventos.

### Ejemplo: Capturar texto introducido

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

## Resumen

| Concepto              | Sintaxis    | Ejemplo                         |
| --------------------- | ----------- | ------------------------------- |
| Evento de clic        | `@click`    | `<button @click='doSomething'>` |
| Binding de atributo   | `:atributo` | `<img :src='imageUrl'>`         |
| Binding bidireccional | `v-model`   | `<input v-model='name'>`        |

---

En el próximo tema exploraremos **las diferencias entre Composition API y Option API**.
