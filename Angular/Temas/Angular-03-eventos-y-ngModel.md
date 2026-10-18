# **Topic 3: Events and Two-Way Binding `[(ngModel)]` in Angular**

## **1. Introduction**

In Angular, events and two-way binding with `[(ngModel)]` are essential tools for letting the user interact with the application.  
This topic will cover:

- How to handle events in Angular with `(event)`.
- Two-way binding with `[(ngModel)]` to keep data in sync between the view and the model.

---

## **2. Handling events in Angular**

An event in Angular occurs when the user interacts with the application, for example:

- Clicking a button.
- Typing in an input field.
- Moving the mouse over an element.

Angular provides a mechanism to handle these events with event binding, using the `(evento)="función()"` syntax.

---

### **2.1. Event binding syntax**

The basic syntax is:

```html
<button (click)="myFunction()">Haz clic</button>
```


When the user clicks the button, the component's `myFunction()` function will run.

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

### **2.3. Passing parameters in events**

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


When the user clicks the button, the `sayHello('Sara')` function will run, displaying `"¡Hola, Sara!"`.

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

1. Every time the user types in the input field, `updateText()` runs.
2. The `mensaje` variable is updated with the text entered.
3. The `{{ mensaje }}` interpolation displays the updated content on the screen.

---

## **3. Two-way binding with `ngModel`**

**Two-way binding** allows a variable in the component and a field in the view to stay in sync automatically.

To achieve this, we use the `[(ngModel)]` directive, which combines property binding and event binding. That's why it uses both square brackets [property binding] and parentheses (event binding).

> Note: This syntax is known as "banana in a box".

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

- `[(ngModel)]="userName"` keeps the input's value and the `userName` variable in sync.
- When you type in the input, `userName` is updated automatically.
- The `"Hola, [nombre]"` message is updated in real time.

---

### **3.1. Importing `FormsModule`**

For `ngModel` to work, we need to import `FormsModule` into the component where it is used.

Example in `ngmodel.component.ts`:

```ts
import { Component } from "@angular/core";
import { FormsModule } from "@angular/forms"; // Importar FormsModule

@Component({
  selector: "app-ngmodel",
  imports: [FormsModule], // Agregar FormsModule aquí
  templateUrl: "./ngmodel.component.html",
  styleUrls: ["./ngmodel.component.css"],
})
export class NgModelComponent {
  userName: string = "";
}
```


Without this import, `ngModel` will not work.

---
[![ngModel](https://img.youtube.com/vi/2NWc1x-VLcM/0.jpg)](https://www.youtube.com/watch?v=2NWc1x-VLcM&list=PLzA2VyZwsq_9cD3JIxBymaIVyef07PJ-y)

---

## **4. Comparing event binding and `ngModel`**

| **Binding type** | **Description** | **Example** |
| --------------------------------------- | ----------------------------------------------------------------- | ------------------------ |
| **Event binding `(event)`** | Captures user events and runs functions in the component. | `(click)="myFunction()"` |
| **Two-way binding `[(ngModel)]`** | Keeps the value of a variable in sync with the input in real time.  | `[(ngModel)]="variable"` |

---

## **5. Key points**

- **Events in Angular** let you run functions in response to user actions.
- We can use `$event` to capture event information.
- Using **two-way binding with `ngModel`** keeps variable values and inputs in sync.
- To use `ngModel`, you need to import `FormsModule` in the component that uses it.

---

In the next topic, we will explore some of Angular's control flow tools, like `@if` and `@for`
