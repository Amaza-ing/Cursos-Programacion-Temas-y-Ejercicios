# **Tema 4: Composition API vs Option API en Vue.js**

## **1. Introducción**

En Vue 3, se introdujo la **Composition API**, un nuevo enfoque para definir la lógica de los componentes. Hasta entonces, Vue utilizaba exclusivamente la **Option API**, que sigue estando disponible en Vue 3.

En este curso utilizaremos únicamente la sintaxis más moderna y recomendada, es decir la **Composition API**, pero es fundamental conocer las diferencias.

---

## **2. Option API: Estructura tradicional**

La **Option API** organiza el código de un componente en secciones predefinidas (data, methods, computed, etc.). Es familiar para los desarrolladores que vienen de Vue 2.

### Ejemplo de Option API

```vue
<script>
export default {
  data() {
    return {
      counter: 0,
    };
  },
  methods: {
    increment() {
      this.counter++;
    },
  },
};
</script>

<template>
  <div>
    <p>Contador: {{ counter }}</p>
    <button @click="increment">Incrementar</button>
  </div>
</template>

<style scoped>
button {
  padding: 10px;
}
</style>
```

---

## **3. Composition API: Nuevo enfoque**

La **Composition API** permite organizar la lógica por funcionalidad, utilizando funciones de composición como `ref()` y `computed()`. Esta flexibilidad mejora la organización en componentes complejos.

### Ejemplo de Composition API

```vue
<script setup>
import { ref } from "vue";

const counter = ref(0);

function increment() {
  counter.value++;
}
</script>

<template>
  <div>
    <p>Contador: {{ counter }}</p>
    <button @click="increment">Incrementar</button>
  </div>
</template>

<style scoped>
button {
  padding: 10px;
}
</style>
```

---

## **4. Diferencias clave**

| Aspecto                  | Option API                                  | Composition API                                 |
| ------------------------ | ------------------------------------------- | ----------------------------------------------- |
| **Estructura**           | Separada por opciones (data, methods, etc.) | Lógica agrupada por funcionalidad               |
| **Curva de aprendizaje** | Más sencilla para principiantes             | Requiere conocer nuevas funciones               |
| **Reactividad**          | Implícita mediante `data()`                 | Definida manualmente con `ref()` y `reactive()` |
| **Composición**          | Difícil combinar lógicas reutilizables      | Fácil dividir en funciones reutilizables        |
| **Migración**            | Compatible con Vue 2                        | Exclusiva de Vue 3                              |

---

## **5. Cuándo usar cada una**

| Situación                                   | Recomendación                          |
| ------------------------------------------- | -------------------------------------- |
| Aplicaciones pequeñas o simples             | Option API es suficiente               |
| Aplicaciones medianas/grandes               | Composition API mejora la organización |
| Reutilizar lógica entre componentes         | Composition API es más eficiente       |
| Trabajas con un equipo acostumbrado a Vue 2 | Option API puede ser más natural       |

---

## **6. Ejemplo comparativo completo**

### Componente con Option API

```vue
<script>
export default {
  data() {
    return { message: "Hola desde Option API" };
  },
};
</script>

<template>
  <p>{{ message }}</p>
</template>

<style scoped>
p {
  color: blue;
}
</style>
```

### Componente con Composition API

```vue
<script setup>
import { ref } from "vue";

const message = ref("Hola desde Composition API");
</script>

<template>
  <p>{{ message }}</p>
</template>

<style scoped>
p {
  color: blue;
}
</style>
```

---

En el próximo tema exploraremos **las Estructuras de Control Condicional y Listas dinámicas en Vue.js** para mostrar contenido condicional y recorrer arrays.
