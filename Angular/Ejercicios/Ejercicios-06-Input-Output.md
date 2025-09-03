# **Ejercicios - Tema 6: Comunicación entre Componentes**

## **Instrucciones:**

A continuación, encontrarás 10 ejercicios prácticos sobre la comunicación entre componentes en Angular.

Intenta resolverlos antes de consultar la solución.

---

### **Ejercicio 1: Uso básico de `@Input()`**

Crea un componente hijo que reciba un mensaje desde el padre y lo muestre en pantalla.

<details><summary>Mostrar solución</summary>

#### **Archivo: `parent.component.ts`**

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

#### **Archivo: `parent.component.html`**

```html
<app-child [message]="parentMsg"></app-child>
```

#### **Archivo: `child.component.ts`**

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

#### **Archivo: `child.component.html`**

```html
<p>Mensaje recibido: {{ message }}</p>
```

</details>

---

### **Ejercicio 2: Uso básico de `@Output()`**

Permite que un componente hijo envíe un mensaje al componente padre mediante eventos.

<details><summary>Mostrar solución</summary>

#### **Archivo: `child.component.ts`**

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

#### **Archivo: `child.component.html`**

```html
<button (click)="sendMsg()">Enviar mensaje al padre</button>
```

#### **Archivo: `parent.component.ts`**

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

#### **Archivo: `parent.component.html`**

```html
<app-child (emittedMsg)="updateMsg($event)"></app-child>
<p>Mensaje recibido del hijo: {{ receivedMsg }}</p>
```

</details>

---

### **Ejercicio 3: Uso de `input()` con Signals**

Crea un componente hijo que reciba una Signal de un padre y la muestre en pantalla.

<details><summary>Mostrar solución</summary>

#### **Archivo: `parent.component.html`**

```html
<app-child [message]="'Hola desde el padre con Signals'"></app-child>
```

#### **Archivo: `child.component.ts`**

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

#### **Archivo: `child.component.html`**

```html
<p>{{ message() }}</p>
```

</details>

---

### **Ejercicio 4: Uso de `output()` con Signals**

Crea un componente hijo que emita un evento al padre utilizando `output()`.

<details><summary>Mostrar solución</summary>

#### **Archivo: `child.component.ts`**

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

#### **Archivo: `parent.component.html`**

```html
<app-child (emittedMsg)="updateMsg($event)"></app-child>
```

#### **Archivo: `parent.component.ts`**

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

### **Ejercicio 5: Comunicación bidireccional con Signals**

Crea una interacción donde el padre pueda actualizar el estado de un hijo y viceversa.

<details><summary>Mostrar solución</summary>

#### **Archivo: `child.component.ts`**

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

#### **Archivo: `child.component.html`**

```html
<input [(ngModel)]="message" placeholder="Escribe un mensaje" />
<button (click)="updateMsg()">Actualizar mensaje en el padre</button>
```

#### **Archivo: `parent.component.html`**

```html
<app-child [message]="parentMsg" (emittedMsg)="parentMsg = $event"></app-child>
<p>Mensaje en el padre: {{ parentMsg }}</p>
```

#### **Archivo: `parent.component.ts`**

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
