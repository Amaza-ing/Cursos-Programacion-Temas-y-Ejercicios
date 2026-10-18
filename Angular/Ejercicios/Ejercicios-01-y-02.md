# **Exercises - Topics 1 and 2**

## **Exercises from Topic 1: Introduction to Angular and Environment Configuration**

Below you will find 10 practical exercises on the basics of Angular.

Try to solve them before consulting the solution.

### **Exercise 1: Installing Angular CLI**

Install Angular CLI on your system and verify the installation with the appropriate commands.

<details><summary>Show solution</summary>

```sh
npm install -g @angular/cli
ng version
```


</details>

---

### **Exercise 2: Creating a new Angular project**

Create a new project in Angular called `mi-proyecto-angular` using Angular CLI.

<details><summary>Show solution</summary>

```sh
ng new mi-proyecto-angular
```


</details>

---

### **Exercise 3: Project structure**

Briefly explain the function of the following files:

- `src/app/app.component.ts`
- `src/main.ts`
- `angular.json`
- `package.json`
<details><summary>Show solution</summary>

- `src/app/app.component.ts`: Defines the logic of the main component of the application.
- `src/main.ts`: Application entry point.
- `angular.json`: Angular project configuration.
- `package.json`: List of project dependencies and scripts.

</details>

---

### **Exercise 4: Development Server**

Start the development server and explain what happens when you change `app.component.html`.

<details><summary>Show solution</summary>

```sh
ng serve
```


Any changes to `app.component.html` will be automatically reflected in the browser without the need to reload the page.

</details>

---

### **Exercise 5: Modification of the initial template**

Modify `app.component.html` to display a custom message.

<details><summary>Show solution</summary>

```html
<h1>Bienvenido a mi aplicación en Angular</h1>
```


</details>

---

## **Exercises from Topic 2: Components in Angular**

### **Exercise 6: Creating a component**

Create an `header` component inside the `components` folder.

<details><summary>Show solution</summary>

```sh
ng generate component components/header
```


This command generates the necessary files: `.ts`, `.html`, `.css` and `.spec.ts`.

</details>

---

### **Exercise 7: Using a component**

Add the `header` component inside `app.component.html`.

<details><summary>Show solution</summary>

```html
<app-header></app-header>
```


</details>

---

### **Exercise 8: Interpolation**

Define a variable `title` in the `header` component and display it in its template.

<details><summary>Show solution</summary>

```ts
export class HeaderComponent {
  title = "Bienvenido a mi aplicación";
}
```


```html
<h1>{{ title }}</h1>
```


</details>

---

### **Exercise 9: Property Binding**

Creates an entry with dynamic `placeholder` based on a variable.

<details><summary>Show solution</summary>

```ts
export class HeaderComponent {
  placeholderText = "Introduce tu nombre";
}
```


```html
<input [placeholder]="placeholderText" />
```


</details>

---

### **Exercise 10: Components within components**

Create an `footer` component that contains three other internal components.

<details><summary>Show solution</summary>

```sh
ng generate component components/footer
ng generate component components/footer/info
ng generate component components/footer/social
ng generate component components/footer/contact
```


```html
<app-info></app-info>
<app-social></app-social>
<app-contact></app-contact>
```


</details>
