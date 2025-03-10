# **Tema 14: Uso del Router en Angular para Crear Rutas en una SPA**

## **1. Introducción**

En Angular, el **Router** permite gestionar la navegación dentro de una aplicación de una sola página (**SPA**, _Single Page Application_). En lugar de recargar la página, Angular cambia dinámicamente los componentes según la URL.

En este tema aprenderás:

- Cómo configurar el `Router` en Angular.
- Cómo definir rutas y navegar entre ellas.
- Cómo usar `RouterLink` para crear enlaces dinámicos.
- Cómo manejar rutas dinámicas con parámetros.

---

## **2. Configuración del Router en Angular**

### **2.1. Abrir `app.routes.ts` y Definir Rutas**

Angular permite definir rutas en el archivo `app.routes.ts` sin necesidad de un módulo separado.

#### **Archivo: `app.routes.ts`**

```ts
import { Routes } from "@angular/router";

import { HomeComponent } from "./app/home/home.component";
import { AboutComponent } from "./app/about/about.component";

export const routes = [
  { path: "", component: HomeComponent },
  { path: "about", component: AboutComponent },
];
```

Aquí:

- Se definen rutas para `/` (Home) y `/about` (About).
- Para que esto funcione los componentes Home y About deben existir.
- Una manera de organizar estos componentes es crearlos en la carpeta `app/pages` en lugar de en `app/components`.

---

## **3. Creación de Componentes para las Rutas**

Cada ruta debe estar asociada a un componente. Cada ruta representará una página de nuestra web, y cada componente se renderizará en la ruta adecuada.

#### **Archivo: `home.component.ts`**

```ts
import { Component } from "@angular/core";

@Component({
  selector: "app-home",
})
export class HomeComponent {}
```

#### **Archivo: `about.component.ts`**

```ts
import { Component } from "@angular/core";

@Component({
  selector: "app-about",
})
export class AboutComponent {}
```

## **4. Router Outlet**

Para que estas páginas se rendericen necesitamos usar el componente `<router-outlet>` y añadir `RouterOutlet` a los imports.

Este se encontrará habitualmente en el componente raíz `app.component.html`. Y normalmente es lo único que hay en el html del componente raíz.

#### **Archivo: `app.component.ts`**

```ts
@Component({
  selector: 'app-root',
  imports: [RouterOutlet],
})
```

#### **Archivo: `app.component.html`**

```html
<router-outlet></router-outlet>
```

Podemos pensar en el `<router-outlet>` como en una especie de televisión, que muestra una imagen u otra al cambiar de canal, sólo que aquí renderizará una página u otra al cambiar de ruta.

---

