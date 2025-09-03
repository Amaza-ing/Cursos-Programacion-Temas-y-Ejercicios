# **Ejercicios - Tema 5: Signals y Reactividad en Angular 19**

## **Instrucciones:**

A continuación, encontrarás 10 ejercicios prácticos sobre el uso de Signals en Angular 19.

Intenta resolverlos antes de consultar la solución.

---

### **Ejercicio 1: Crear una Signal**

Crea una Signal que almacene un número y muestre su valor en la plantilla.

<details><summary>Mostrar solución</summary>

```ts
import { signal } from "@angular/core";

export class CounterComponent {
  count = signal(0);
}
```

```html
<p>Valor actual: {{ count() }}</p>
```

</details>

---

### **Ejercicio 2: Actualizar una Signal**

Crea un botón que incremente el valor de la Signal al hacer clic.

<details><summary>Mostrar solución</summary>

```ts
export class CounterComponent {
  count = signal(0);

  increment() {
    this.count.set(this.count() + 1);
  }
}
```

```html
<p>Valor: {{ count() }}</p>
<button (click)="increment()">Incrementar</button>
```

</details>

---

### **Ejercicio 3: Computed Signal**

Crea una Computed Signal que calcule el doble del valor almacenado en una Signal.

<details><summary>Mostrar solución</summary>

```ts
import { computed, signal } from "@angular/core";

export class MathComponent {
  value = signal(5);
  doubleValue = computed(() => this.value() * 2);
}
```

```html
<p>Valor: {{ value() }}</p>
<p>El doble es: {{ doubleValue() }}</p>
```

</details>

---

### **Ejercicio 4: Effect con Signal**

Crea un Effect que muestre un mensaje en la consola cuando cambie una Signal.

<details><summary>Mostrar solución</summary>

```ts
import { effect, signal } from "@angular/core";

export class LoggerComponent {
  message = signal("Inicio");

  constructor() {
    effect(() => {
      console.log(`Mensaje: ${this.message()}`);
    });
  }
}
```

```html
<input [(ngModel)]="message" />
```

</details>

---

### **Ejercicio 5: Manejo de lista con @for**

Crea una signal con una lista de nombres y usa `@for` para mostrarlos en la plantilla.

<details><summary>Mostrar solución</summary>

```ts
export class NamesComponent {
  names = signal(["Ana", "Luis", "Carlos"]);
}
```

```html
<ul>
  @for (name of names(); track name) {
  <li>{{ name }}</li>
  }
</ul>
```

</details>

---

### **Ejercicio 6: Filtro con Computed Signal**

Filtra una lista de números para mostrar solo los pares usando `computed()`.

<details><summary>Mostrar solución</summary>

```ts
export class FilterComponent {
  numbers = signal([1, 2, 3, 4, 5, 6]);
  evenNumbers = computed(() => this.numbers().filter((n) => n % 2 === 0));
}
```

```html
<p>Números pares: {{ evenNumbers() }}</p>
```

</details>

---

### **Ejercicio 7: Uso de @if con Signal**

Muestra un mensaje solo si un contador es mayor que 10.

<details><summary>Mostrar solución</summary>

```html
@if (count() > 10) {
<p>El contador es mayor que 10</p>
}
```

```ts
export class ConditionComponent {
  count = signal(0);
}
```

</details>

---

### **Ejercicio 8: Reset de Signal**

Añade un botón para resetear el valor de una Signal a su estado inicial.

<details><summary>Mostrar solución</summary>

```ts
export class ResetComponent {
  count = signal(0);

  reset() {
    this.count.set(0);
  }
}
```

```html
<p>Contador: {{ count() }}</p>
<button (click)="reset()">Resetear</button>
```

</details>

---

### **Ejercicio 9: Cambio de estado con Signal**

Cambia el estado de una Signal entre "Activo" y "Inactivo" al hacer clic en un botón.

<details><summary>Mostrar solución</summary>

```ts
export class ToggleComponent {
  status = signal("Inactivo");

  toggle() {
    this.status.set(this.status() === "Activo" ? "Inactivo" : "Activo");
  }
}
```

```html
<p>Estado: {{ status() }}</p>
<button (click)="toggle()">Cambiar Estado</button>
```

</details>

---

### **Ejercicio 10: Tabla de usuarios con Signals**

Crea una tabla con datos de usuarios usando Signals.

<details><summary>Mostrar solución</summary>

```ts
export class UsersComponent {
  users = signal([
    { id: 1, name: "Laura", age: 25 },
    { id: 2, name: "Pedro", age: 30 },
  ]);
}
```

```html
<table>
  <tr>
    <th>Nombre</th>
    <th>Edad</th>
  </tr>
  @for (user of users(); track user.id) {
  <tr>
    <td>{{ user.name }}</td>
    <td>{{ user.age }}</td>
  </tr>
  }
</table>
```

</details>
