# **Tema 13: El Ciclo de Vida de los Componentes en Vue.js**

## **1. Introducción**

Cada componente en Vue pasa por una serie de fases o "etapas" desde su creación hasta su destrucción. A estas fases las llamamos el **ciclo de vida del componente**. Conocer el ciclo de vida es clave para saber **cuándo y dónde ejecutar código** específico, como peticiones a la API, suscripciones a eventos o limpieza de recursos.

En Vue 3, las funciones de ciclo de vida más importantes son:

| Hook              | Momento de ejecución                                      |
| ----------------- | --------------------------------------------------------- |
| `onBeforeMount`   | Antes de que el componente se inserte en el DOM           |
| `onMounted`       | Cuando el componente ya está en el DOM                    |
| `onBeforeUpdate`  | Antes de que el DOM se actualice (por un cambio reactivo) |
| `onUpdated`       | Justo después de que el DOM se haya actualizado           |
| `onBeforeUnmount` | Justo antes de que el componente se elimine del DOM       |
| `onUnmounted`     | Después de eliminar el componente del DOM                 |

---

## **2. Ciclo de vida en detalle**

### Creación

1. **onBeforeMount:** El componente ha sido creado, pero aún no está en el DOM.
2. **onMounted:** El componente ya se ha añadido al DOM. Aquí es ideal para hacer `fetch`, observar el tamaño de elementos, o inicializar librerías externas.

### Actualización

1. **onBeforeUpdate:** Se detectó un cambio reactivo, pero el DOM aún no refleja el cambio.
2. **onUpdated:** El DOM ya refleja los nuevos valores reactivos.

### Destrucción

1. **onBeforeUnmount:** El componente está a punto de ser eliminado del DOM.
2. **onUnmounted:** El componente ya se eliminó. Aquí es donde limpiamos timers, eventos o conexiones.

---

## **3. Ejemplo completo con todos los hooks**

```vue
<script setup>
import {
  ref,
  onBeforeMount,
  onMounted,
  onBeforeUpdate,
  onUpdated,
  onBeforeUnmount,
  onUnmounted,
} from "vue";

const message = ref("Hola Mundo");

onBeforeMount(() => {
  console.log(
    "Antes de montar: el componente se ha creado, pero no está en el DOM",
  );
});

onMounted(() => {
  console.log("Montado: el componente ya está en el DOM");
});

onBeforeUpdate(() => {
  console.log("Antes de actualizar: el DOM aún no refleja los cambios");
});

onUpdated(() => {
  console.log("Actualizado: el DOM ya refleja los cambios");
});

onBeforeUnmount(() => {
  console.log("Antes de desmontar: el componente está a punto de eliminarse");
});

onUnmounted(() => {
  console.log("Desmontado: el componente ya se eliminó");
});
</script>

<template>
  <div>
    <p>{{ message }}</p>
    <button @click="message = 'Adiós Mundo'">Actualizar mensaje</button>
  </div>
</template>
```

---

## **4. Cuándo usar cada hook**

| Hook            | Uso típico                                                         |
| --------------- | ------------------------------------------------------------------ |
| onBeforeMount   | Inicializar variables internas, preparar datos                     |
| onMounted       | Hacer fetch, añadir listeners globales, iniciar librerías externas |
| onBeforeUpdate  | Revisar valores antiguos antes de actualizar                       |
| onUpdated       | Confirmar cambios visuales, ejecutar callbacks                     |
| onBeforeUnmount | Guardar datos, advertir al usuario                                 |
| onUnmounted     | Limpiar listeners, detener timers, cerrar conexiones               |

---

## **5. Diagrama básico**

```
Creación:
  onBeforeMount → onMounted

Actualización:
  onBeforeUpdate → onUpdated

Destrucción:
  onBeforeUnmount → onUnmounted
```

---

[![Ciclo de Vida de los Componentes](https://img.youtube.com/vi/68Vpwer3CHo/0.jpg)](https://www.youtube.com/watch?v=68Vpwer3CHo&list=PLzA2VyZwsq_92Fnb4JEUnXUhSYfNHtcKx)

---

## Resumen

Comprender el ciclo de vida permite crear componentes más eficientes, limpios y con mejor manejo de recursos. Usar el hook correcto en cada momento mejora el rendimiento y la estabilidad de la aplicación.

En el próximo tema exploraremos **Cómo realizar Tests Unitarios usando Vitest**.
