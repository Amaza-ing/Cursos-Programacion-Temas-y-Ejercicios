# **Tema 7: Comunicación entre Componentes - Props, Component Events y Slots en Vue.js**

## **1. Introducción**

En aplicaciones Vue, la comunicación entre componentes es clave para que la información fluya correctamente. En Vue 3, esto se gestiona principalmente con:

- **Props:** Para pasar datos de un componente padre a un componente hijo.
- **Emits (Component Events):** Para que un hijo notifique eventos al padre.
- **Slots:** Para que un componente padre inserte contenido personalizado dentro de un componente hijo.

---

## **2. Props: Pasar datos de padre a hijo**

`defineProps()` permite a un componente hijo recibir datos desde su componente padre. La información se pasará del componente padre al componente mediante un atributo.

### Ejemplo básico

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

#### Uso en el componente padre:

```vue
<ChildComponent title="Bienvenido" />
```

#### Variable desde el componente padre:

```vue
<ChildComponent :title="titleVariable" />
```

---

[![Props](https://img.youtube.com/vi/YPkwwylbgFk/0.jpg)](https://www.youtube.com/watch?v=YPkwwylbgFk&list=PLzA2VyZwsq_92Fnb4JEUnXUhSYfNHtcKx)

---

## **3. Emits (Component Events): Emitir eventos del hijo al padre**

`defineEmits()` permite a un componente hijo emitir eventos personalizados que el componente padre puede escuchar. Con los eventos puede viajar información del componente hijo al componente padre.

### Ejemplo básico

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

Uso en el componente padre:

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

## **4. Slots: Personalizar el contenido de un componente hijo**

Los `slots` permiten que el componente padre inserte contenido arbitrario dentro del componente hijo.

### Ejemplo básico

Componente hijo (`Card.vue`):

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

Uso en el componente padre:

```vue
<Card>
  <p>Este es el contenido personalizado del slot.</p>
</Card>
```

---

[![Slots](https://img.youtube.com/vi/Wi3ljhfAheo/0.jpg)](https://www.youtube.com/watch?v=Wi3ljhfAheo&list=PLzA2VyZwsq_92Fnb4JEUnXUhSYfNHtcKx)

---

## **5. Slots con nombre**

Los slots pueden tener nombres para permitir múltiples zonas personalizables dentro de un componente.

### Ejemplo

Componente hijo (`Modal.vue`):

```vue
<template>
  <div class="modal">
    <header><slot name="header"></slot></header>
    <main><slot></slot></main>
    <footer><slot name="footer"></slot></footer>
  </div>
</template>
```

Uso en el componente padre:

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

[![Slots con nombre](https://img.youtube.com/vi/4017IZG5218/0.jpg)](https://www.youtube.com/watch?v=4017IZG5218&list=PLzA2VyZwsq_92Fnb4JEUnXUhSYfNHtcKx)

---

## Resumen

| Técnica | Dirección     | Uso                             |
| ------- | ------------- | ------------------------------- |
| Props   | Padre ➡️ Hijo | Enviar datos al hijo            |
| Emits   | Hijo ➡️ Padre | Notificar eventos al padre      |
| Slots   | Padre ➡️ Hijo | Personalizar contenido del hijo |

---

En el próximo tema exploraremos **Las Propiedades Computadas, watch y watchEffect**, para tener un proyecto completamente reactivo.
