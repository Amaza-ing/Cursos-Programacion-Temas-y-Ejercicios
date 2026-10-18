# **Exercises - Topic 13: Angular Services and Global State Management**

## **Instructions:**

Below you will find exercises on how to use services and manage global state in Angular.

Try to solve them before looking at the solution.

---

### **Exercise 1: Create a service**

Create a `CounterService` service that stores a counter and lets you increment and reset it.

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

### **Exercise 2: Use a service in a component**

Create a `CounterComponent` component that displays the counter's value and lets you increment and reset it using `CounterService`.

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

### **Exercise 3: Create a service to store users**

Create a `UserService` service that manages a list of users and lets you add new users.

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

### **Exercise 4: Display users in a component**

Create a `UserComponent` component that displays the list of users and lets you add new ones.

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
