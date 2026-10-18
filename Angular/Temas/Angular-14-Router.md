# **Topic 14: Using the Router in Angular to Create Routes in a SPA**

## **1. Introduction**

In Angular, the **Router** allows you to manage navigation within a single page application (**SPA**, _Single Page Application_). Instead of reloading the page, Angular dynamically changes components based on the URL.

In this topic you will learn:

- How to configure `Router` in Angular.
- How to define routes and navigate between them.
- How to use `RouterLink` to create dynamic links.
- How to handle dynamic routes with parameters.

---

## **2. Router Configuration in Angular**

### **2.1. Open `app.routes.ts` and Define Routes**

Angular allows you to define routes in the `app.routes.ts` file without needing a separate module.

#### **File: `app.routes.ts`**

```ts
import { Routes } from "@angular/router";

import { HomeComponent } from "./app/home/home.component";
import { AboutComponent } from "./app/about/about.component";

export const routes = [
  { path: "", component: HomeComponent },
  { path: "about", component: AboutComponent },
];
```


Here:

- Routes are defined for `/` (Home) and `/about` (About).
- For this to work the Home and About components must exist.
- One way to organize these components is to create them in the `app/pages` folder instead of `app/components`.

---

## **3. Creation of Components for Routes**

Each route must be associated with a component. Each route will represent a page on our website, and each component will be rendered in the appropriate route.

#### **File: `home.component.ts`**

```ts
import { Component } from "@angular/core";

@Component({
  selector: "app-home",
})
export class HomeComponent {}
```


#### **File: `about.component.ts`**

```ts
import { Component } from "@angular/core";

@Component({
  selector: "app-about",
})
export class AboutComponent {}
```


## **4. Router Outlet**

For these pages to render we need to use the `<router-outlet>` component and add `RouterOutlet` to the imports.

This will usually be found in the `app.component.html` root component. And usually it's the only thing in the html of the root component.

#### **File: `app.component.ts`**

```ts
@Component({
  selector: 'app-root',
  imports: [RouterOutlet],
})
```


#### **File: `app.component.html`**

```html
<router-outlet></router-outlet>
```


We can think of the `<router-outlet>` as a kind of television, which shows one image or another when changing channels, only here it will render one page or another when changing routes.

---

[![Router](https://img.youtube.com/vi/HNb0ITSvHdE/0.jpg)](https://www.youtube.com/watch?v=HNb0ITSvHdE&list=PLzA2VyZwsq_9cD3JIxBymaIVyef07PJ-y)

---

## **5. Navigation with `RouterLink`**

As our website can have several pages, we need internal links to navigate between them and not depend on typing the path in the browser's address bar.

Angular provides `RouterLink` to create these links and navigate between pages without reloading the application.

To use `RouterLink` we have to import it into the component where we want to use it.

#### **File: `header.component.ts`**

```ts
import { RouterLink } from '@angular/router';

@Component({
  imports: [RouterLink],
})
export class HeaderComponent {
  ...
}
```


#### **File: `header.component.html`**

```html
<header>
  <nav>
    <a routerLink="/">Inicio</a>
    <a routerLink="/about">Acerca de</a>
  </nav>
</header>
```


Here `routerLink` defines internal links without reloading the page.

---

[![RouterLink](https://img.youtube.com/vi/wp5IVM7vkDM/0.jpg)](https://www.youtube.com/watch?v=wp5IVM7vkDM&list=PLzA2VyZwsq_9cD3JIxBymaIVyef07PJ-y)

---

## **6. Routes with Dynamic Parameters**

It is possible to define routes with parameters to display dynamic information. This way a component with different information can be reused many times.

Imagine you want to create an image gallery or a social network, you wouldn't want to create a component for each individual image nor a component for each user. The ideal is to create a single component and from a parameter (id of a photo, or username) obtain all the necessary information to display it on the page.
### **6.1. Define a Route with Parameters**

To define a parametric route we must do the same as before, add a route to the `app.routes.ts` file and specify a parameter in that route.

#### **File: `app.routes.ts` (Add a Route with Parameter)**

```ts
const routes = [{ path: "profile/:id", component: ProfileComponent }];
```


Here `:id` represents an `id` variable that can get any value in the path. A colon (:) must be used to specify the route parameter.

### **6.2. Capture Parameters in a Component**

Once we have a parametric route we can obtain the route parameter and then use it to search for the information we want (for example, obtain a user's information from their username by making a query in a database or an API).

For that we have to import `ActivatedRoute` and use `this.route.snapshot.paramMap.get("id")` where `id` can be any name that we have given to the parameter and `route` the name of the variable that contains all the route information. This variable must be injected into the constructor.

#### **File: `profile.component.ts`**

```ts
import { ActivatedRoute } from "@angular/router";

@Component({
  selector: "app-profile",
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

[![Parametric Routes](https://img.youtube.com/vi/tAa4P8a__uQ/0.jpg)](https://www.youtube.com/watch?v=tAa4P8a__uQ&list=PLzA2VyZwsq_9cD3JIxBymaIVyef07PJ-y)

---

### **6.3. Link to a Route with Parameters**

#### **File: `app.component.html`**

```html
<a routerLink="/profile/1">Ver Perfil de Usuario 1</a>
```


**Or using variables:**

```html
<a [routerLink]="routePath">Ver Perfil de Usuario 1</a>
```


**Or without using '/' from a specific path:**

If we add a link from a component that is being rendered in a specific path, adding `[routerLink]` with any value without using "/" will go to the path we were on / the value we added.

For example, from a component that renders to path `/profile`.

```html
<a [routerLink]="user.id">Ver Perfil de Usuario 1</a>
```


If `user.id` is equal to 1, this would take us to `/profile/1`.

**Here:**

- `:id` is a dynamic parameter that is captured in `ProfileComponent`.
- `routerLink="/profile/1"` creates a dynamic link to `/profile/1`.

---

## **7. Redirects and 404 Routes**

We can define default routes and handle non-existent routes.

#### **File: `main.ts`**

```ts
const routes = [
  { path: "", component: HomeComponent },
  { path: "about", component: AboutComponent },
  { path: "**", redirectTo: "" },
];
```


Here:

- `redirectTo: ''` redirects any non-existent routes to `/` (Home).
- We can create any other component, such as an Error page, to redirect there instead of to the Home.

---

## **8. Routes and services**

If we mix routes with services we can share information between pages (components) in a simple way.

---

[![Routes and Services](https://img.youtube.com/vi/QBLDZE0nzng/0.jpg)](https://www.youtube.com/watch?v=QBLDZE0nzng&list=PLzA2VyZwsq_9cD3JIxBymaIVyef07PJ-y)

---

## **9. Conclusion**

- **The Angular Router** allows you to manage navigation in a SPA without reloading the page.
- **`RouterLink`** facilitates internal navigation without the need for `href`.
- **Routes with parameters** allow you to display dynamic content.
- **`router-outlet`** defines the area where components will be displayed based on the active route.

---

In the next topic, we will explore **how to make requests to an API using HttpClient**.
