# **Tema 6: Estilo y Clases Dinámicas en Vue.js**

## **1. Introducción**

En Vue.js podemos aplicar clases CSS y estilos inline de forma dinámica. Esto permite que los estilos cambien en función de los datos reactivos, lo que es especialmente útil para resaltar elementos, mostrar estados o realizar adaptaciones visuales según la interacción del usuario.

---

## **2. Aplicar clases dinámicas con v-bind:class**

La directiva `v-bind:class` (o su forma corta `:class`) permite asociar una o varias clases en función de variables reactivas.

### Ejemplo básico

```vue
<script setup>
import { ref } from "vue";

const isActive = ref(true);
</script>

<template>
  <p :class="{ active: isActive }">Este párrafo cambia su clase</p>
</template>

<style scoped>
.active {
  color: green;
  font-weight: bold;
}
</style>
```

Aquí se aplicará la clase `active` al elemento `<p>` si la propiedad `isActive` es truthy.

---

## **3. Aplicar múltiples clases condicionales**

Puedes combinar varias clases dinámicas en un mismo `:class`, utilizando un objeto o array.

### Ejemplo

```vue
<script setup>
import { ref } from "vue";

const isActive = ref(true);
const isHighlighted = ref(false);
</script>

<template>
  <p :class="{ active: isActive, highlighted: isHighlighted }">
    Texto con clases múltiples
  </p>
</template>

<style scoped>
.active {
  color: green;
}
.highlighted {
  background-color: yellow;
}
</style>
```

---

[![Clases dinámicas](https://img.youtube.com/vi/8iLO9gra6RQ/0.jpg)](https://www.youtube.com/watch?v=8iLO9gra6RQ&list=PLzA2VyZwsq_92Fnb4JEUnXUhSYfNHtcKx)

---

## **4. Aplicar estilos inline dinámicos con v-bind:style**

Además de las clases, también se pueden definir estilos CSS directamente desde variables reactivas.

### Ejemplo básico

```vue
<script setup>
import { ref } from "vue";

const textColor = ref("blue");
const fontSize = ref("20px");
</script>

<template>
  <p :style="{ color: textColor, fontSize: fontSize }">
    Texto con estilo dinámico
  </p>
</template>

<style scoped>
p {
  margin: 10px 0;
}
</style>
```

---

## **5. Cambiar clases y estilos desde eventos**

Es muy común cambiar clases o estilos directamente tras alguna interacción.

### Ejemplo

```vue
<script setup>
import { ref } from "vue";

const isDanger = ref(false);

function toggleDanger() {
  isDanger.value = !isDanger.value;
}
</script>

<template>
  <p :class="{ danger: isDanger }">Este texto puede ser peligroso</p>
  <button @click="toggleDanger">Cambiar estado</button>
</template>

<style scoped>
.danger {
  color: red;
}
button {
  margin-top: 10px;
}
</style>
```

---

## **6. Combinar clases dinámicas y estilos inline**

Vue permite mezclar ambas técnicas en un mismo elemento.

### Ejemplo

```vue
<script setup>
import { ref } from "vue";

const isActive = ref(true);
const customColor = ref("purple");
</script>

<template>
  <p :class="{ active: isActive }" :style="{ color: customColor }">
    Texto con clase y estilo dinámico
  </p>
</template>

<style scoped>
.active {
  font-weight: bold;
}
</style>
```

---

## Resumen

| Directiva | Uso                                 |
| --------- | ----------------------------------- |
| `:class`  | Añadir clases dinámicas             |
| `:style`  | Añadir estilos CSS inline dinámicos |

---

En el próximo tema exploraremos **la Comunicación entre Componentes: Props, Component Events y Slots en Vue.js**, para aprender a pasar datos, emitir eventos y crear componentes flexibles.
