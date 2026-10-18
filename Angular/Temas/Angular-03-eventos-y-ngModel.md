# **Topic 3: Events and Bidirectional Binding `[(ngModel)]` in Angular**

## **1. Introduction**

In Angular, events and the `[(ngModel)]` bidirectional binding are essential tools for user interaction with the application.  
This topic will cover:

- How to handle events in Angular with `(event)`.
- Bidirectional binding with `[(ngModel)]` to synchronize data between the view and the model.

---

## **2. Handling events in Angular**

An event in Angular occurs when the user interacts with the application, for example:

- Click a button.
- Write in an input field.
- Move the mouse over an element.

Angular provides a mechanism to handle these events with event binding, using the `(evento)="función()"` syntax.

---

### **2.1. Event binding syntax**

The basic syntax is:

```html
<button (click)="myFunction()">Haz clic</button>
```


When the user clicks the button, the `myFunction()` function will be executed on the component.

---

### **2.2. Example of event handling**

Suppose we want to display a message when the user clicks a button.

**Example in `eventos.component.ts`**:

```ts
import { Component } from "@angular/core";

@Component({
  selector: "app-eventos",
  templateUrl: "./eventos.component.html",
  styleUrls: ["./eventos.component.css"],
})
export class EventosComponent {
  showMessage() {
    alert("¡Botón clicado!");
  }
}
```


**Example in `eventos.component.html`**:

```html
<button (click)="showMessage()">Haz clic aquí</button>
```


In this case, clicking the button runs `showMessage()`, displaying an alert.

---

[![Events](https://img.youtube.com/vi/efvtZZDpixc/0.jpg)](https://www.youtube.com/watch?v=efvtZZDpixc&list=PLzA2VyZwsq_9cD3JIxBymaIVyef07PJ-y)

---

### **23. Pass parameters in events**

We can pass values to the function inside the component.

Example in `eventos.component.html`:

```html
<button (click)="sayHello('Sara')">Saludar</button>
```


Example in `eventos.component.ts`:

```ts
export class EventosComponent {
  sayHello(nombre: string) {
    alert("¡Hola, " + nombre + "!");
  }
}
```


When the user clicks the button, the `sayHello('Sara')` function will be executed, displaying `"¡Hola, Sara!"`.

---

### **2.4. Events with `$event`**

We can also capture event information using `$event`.

Example in `eventos.component.html`:

```html
<input (input)="updateText($event)" />
<p>{{ mensaje }}</p>
```


Example in `eventos.component.ts`:

```ts
export class EventosComponent {
  mensaje: string = "";

  updateText(e: Event) {
    this.mensaje = (e.target as HTMLInputElement).value;
  }
}
```


Here:

1. Every time the user types in the input field, `updateText()` is executed.
2. The `mensaje` variable is updated with the entered text.
3. `{{ mensaje }}` interpolation displays the updated content on the screen.

---

## **3. Bidirectional binding with `ngModel`**

**Two-way binding** allows a variable in the component and a field in the view to stay in sync automatically.

To achieve this, we use the `[(ngModel)]` directive, which combines property binding and event binding. That's why it uses both square brackets [property binding] and parentheses (event binding).

> Note: This syntax is known as: Banana in a box.

**Basic example in `ngmodel.component.ts`**:

```ts
import { Component } from "@angular/core";

@Component({
  selector: "app-ngmodel",
  templateUrl: "./ngmodel.component.html",
  styleUrls: ["./ngmodel.component.css"],
})
export class NgModelComponent {
  userName: string = "";
}
```


**Example in `ngmodel.component.html`**:

```html
<input [(ngModel)]="userName" placeholder="Escribe tu nombre" />
<p>Hola, {{ userName }}</p>
```


In this case:

- `[(ngModel)]="userName"` causes the input value and the `userName` variable to be synchronized.
- When writing to the input, `userName` is automatically updated.
- The `"Hola, [nombre]"` message is updated in real time.

---

### **3.1. Import `FormsModule`**

For `ngModel` to work, we need to import `FormsModule` into the component where it is used.

Example in `app.module.ts`:

```ts
import { NgModule } from "@angular/core";
import { FormsModule } from "@angular/forms"; // Importar FormsModule

import { AppComponent } from "./app.component";
import { NgModelComponent } from "./ngmodel/ngmodel.component";

@NgModule({
  declarations: [AppComponent, NgModelComponent],
  imports: [FormsModule], // Agregar FormsModule aquí
  bootstrap: [AppComponent],
})
export class AppModule {}
```


Without this import, `ngModel` will not work.

---
[![ngModel](https://img.youtube.com/vi/2NWc1x-VLcM/0.jpg)](https://www.youtube.com/watch?v=2NWc1x-VLcM&list=PLzA2VyZwsq_9cD3JIxBymaIVyef07PJ-y)

---

## **4. Comparison between event binding and `ngModel`**

| **Binding Type** | **Description** | **Example** |
| --------------------------------------- | ----------------------------------------------------------------- | ------------------------ |
| **`(event)` event binding** | Captures user events and executes functions on the component. | `(click)="myFunction()"` |
| **Bidirectional binding `[(ngModel)]`** | Synchronizes the value of a variable with the input in real time.  | `[(ngModel)]="variable"` |

---

## **5. Highlight**

- **Events in Angular** allow functions to be executed in response to user actions.
- We can use `$event` to capture event information.
- Using **bidirectional binding with `ngModel`** keeps variable values and inputs synchronized.
- To use `ngModel`, it is necessary to import `FormsModule` in the component that uses it.

---

In the next topic, we will explore some Angular flow control tools like `@if` and `@for`