[![Router](https://img.youtube.com/vi/HNb0ITSvHdE/0.jpg)](https://www.youtube.com/watch?v=HNb0ITSvHdE&list=PLzA2VyZwsq_9cD3JIxBymaIVyef07PJ-y)

---

## **5. Navegación con `RouterLink`**

Como nuestra web puede tener varias páginas, necesitamos enlaces internos para navegar entre ellas y no depender de escribir la ruta en la barra de direcciones del navegador.

Angular proporciona `RouterLink` para crear estos enlaces y navegar entre páginas sin recargar la aplicación.

Para usar `RouterLink` tenemos que importarlo en el componente donde queramos usarlo.

#### **Archivo: `header.component.ts`**

```ts
import { RouterLink } from '@angular/router';

@Component({
  imports: [RouterLink],
})
export class HeaderComponent {
  ...
}
```

#### **Archivo: `header.component.html`**

```html
<header>
  <nav>
    <a routerLink="/">Inicio</a>
    <a routerLink="/about">Acerca de</a>
  </nav>
</header>
```

Aquí `routerLink` define enlaces internos sin recargar la página.

---

[![RouterLink](https://img.youtube.com/vi/wp5IVM7vkDM/0.jpg)](https://www.youtube.com/watch?v=wp5IVM7vkDM&list=PLzA2VyZwsq_9cD3JIxBymaIVyef07PJ-y)

---

## **6. Rutas con Parámetros Dinámicos**

Es posible definir rutas con parámetros para mostrar información dinámica. Así se puede reutilizar un componente con distinta información muchas veces.

Imagina que quieres crear una galería de imágenes o una red social, no querrías crear un componente para cada imagen individual ni tampoco un componente para cada usuario. Lo ideal es crear un sólo componente y a partir de un parámetro (id de una foto, o el nombre de usuario) obtener toda la información necesaria para mostrarla en la página.

### **6.1. Definir una Ruta con Parámetros**

Para definir una ruta paramétrica debemos hacer lo mismo que antes, añadir una ruta en el fichero `app.routes.ts` y especificar un parámetro en esa ruta.

#### **Archivo: `app.routes.ts` (Añadir una Ruta con Parámetro)**

```ts
const routes = [{ path: "profile/:id", component: ProfileComponent }];
```

Aquí `:id` representa a una variable `id` que puede obtener cualquier valor en la ruta. Se deben poner los dos puntos (:) para especificar el parámetro de ruta.

### **6.2. Capturar Parámetros en un Componente**

Una vez tenemos una ruta paramétrica podemos obtener el parámetro de ruta para después utilizarlo para buscar la información que queremos (por ejemplo obtener la información de un usuario a partir de su nombre de usuario haciendo una consulta en una base de datos o una API).

Para eso tenemos que importar `ActivatedRoute` y utilizar `this.route.snapshot.paramMap.get("id")` donde `id` puede ser cualquier nombre que hayamos puesto al parámetro y `route` el nombre de la variable que contiene toda la información de la ruta. Esta variable hay que inyectarla en el constructor.

#### **Archivo: `profile.component.ts`**

```ts
import { ActivatedRoute } from "@angular/router";

@Component({
  selector: "app-profile",
  standalone: true,
  template: "<h1>Perfil de usuario: {{ userId }}</h1>",
})
export class ProfileComponent {
  userId;

  constructor(private route: ActivatedRoute) {
    this.userId = this.route.snapshot.paramMap.get("id");
  }
}
```

---

[![Rutas Paramétricas](https://img.youtube.com/vi/tAa4P8a__uQ/0.jpg)](https://www.youtube.com/watch?v=tAa4P8a__uQ&list=PLzA2VyZwsq_9cD3JIxBymaIVyef07PJ-y)

---

### **6.3. Enlazar a una Ruta con Parámetros**

#### **Archivo: `app.component.html`**

```html
<a routerLink="/profile/1">Ver Perfil de Usuario 1</a>
```

**O usando variables:**

```html
<a [routerLink]="routePath">Ver Perfil de Usuario 1</a>
```

**O sin usar '/' desde una ruta específica:**

Si añadimos un enlace desde un componente que se está renderizando en una ruta concreta, al añadir `[routerLink]` con cualquier valor sin usar "/" iremos a la ruta en la que estuviéramos / el valor que añadamos.

Por ejemplo, desde un componente que se renderiza en la ruta `/profile`.

```html
<a [routerLink]="user.id">Ver Perfil de Usuario 1</a>
```

Si `user.id` es igual a 1, esto nos llevaría a `/profile/1`.

**Aquí:**

- `:id` es un parámetro dinámico que se captura en `ProfileComponent`.
- `routerLink="/profile/1"` crea un enlace dinámico a `/profile/1`.

---

## **7. Redirecciones y Rutas 404**

Podemos definir rutas por defecto y manejar rutas inexistentes.

#### **Archivo: `main.ts`**

```ts
const routes = [
  { path: "", component: HomeComponent },
  { path: "about", component: AboutComponent },
  { path: "**", redirectTo: "" },
];
```

Aquí:

- `redirectTo: ''` redirige cualquier ruta inexistente a `/` (Home).
- Podemos crear cualquier otro componente, como una página de Error, para redirgir allí en lugar de a la Home.

---

## **8. Rutas y servicios**

Si mezclamos las rutas con los servicios podemos compartir información entre páginas (componentes) de una manera sencilla.

---

[![Rutas y Servicios](https://img.youtube.com/vi/QBLDZE0nzng/0.jpg)](https://www.youtube.com/watch?v=QBLDZE0nzng&list=PLzA2VyZwsq_9cD3JIxBymaIVyef07PJ-y)

---

## **9. Conclusión**

- **El Router de Angular** permite gestionar la navegación en una SPA sin recargar la página.
- **`RouterLink`** facilita la navegación interna sin necesidad de `href`.
- **Las rutas con parámetros** permiten mostrar contenido dinámico.
- **`router-outlet`** define el área donde se mostrarán los componentes según la ruta activa.

---

En el próximo tema, exploraremos **cómo realizar peticiones a una API utilizando HttpClient**.
