# **Exercises - Topic 10: Using Dynamic Classes and Styles with `ngClass`**

## **Instructions:**

Below you will find exercises on how to apply dynamic classes and styles with `ngClass` in Angular.

Try to solve them before consulting the solution.

---

### **Exercise 1: Apply a dynamic class with `ngClass`**

Create a component that applies a CSS class defined based on a variable.

<details><summary>Show solution</summary>

#### **File: `example.component.ts`**

```ts
import { Component } from "@angular/core";

@Component({
  selector: "app-example",
  templateUrl: "./example.component.html",
  styleUrls: ["./example.component.css"],
})
export class ExampleComponent {
  pageTheme: string = "dark";
}
```


#### **File: `example.component.html`**

```html
<p [ngClass]="pageTheme">Este texto tiene una clase dinámica</p>
```


#### **File: `example.component.css`**

```css
.dark {
  color: white;
  background-color: black;
}
```


</details>

---

### **Exercise 2: Apply multiple classes with `ngClass`**

Define a list of classes and apply them to the same element with `ngClass`.

<details><summary>Show solution</summary>

#### **File: `example.component.ts`**

```ts
export class ExampleComponent {
  pageStyles: string[] = ["dark", "bold-text"];
}
```


#### **File: `example.component.html`**

```html
<p [ngClass]="pageStyles">Este texto tiene múltiples clases</p>
```


#### **File: `example.component.css`**

```css
.bold-text {
  font-weight: bold;
}
```


</details>

---

### **Exercise 3: Apply conditional classes with `ngClass`**

Uses an object to conditionally assign classes.

<details><summary>Show solution</summary>

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


</details>

---

### **Exercise 4: Toggle Classes with a Button**

Create a button that allows you to toggle the application of a class in a paragraph.

<details><summary>Show solution</summary>

#### **File: `example.component.ts`**

```ts
export class ExampleComponent {
  isDark: boolean = false;

  toggleDark() {
    this.isDark = !this.isDark;
  }
}
```


#### **File: `example.component.html`**

```html
<button (click)="toggleDark()">Alternar Clase</button>
<p [ngClass]="{ 'dark': isDark }">Texto con clase condicional</p>
```


</details>

---

### **Exercise 5: Apply multiple classes with a dynamic array**

Use a dynamically changing array to modify the classes of an element.

<details><summary>Show solution</summary>

#### **File: `example.component.ts`**

```ts
export class ExampleComponent {
  classes: string[] = ["text-large"];

  addClass() {
    this.classes.push("highlight");
  }
}
```


#### **File: `example.component.html`**

```html
<button (click)="addClass()">Añadir Clase</button>
<p [ngClass]="classes">Texto con clases dinámicas</p>
```


#### **File: `example.component.css`**

```css
.highlight {
  background-color: yellow;
}

.text-large {
  font-size: 20px;
}
```


</details>
