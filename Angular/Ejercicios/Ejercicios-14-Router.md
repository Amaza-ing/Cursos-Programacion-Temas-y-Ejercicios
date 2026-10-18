# **Exercises - Topic 14: Using the Router and `RouterLink` in Angular**

## **Instructions:**

Below you will find exercises on how to configure routes and navigate within a SPA in Angular.

Try to solve them before looking at the solution.

---

### **Exercise 1: Configure a router with basic routes**

Define a router with two routes: `home` and `about`, and have the application start with `home`.

<details><summary>Show solution</summary>

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


</details>

---

### **Exercise 2: Create links with `RouterLink`**

Add the code needed to include navigation links with `RouterLink` to one component and add `<router-outlet>` to another component to render the pages.

<details><summary>Show solution</summary>

#### **File: `app.component.html`**

```html
<router-outlet></router-outlet>
```


#### **File: `header.component.html`**

```html
<nav>
  <a routerLink="/">Inicio</a>
  <a routerLink="/about">Acerca de</a>
</nav>
```


</details>

---

### **Exercise 3: Create a route with parameters**

Create a new `/profile/:id` route and a `ProfileComponent` component that displays the user ID received through the URL.

<details><summary>Show solution</summary>

#### **File: `app.routes.ts`**

```ts
import { ProfileComponent } from "./app/profile/profile.component";

const routes = [{ path: "profile/:id", component: ProfileComponent }];
```


#### **File: `profile.component.ts`**

```ts
import { ActivatedRoute } from "@angular/router";

@Component({
  selector: "app-profile",
  template: "<h1>Perfil de usuario: {{ userId }}</h1>",
})
export class ProfileComponent {
  userId = this.route.snapshot.paramMap.get("id");

  constructor(private route: ActivatedRoute) {}
}
```


#### **File: `users.component.html`**

```html
<a routerLink="/profile/1">Ver Perfil de Usuario 1</a>
```


</details>

---

### **Exercise 4: Route redirection and 404 handling**

Configure the Router so that any undefined route redirects to `home`.

<details><summary>Show solution</summary>

#### **File: `app.routes.ts`**

```ts
const routes = [
  { path: "", component: HomeComponent },
  { path: "about", component: AboutComponent },
  { path: "**", redirectTo: "", pathMatch: "full" },
];
```


</details>

---

### **Exercise 5: Set an active route with `routerLinkActive`**

Add a CSS class to highlight the active link.

<details><summary>Show solution</summary>

#### **File: `header.component.html`**

```html
<nav>
  <a routerLink="/" routerLinkActive="active">Inicio</a>
  <a routerLink="/about" routerLinkActive="active">Acerca de</a>
</nav>
```


#### **File: `styles.css`**

```css
.active {
  font-weight: bold;
  color: blue;
}
```


</details>
