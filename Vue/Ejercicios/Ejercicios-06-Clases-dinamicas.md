# **Ejercicios - Tema 6: Estilos y Clases Dinámicas en Vue.js**

A continuación, encontrarás 6 ejercicios prácticos sobre estilos y clases dinámicas en Vue.

Intenta resolverlos antes de consultar la solución.

---

## **Ejercicio 1: Aplicar una clase si un usuario está activo**

Crea un componente `UserStatus.vue` que muestre un párrafo con la clase `active` si la variable `isUserActive` es `true`.

<details><summary>Mostrar Solución</summary>

```vue
<script setup>
import { ref } from "vue";

const isUserActive = ref(true);
</script>

<template>
  <p :class="{ active: isUserActive }">Estado del usuario</p>
</template>

<style scoped>
.active {
  color: green;
  font-weight: bold;
}
</style>
```

</details>

---

## **Ejercicio 2: Aplicar múltiples clases dinámicas**

Crea un componente `DynamicBox.vue` que aplique `box` siempre, `selected` si `isSelected` es `true`, y `highlighted` si `isHighlighted` es `true`.

<details><summary>Mostrar Solución</summary>

```vue
<script setup>
import { ref } from "vue";

const isSelected = ref(true);
const isHighlighted = ref(false);
</script>

<template>
  <div
    :class="['box', { selected: isSelected, highlighted: isHighlighted }]"
  ></div>
</template>

<style scoped>
.box {
  width: 100px;
  height: 100px;
  background-color: lightgray;
}
.selected {
  border: 2px solid blue;
}
.highlighted {
  background-color: yellow;
}
</style>
```

</details>

---

## **Ejercicio 3: Cambiar color de texto dinámicamente**

Crea un componente `ColorText.vue` que tenga un texto cuyo color proviene de una variable reactiva `textColor`.

<details><summary>Mostrar Solución</summary>

```vue
<script setup>
import { ref } from "vue";

const textColor = ref("orange");
</script>

<template>
  <p :style="{ color: textColor }">Texto dinámico</p>
</template>

<style scoped>
p {
  font-size: 18px;
}
</style>
```

</details>

---

## **Ejercicio 4: Cambiar tamaño de fuente con un botón**

Crea un componente `ResizableText.vue` que tenga un botón para aumentar el tamaño de la fuente de un párrafo.

<details><summary>Mostrar Solución</summary>

```vue
<script setup>
import { ref } from "vue";

const fontSize = ref("16px");

function increaseFont() {
  fontSize.value = parseInt(fontSize.value) + 2 + "px";
}
</script>

<template>
  <div>
    <p :style="{ fontSize: fontSize }">Texto con tamaño dinámico</p>
    <button @click="increaseFont">Aumentar tamaño</button>
  </div>
</template>

<style scoped>
button {
  margin-top: 8px;
}
</style>
```

</details>

---

## **Ejercicio 5: Cambiar entre tema claro y oscuro**

Crea un componente `ThemeSwitcher.vue` que aplique la clase `dark` o `light` a un `div` dependiendo de la variable `isDarkMode`.

<details><summary>Mostrar Solución</summary>

```vue
<script setup>
import { ref } from "vue";

const isDarkMode = ref(false);
</script>

<template>
  <div :class="isDarkMode ? 'dark' : 'light'">
    <p>Modo actual: {{ isDarkMode ? "Oscuro" : "Claro" }}</p>
    <button @click="isDarkMode = !isDarkMode">Cambiar Modo</button>
  </div>
</template>

<style scoped>
.light {
  background-color: white;
  color: black;
}
.dark {
  background-color: black;
  color: white;
}
button {
  margin-top: 10px;
}
</style>
```

</details>

---

## **Ejercicio 6: Cambiar color de fondo desde un input**

Crea un componente `BackgroundPicker.vue` que permita al usuario introducir un color en un input, y ese color se aplique como fondo de un `div`.

<details><summary>Mostrar Solución</summary>

```vue
<script setup>
import { ref } from "vue";

const backgroundColor = ref("lightblue");
</script>

<template>
  <div>
    <input v-model="backgroundColor" placeholder="Escribe un color" />
    <div :style="{ backgroundColor: backgroundColor }" class="color-box"></div>
  </div>
</template>

<style scoped>
.color-box {
  width: 100px;
  height: 100px;
  margin-top: 8px;
}
</style>
```

</details>
