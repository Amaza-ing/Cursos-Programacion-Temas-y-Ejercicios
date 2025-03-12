# **Tema 15: Realización de Peticiones HTTP con `HttpClient` en Angular**

## **1. Introducción**

En Angular, el servicio `HttpClient` permite realizar peticiones HTTP para comunicarse con APIs externas. Es una herramienta esencial para recuperar y enviar datos entre el cliente y el servidor.

En este tema aprenderás:

- Cómo configurar y usar `HttpClient`.
- Realizar peticiones GET, POST, PUT y DELETE.
- Manejar errores en las peticiones.
- Usar observables y suscripciones para gestionar respuestas asíncronas.

---

## **2. Configuración Inicial**

Para usar `HttpClient`, es necesario añadir el provider `provideHttpClient()` en el fichero `app.config.ts`.

#### **Archivo: `app.config.ts`**

```ts
import { provideHttpClient } from '@angular/common/http';

providers: [provideRouter(routes), provideHttpClient()],
```

---

## **3. Realizar una Petición GET**

La petición GET se utiliza para recuperar datos desde una API. Podemos acceder a cualquier API pública, para este ejemplo usaremos una API de [jsonplaceholder](https://jsonplaceholder.typicode.com/), que es una web que nos permite hacer peticiones a algunos datos.

Para gestionar mejor todas las llamadas a las APIs se debe crear un servicio y gestionar todas las peticiones desde ahí mediante funciones.

Los servicios en este caso recibirán el nombre del recurso que estemos gestionando, habitualmente escrito en singular. Por ejemplo `user.service.ts` para usuarios o `photo.service.ts` para fotos. Podemos (y debemos) crear tantos servicios como sea necesario, y dejar que cada servicio gestione únicamente un tipo de recurso para una mejor organización.

#### **Archivo: `comment.service.ts`**

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

#### **Archivo: `app.component.ts`**

```ts
import { Component, OnInit } from "@angular/core";
import { CommentService } from "./comment.service";

@Component({
  selector: "app-root",
  standalone: true,
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

#### **Archivo: `app.component.html`**

```html
<h1>Lista de Publicaciones</h1>
<ul>
  @for (comment of CommentService.comments; track comment.id) {
  <li>{{ comment.name }}</li>
  }
</ul>
```

Cuando hacemos una petición `GET` usando `httpClient` mediante `this.http.get<any[]>(this.API_URL)` estamos obteniendo un `Observable`, y para utilizar los observables debemos suscribirnos a ellos mediante el método `subscribe` para ejecutar la petición, que es lo que hemos hecho en el ejemplo en el fichero `app.component.ts`.

Las peticiones a las APIs pueden fallar, por eso es necesario tener esto en cuenta cuando usamos un `subscribe`.

- Si todo va bien se ejecutará la función que hay en el `next`, que recibirá los datos de la petición.

- Si algo va mal se ejecutará la función que hay en el `error`, que recibirá los datos de error.

---

[![Peticiones GET a una API](https://img.youtube.com/vi/UV_anqLaBko/0.jpg)](https://www.youtube.com/watch?v=UV_anqLaBko&list=PLzA2VyZwsq_9cD3JIxBymaIVyef07PJ-y)

---

## **4. Realizar una Petición POST**

La petición POST se utiliza para enviar nuevos datos a la API.

#### **Archivo: `comment.service.ts`**

```ts
addComment(comment: { name: string, body: string }): Observable<any> {
  return this.http.post(this.API_URL, comment);
}
```

#### **Archivo: `app.component.ts`**

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

#### **Archivo: `app.component.html`**

```html
<h2>Añadir Nueva Publicación</h2>
<input [(ngModel)]="newComment.name" placeholder="Título" />
<input [(ngModel)]="newComment.body" placeholder="Contenido" />
<button (click)="addNewComment()">Agregar</button>
```

---

## **5. Realizar una Petición PUT**

La petición PUT se usa para actualizar un recurso existente.

#### **Archivo: `comment.service.ts`**

```ts
updateComment(id: number, comment: { name: string, body: string }): Observable<any> {
  return this.http.put(`${this.API_URL}/${id}`, comment);
}
```

#### **Archivo: `app.component.ts`**

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

#### **Archivo: `app.component.html`**

```html
<button (click)="updateExistingComment()">Actualizar Comentario</button>
```

---

## **6. Realizar una Petición DELETE**

La petición DELETE elimina un recurso de la API.

#### **Archivo: `comment.service.ts`**

```ts
deleteComment(id: number): Observable<any> {
  return this.http.delete(`${this.API_URL}/${id}`);
}
```

#### **Archivo: `app.component.ts`**

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

#### **Archivo: `app.component.html`**

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

[![Peticiones POST y DELETE](https://img.youtube.com/vi/puuGP0iq5Zk/0.jpg)](https://www.youtube.com/watch?v=puuGP0iq5Zk&list=PLzA2VyZwsq_9cD3JIxBymaIVyef07PJ-y)

---

## **7. Manejo de Errores en Peticiones HTTP**

También se pueden manejar errores usando el operador `catchError` de RxJS.

#### **Archivo: `comment.service.ts`**

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

## **8. Conclusión**

- **`HttpClient`** permite realizar peticiones HTTP de forma sencilla.
- **GET, POST, PUT y DELETE** son los métodos más utilizados.
- Se deben gestionar los posibles errores.
- Angular ofrece una integración eficiente y moderna para consumir APIs.

---

En el próximo tema, exploraremos **cómo realizar tests unitarios usando Jasmine y Karma**.
