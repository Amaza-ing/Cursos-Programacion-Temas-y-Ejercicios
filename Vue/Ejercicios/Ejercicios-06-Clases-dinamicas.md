# **Exercises - Topic 6: Styles and Dynamic Classes in Vue.js**

Below you will find 6 practical exercises on styles and dynamic classes in Vue.

Try to solve them before consulting the solution.

---

## **Exercise 1: Apply a class if a user is active**

Creates an `UserStatus.vue` component that displays a paragraph with class `active` if the variable `isUserActive` is `true`.

<details><summary>Show Solution</summary>

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

## **Exercise 2: Apply multiple dynamic classes**

Create an `DynamicBox.vue` component that always applies `box`, `selected` if `isSelected` is `true`, and `highlighted` if `isHighlighted` is `true`.

<details><summary>Show Solution</summary>

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

## **Exercise 3: Change text color dynamically**

Create an `ColorText.vue` component that has text whose color comes from an `textColor` reactive variable.

<details><summary>Show Solution</summary>

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

## **Exercise 4: Change font size with a button**

Create an `ResizableText.vue` component that has a button to increase the font size of a paragraph.

<details><summary>Show Solution</summary>

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

## **Exercise 5: Switch between light and dark theme**

Create an `ThemeSwitcher.vue` component that applies the `dark` or `light` class to an `div` depending on the `isDarkMode` variable.

<details><summary>Show Solution</summary>

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

## **Exercise 6: Change background color from an input**

Create an `BackgroundPicker.vue` component that allows the user to enter a color in an input, and that color is applied as the background of an `div`.

<details><summary>Show Solution</summary>

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
