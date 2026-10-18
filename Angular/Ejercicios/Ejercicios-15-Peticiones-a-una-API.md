# **Exercises - Topic 15: Making HTTP Requests with `HttpClient`**

## **Instructions:**

Below you will find exercises on how to make HTTP requests in Angular using `HttpClient`.

Try to solve them before looking at the solution.

---

### **Exercise 1: Make a GET request**

Create a `UserService` service that makes a GET request to get a list of users from `https://jsonplaceholder.typicode.com/users`.

<details><summary>Show solution</summary>

#### **File: `user.service.ts`**

```ts
import { Injectable } from "@angular/core";
import { HttpClient } from "@angular/common/http";
import { Observable } from "rxjs";

@Injectable({ providedIn: "root" })
export class UserService {
  apiUrl = "https://jsonplaceholder.typicode.com/users";
  users: any[] = [];

  constructor(private http: HttpClient) {}

  getUsers(): Observable<any[]> {
    return this.http.get<any[]>(this.apiUrl);
  }
}
```


#### **File: `user.component.ts`**

```ts
import { Component, OnInit } from "@angular/core";
import { UserService } from "./user.service";

@Component({
  selector: "app-user",
  templateUrl: "./user.component.html",
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
      },
    });
  }
}
```


#### **File: `user.component.html`**

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

### **Exercise 2: Make a POST request**

Create a form to add a new user using a POST request.

<details><summary>Show solution</summary>

#### **File: `user.service.ts`**

```ts
addUser(user: { name: string; email: string }): Observable<any> {
  return this.http.user(this.apiUrl, user);
}
```


#### **File: `user.component.ts`**

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


#### **File: `user.component.html`**

```html
<h2>Añadir Nuevo Usuario</h2>
<input [(ngModel)]="newUser.name" placeholder="Nombre" />
<input [(ngModel)]="newUser.email" placeholder="email" />
<button (click)="addNewUser()">Agregar</button>
```


</details>

---

### **Exercise 3: Make a PUT request**

Update an existing user using a PUT request.

<details><summary>Show solution</summary>

#### **File: `user.service.ts`**

```ts
updateUser(id: number, user: { name: string; email: string }): Observable<any> {
  return this.http.put(`${this.apiUrl}/${id}`, user);
}
```


#### **File: `user.component.ts`**

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


#### **File: `user.component.html`**

```html
<button (click)="updateExistingUser()">Actualizar Usuario</button>
```


</details>

---

### **Exercise 4: Make a DELETE request**

Delete an existing user using a DELETE request.

<details><summary>Show solution</summary>

#### **File: `user.service.ts`**

```ts
deleteUser(id: number): Observable<any> {
  return this.http.delete(`${this.apiUrl}/${id}`);
}
```


#### **File: `user.component.ts`**

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


#### **File: `user.component.html`**

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
