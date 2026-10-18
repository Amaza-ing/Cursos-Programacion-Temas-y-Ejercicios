# **Exercises - Topic 7: The Constructor and `ngOnInit` in Angular**

## **Instructions:**

Below you will find exercises on the constructor and `ngOnInit` in Angular.

Try to solve them before looking at the solution.

---

### **Exercise 1: Using the constructor**

Create a component that initializes a `message` variable in the constructor and displays it on the screen.

<details><summary>Show solution</summary>

#### **File: `example.component.ts`**

```ts
import { Component } from "@angular/core";

@Component({
  selector: "app-example",
  templateUrl: "./example.component.html",
})
export class ExampleComponent {
  message: string;

  constructor() {
    this.message = "Mensaje inicializado en el constructor";
  }
}
```


#### **File: `example.component.html`**

```html
<p>{{ message }}</p>
```


</details>

---

### **Exercise 2: Using `ngOnInit`**

Modify the component so that the message is assigned in `ngOnInit` instead of the constructor.

<details><summary>Show solution</summary>

#### **File: `example.component.ts`**

```ts
import { Component, OnInit } from "@angular/core";

@Component({
  selector: "app-example",
  templateUrl: "./example.component.html",
})
export class ExampleComponent implements OnInit {
  message: string;

  constructor() {
    this.message = "Mensaje inicializado en el constructor";
  }

  ngOnInit(): void {
    this.message = "Mensaje modificado en ngOnInit";
  }
}
```


</details>

---

### **Exercise 3: Telling the constructor and `ngOnInit` apart**

Add `console.log()` to both methods and observe the order in which they run.

<details><summary>Show solution</summary>

#### **File: `example.component.ts`**

```ts
import { Component, OnInit } from "@angular/core";

@Component({
  selector: "app-example",
  templateUrl: "./example.component.html",
})
export class ExampleComponent implements OnInit {
  message: string;

  constructor() {
    console.log("Constructor ejecutado");
    this.message = "Mensaje desde el constructor";
  }

  ngOnInit(): void {
    console.log("ngOnInit ejecutado");
    this.message = "Mensaje desde ngOnInit";
  }
}
```


</details>

---

### **Exercise 4: Testing with a delay in `ngOnInit`**

Simulate delayed data loading using `setTimeout()` inside `ngOnInit`.

<details><summary>Show solution</summary>

#### **File: `example.component.ts`**

```ts
import { Component, OnInit } from "@angular/core";

@Component({
  selector: "app-example",
  templateUrl: "./example.component.html",
})
export class ExampleComponent implements OnInit {
  message: string = "Cargando...";

  constructor() {}

  ngOnInit(): void {
    setTimeout(() => {
      this.message = "Datos cargados después de 3 segundos";
    }, 3000);
  }
}
```


#### **File: `example.component.html`**

```html
<p>{{ message }}</p>
```


</details>
