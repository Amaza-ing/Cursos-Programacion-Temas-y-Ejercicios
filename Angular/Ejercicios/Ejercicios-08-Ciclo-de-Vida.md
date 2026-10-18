# **Exercises - Topic 8: Complete Component Lifecycle in Angular**

## **Instructions:**

Below you will find exercises on lifecycle hooks in Angular.

Try to solve them before looking at the solution.

---

### **Exercise 1: Using `ngOnChanges()`**

Create a child component that detects changes to a property received from the parent component.

<details><summary>Show solution</summary>

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


</details>

---

### **Exercise 2: Using `ngOnInit()`**

Initialize a value in `ngOnInit()` and display it in the template.

<details><summary>Show solution</summary>

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
    this.message = "Componente inicializado en ngOnInit";
  }
}
```


#### **File: `example.component.html`**

```html
<p>{{ message }}</p>
```


</details>

---

### **Exercise 3: Using `ngDoCheck()`**

Implement `ngDoCheck()` to detect changes manually.

<details><summary>Show solution</summary>

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


</details>

---

### **Exercise 4: Using `ngAfterViewInit()`**

Change the color of an HTML element using `ngAfterViewInit()`.

<details><summary>Show solution</summary>

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
    this.title.nativeElement.style.color = "blue";
  }
}
```


#### **File: `example.component.html`**

```html
<h1 #title>Título modificado en AfterViewInit</h1>
```


</details>

---

### **Exercise 5: Using `ngOnDestroy()`**

Run an action before the component is destroyed.

<details><summary>Show solution</summary>

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


</details>
