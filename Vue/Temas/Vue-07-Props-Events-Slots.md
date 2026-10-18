# **Topic 7: Communication between Components - Props, Component Events and Slots in Vue.js**

## **1. Introduction**

In Vue applications, communication between components is key to making information flow correctly. In Vue 3, this is mainly handled with:

- **Props:** To pass data from a parent component to a child component.
- **Emits (Component Events):** So that a child can notify the parent of events.
- **Slots:** So that a parent component can insert custom content inside a child component.

---

## **2. Props: Passing data from parent to child**

`defineProps()` lets a child component receive data from its parent component. The information is passed from the parent component to the child through an attribute.

### Basic example

#### ChildComponent.vue

```vue
<script setup>
const props = defineProps({
  title: String,
});
</script>

<template>
  <h2>{{ props.title }}</h2>
</template>
```

#### Usage in the parent component:

```vue
<ChildComponent title="Bienvenido" />
```

#### A variable from the parent component:

```vue
<ChildComponent :title="titleVariable" />
```

---

[![Props](https://img.youtube.com/vi/YPkwwylbgFk/0.jpg)](https://www.youtube.com/watch?v=YPkwwylbgFk&list=PLzA2VyZwsq_92Fnb4JEUnXUhSYfNHtcKx)

---

## **3. Emits (Component Events): Emitting events from the child to the parent**

`defineEmits()` lets a child component emit custom events that the parent component can listen to. Events can carry information from the child component to the parent component.

### Basic example

```vue
<script setup>
const emit = defineEmits(["sendMessage"]);

function notify() {
  emit("sendMessage", "Hola desde el hijo");
}
</script>

<template>
  <button @click="notify">Enviar mensaje</button>
</template>
```

Usage in the parent component:

```vue
<ChildComponent @sendMessage="handleMessage" />
```

```js
function handleMessage(msg) {
  console.log(msg);
}
```

---

[![Component Events](https://img.youtube.com/vi/RZLrSSaYY24/0.jpg)](https://www.youtube.com/watch?v=RZLrSSaYY24&list=PLzA2VyZwsq_92Fnb4JEUnXUhSYfNHtcKx)

---

## **4. Slots: Customizing the content of a child component**

`slots` let the parent component insert any content it wants inside the child component.

### Basic example

Child component (`Card.vue`):

```vue
<template>
  <div class="card">
    <slot></slot>
  </div>
</template>

<style scoped>
.card {
  border: 1px solid #ddd;
  padding: 16px;
  border-radius: 8px;
}
</style>
```

Usage in the parent component:

```vue
<Card>
  <p>Este es el contenido personalizado del slot.</p>
</Card>
```

---

[![Slots](https://img.youtube.com/vi/Wi3ljhfAheo/0.jpg)](https://www.youtube.com/watch?v=Wi3ljhfAheo&list=PLzA2VyZwsq_92Fnb4JEUnXUhSYfNHtcKx)

---

## **5. Named slots**

Slots can have names, which allows multiple customizable areas within a component.

### Example

Child component (`Modal.vue`):

```vue
<template>
  <div class="modal">
    <header><slot name="header"></slot></header>
    <main><slot></slot></main>
    <footer><slot name="footer"></slot></footer>
  </div>
</template>
```

Usage in the parent component:

```vue
<Modal>
  <template #header>
    <h2>Título del Modal</h2>
  </template>
  <p>Contenido principal</p>
  <template #footer>
    <button>Cerrar</button>
  </template>
</Modal>
```

---

[![Named slots](https://img.youtube.com/vi/4017IZG5218/0.jpg)](https://www.youtube.com/watch?v=4017IZG5218&list=PLzA2VyZwsq_92Fnb4JEUnXUhSYfNHtcKx)

---

## Summary

| Technique | Direction      | Usage                         |
| --------- | -------------- | ----------------------------- |
| Props     | Parent ➡️ Child | Send data to the child        |
| Emits     | Child ➡️ Parent | Notify the parent of events   |
| Slots     | Parent ➡️ Child | Customize the child's content |

---

In the next topic, we'll explore **computed properties, watch and watchEffect**, to make our project fully reactive.
