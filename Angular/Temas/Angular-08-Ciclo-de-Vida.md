# **Topic 8: Complete Life Cycle of Components in Angular**

## **1. Introduction**

Components in Angular have a life cycle defined by a series of methods (hooks) that allow logic to be executed at different times during the component's existence.

In this topic you will learn:

- What are the hooks of the Angular life cycle.
- When they are executed and how to use them correctly.
- Practical examples of each hook.

---

## **2. Lifecycle Hooks in Angular**

| **Hook** | **When is it executed** | **Primary use** |
| ------------------------- | ---------------------------------------------------------- | --------------------------------------------------- |
| `ngOnChanges()` | When an `@Input()` changes value | Detect changes in properties received from the parent |
| `ngOnInit()` | After Angular initializes the | Initial configuration, calls to services |
| `ngDoCheck()` | In each change detection cycle | Manually detect changes in variables |
| `ngAfterContentInit()` | After inserting content into `<ng-content>` | Detect changes in projected content |
| `ngAfterContentChecked()` | After each detection of changes in `<ng-content>` | Respond to changes in projected content |
| `ngAfterViewInit()` | After the view and children have been initialized | Access view elements with `ViewChild` |
| `ngAfterViewChecked()` | After each view change detection | Adjust dynamic visual elements |
| `ngOnDestroy()` | Before destroying the component | Clean subscriptions and release resources |

---

## **3. Explanation and Examples of Hooks**

### **3.1. `ngOnChanges()`**

Executed when one or more `@Input()` values change in the child component.

#### **File: `child.component.ts`**

```ts
import { Component, Input, OnChanges, SimpleChanges } from "@angular/core";

@Component({
  selector: "app-child",
  templateUrl: "./child.component.html",
})
export class ChildComponent implements OnChanges {
  @Input() data: string = "";

  ngOnChanges(changes: SimpleChanges): void {
    console.log("ngOnChanges ejecutado:", changes);
  }
}
```


#### **File: `parent.component.html`**

```html
<input [(ngModel)]="message" placeholder="Escribe algo" />
<app-child [data]="message"></app-child>
```


---

### **3.2. `ngOnInit()`**

It is executed only once, after the constructor. Ideal for initializing data or making calls to services.

#### **File: `example.component.ts`**

```ts
import { Component, OnInit } from "@angular/core";

@Component({
  selector: "app-example",
  templateUrl: "./example.component.html",
})
export class ExampleComponent implements OnInit {
  message: string = "";

  ngOnInit(): void {
    this.message = "Componente inicializado";
  }
}
```


#### **File: `example.component.html`**

```html
<p>{{ message }}</p>
```


---

### **3.3. `ngDoCheck()`**

It runs every change detection cycle. Useful when Angular doesn't detect changes automatically.

#### **File: `example.component.ts`**

```ts
import { Component, DoCheck } from "@angular/core";

@Component({
  selector: "app-example",
  templateUrl: "./example.component.html",
})
export class ExampleComponent implements DoCheck {
  counter: number = 0;

  ngDoCheck(): void {
    console.log("ngDoCheck ejecutado, contador:", this.counter);
  }
}
```


---

### **3.4. `ngAfterContentInit()` and `ngAfterContentChecked()`**

These hooks allow detecting changes in projected content within `<ng-content>`.

#### **File: `child.component.html`**

```html
<ng-content></ng-content>
```


#### **File: `child.component.ts`**

```ts
import {
  Component,
  AfterContentInit,
  AfterContentChecked,
} from "@angular/core";

@Component({
  selector: "app-child",
  templateUrl: "./child.component.html",
})
export class ChildComponent implements AfterContentInit, AfterContentChecked {
  ngAfterContentInit(): void {
    console.log("ngAfterContentInit ejecutado");
  }

  ngAfterContentChecked(): void {
    console.log("ngAfterContentChecked ejecutado");
  }
}
```


---

### **3.5. `ngAfterViewInit()` and `ngAfterViewChecked()`**

They are used to interact with elements of the view after rendering.

#### **File: `example.component.ts`**

```ts
import { Component, AfterViewInit, ViewChild, ElementRef } from "@angular/core";

@Component({
  selector: "app-example",
  templateUrl: "./example.component.html",
})
export class ExampleComponent implements AfterViewInit {
  @ViewChild("title") title!: ElementRef;

  ngAfterViewInit(): void {
    console.log("ngAfterViewInit ejecutado");
    this.title.nativeElement.style.color = "red";
  }
}
```


#### **File: `example.component.html`**

```html
<h1 #title>Título modificado en AfterViewInit</h1>
```


---

### **3.6. `ngOnDestroy()`**
It is executed before destroying the component. Used to clean up subscriptions and release resources.

#### **File: `example.component.ts`**

```ts
import { Component, OnDestroy } from "@angular/core";

@Component({
  selector: "app-example",
  templateUrl: "./example.component.html",
})
export class ExampleComponent implements OnDestroy {
  ngOnDestroy(): void {
    console.log("Componente destruido");
  }
}
```


---

## **4. Conclusion**

- Angular provides **lifecycle hooks** that allow logic to be executed at different times during a component's existence.
- `ngOnInit()` is the most used for component initialization.
- `ngOnChanges()` detects changes to `@Input()`.
- `ngDoCheck()` is useful when Angular does not detect changes automatically.
- `ngAfterViewInit()` and `ngAfterViewChecked()` allow you to manipulate the view after loading.
- `ngOnDestroy()` is used to free resources before removing a component.

---

In the next topic, we will explore **Models and Interfaces for Object typing**.
