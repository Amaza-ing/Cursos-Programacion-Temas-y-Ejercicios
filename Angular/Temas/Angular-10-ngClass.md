# **Topic 10: Using Dynamic Classes and Styles with `ngClass` in Angular**

## **1. Introduction**

In Angular, the `ngClass` directive lets you dynamically assign CSS classes to HTML elements based on conditions or variable values. This makes it easy to customize the styling of components in response to events or data changes.

In this topic, you will learn:

- How to use `ngClass` to dynamically add or remove classes.
- Different ways to apply `ngClass`.
- Practical examples of using `ngClass` in Angular.

---

## **2. What is `ngClass` and how does it work?**

The `ngClass` directive is used in HTML templates to apply CSS classes conditionally or dynamically. It can be used in different ways:

1. **As a string**: A class is assigned directly.
2. **As an array of strings**: Multiple classes can be added.
3. **As an object**: Classes can be assigned conditionally.

---

## **3. Different ways to use `ngClass`**

To use ngClass, we must add it to the imports: `imports: [NgClass]`

### **3.1. Using `ngClass` with a string**

A CSS class can be assigned directly from the component.

#### **File: `example.component.ts`**

```ts
import { Component } from "@angular/core";
import { NgClass } from "@angular/common";

@Component({
  selector: "app-example",
  imports: [NgClass],
  templateUrl: "./example.component.html",
  styleUrls: ["./example.component.css"],
})
export class ExampleComponent {
  className: string = "highlight";
}
```


#### **File: `example.component.html`**

```html
<p [ngClass]="className">Este texto tiene una clase dinámica</p>
```


#### **File: `example.component.css`**

```css
.highlight {
  color: white;
  background-color: blue;
  padding: 10px;
}
```


---

### **3.2. Using `ngClass` with an array of classes**

Multiple classes can be assigned dynamically using an array.

#### **File: `example.component.ts`**

```ts
export class ExampleComponent {
  classList: string[] = ["highlight", "bold-text"];
}
```


#### **File: `example.component.html`**

```html
<p [ngClass]="classList">Este texto tiene múltiples clases</p>
```


#### **File: `example.component.css`**

```css
.bold-text {
  font-weight: bold;
}
```


---

### **3.3. Using `ngClass` with an object**

Classes can be added or removed conditionally.

#### **File: `example.component.ts`**

```ts
export class ExampleComponent {
  isActive: boolean = true;
  isHighlighted: boolean = false;
}
```


#### **File: `example.component.html`**

```html
<p [ngClass]="{ 'active': isActive, 'highlight': isHighlighted }">
  Este texto cambia de estilo dinámicamente
</p>
```


#### **File: `example.component.css`**

```css
.active {
  color: green;
}
```


---

### **3.4. Toggling classes with events**

You can toggle classes using events such as `click`.

#### **File: `example.component.ts`**

```ts
export class ExampleComponent {
  isHighlighted: boolean = false;

  toggleHighlight() {
    this.isHighlighted = !this.isHighlighted;
  }
}
```


#### **File: `example.component.html`**

```html
<button (click)="toggleHighlight()">Alternar Clase</button>
<p [ngClass]="{ 'highlight': isHighlighted }">Texto con clase condicional</p>
```


---

[![Dynamic classes with ngClass](https://img.youtube.com/vi/XrZKMaZccmA/0.jpg)](https://www.youtube.com/watch?v=XrZKMaZccmA&list=PLzA2VyZwsq_9cD3JIxBymaIVyef07PJ-y)

---

## **4. Conclusion**

- `ngClass` makes it easy to dynamically apply CSS classes in Angular.
- It can be used as a string, an array or an object with conditional keys.
- It lets you toggle classes through events such as `click`.
- It improves customization and interaction in Angular applications.

---

In the next topic, we will explore **how to create and validate forms using ngModel**.
