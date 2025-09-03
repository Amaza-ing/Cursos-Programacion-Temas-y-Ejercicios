# **Ejercicios - Tema 4: Control de Flujo en Angular (@if y @for)**

## **Instrucciones:**

A continuación, encontrarás 10 ejercicios prácticos sobre el control de flujo en Angular usando `@if` y `@for`.

Intenta resolverlos antes de consultar la solución.

---

### **Ejercicio 1: Uso básico de `@if`**

Crea una condición en la plantilla para mostrar un mensaje si la variable `isLoggedIn` es `true` y otro mensaje diferente si es `false`.

<details><summary>Mostrar solución</summary>

```html
@if (isLoggedIn) {
<p>Bienvenido, usuario.</p>
} @else {
<p>Por favor, inicia sesión.</p>
}
```

```ts
export class SomeComponent {
  isLoggedIn: boolean = false;
}
```

</details>

---

### **Ejercicio 2: Uso de `@for` para mostrar una lista**

Muestra una lista de nombres usando `@for` y optimiza con `track`.

<details><summary>Mostrar solución</summary>

```html
<ul>
  @for (name of names; track name) {
  <li>{{ name }}</li>
  }
</ul>
```

```ts
export class SomeComponent {
  names: string[] = ["Ana", "Luis", "Carlos"];
}
```

</details>

---

### **Ejercicio 3: `@if` anidado**

Crea una estructura condicional que muestre mensajes diferentes según la edad del usuario.

<details><summary>Mostrar solución</summary>

```html
@if (age < 18) {
<p>Eres menor de edad.</p>
} @else if (age < 65) {
<p>Eres un adulto.</p>
} @else {
<p>Eres un adulto mayor.</p>
}
```

```ts
export class SomeComponent {
  age: number = 30;
}
```

</details>

---

### **Ejercicio 4: Iterar sobre un array de objetos**

Muestra una lista de productos con nombre y precio usando `@for`.

<details><summary>Mostrar solución</summary>

```html
<ul>
  @for (product of products; track product.id) {
  <li>{{ product.name }} - ${{ product.price }}</li>
  }
</ul>
```

```ts
export class SomeComponent {
  products = [
    { id: 1, name: "Ordenador", price: 1000 },
    { id: 2, name: "Ratón", price: 20 },
  ];
}
```

</details>

---

### **Ejercicio 5: Alternar entre dos vistas con `@if`**

Crea un botón que cambie entre "Mostrar más" y "Mostrar menos".

<details><summary>Mostrar solución</summary>

```html
<button (click)="showMore = !showMore">
  @if (showMore) { Mostrar menos } @else { Mostrar más }
</button>
```

```ts
export class SomeComponent {
  showMore: boolean = false;
}
```

</details>

---

### **Ejercicio 6: Uso combinado de `@if` y `@for`**

Muestra una lista de tareas si hay elementos en el array, y un mensaje si está vacío.

<details><summary>Mostrar solución</summary>

```html
@if (tasks.length) {
<ul>
  @for (task of tasks; track task) {
  <li>{{ task }}</li>
  }
</ul>
} @else {
<p>No hay tareas pendientes.</p>
}
```

```ts
export class SomeComponent {
  tasks: string[] = [];
}
```

</details>

---

### **Ejercicio 7: Uso de `@for` con índice**

Muestra una lista numerada de elementos con su índice.

<details><summary>Mostrar solución</summary>

```html
<ul>
  @for ((item, index) of items; track item) {
  <li>{{ index + 1 }}. {{ item }}</li>
  }
</ul>
```

```ts
export class SomeComponent {
  items: string[] = ["Elemento 1", "Elemento 2"];
}
```

</details>

---

### **Ejercicio 8: Alternar entre dos listas con `@if`**

Muestra una lista diferente según una variable booleana.

<details><summary>Mostrar solución</summary>

```html
@if (showFruits) {
<ul>
  @for (fruit of fruits; track fruit) {
  <li>{{ fruit }}</li>
  }
</ul>
} @else {
<ul>
  @for (vegetable of vegetables; track vegetable) {
  <li>{{ vegetable }}</li>
  }
</ul>
}
```

```ts
export class SomeComponent {
  showFruits: boolean = true;
  fruits: string[] = ["Manzana", "Banana"];
  vegetables: string[] = ["Zanahoria", "Brócoli"];
}
```

</details>

---

### **Ejercicio 9: Ocultar elementos de una lista con `@if`**

Oculta elementos de una lista si cumplen cierta condición.

<details><summary>Mostrar solución</summary>

```html
<ul>
  @for (user of users; track user.id) { @if (!user.isBanned) {
  <li>{{ user.name }}</li>
  } }
</ul>
```

```ts
export class SomeComponent {
  users = [
    { id: 1, name: "Carlos", isBanned: false },
    { id: 2, name: "Ana", isBanned: true },
  ];
}
```

</details>

---

### **Ejercicio 10: Mostrar una tabla con `@for`**

Crea una tabla con datos de usuarios usando `@for`.

<details><summary>Mostrar solución</summary>

```html
<table>
  <tr>
    <th>Nombre</th>
    <th>Edad</th>
  </tr>
  @for (user of users; track user.id) {
  <tr>
    <td>{{ user.name }}</td>
    <td>{{ user.age }}</td>
  </tr>
  }
</table>
```

```ts
export class SomeComponent {
  users = [
    { id: 1, name: "Laura", age: 25 },
    { id: 2, name: "Pedro", age: 30 },
  ];
}
```

</details>
