# **Ejercicios - Tema 14: Uso del Router y `RouterLink` en Angular**

## **Instrucciones:**

A continuación, encontrarás ejercicios sobre cómo configurar rutas y navegar dentro de una SPA en Angular.

Intenta resolverlos antes de consultar la solución.

---

### **Ejercicio 1: Configurar un Router con Rutas Básicas**

Define un enrutador con dos rutas: `home` y `about`, y haz que la aplicación arranque con `home`.

<details><summary>Mostrar solución</summary>

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

</details>

---

### **Ejercicio 2: Crear Enlaces con `RouterLink`**

Añade a un componente el código necesario para incluir enlaces de navegación con `RouterLink` y a otro componente `<router-outlet>` para renderizar las páginas.

<details><summary>Mostrar solución</summary>

#### **Archivo: `app.component.html`**

```html
<router-outlet></router-outlet>
```

#### **Archivo: `header.component.html`**

```html
<nav>
  <a routerLink="/">Inicio</a>
  <a routerLink="/about">Acerca de</a>
</nav>
```

</details>

---

### **Ejercicio 3: Crear una Ruta con Parámetros**

Crea una nueva ruta `/profile/:id` y un componente `ProfileComponent` que muestre el ID del usuario recibido por la URL.

<details><summary>Mostrar solución</summary>

#### **Archivo: `app.routes.ts`**

```ts
import { ProfileComponent } from "./app/profile/profile.component";

const routes = [{ path: "profile/:id", component: ProfileComponent }];
```

#### **Archivo: `profile.component.ts`**

```ts
import { ActivatedRoute } from "@angular/router";

@Component({
  selector: "app-profile",
  standalone: true,
  template: "<h1>Perfil de usuario: {{ userId }}</h1>",
})
export class ProfileComponent {
  userId = this.route.snapshot.paramMap.get("id");

  constructor(private route: ActivatedRoute) {}
}
```

#### **Archivo: `users.component.html`**

```html
<a routerLink="/profile/1">Ver Perfil de Usuario 1</a>
```

</details>

---

### **Ejercicio 4: Redirección de Rutas y Manejo de 404**

Configura el Router para que cualquier ruta no definida redirija a `home`.

<details><summary>Mostrar solución</summary>

#### **Archivo: `app.routes.ts`**

```ts
const routes = [
  { path: "", component: HomeComponent },
  { path: "about", component: AboutComponent },
  { path: "**", redirectTo: "", pathMatch: "full" },
];
```

</details>

---

### **Ejercicio 5: Establecer una Ruta Activa con `routerLinkActive`**

Añade una clase CSS para resaltar el enlace activo.

<details><summary>Mostrar solución</summary>

#### **Archivo: `header.component.html`**

```html
<nav>
  <a routerLink="/" routerLinkActive="active">Inicio</a>
  <a routerLink="/about" routerLinkActive="active">Acerca de</a>
</nav>
```

#### **Archivo: `styles.css`**
```css
.active {
  font-weight: bold;
  color: blue;
}
```

</details>
