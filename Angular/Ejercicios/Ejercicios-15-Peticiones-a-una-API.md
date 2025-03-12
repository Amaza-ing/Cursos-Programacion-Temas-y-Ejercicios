# **Ejercicios - Tema 15: Realización de Peticiones HTTP con `HttpClient`**

## **Instrucciones:**
A continuación, encontrarás ejercicios sobre cómo realizar peticiones HTTP en Angular usando `HttpClient`.

Intenta resolverlos antes de consultar la solución.

---

### **Ejercicio 1: Realizar una Petición GET**
Crea un servicio `UserService` que realice una petición GET para obtener una lista de usuarios desde `https://jsonplaceholder.typicode.com/users`.

<details><summary>Mostrar solución</summary>

#### **Archivo: `user.service.ts`**
```ts
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({ providedIn: 'root' })
export class UserService {
  apiUrl = 'https://jsonplaceholder.typicode.com/users';
  users: any[] = [];

  constructor(private http: HttpClient) {}

  getUsers(): Observable<any[]> {
    return this.http.get<any[]>(this.apiUrl);
  }
}
```

#### **Archivo: `user.component.ts`**
```ts
import { Component, OnInit } from '@angular/core';
import { UserService } from './user.service';

@Component({
  selector: 'app-user',
  templateUrl: './user.component.html'
})
export class UserComponent implements OnInit {
  constructor(public UserService: UserService) {}

  ngOnInit(): void {
    this.getUsers();
  }

  getUsers() {
    this.UserService.getUsers().subscribe({
      next: (data) => {
        console.log(data);
        this.UserService.users = data;
      },
      error: (e) => {
        console.error(e);
      }
    });
  }
}
```

#### **Archivo: `user.component.html`**
```html
<h2>Usuarios</h2>
<ul>
  @for (user of UserService.users; track user.id) {
    <li>{{ user.name }}</li>
  }
</ul>
```
</details>

---

### **Ejercicio 2: Realizar una Petición POST**
Crea un formulario para agregar un nuevo usuario usando una petición POST.

<details><summary>Mostrar solución</summary>

#### **Archivo: `user.service.ts`**
```ts
addUser(user: { name: string; email: string }): Observable<any> {
  return this.http.user(this.apiUrl, user);
}
```

#### **Archivo: `user.component.ts`**
```ts
newUser = { name: '', email: '' };

addNewUser() {
  this.UserService.addUser(this.newUser).subscribe({
    next: (response) => {
      console.log('Nuevo usuario añadido:', response);
      this.UserService.users.push(response);
    },
    error: (e) => {
      console.error(e);
    }
  });
}
```

#### **Archivo: `user.component.html`**
```html
<h2>Añadir Nuevo Usuario</h2>
<input [(ngModel)]="newUser.name" placeholder="Nombre">
<input [(ngModel)]="newUser.email" placeholder="email">
<button (click)="addNewUser()">Agregar</button>
```
</details>

---

### **Ejercicio 3: Realizar una Petición PUT**
Actualiza un usuario existente usando una petición PUT.

<details><summary>Mostrar solución</summary>

#### **Archivo: `user.service.ts`**
```ts
updateUser(id: number, user: { name: string; email: string }): Observable<any> {
  return this.http.put(`${this.apiUrl}/${id}`, user);
}
```

#### **Archivo: `user.component.ts`**
```ts
updateExistingUser() {
  const updatedUser = { name: 'Nombre Actualizado', email: 'Email Actualizado' };
  this.UserService.updateUser(1, updatedUser).subscribe({
    next: (response) => {
      console.log('Usuario actualizado:', response);
    },
    error: (e) => {
      console.error(e);
    }
  });
}
```

#### **Archivo: `user.component.html`**
```html
<button (click)="updateExistingUser()">Actualizar Usuario</button>
```
</details>

---

### **Ejercicio 4: Realizar una Petición DELETE**
Elimina un usuario existente usando una petición DELETE.

<details><summary>Mostrar solución</summary>

#### **Archivo: `user.service.ts`**
```ts
deleteUser(id: number): Observable<any> {
  return this.http.delete(`${this.apiUrl}/${id}`);
}
```

#### **Archivo: `user.component.ts`**
```ts
deleteUser(id: number) {
  this.UserService.deleteUser(id).subscribe({
    next: () => {
      console.log(`Usuario con ID ${id} eliminado.`);
      this.UserService.users = this.UserService.users.filter(user => user.id !== id);
    },
    error: (e) => {
      console.error(e);
    }
  });
}
```

#### **Archivo: `user.component.html`**
```html
<ul>
  @for (user of UserService.users; track user.id) {
    <li>
      {{ user.name }}
      <button (click)="deleteUser(user.id)">Eliminar</button>
    </li>
  }
</ul>
```
</details>
