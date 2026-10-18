# **Topic 4: Flow Control in Angular (@if and @for)**

## **1. Introduction**

In Angular, flow control allows us to manage the display logic of elements in the DOM. Starting with Angular 17, the `@if` and `@for` directives were introduced, which improve the readability and efficiency of the code.

This topic will cover:

- The `@if` directive to conditionally render elements in the view.
- The `@for` directive to iterate over lists of elements.
- Comparison with the traditional `*ngIf` and `*ngFor` directives.

---

## **2. The `@if`** Directive

The `@if` directive allows you to show or hide elements based on a condition. Replaces `*ngIf`, improving code structure and clarity.

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

- If `isLoggedIn` is `true`, the message "Welcome, user." will be displayed.
- If `isLoggedIn` is `false`, "Please log in." will be displayed.

---

[![@if](https://img.youtube.com/vi/DeCvp-KUOcY/0.jpg)](https://www.youtube.com/watch?v=DeCvp-KUOcY&list=PLzA2VyZwsq_9cD3JIxBymaIVyef07PJ-y)

---

## **3. The `@for`** Directive

The `@for` directive allows iterating over a list and dynamically generating elements in the view, it replaces `*ngFor`, improving the structure and clarity of the code.

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

- An `ul` list is dynamically generated with the elements of `items`.
- `track` is used to optimize DOM updating by making Angular clearly identify each element in the list.

---

[![@for](https://img.youtube.com/vi/xlM4U-cjMXA/0.jpg)](https://www.youtube.com/watch?v=xlM4U-cjMXA&list=PLzA2VyZwsq_9cD3JIxBymaIVyef07PJ-y)

---

## **4. Comparison between `@if`/`@for` and `*ngIf`/`*ngFor`**

| **Directive** | **New Syntax** | **Previous Syntax** |
| ------------- | ------------------------------------------ | --------------------------------------------------------------------- |
| Conditional | `@if (condición) { ... } @else { ... }` | `<ng-container *ngIf="condición; else otraPlantilla"></ng-container>` |
| Iteration | `@for (item of items; track item) { ... }` | `<div *ngFor="let item of items">{{ item }}</div>` |

### **4.1. Advantages of `@if` and `@for`**

- **Greater readability**: More like JavaScript syntax.
- **Better performance**: Reduces unnecessary calculations in the DOM.
- **Clearer structure**: Avoid the use of `<ng-container>` and auxiliary templates.

---

## **5. Conclusion**

- `@if` allows you to show or hide content depending on the condition we choose.
- `@for` makes iterating over lists efficiently.
- These new directives simplify the code and improve the organization of the view.

---

In the next topic, we will explore signals and new ways to manage reactivity in Angular.
