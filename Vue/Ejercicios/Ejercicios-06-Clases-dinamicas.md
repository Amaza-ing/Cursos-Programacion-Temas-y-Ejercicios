# **Exercises - Topic 6: Styles and Dynamic Classes in Vue.js**

Below you'll find 6 practical exercises on styles and dynamic classes in Vue.

Try to solve them before looking at the solution.

---

## **Exercise 1: Apply a class if a user is active**

Create a `UserStatus.vue` component that displays a paragraph with the `active` class if the `isUserActive` variable is `true`.

<details><summary>Show solution</summary>

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

Create a `DynamicBox.vue` component that always applies `box`, applies `selected` if `isSelected` is `true`, and `highlighted` if `isHighlighted` is `true`.

<details><summary>Show solution</summary>

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

## **Exercise 3: Change the text color dynamically**

Create a `ColorText.vue` component with some text whose color comes from a `textColor` reactive variable.

<details><summary>Show solution</summary>

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

## **Exercise 4: Change the font size with a button**

Create a `ResizableText.vue` component with a button that increases the font size of a paragraph.

<details><summary>Show solution</summary>

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

## **Exercise 5: Switch between a light and a dark theme**

Create a `ThemeSwitcher.vue` component that applies the `dark` or `light` class to a `div` depending on the `isDarkMode` variable.

<details><summary>Show solution</summary>

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

## **Exercise 6: Change the background color from an input**

Create a `BackgroundPicker.vue` component that lets the user enter a color in an input and applies that color as the background of a `div`.

<details><summary>Show solution</summary>

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
