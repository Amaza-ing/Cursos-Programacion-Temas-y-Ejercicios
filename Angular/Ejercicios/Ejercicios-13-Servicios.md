# **Exercises - Topic 13: Angular Services and Global State Management**

## **Instructions:**

Below you will find exercises on how to use services and manage global state in Angular.

Try to solve them before consulting the solution.

---

### **Exercise 1: Create a Service**

Create an `CounterService` service that stores a counter and allows it to be incremented and reset.

<details><summary>Show solution</summary>

#### **File: `counter.service.ts`**

```ts
import { Injectable } from "@angular/core";

@Injectable({ providedIn: "root" })
export class CounterService {
  counter = 0;

  increment() {
    this.counter++;
  }

  reset() {
    this.counter = 0;
  }
}
```


Using signals:

#### **File: `counter.service.ts`**

```ts
import { Injectable, signal } from "@angular/core";

@Injectable({ providedIn: "root" })
export class CounterService {
  counter = signal(0);

  increment() {
    this.counter.update((value) => value + 1);
  }

  reset() {
    this.counter.set(0);
  }
}
```


</details>

---

### **Exercise 2: Using a Service in a Component**

Create an `CounterComponent` component that displays the counter value and allows it to be incremented and reset using `CounterService`.

<details><summary>Show solution</summary>

#### **File: `counter.component.ts`**

```ts
import { CounterService } from "./counter.service";

@Component({
  selector: "app-counter",
})
export class CounterComponent {
  constructor(public counterService: CounterService) {}
}
```


#### **File: `counter.component.html`**

```html
<p>Contador: {{ counterService.counter }}</p>
<button (click)="counterService.increment()">Incrementar</button>
<button (click)="counterService.reset()">Reiniciar</button>
```


</details>

---

### **Exercise 3: Create a Service to Store Users**

Create an `UserService` service that manages a list of users and allows new users to be added.

<details><summary>Show solution</summary>

#### **File: `user.service.ts`**

```ts
import { Injectable, signal } from "@angular/core";

@Injectable({ providedIn: "root" })
export class UserService {
  users = signal([
    { id: 1, name: "Juan" },
    { id: 2, name: "Ana" },
  ]);

  addUser(name: string) {
    this.users.update((users) => [...users, { id: users.length + 1, name }]);
  }
}
```


</details>

---

### **Exercise 4: Show Users in a Component**

Create an `UserComponent` component that displays the list of users and allows new ones to be added.

<details><summary>Show solution</summary>

#### **File: `user.component.ts`**

```ts
import { UserService } from "./user.service";

@Component({
  selector: "app-user",
})
export class UserComponent {
  constructor(public userService: UserService) {}
}
```


#### **File: `user.component.html`**

```html
<ul>
  @for (user of userService.users(); track user.id) {
  <li>{{ user.name }}</li>
  }
</ul>
<input #userName type="text" placeholder="Nuevo usuario" />
<button (click)="userService.addUser(userName.value); userName.value = ''">
  Agregar Usuario
</button>
```


</details>
