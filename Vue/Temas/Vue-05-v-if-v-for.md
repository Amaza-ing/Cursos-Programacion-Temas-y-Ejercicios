# **Tema 5: Estructuras de Control Condicional y Listas dinámicas en Vue.js**

## **1. Introducción**

En Vue.js, podemos controlar qué elementos se muestran y cómo se muestran utilizando **estructuras de control condicional** y **directivas para listas dinámicas**. Estas herramientas son esenciales para crear interfaces dinámicas y adaptables.

---

## **2. Directivas condicionales: v-if, v-else-if y v-else**

Vue proporciona la directiva `v-if` para mostrar u ocultar elementos de forma condicional.

### Ejemplo básico

```vue
<script setup>
import { ref } from "vue";

const isLoggedIn = ref(false);
</script>

<template>
  <div>
    <p v-if="isLoggedIn">Bienvenido, usuario.</p>
    <p v-else>No has iniciado sesión.</p>
  </div>
</template>

<style scoped>
p {
  font-size: 16px;
}
</style>
```

---

[![Directiva v-if](https://img.youtube.com/vi/iSxPEkS4P2s/0.jpg)](https://www.youtube.com/watch?v=iSxPEkS4P2s&list=PLzA2VyZwsq_92Fnb4JEUnXUhSYfNHtcKx)

---

## **3. Mostrar listas dinámicas con v-for**

La directiva `v-for` permite recorrer arrays y mostrar cada elemento en el DOM.

### Ejemplo básico

```vue
<script setup>
const names = ["Ana", "Luis", "Carlos"];
</script>

<template>
  <ul>
    <li v-for="(name, index) in names" :key="index">{{ name }}</li>
  </ul>
</template>

<style scoped>
li {
  list-style: none;
}
</style>
```

Cuando usamos `v-for` es importante dar un valor adecuado a la propiedad `key`, ya que esta propiedad es la que lleva el control de cada elemento de la lista. El valor de key debe ser único para cada elemento.

---

[![Listas dinámicas v-for](https://img.youtube.com/vi/RUQ5RffUh5o/0.jpg)](https://www.youtube.com/watch?v=RUQ5RffUh5o&list=PLzA2VyZwsq_92Fnb4JEUnXUhSYfNHtcKx)

---

[![Index en v-for](https://img.youtube.com/vi/vqrNhPDhDnA/0.jpg)](https://www.youtube.com/watch?v=vqrNhPDhDnA&list=PLzA2VyZwsq_92Fnb4JEUnXUhSYfNHtcKx)

---

## **4. Combinando v-if y v-for**

Podemos combinar `v-if` y `v-for` para filtrar y mostrar elementos dinámicamente.

### Ejemplo

```vue
<script setup>
const users = [
  { id: 1, name: "Ana", active: true },
  { id: 2, name: "Luis", active: false },
  { id: 3, name: "María", active: true },
];
</script>

<template>
  <ul>
    <li v-for="(user, index) in users" :key="user.id" v-if="user.active">
      {{ user.name }} (Activo)
    </li>
  </ul>
</template>

<style scoped>
li {
  color: green;
}
</style>
```


---

## **5. Listas de objetos y visualización compleja**

Las listas pueden contener objetos con múltiples propiedades, y podemos mostrar esas propiedades fácilmente.

### Ejemplo

```vue
<script setup>
const products = [
  { id: 1, name: "Teclado", price: 30 },
  { id: 2, name: "Ratón", price: 20 },
];
</script>

<template>
  <table>
    <thead>
      <tr>
        <th>Producto</th>
        <th>Precio</th>
      </tr>
    </thead>
    <tbody>
      <tr v-for="product in products" :key="product.id">
        <td>{{ product.name }}</td>
        <td>{{ product.price }} €</td>
      </tr>
    </tbody>
  </table>
</template>

<style scoped>
table {
  width: 100%;
  border-collapse: collapse;
}
th,
td {
  border: 1px solid #ddd;
  padding: 8px;
}
</style>
```

Cuando utilizamos `v-for` con objetos es muy común utilizar el campo `id` u otro campo que tenga un valor único para la propiedad `key`.

---

[![Listas de objetos con v-for](https://img.youtube.com/vi/jyTqcRGQpSY/0.jpg)](https://www.youtube.com/watch?v=jyTqcRGQpSY&list=PLzA2VyZwsq_92Fnb4JEUnXUhSYfNHtcKx)

---

## **6. v-for con objetos (propiedades dinámicas)**

También se puede usar `v-for` para recorrer las propiedades de un objeto.

### Ejemplo

```vue
<script setup>
const user = {
  name: "Ana",
  age: 30,
  country: "España",
};
</script>

<template>
  <ul>
    <li v-for="(value, key) in user" :key="key">{{ key }}: {{ value }}</li>
  </ul>
</template>

<style scoped>
li {
  text-transform: capitalize;
}
</style>
```

---

## Resumen

| Directiva   | Uso                                                                    |
| ----------- | ---------------------------------------------------------------------- |
| `v-if`      | Muestra u oculta elementos según una condición                         |
| `v-else-if` | Encadena condiciones alternativas                                      |
| `v-else`    | Define el bloque final cuando no se cumplen las condiciones anteriores |
| `v-for`     | Recorre arrays u objetos mostrando sus elementos                       |

---

En el próximo tema exploraremos **Estilo y Clases Dinámicas en Vue.js**, para aprender a aplicar clases y estilos de forma condicional y reactiva.
