# **Topic 7: The Constructor and `ngOnInit` in Angular**

## **1. Introduction**

In Angular, components have a lifecycle that defines how they are created, updated, and destroyed. Two key methods in this life cycle are:

- **The constructor**: It is executed when an instance of the component is created.
- **`ngOnInit`**: It is an Angular lifecycle hook that is executed after the component has been initialized.

Understanding the difference between the two is essential to correctly handle the initialization and configuration of components.

---

## **2. What is the constructor in Angular?**

The constructor is a special method in TypeScript that is executed when a new instance of the class is created. It is used to initialize properties and for dependency injection.

### **Example of constructor usage**

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
    this.message = "Este mensaje se inicializó en el constructor";
    console.log("Constructor ejecutado");
  }
}
```


#### **File: `example.component.html`**

```html
<p>{{ message }}</p>
```


### **Builder Features**

- Runs **before Angular initializes the component**.
- Mainly used to **initialize variables and receive dependencies**.
- No heavy logic should be performed inside the constructor.

---

[![Constructor](https://img.youtube.com/vi/2YPur9wymh0/0.jpg)](https://www.youtube.com/watch?v=2YPur9wymh0&list=PLzA2VyZwsq_9cD3JIxBymaIVyef07PJ-y)

---

## **3. What is `ngOnInit` and what is it used for?**

`ngOnInit` is an Angular lifecycle method that runs after the constructor has finished and when Angular has initialized the component.

### **Example of use of `ngOnInit`**

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
    this.message = "Mensaje inicial";
    console.log("Constructor ejecutado");
  }

  ngOnInit(): void {
    this.message = "Mensaje actualizado en ngOnInit";
    console.log("ngOnInit ejecutado");
  }
}
```


#### **File: `example.component.html`**

```html
<p>{{ message }}</p>
```


### **`ngOnInit` Features**

- It is executed **only once**, after the constructor.
- Used to **perform complex initializations** such as:
  - API calls.
  - Assign values obtained from services.
  - Subscribe to observables.
- It is defined by implementing the `OnInit` interface and the `ngOnInit()` method.

---

[![ngOnInit](https://img.youtube.com/vi/FSZoekTcJn4/0.jpg)](https://www.youtube.com/watch?v=FSZoekTcJn4&list=PLzA2VyZwsq_9cD3JIxBymaIVyef07PJ-y)

---

## **4. Differences between the constructor and `ngOnInit`**

| **Feature** | **Builder** | **ngOnInit** |
| ----------------------- | ------------------------------------------------------ | ------------------------------------------------ |
| When is it executed | When creating the component | After component initialization |
| Main use | Variable initialization, dependency injection | API calls, subscriptions and complex logic |
| Number of executions | One time | One time |
| Interaction with Angular | You do not have full access to the framework yet | You can now interact with Angular |

---

## **5. When to use `ngOnInit` instead of the constructor**

You should use `ngOnInit` instead of the constructor when:

- You need to wait until the component has been completely initialized.
- You must make calls to services or HTTP requests.
- You require logic that depends on dependency injection.

This is very often used in conjunction with services. We will talk about services later in topic 13.

Example with service:

#### **File: `example.component.ts`**

```ts
import { Component, OnInit } from "@angular/core";
import { DataService } from "../services/data.service";

@Component({
  selector: "app-example",
  templateUrl: "./example.component.html",
})
export class ExampleComponent implements OnInit {
  data: string = "";

  constructor(private dataService: DataService) {}

  ngOnInit(): void {
    this.data = this.dataService.getData();
  }
}
```


In this case, `ngOnInit` is the appropriate place to make the service call, since the constructor should not contain business logic.

---

## **6. Conclusion**

- The **constructor** is used to initialize variables and receive dependencies.
- `ngOnInit` is an Angular **lifecycle hook** that runs after the constructor.
- It is preferable to **perform complex logic inside `ngOnInit`** instead of the constructor.
- Understanding the difference between the two improves code organization and application performance.

---

In the next topic, we will explore **the complete life cycles of components in Angular**.
