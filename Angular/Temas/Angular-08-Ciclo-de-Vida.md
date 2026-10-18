# **Topic 8: Complete Component Lifecycle in Angular**

## **1. Introduction**

Components in Angular have a lifecycle defined by a series of methods (hooks) that let you run logic at different moments of the component's existence.

In this topic, you will learn:

- What the Angular lifecycle hooks are.
- When they run and how to use them correctly.
- Practical examples of each hook.

---

## **2. Lifecycle hooks in Angular**

| **Hook** | **When it runs** | **Main use** |
| ------------------------- | ---------------------------------------------------------- | --------------------------------------------------- |
| `ngOnChanges()` | When an `@Input()` changes value | Detect changes in properties received from the parent |
| `ngOnInit()` | After Angular initializes the component | Initial setup, calls to services |
| `ngDoCheck()` | In every change detection cycle | Manually detect changes in variables |
| `ngAfterContentInit()` | After content is inserted into `<ng-content>` | Detect changes in projected content |
| `ngAfterContentChecked()` | After every change detection in `<ng-content>` | Respond to changes in projected content |
| `ngAfterViewInit()` | After the view and its children have been initialized | Access view elements with `ViewChild` |
| `ngAfterViewChecked()` | After every change detection in the view | Adjust dynamic visual elements |
| `ngOnDestroy()` | Before the component is destroyed | Clean up subscriptions and release resources |

---

## **3. Explanation and examples of the hooks**

### **3.1. `ngOnChanges()`**

It runs when one or more `@Input()` values change in the child component.

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

It runs only once, after the constructor. Ideal for initializing data or calling services.

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

It runs in every change detection cycle. Useful when Angular doesn't detect changes automatically.

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

These hooks let you detect changes in content projected inside `<ng-content>`.

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

They are used to interact with the view's elements after it has been rendered.

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
It runs before the component is destroyed. It is used to clean up subscriptions and release resources.

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

- Angular provides **lifecycle hooks** that let you run logic at different moments of a component's existence.
- `ngOnInit()` is the most commonly used one for initializing the component.
- `ngOnChanges()` detects changes to `@Input()`.
- `ngDoCheck()` is useful when Angular does not detect changes automatically.
- `ngAfterViewInit()` and `ngAfterViewChecked()` let you manipulate the view after it has loaded.
- `ngOnDestroy()` is used to free resources before removing a component.

---

In the next topic, we will explore **models and interfaces for typing objects**.
