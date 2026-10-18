# **Topic 7: Communication between Components - Props, Component Events and Slots in Vue.js**

## **1. Introduction**

In Vue applications, communication between components is key for information to flow correctly. In Vue 3, this is primarily managed with:

- **Props:** To pass data from a parent component to a child component.
- **Emits (Component Events):** For a child to notify events to the parent.
- **Slots:** For a parent component to insert custom content inside a child component.

---

## **2. Props: Pass data from parent to child**

`defineProps()` allows a child component to receive data from its parent component. The information will be passed from the parent component to the component using an attribute.

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

#### Usage in parent component:

```vue
<ChildComponent title="Bienvenido" />
```

#### Variable from parent component:

```vue
<ChildComponent :title="titleVariable" />
```

---

[![Props](https://img.youtube.com/vi/YPkwwylbgFk/0.jpg)](https://www.youtube.com/watch?v=YPkwwylbgFk&list=PLzA2VyZwsq_92Fnb4JEUnXUhSYfNHtcKx)

---

## **3. Emits (Component Events): Emit events from the child to the parent**

`defineEmits()` allows a child component to emit custom events that the parent component can listen to. With events you can travel information from the child component to the parent component.

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

Usage in parent component:

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

## **4. Slots: Customize the content of a child component**

`slots` allow the parent component to insert arbitrary content inside the child component.

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

Usage in parent component:

```vue
<Card>
  <p>Este es el contenido personalizado del slot.</p>
</Card>
```

---

[![Slots](https://img.youtube.com/vi/Wi3ljhfAheo/0.jpg)](https://www.youtube.com/watch?v=Wi3ljhfAheo&list=PLzA2VyZwsq_92Fnb4JEUnXUhSYfNHtcKx)

---

## **5. Named Slots**

Slots can be named to allow multiple customizable zones within a component.

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

Usage in parent component:

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

[![Slots with name](https://img.youtube.com/vi/4017IZG5218/0.jpg)](https://www.youtube.com/watch?v=4017IZG5218&list=PLzA2VyZwsq_92Fnb4JEUnXUhSYfNHtcKx)

---

## Summary

| Technique | Address | Usage |
| ------- | ------------- | ---------------------------- |
| Props | Father ➡️ Son | Send data to child |
| Emits | Son ➡️ Father | Notify events to parent |
| Slots | Father ➡️ Son | Customize child content |

---

In the next topic we will explore **Computed Properties, watch and watchEffect**, to have a completely reactive project.
