# **Exercises - Topic 4: Control Flow in Angular (@if and @for)**

## **Instructions:**

Below you will find 10 practical exercises on control flow in Angular using `@if` and `@for`.

Try to solve them before looking at the solution.

---

### **Exercise 1: Basic use of `@if`**

Create a condition in the template to display one message if the `isLoggedIn` variable is `true` and a different message if it is `false`.

<details><summary>Show solution</summary>

```html
@if (isLoggedIn) {
<p>Bienvenido, usuario.</p>
} @else {
<p>Por favor, inicia sesión.</p>
}
```


```ts
export class SomeComponent {
  isLoggedIn: boolean = false;
}
```


</details>

---

### **Exercise 2: Using `@for` to display a list**

Display a list of names using `@for` and optimize with `track`.

<details><summary>Show solution</summary>

```html
<ul>
  @for (name of names; track name) {
  <li>{{ name }}</li>
  }
</ul>
```


```ts
export class SomeComponent {
  names: string[] = ["Ana", "Luis", "Carlos"];
}
```


</details>

---

### **Exercise 3: Nested `@if`**

Create a conditional structure that displays different messages depending on the user's age.

<details><summary>Show solution</summary>

```html
@if (age < 18) {
<p>Eres menor de edad.</p>
} @else if (age < 65) {
<p>Eres un adulto.</p>
} @else {
<p>Eres un adulto mayor.</p>
}
```


```ts
export class SomeComponent {
  age: number = 30;
}
```


</details>

---

### **Exercise 4: Iterating over an array of objects**

Display a list of products with their name and price using `@for`.

<details><summary>Show solution</summary>

```html
<ul>
  @for (product of products; track product.id) {
  <li>{{ product.name }} - ${{ product.price }}</li>
  }
</ul>
```


```ts
export class SomeComponent {
  products = [
    { id: 1, name: "Ordenador", price: 1000 },
    { id: 2, name: "Ratón", price: 20 },
  ];
}
```


</details>

---

### **Exercise 5: Toggling between two views with `@if`**

Create a button that toggles between "Mostrar más" and "Mostrar menos".

<details><summary>Show solution</summary>

```html
<button (click)="showMore = !showMore">
  @if (showMore) { Mostrar menos } @else { Mostrar más }
</button>
```


```ts
export class SomeComponent {
  showMore: boolean = false;
}
```


</details>

---

### **Exercise 6: Using `@if` and `@for` together**

Display a list of tasks if there are elements in the array, and a message if it is empty.

<details><summary>Show solution</summary>

```html
@if (tasks.length) {
<ul>
  @for (task of tasks; track task) {
  <li>{{ task }}</li>
  }
</ul>
} @else {
<p>No hay tareas pendientes.</p>
}
```


```ts
export class SomeComponent {
  tasks: string[] = [];
}
```


</details>

---

### **Exercise 7: Using `@for` with an index**

Display a numbered list of items with their index.

<details><summary>Show solution</summary>

```html
<ul>
  @for ((item, index) of items; track item) {
  <li>{{ index + 1 }}. {{ item }}</li>
  }
</ul>
```


```ts
export class SomeComponent {
  items: string[] = ["Elemento 1", "Elemento 2"];
}
```


</details>

---

### **Exercise 8: Switching between two lists with `@if`**

Display a different list depending on a boolean variable.

<details><summary>Show solution</summary>

```html
@if (showFruits) {
<ul>
  @for (fruit of fruits; track fruit) {
  <li>{{ fruit }}</li>
  }
</ul>
} @else {
<ul>
  @for (vegetable of vegetables; track vegetable) {
  <li>{{ vegetable }}</li>
  }
</ul>
}
```


```ts
export class SomeComponent {
  showFruits: boolean = true;
  fruits: string[] = ["Manzana", "Banana"];
  vegetables: string[] = ["Zanahoria", "Brócoli"];
}
```


</details>

---

### **Exercise 9: Hiding list elements with `@if`**

Hide elements of a list if they meet a certain condition.

<details><summary>Show solution</summary>

```html
<ul>
  @for (user of users; track user.id) { @if (!user.isBanned) {
  <li>{{ user.name }}</li>
  } }
</ul>
```


```ts
export class SomeComponent {
  users = [
    { id: 1, name: "Carlos", isBanned: false },
    { id: 2, name: "Ana", isBanned: true },
  ];
}
```


</details>

---

### **Exercise 10: Displaying a table with `@for`**

Create a table with user data using `@for`.

<details><summary>Show solution</summary>

```html
<table>
  <tr>
    <th>Nombre</th>
    <th>Edad</th>
  </tr>
  @for (user of users; track user.id) {
  <tr>
    <td>{{ user.name }}</td>
    <td>{{ user.age }}</td>
  </tr>
  }
</table>
```


```ts
export class SomeComponent {
  users = [
    { id: 1, name: "Laura", age: 25 },
    { id: 2, name: "Pedro", age: 30 },
  ];
}
```


</details>
