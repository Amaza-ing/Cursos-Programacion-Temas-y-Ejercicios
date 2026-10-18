# **Exercises - Topic 5: Signals and Reactivity in Angular 19**

## **Instructions:**

Below you will find 10 practical exercises on using Signals in Angular 19.

Try to solve them before looking at the solution.

---

### **Exercise 1: Creating a Signal**

Create a Signal that stores a number and displays its value in the template.

<details><summary>Show solution</summary>

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

### **Exercise 2: Updating a Signal**

Create a button that increments the Signal's value when clicked.

<details><summary>Show solution</summary>

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

### **Exercise 3: Computed Signal**

Create a Computed Signal that calculates double the value stored in a Signal.

<details><summary>Show solution</summary>

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

### **Exercise 4: Effect with a Signal**

Create an Effect that displays a message in the console when a Signal changes.

<details><summary>Show solution</summary>

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

### **Exercise 5: Handling a list with @for**

Create a signal with a list of names and use `@for` to display them in the template.

<details><summary>Show solution</summary>

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

### **Exercise 6: Filtering with a Computed Signal**

Filter a list of numbers to show only the even ones using `computed()`.

<details><summary>Show solution</summary>

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

### **Exercise 7: Using @if with a Signal**

Display a message only if a counter is greater than 10.

<details><summary>Show solution</summary>

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

### **Exercise 8: Resetting a Signal**

Add a button to reset the value of a Signal to its initial state.

<details><summary>Show solution</summary>

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

### **Exercise 9: Changing state with a Signal**

Switch the state of a Signal between "Activo" and "Inactivo" when a button is clicked.

<details><summary>Show solution</summary>

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

### **Exercise 10: User table with Signals**

Create a table with user data using Signals.

<details><summary>Show solution</summary>

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
