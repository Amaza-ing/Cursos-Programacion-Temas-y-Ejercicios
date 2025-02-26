# **Tema 13: Servicios en Angular y Gestión del Estado Global**

## **1. Introducción**

En Angular, los **servicios** son esenciales para manejar datos compartidos entre componentes y gestionar el estado global de una aplicación. Permiten desacoplar la lógica de negocio de los componentes, haciendo que la aplicación sea más escalable y mantenible.

En este tema aprenderás:

- Qué es un servicio en Angular.
- Cómo crear y usar un servicio.
- Cómo gestionar el estado global con `signal`.
- Uso de servicios con la nueva sintaxis de Angular.

---

## **2. ¿Qué es un Servicio en Angular?**

Un **servicio** en Angular es una clase que contiene lógica reutilizable, como peticiones HTTP, almacenamiento de datos y gestión del estado. Los servicios se pueden inyectar en cualquier componente o en otros servicios.

Los servicios en Angular se pueden definir como **standalone** (`providedIn: 'root'`), lo que permite que estén disponibles en toda la aplicación sin necesidad de declararlos en un módulo.

---

## **3. Creación de un Servicio en Angular**

Para generar un servicio en nuestro proyecto de Angular tenemos que ejecutar el siguiente comando:

```sh
ng generate service services/user
```

O en su versión resumida:

```sh
ng g s services/user
```

Esto creará un fichero `user.service.ts` dentro de la carpeta `services`, si la carpeta `services` no existe la creará también.

### **3.1. Definir un Servicio**

#### **Archivo: `user.service.ts`**

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

En este servicio:

- Se usa `users` para almacenar el estado de los usuarios.
- `addUser()` añade un nuevo usuario a la lista.
- `toggleActive()` cambia el estado activo/inactivo de un usuario.

### **3.2. Definir un Servicio usando Signals**

También se puede trabajar con signals dentro de los servicios si queremos jugar con la reactividad.

#### **Archivo: `user.service.ts`**

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
        user.id === id ? { ...user, active: !user.active } : user
      )
    );
  }
}
```

---

## **4. Uso de un Servicio en un Componente**

### **4.1. Inyección del Servicio en un Componente Standalone**

#### **Archivo: `user.component.ts`**

```ts
import { UserService } from "../services/user.service";

@Component({
  selector: "app-user",
})
export class UserComponent {
  constructor(public userService: UserService) {}
}
```

Aquí se inyecta el servicio directamente en el constructor.

---

## **5. Mostrar Datos en la Plantilla con `@for`**

#### **Archivo: `user.component.html`**

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

Aquí se usa:

- `@for` para iterar sobre la lista de usuarios.
- `userService.addUser()` y `userService.toggleActive()` directamente en los botones.

---

## **6. Beneficios de Usar Servicios para el Estado Global**

| **Beneficio**       | **Descripción**                                                                            |
| ------------------- | ------------------------------------------------------------------------------------------ |
| **Desacoplamiento** | Los componentes no dependen unos de otros para compartir datos.                            |
| **Reactividad**     | `signal` permite una gestión del estado eficiente sin necesidad de suscripciones manuales. |
| **Escalabilidad**   | Los datos pueden ser accedidos desde cualquier parte de la aplicación.                     |
| **Rendimiento**     | Menos necesidad de detección de cambios en comparación con `BehaviorSubject` de RxJS.      |

---

[![Servicios](https://img.youtube.com/vi/ehv9_wYfAfU/0.jpg)](https://www.youtube.com/watch?v=ehv9_wYfAfU&list=PLzA2VyZwsq_9cD3JIxBymaIVyef07PJ-y)

---

## **7. Conclusión**

- **Los servicios** permiten compartir datos y lógica entre componentes.
- **Los signals** en Angular facilitan la reactividad sin depender de `RxJS`.
- **La inyección de dependencias** simplifica el acceso a los servicios en toda la aplicación.
- **El uso de `@for` y `@if`** en las plantillas hace que el código sea más limpio y eficiente.

---

En el próximo tema, exploraremos **cómo usar el Router para crear rutas en una SPA y cómo usar RouterLink para crear enlaces**.
