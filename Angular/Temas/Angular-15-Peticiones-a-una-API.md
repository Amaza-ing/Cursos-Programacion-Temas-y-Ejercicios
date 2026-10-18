# **Topic 15: Making HTTP Requests with `HttpClient` in Angular**

## **1. Introduction**

In Angular, the `HttpClient` service lets you make HTTP requests to communicate with external APIs. It is an essential tool for retrieving and sending data between the client and the server.

In this topic, you will learn:

- How to configure and use `HttpClient`.
- How to make GET, POST, PUT and DELETE requests.
- How to handle errors in requests.
- How to use observables and subscriptions to handle asynchronous responses.

---

## **2. Initial setup**

To use `HttpClient`, you need to add the `provideHttpClient()` provider to the `app.config.ts` file.

#### **File: `app.config.ts`**

```ts
import { provideHttpClient } from '@angular/common/http';

providers: [provideRouter(routes), provideHttpClient()],
```


---

## **3. Making a GET request**

The GET request is used to retrieve data from an API. We can access any public API; for this example, we will use an API from [jsonplaceholder](https://jsonplaceholder.typicode.com/), a website that lets us make requests for some sample data.

To manage all the API calls better, you should create a service and handle all the requests from there through functions.

In this case, the services will be named after the resource we are managing, usually in the singular. For example, `user.service.ts` for users or `photo.service.ts` for photos. We can (and should) create as many services as necessary, and let each service manage only one type of resource for better organization.

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


When we make a `GET` request with `httpClient` through `this.http.get<any[]>(this.API_URL)`, we get an `Observable`, and to use observables we must subscribe to them with the `subscribe` method so that the request runs, which is what we did in the example in the `app.component.ts` file.

API requests can fail, so you need to take this into account when you use `subscribe`.

- If everything goes well, the function in `next` will run and receive the data from the request.

- If something goes wrong, the function in `error` will run and receive the error data.

---

[![GET requests to an API](https://img.youtube.com/vi/UV_anqLaBko/0.jpg)](https://www.youtube.com/watch?v=UV_anqLaBko&list=PLzA2VyZwsq_9cD3JIxBymaIVyef07PJ-y)

---

## **4. Making a POST request**

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

## **5. Making a PUT request**

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

## **6. Making a DELETE request**

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

## **7. Error handling in HTTP requests**

You can also handle errors with the RxJS `catchError` operator.

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

- **`HttpClient`** lets you make HTTP requests easily.
- **GET, POST, PUT and DELETE** are the most commonly used methods.
- Possible errors must be handled.
- Angular offers an efficient, modern integration for consuming APIs.

---

In the next topic, we will explore **how to write unit tests using Jasmine and Karma**.
