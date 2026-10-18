# **Topic 13: Angular Services and Global State Management**

## **1. Introduction**

In Angular, **services** are essential for handling data shared between components and managing the global state of an application. They allow the business logic to be decoupled from the components, making the application more scalable and maintainable.

In this topic you will learn:

- What is a service in Angular.
- How to create and use a service.
- How to manage global state with `signal`.
- Use of services with the new Angular syntax.

---

## **2. What is a Service in Angular?**

A **service** in Angular is a class that contains reusable logic, such as HTTP requests, data storage, and state management. Services can be injected into any component or into other services.

Services in Angular can be defined as **standalone** (`providedIn: 'root'`), which allows them to be available throughout the application without needing to declare them in a module.

---

## **3. Creating a Service in Angular**

To generate a service in our Angular project we have to execute the following command:

```sh
ng generate service services/user
```


Or in its summarized version:

```sh
ng g s services/user
```


This will create an `user.service.ts` file inside the `services` folder. If the `services` folder does not exist, it will create it as well.

### **3.1. Define a Service**

#### **File: `user.service.ts`**

```ts
import { Injectable, signal } from "@angular/core";

@Injectable({ providedIn: "root" })
export class UserService {
  users = [
    { id: 1, name: "Juan", active: true },
    { id: 2, name: "Ana", active: false },
  ];

  addUser(name: string) {
    const newUser = {
      id: 3,
      name,
      active: true,
    };
    this.users.push(newUser);
  }

  toggleActive(id: number) {
    const selectedUser = this.users.find((user) => user.id === id);
    if (selectedUser) {
      selectedUser.active = !selectedUser.active;
    }
  }
}
```


In this service:

- `users` is used to store users' state.
- `addUser()` adds a new user to the list.
- `toggleActive()` changes the active/inactive status of a user.

### **3.2. Define a Service using Signals**

You can also work with signals within the services if we want to play with reactivity.

#### **File: `user.service.ts`**

```ts
import { Injectable, signal } from "@angular/core";

@Injectable({ providedIn: "root" })
export class UserService {
  users = signal([
    { id: 1, name: "Juan", active: true },
    { id: 2, name: "Ana", active: false },
  ]);

  addUser(name: string) {
    this.users.update((users) => [
      ...users,
      { id: users.length + 1, name, active: true },
    ]);
  }

  toggleActive(id: number) {
    this.users.update((users) =>
      users.map((user) =>
        user.id === id ? { ...user, active: !user.active } : user,
      ),
    );
  }
}
```


---

## **4. Use of a Service in a Component**

### **4.1. Service Injection into a Standalone Component**

#### **File: `user.component.ts`**

```ts
import { UserService } from "../services/user.service";

@Component({
  selector: "app-user",
})
export class UserComponent {
  constructor(public userService: UserService) {}
}
```


Here the service is injected directly into the constructor.

---

## **5. Show Data in the template (HTML code) with `@for`**

#### **File: `user.component.html`**

```html
<ul>
  @for (user of userService.users(); track user.id) {
  <li>
    {{ user.name }} - Estado: {{ user.active ? 'Activo' : 'Inactivo' }}
    <button (click)="userService.toggleActive(user.id)">Cambiar Estado</button>
  </li>
  }
</ul>

<input #userName type="text" placeholder="Nuevo usuario" />
<button (click)="userService.addUser(userName.value); userName.value = ''">
  Agregar Usuario
</button>
```


Here it is used:

- `@for` to iterate over the list of users.
- `userService.addUser()` and `userService.toggleActive()` directly on the buttons.

---

## **6. Benefits of Using Services for Global Status**

| **Benefit** | **Description** |
| ------------------- | ------------------------------------------------------------------------------------------ |
| **Decoupling** | Components do not depend on each other to share data.                            |
| **Reactivity** | `signal` enables efficient state management without the need for manual subscriptions. |
| **Scalability** | The data can be accessed from anywhere in the application.                     |
| **Performance** | Less need for change detection compared to RxJS's `BehaviorSubject`.      |

---

[![](https://img.youtube.com/vi/ehv9_wYfAfU/0.jpg) Services](https://www.youtube.com/watch?v=ehv9_wYfAfU&list=PLzA2VyZwsq_9cD3JIxBymaIVyef07PJ-y)

---

## **7. Conclusion**
- **Services** allow data and logic to be shared between components.
- **Signals** in Angular facilitate reactivity without depending on `RxJS`.
- **Dependency injection** simplifies access to services throughout the application.
- **The use of `@for` and `@if`** in the template makes the code cleaner and more efficient.

---

In the next topic, we will explore **how to use Router to create routes in a SPA and how to use RouterLink to create links**.
