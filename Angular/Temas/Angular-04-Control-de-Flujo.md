# **Topic 4: Control Flow in Angular (@if and @for)**

## **1. Introduction**

In Angular, control flow lets us manage the display logic of elements in the DOM. Angular 17 introduced the `@if` and `@for` directives, which improve the readability and efficiency of the code.

This topic will cover:

- The `@if` directive to conditionally render elements in the view.
- The `@for` directive to iterate over lists of elements.
- Comparison with the traditional `*ngIf` and `*ngFor` directives.

---

## **2. The `@if` directive**

The `@if` directive lets you show or hide elements based on a condition. It replaces `*ngIf`, improving the structure and clarity of the code.

### **2.1. Basic use of `@if`**

Example in `control-flujo.component.html`:

```html
@if (isLoggedIn) {
<p>Bienvenido, usuario.</p>
} @else {
<p>Por favor, inicia sesión.</p>
}
```


Example in `control-flujo.component.ts`:

```ts
import { Component } from "@angular/core";

@Component({
  selector: "app-control-flujo",
  templateUrl: "./control-flujo.component.html",
  styleUrls: ["./control-flujo.component.css"],
})
export class ControlFlujoComponent {
  isLoggedIn: boolean = false;
}
```


In this case:

- If `isLoggedIn` is `true`, the message "Bienvenido, usuario." will be displayed.
- If `isLoggedIn` is `false`, "Por favor, inicia sesión." will be displayed.

---

[![@if](https://img.youtube.com/vi/DeCvp-KUOcY/0.jpg)](https://www.youtube.com/watch?v=DeCvp-KUOcY&list=PLzA2VyZwsq_9cD3JIxBymaIVyef07PJ-y)

---

## **3. The `@for` directive**

The `@for` directive lets you iterate over a list and dynamically generate elements in the view. It replaces `*ngFor`, improving the structure and clarity of the code.

### **3.1. Basic use of `@for`**

Example in `control-flujo.component.html`:

```html
<ul>
  @for (item of items; track item) {
  <li>{{ item }}</li>
  }
</ul>
```


Example in `control-flujo.component.ts`:

```ts
import { Component } from "@angular/core";

@Component({
  selector: "app-control-flujo",
  templateUrl: "./control-flujo.component.html",
  styleUrls: ["./control-flujo.component.css"],
})
export class ControlFlujoComponent {
  items: string[] = ["Angular", "React", "Vue"];
}
```


In this case:

- A `ul` list is generated dynamically with the elements of `items`.
- `track` is used to optimize DOM updates by letting Angular clearly identify each element in the list.

---

[![@for](https://img.youtube.com/vi/xlM4U-cjMXA/0.jpg)](https://www.youtube.com/watch?v=xlM4U-cjMXA&list=PLzA2VyZwsq_9cD3JIxBymaIVyef07PJ-y)

---

## **4. Comparing `@if`/`@for` and `*ngIf`/`*ngFor`**

| **Directive** | **New syntax** | **Previous syntax** |
| ------------- | ------------------------------------------ | --------------------------------------------------------------------- |
| Conditional | `@if (condición) { ... } @else { ... }` | `<ng-container *ngIf="condición; else otraPlantilla"></ng-container>` |
| Iteration | `@for (item of items; track item) { ... }` | `<div *ngFor="let item of items">{{ item }}</div>` |

### **4.1. Advantages of `@if` and `@for`**

- **Better readability**: It looks more like JavaScript syntax.
- **Better performance**: Reduces unnecessary calculations in the DOM.
- **Clearer structure**: Avoids the use of `<ng-container>` and helper templates.

---

## **5. Conclusion**

- `@if` lets you show or hide content depending on the condition you choose.
- `@for` makes it easy to iterate over lists efficiently.
- These new directives simplify the code and improve the organization of the view.

---

In the next topic, we will explore signals and new ways to manage reactivity in Angular.
