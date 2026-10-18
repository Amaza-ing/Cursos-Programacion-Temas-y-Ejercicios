# **Topic 14: Using the Router in Angular to Create Routes in a SPA**

## **1. Introduction**

In Angular, the **Router** lets you manage navigation within a single-page application (**SPA**, _Single Page Application_). Instead of reloading the page, Angular dynamically swaps components based on the URL.

In this topic, you will learn:

- How to configure the `Router` in Angular.
- How to define routes and navigate between them.
- How to use `RouterLink` to create dynamic links.
- How to handle dynamic routes with parameters.

---

## **2. Configuring the Router in Angular**

### **2.1. Opening `app.routes.ts` and defining routes**

Angular lets you define routes in the `app.routes.ts` file without needing a separate module.

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
- For this to work, the Home and About components must exist.
- One way to organize these components is to create them in the `app/pages` folder instead of `app/components`.

---

## **3. Creating components for the routes**

Each route must be associated with a component. Each route will represent a page of our website, and each component will be rendered on the right route.

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

For these pages to render, we need to use the `<router-outlet>` component and add `RouterOutlet` to the imports.

It is usually placed in the root component, `app.component.html`, and it is normally the only thing in the root component's HTML.

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


We can think of the `<router-outlet>` as a kind of television that shows one picture or another when you change channels, except that here it renders one page or another when the route changes.

---

[![Router](https://img.youtube.com/vi/HNb0ITSvHdE/0.jpg)](https://www.youtube.com/watch?v=HNb0ITSvHdE&list=PLzA2VyZwsq_9cD3JIxBymaIVyef07PJ-y)

---

## **5. Navigating with `RouterLink`**

Since our website can have several pages, we need internal links to navigate between them instead of depending on typing the path in the browser's address bar.

Angular provides `RouterLink` to create these links and navigate between pages without reloading the application.

To use `RouterLink`, we have to import it into the component where we want to use it.

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


Here, `routerLink` defines internal links that don't reload the page.

---

[![RouterLink](https://img.youtube.com/vi/wp5IVM7vkDM/0.jpg)](https://www.youtube.com/watch?v=wp5IVM7vkDM&list=PLzA2VyZwsq_9cD3JIxBymaIVyef07PJ-y)

---

## **6. Routes with dynamic parameters**

You can define routes with parameters to display dynamic information. This way, a component can be reused many times with different information.

Imagine you want to create an image gallery or a social network: you wouldn't want to create a component for each individual image, or a component for each user. The ideal is to create a single component and, from a parameter (a photo's id or a username), get all the information needed to display it on the page.
### **6.1. Defining a route with parameters**

To define a parameterized route, we do the same as before: add a route to the `app.routes.ts` file and specify a parameter in that route.

#### **File: `app.routes.ts` (adding a route with a parameter)**

```ts
const routes = [{ path: "profile/:id", component: ProfileComponent }];
```


Here, `:id` represents an `id` variable that can take any value in the route. You must put the colon (:) to specify the route parameter.

### **6.2. Capturing parameters in a component**

Once we have a parameterized route, we can get the route parameter and then use it to look up the information we want (for example, getting a user's information from their username by querying a database or an API).

To do that, we have to import `ActivatedRoute` and use `this.route.snapshot.paramMap.get("id")`, where `id` can be whatever name we gave the parameter and `route` is the name of the variable that holds all the route information. This variable has to be injected into the constructor.

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

[![Parameterized Routes](https://img.youtube.com/vi/tAa4P8a__uQ/0.jpg)](https://www.youtube.com/watch?v=tAa4P8a__uQ&list=PLzA2VyZwsq_9cD3JIxBymaIVyef07PJ-y)

---

### **6.3. Linking to a route with parameters**

#### **File: `app.component.html`**

```html
<a routerLink="/profile/1">Ver Perfil de Usuario 1</a>
```


**Or using variables:**

```html
<a [routerLink]="routePath">Ver Perfil de Usuario 1</a>
```


**Or without using '/' from a specific route:**

If we add a link from a component that is being rendered on a specific route, adding `[routerLink]` with any value without a "/" will take us to the route we were on / the value we added.

For example, from a component that is rendered on the `/profile` route.

```html
<a [routerLink]="user.id">Ver Perfil de Usuario 1</a>
```


If `user.id` is equal to 1, this would take us to `/profile/1`.

**Here:**

- `:id` is a dynamic parameter that is captured in `ProfileComponent`.
- `routerLink="/profile/1"` creates a dynamic link to `/profile/1`.

---

## **7. Redirects and 404 routes**

We can define default routes and handle routes that don't exist.

#### **File: `main.ts`**

```ts
const routes = [
  { path: "", component: HomeComponent },
  { path: "about", component: AboutComponent },
  { path: "**", redirectTo: "" },
];
```


Here:

- `redirectTo: ''` redirects any route that doesn't exist to `/` (Home).
- We can create any other component, such as an Error page, and redirect there instead of to the Home page.

---

## **8. Routes and services**

If we combine routes with services, we can easily share information between pages (components).

---

[![Routes and Services](https://img.youtube.com/vi/QBLDZE0nzng/0.jpg)](https://www.youtube.com/watch?v=QBLDZE0nzng&list=PLzA2VyZwsq_9cD3JIxBymaIVyef07PJ-y)

---

## **9. Conclusion**

- **The Angular Router** lets you manage navigation in a SPA without reloading the page.
- **`RouterLink`** makes internal navigation easy without the need for `href`.
- **Routes with parameters** let you display dynamic content.
- **`router-outlet`** defines the area where components will be displayed based on the active route.

---

In the next topic, we will explore **how to make requests to an API using HttpClient**.
