# **Exercises - Topic 6: Communication between Components**

## **Instructions:**

Below you will find 5 practical exercises on communication between components in Angular.

Try to solve them before looking at the solution.

---

### **Exercise 1: Basic use of `@Input()`**

Create a child component that receives a message from the parent and displays it on the screen.

<details><summary>Show solution</summary>

#### **File: `parent.component.ts`**

```ts
import { Component } from "@angular/core";

@Component({
  selector: "app-parent",
  templateUrl: "./parent.component.html",
})
export class ParentComponent {
  parentMsg: string = "Mensaje desde el padre";
}
```


#### **File: `parent.component.html`**

```html
<app-child [message]="parentMsg"></app-child>
```


#### **File: `child.component.ts`**

```ts
import { Component, Input } from "@angular/core";

@Component({
  selector: "app-child",
  templateUrl: "./child.component.html",
})
export class ChildComponent {
  @Input() message: string = "";
}
```


#### **File: `child.component.html`**

```html
<p>Mensaje recibido: {{ message }}</p>
```


</details>

---

### **Exercise 2: Basic use of `@Output()`**

Let a child component send a message to its parent component through events.

<details><summary>Show solution</summary>

#### **File: `child.component.ts`**

```ts
import { Component, EventEmitter, Output } from "@angular/core";

@Component({
  selector: "app-child",
  templateUrl: "./child.component.html",
})
export class ChildComponent {
  @Output() emittedMsg = new EventEmitter<string>();

  sendMsg() {
    this.emittedMsg.emit("Mensaje enviado desde el hijo");
  }
}
```


#### **File: `child.component.html`**

```html
<button (click)="sendMsg()">Enviar mensaje al padre</button>
```


#### **File: `parent.component.ts`**

```ts
import { Component } from "@angular/core";

@Component({
  selector: "app-parent",
  templateUrl: "./parent.component.html",
})
export class ParentComponent {
  receivedMsg: string = "";

  updateMsg(nuevoMensaje: string) {
    this.receivedMsg = nuevoMensaje;
  }
}
```


#### **File: `parent.component.html`**

```html
<app-child (emittedMsg)="updateMsg($event)"></app-child>
<p>Mensaje recibido del hijo: {{ receivedMsg }}</p>
```


</details>

---

### **Exercise 3: Using `input()` with Signals**

Create a child component that receives a Signal from a parent and displays it on the screen.

<details><summary>Show solution</summary>

#### **File: `parent.component.html`**

```html
<app-child [message]="'Hola desde el padre con Signals'"></app-child>
```


#### **File: `child.component.ts`**

```ts
import { Component, input } from "@angular/core";

@Component({
  selector: "app-child",
  templateUrl: "./child.component.html",
})
export class ChildComponent {
  message = input("");
}
```


#### **File: `child.component.html`**

```html
<p>{{ message() }}</p>
```


</details>

---

### **Exercise 4: Using `output()` with Signals**

Create a child component that emits an event to the parent using `output()`.

<details><summary>Show solution</summary>

#### **File: `child.component.ts`**

```ts
import { Component, output } from "@angular/core";

@Component({
  selector: "app-child",
  templateUrl: "./child.component.html",
})
export class ChildComponent {
  emittedMsg = output<string>();

  sendMsg() {
    this.emittedMsg.emit("Mensaje desde el hijo con Signals");
  }
}
```


#### **File: `parent.component.html`**

```html
<app-child (emittedMsg)="updateMsg($event)"></app-child>
```


#### **File: `parent.component.ts`**

```ts
import { Component } from "@angular/core";

@Component({
  selector: "app-parent",
  templateUrl: "./parent.component.html",
})
export class ParentComponent {
  receivedMsg: string = "";

  updateMsg(nuevoMensaje: string) {
    this.receivedMsg = nuevoMensaje;
  }
}
```


</details>

---

### **Exercise 5: Two-way communication with Signals**

Create an interaction where the parent can update the state of a child and vice versa.

<details><summary>Show solution</summary>

#### **File: `child.component.ts`**

```ts
import { Component, input, output } from "@angular/core";

@Component({
  selector: "app-child",
  templateUrl: "./child.component.html",
})
export class ChildComponent {
  message = input("");
  emittedMsg = output<string>();

  updateMsg() {
    this.emittedMsg.emit(this.message());
  }
}
```


#### **File: `child.component.html`**

```html
<input [(ngModel)]="message" placeholder="Escribe un mensaje" />
<button (click)="updateMsg()">Actualizar mensaje en el padre</button>
```


#### **File: `parent.component.html`**

```html
<app-child [message]="parentMsg" (emittedMsg)="parentMsg = $event"></app-child>
<p>Mensaje en el padre: {{ parentMsg }}</p>
```


#### **File: `parent.component.ts`**

```ts
import { Component, signal } from "@angular/core";

@Component({
  selector: "app-parent",
  templateUrl: "./parent.component.html",
})
export class ParentComponent {
  parentMsg = signal("");
}
```


</details>
