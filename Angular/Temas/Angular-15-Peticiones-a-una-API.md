# **Topic 15: Making HTTP Requests with `HttpClient` in Angular**

## **1. Introduction**

In Angular, the `HttpClient` service allows you to make HTTP requests to communicate with external APIs. It is an essential tool for retrieving and sending data between the client and the server.

In this topic you will learn:

- How to configure and use `HttpClient`.
- Make GET, POST, PUT and DELETE requests.
- Handle errors in requests.
- Use observables and subscriptions to manage asynchronous responses.

---

## **2. Initial Configuration**

To use `HttpClient`, it is necessary to add the `provideHttpClient()` provider to the `app.config.ts` file.

#### **File: `app.config.ts`**

```ts
import { provideHttpClient } from '@angular/common/http';

providers: [provideRouter(routes), provideHttpClient()],
```


---

## **3. Make a GET Request**

The GET request is used to retrieve data from an API. We can access any public API, for this example we will use an [jsonplaceholder](https://jsonplaceholder.typicode.com/) API, which is a website that allows us to make requests for some data.

To better manage all calls to APIs, you must create a service and manage all requests from there using functions.

The services in this case will receive the name of the resource that we are managing, usually written in the singular. For example `user.service.ts` for users or `photo.service.ts` for photos. We can (and should) create as many services as necessary, and let each service manage only one type of resource for better organization.

#### **File: `comment.service.ts`**

```ts
import { Injectable } from "@angular/core";
import { HttpClient } from "@angular/common/http";
import { Observable } from "rxjs";

@Injectable({ providedIn: "root" })
export class CommentService {
  private readonly API_URL = "https://jsonplaceholder.typicode.com/comments";

  comments: any[];

  constructor(private http: HttpClient) {
    this.comments = [];
  }

  getComments(): Observable<any[]> {
    return this.http.get<any[]>(this.API_URL);
  }
}
```


#### **File: `app.component.ts`**

```ts
import { Component, OnInit } from "@angular/core";
import { CommentService } from "./comment.service";

@Component({
  selector: "app-root",
  templateUrl: "./app.component.html",
})
export class AppComponent implements OnInit {
  comments: any[] = [];

  constructor(public CommentService: CommentService) {}

  ngOnInit() {
    this.getComments();
  }

  getComments() {
    this.CommentService.getComments().subscribe({
      next: (data) => {
        console.log(data);
        this.CommentService.comments = data;
      },
      error: (e) => {
        console.log(e);
      },
    });
  }
}
```


#### **File: `app.component.html`**

```html
<h1>Lista de Publicaciones</h1>
<ul>
  @for (comment of CommentService.comments; track comment.id) {
  <li>{{ comment.name }}</li>
  }
</ul>
```


When we make an `GET` request using `httpClient` through `this.http.get<any[]>(this.API_URL)` we are obtaining an `Observable`, and to use the observables we must subscribe to them using the `subscribe` method to execute the request, which is what we have done in the example in the file `app.component.ts`.

Requests to APIs can fail, so it is necessary to take this into account when using an `subscribe`.

- If everything goes well, the function in `next` will be executed, which will receive the request data.

- If something goes wrong, the function in `error` will be executed, which will receive the error data.

---

[![GET requests to an API](https://img.youtube.com/vi/UV_anqLaBko/0.jpg)](https://www.youtube.com/watch?v=UV_anqLaBko&list=PLzA2VyZwsq_9cD3JIxBymaIVyef07PJ-y)

---

## **4. Make a POST Request**

The POST request is used to send new data to the API.

#### **File: `comment.service.ts`**

```ts
addComment(comment: { name: string, body: string }): Observable<any> {
  return this.http.post(this.API_URL, comment);
}
```


#### **File: `app.component.ts`**

```ts
newComment = { name: '', body: '' };

addNewComment() {
  this.CommentService.addComment(this.newComment).subscribe({
    next: (data) => {
      console.log("Comentario Añadido: " + data);
    },
    error: (e) => {
      console.log(e);
    },
  });
}
```


#### **File: `app.component.html`**

```html
<h2>Añadir Nueva Publicación</h2>
<input [(ngModel)]="newComment.name" placeholder="Título" />
<input [(ngModel)]="newComment.body" placeholder="Contenido" />
<button (click)="addNewComment()">Agregar</button>
```


---

## **5. Make a PUT Request**

The PUT request is used to update an existing resource.

#### **File: `comment.service.ts`**

```ts
updateComment(id: number, comment: { name: string, body: string }): Observable<any> {
  return this.http.put(`${this.API_URL}/${id}`, comment);
}
```


#### **File: `app.component.ts`**

```ts
updateExistingComment() {
  const updatedComment = { name: 'Título Actualizado', body: 'Contenido Actualizado' };
  this.CommentService.updateComment(1, updatedComment).subscribe({
    next: (data) => {
      console.log("Comentario Actualizado: " + data);
    },
    error: (e) => {
      console.log(e);
    },
  });
}
```


#### **File: `app.component.html`**

```html
<button (click)="updateExistingComment()">Actualizar Comentario</button>
```


---

## **6. Make a DELETE Request**

The DELETE request deletes a resource from the API.

#### **File: `comment.service.ts`**

```ts
deleteComment(id: number): Observable<any> {
  return this.http.delete(`${this.API_URL}/${id}`);
}
```


#### **File: `app.component.ts`**

```ts
deleteComment(id: number) {
  this.CommentService.deleteComment(id).subscribe({
    next: (data) => {
      console.log("Comentario Eliminado: " + data);
    },
    error: (e) => {
      console.log(e);
    },
  });
}
```


#### **File: `app.component.html`**

```html
<ul>
  @for (comment of comments; track comment.id) {
  <li>
    {{ comment.name }}
    <button (click)="deleteComment(comment.id)">Eliminar</button>
  </li>
  }
</ul>
```


---
[![POST and DELETE requests](https://img.youtube.com/vi/puuGP0iq5Zk/0.jpg)](https://www.youtube.com/watch?v=puuGP0iq5Zk&list=PLzA2VyZwsq_9cD3JIxBymaIVyef07PJ-y)

---

## **7. Error Handling in HTTP Requests**

Errors can also be handled using RxJS's `catchError` operator.

#### **File: `comment.service.ts`**

```ts
import { catchError, throwError } from 'rxjs';

getComments(): Observable<any[]> {
  return this.http.get<any[]>(this.API_URL).pipe(
    catchError(error => {
      console.error('Error al obtener los comments:', error);
      return throwError(() => new Error('Error en la petición GET'));
    })
  );
}
```


---

## **8. Conclusion**

- **`HttpClient`** allows you to make HTTP requests easily.
- **GET, POST, PUT and DELETE** are the most used methods.
- Possible errors must be managed.
- Angular offers an efficient and modern integration to consume APIs.

---

In the next topic, we will explore **how to perform unit tests using Jasmine and Karma**.
