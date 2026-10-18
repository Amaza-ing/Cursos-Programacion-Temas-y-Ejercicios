# **Topic 6: Communication between Components in Angular**

## **1. Introduction**

In Angular, communication between components is key to building scalable applications. There are several ways to pass data between components, but the most common are:

- `@Input()` and `@Output()`, which allow communication between a parent component and a child component.
- The `input` and `output` **Signals**, which are a more efficient alternative introduced in Angular 17 and stable since Angular 19.

In this topic, we will explore how to use these techniques for communication between components.

---

## **2. Communication with `@Input()`**

The `@Input()` directive lets a child component receive data from its parent component.

### **`@Input()` example**

#### **File: `child.component.ts`**

```ts
import { Component, Input } from "@angular/core";

@Component({
  selector: "app-child",
  templateUrl: "./child.component.html",
})
export class ChildComponent {
  @Input()
  message: string = "";
}
```


#### **File: `child.component.html`**

```html
<p>Mensaje recibido: {{ message }}</p>
```


#### **File: `parent.component.ts`**

```ts
import { Component } from "@angular/core";

@Component({
  selector: "app-parent",
  templateUrl: "./parent.component.html",
})
export class ParentComponent {
  parentMsg: string = "Hola desde el componente padre";
}
```


#### **File: `parent.component.html`**

```html
<app-child [message]="parentMsg"></app-child>
```


Of course, you can pass any type of data, not just strings. You can also pass objects and any other data type.

---

[![@Input](https://img.youtube.com/vi/UgrlXyxxfUc/0.jpg)](https://www.youtube.com/watch?v=UgrlXyxxfUc&list=PLzA2VyZwsq_9cD3JIxBymaIVyef07PJ-y)

---

## **3. Communication with `@Output()`**

The `@Output()` directive lets a child component send data to its parent component through events.

### **`@Output()` example**

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
    this.emittedMsg.emit("Mensaje desde el hijo");
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

  updateMsg(newMsg: string) {
    this.receivedMsg = newMsg;
  }
}
```


#### **File: `parent.component.html`**

```html
<app-child (emittedMsg)="updateMsg($event)"></app-child>
<p>Mensaje recibido del hijo: {{ receivedMsg }}</p>
```


---

[![@Output](https://img.youtube.com/vi/8dQ_Kt7V6Dg/0.jpg)](https://www.youtube.com/watch?v=8dQ_Kt7V6Dg&list=PLzA2VyZwsq_9cD3JIxBymaIVyef07PJ-y)

---

## **4. Communication with the `input` and `output` Signals**

Angular 17.1 and 17.3 introduced `input()` and `output()`, respectively (stable since Angular 19), a more optimized alternative to `@Input()` and `@Output()`.

### **`input()` example**

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


[![input signal](https://img.youtube.com/vi/3Jg9OYIqdSA/0.jpg)](https://www.youtube.com/watch?v=3Jg9OYIqdSA&list=PLzA2VyZwsq_9cD3JIxBymaIVyef07PJ-y)

### **`output()` example**

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

  updateMsg(newMsg: string) {
    this.receivedMsg = newMsg;
  }
}
```


[![output signal](https://img.youtube.com/vi/y5qUAE3ruP8/0.jpg)](https://www.youtube.com/watch?v=y5qUAE3ruP8&list=PLzA2VyZwsq_9cD3JIxBymaIVyef07PJ-y)

---

## **5. Comparing `@Input/@Output` and `input()/output()`**

| **Feature** | **@Input/@Output** | **input()/output()** |
| ----------------------- | ------------------------- | ---------------------------- |
| How they are declared | Decorators in the class | Variables inside the class |
| Reactivity | Not reactive by default | Automatically reactive |
| Ease of use | Better known and more compatible | Better performance |
| Requires `EventEmitter` | Yes | No |

---

## **6. Conclusion**

- `@Input()` and `@Output()` are the classic way for components to communicate in Angular.
- `input()` and `output()` introduce a more efficient and reactive way of handling data flow.
- Choosing between the two depends on backward compatibility and performance optimization.

---

In the next topic, we will explore the **constructor and ngOnInit** and how they affect the component lifecycle
