# **Ejercicios - Tema 13: Servicios en Angular y Gestión del Estado Global**

## **Instrucciones:**
A continuación, encontrarás ejercicios sobre cómo usar servicios y gestionar el estado global en Angular.

Intenta resolverlos antes de consultar la solución.

---

### **Ejercicio 1: Crear un Servicio**
Crea un servicio `CounterService` que almacene un contador y permita incrementarlo y reiniciarlo.

<details><summary>Mostrar solución</summary>

#### **Archivo: `counter.service.ts`**
```ts
import { Injectable } from '@angular/core';

@Injectable({ providedIn: 'root' })
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

Usando signals:

#### **Archivo: `counter.service.ts`**
```ts
import { Injectable, signal } from '@angular/core';

@Injectable({ providedIn: 'root' })
export class CounterService {
  counter = signal(0);

  increment() {
    this.counter.update(value => value + 1);
  }

  reset() {
    this.counter.set(0);
  }
}
```
</details>

---

### **Ejercicio 2: Usar un Servicio en un Componente**
Crea un componente `CounterComponent` que muestre el valor del contador y permita incrementarlo y reiniciarlo usando `CounterService`.

<details><summary>Mostrar solución</summary>

#### **Archivo: `counter.component.ts`**
```ts
import { CounterService } from './counter.service';

@Component({
  selector: 'app-counter',
})
export class CounterComponent {
  constructor(public counterService: CounterService) {}
}
```

#### **Archivo: `counter.component.html`**
```html
<p>Contador: {{ counterService.counter }}</p>
<button (click)="counterService.increment()">Incrementar</button>
<button (click)="counterService.reset()">Reiniciar</button>
```
</details>

---

### **Ejercicio 3: Crear un Servicio para Almacenar Usuarios**
Crea un servicio `UserService` que maneje una lista de usuarios y permita agregar nuevos usuarios.

<details><summary>Mostrar solución</summary>

#### **Archivo: `user.service.ts`**
```ts
import { Injectable, signal } from '@angular/core';

@Injectable({ providedIn: 'root' })
export class UserService {
  users = signal([{ id: 1, name: 'Juan' }, { id: 2, name: 'Ana' }]);

  addUser(name: string) {
    this.users.update(users => [...users, { id: users.length + 1, name }]);
  }
}
```
</details>

---

### **Ejercicio 4: Mostrar Usuarios en un Componente**
Crea un componente `UserComponent` que muestre la lista de usuarios y permita agregar nuevos.

<details><summary>Mostrar solución</summary>

#### **Archivo: `user.component.ts`**
```ts
import { UserService } from './user.service';

@Component({
  selector: 'app-user',
})
export class UserComponent {
  constructor(public userService: UserService) {}
}
```

#### **Archivo: `user.component.html`**
```html
<ul>
  @for (user of userService.users(); track user.id) {
    <li>{{ user.name }}</li>
  }
</ul>
<input #userName type="text" placeholder="Nuevo usuario">
<button (click)="userService.addUser(userName.value); userName.value = ''">Agregar Usuario</button>
```
</details>
