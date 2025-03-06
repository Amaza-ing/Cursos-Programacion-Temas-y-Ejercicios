# **Tema 2: Componentes en Vue.js**

## **1. ¿Qué es un componente?**

En Vue.js, un **componente** es una unidad reutilizable e independiente de la interfaz de usuario. Cada componente gestiona su propio contenido, lógica y estilo.

Con **Composition API** y la sintaxis de `<script setup>`, trabajar con componentes es aún más sencillo y eficiente.

---

## **2. Estructura de un componente Vue**

En Vue 3, cada componente se define en un archivo `.vue` con la siguiente estructura básica:

```vue
<script setup>
import { ref } from "vue";

const message = ref("Bienvenido al componente");
</script>

<template>
  <div>
    <h1>{{ message }}</h1>
  </div>
</template>

<style scoped>
h1 {
  color: blue;
}
</style>
```

### Explicación

- `template`: Contiene el HTML del componente.
- `script setup`: Define la lógica del componente utilizando Composition API.
- `style scoped`: Añade estilos locales, aplicables solo al componente.

> Nota: Si no añadimos el atributo `scoped` en la etiquta `style` los estilos serán aplicables a todos los componentes del proyecto.

---

## **3. Creación de un componente**

Para crear un componente llamado `MyComponent.vue`, basta con crear el archivo dentro de `src/components`:

Los nombres de los componentes deben empezar en mayúsculas y usar PascalCase (Todas las palabras del nombre empiezan en mayúsculas).

```
src/components/MyComponent.vue
```

Contenido del componente:

```vue
<script setup>
import { ref } from "vue";

const message = ref("Este es mi componente");
</script>

<template>
  <div>
    <p>{{ message }}</p>
  </div>
</template>

<style scoped>
p {
  font-size: 18px;
}
</style>
```

> Nota: En este ejemplo se usa `ref()` para crear una variable reactiva, esto lo veremos más adelante.

---

## **4. Uso de un componente dentro de otro**

Una vez creado, podemos importar y usar el componente dentro de `App.vue` u otros componentes.

Ejemplo en `App.vue`:

```vue
<script setup>
import MyComponent from "./components/MyComponent.vue";
</script>

<template>
  <div>
    <MyComponent />
  </div>
</template>
```

---

En el próximo tema, exploraremos **Variables reactivas, Eventos y Binding en Vue.js**, para aprender a gestionar la interacción del usuario.
