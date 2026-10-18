# **Topic 2: Components in Angular**

## **1. What is a component in Angular?**

A component is the fundamental unit of an Angular application. Each component defines a part of the user interface and its behavior.

### **Structure of a component**

A component in Angular is made up of three main parts:

- **Template (`.html`)**: Defines the visual structure of the component.
- **Styles (`.css` or `.scss`)**: Contains the component's styling rules.
- **TypeScript class (`.ts`)**: Contains the logic and behavior of the component.

---

## **2. Creating a component**

To create a new component in Angular, for example, a component for a menu called menu, use the following command:

```sh
ng generate component components/menu
```


Or in its short form:

```sh
ng g c components/menu
```


This command will generate a new folder inside `src/app/components` with the following files (and others that are not important to begin with):

```
menu/
│── menu.component.ts      # Lógica del componente
│── menu.component.html    # Plantilla del componente
│── menu.component.css     # Estilos del componente
│── menu.component.spec.ts # Pruebas unitarias del componente
```


---

## **3. Using a component**

To use a component elsewhere in the application, add it to the HTML template of another component as follows:

```html
<app-menu></app-menu>
```


And make sure it has been imported into the parent component's .ts:

```ts
import { MenuComponent } from "./components/menu/menu.component";

@Component({
  ...
  imports: [MenuComponent],
  ...
})
```


The component's selector is defined in the `menu.component.ts` file

```ts
@Component({
  selector: 'app-menu',
  ...
})
```


---

[![Components](https://img.youtube.com/vi/K_6ixeC7GbM/0.jpg)](https://www.youtube.com/watch?v=K_6ixeC7GbM&list=PLzA2VyZwsq_9cD3JIxBymaIVyef07PJ-y)

---

## **4. Using variables and data binding in Angular**

### **Variables in a component**

In Angular, we can define variables inside the component class to store and manipulate data. These variables can be used in the template to display information or react to events.

Since in Angular we work with TypeScript, all variables have to be correctly typed.

[![Data Typing in TypeScript](https://img.youtube.com/vi/r7HrKb2-nDk/0.jpg)](https://www.youtube.com/watch?v=r7HrKb2-nDk&list=PLzA2VyZwsq__tcg5_rW6Ozp4hLYzrtXGX)

Example of defining variables in the `menu.component.ts` file:

```ts
import { Component } from "@angular/core";

@Component({
  selector: "app-menu",
  templateUrl: "./menu.component.html",
  styleUrls: ["./menu.component.css"],
})
export class MenuComponent {
  title: string = "Menú Principal";
  options: string[] = ["Inicio", "Acerca de", "Contacto"];
}
```


---

### **Data binding in Angular**

Data binding in Angular keeps the data in sync between the model (TypeScript class) and the view (HTML template). There are four main types of data binding:

1. **Interpolation (`{{ }}`)**: Used to display values within the HTML template.
2. **Property binding (`[property]`)**: Allows you to assign values to HTML attributes from the component.
3. **Event binding (`(event)`)**: Lets you run component functions when the user interacts with the view, for example by clicking.
4. **Two-way binding (`[(ngModel)]`)**: Keeps a component variable and a field in the view in sync in both directions.

In this topic we will look at the first two, and at the other two in the next topic.

---

### **1. Interpolation**

Interpolation allows you to display variable values in the HTML using `{{ }}`.

Example in `menu.component.html`:

```html
<h1>{{ title }}</h1>
```


In this example:
`{{ title }}` displays the value of the `title` variable.

---

### **2. Property binding (`[property]`)**

Allows you to assign dynamic values to HTML properties.

Example in `menu.component.html`:

```html
<img [src]="image" alt="Menú" />
```


Example in `menu.component.ts`:

```ts
export class MenuComponent {
  image: string = "assets/menu.png";
}
```


Here, the value of the image's `src` comes from the component's `image` variable.

> Note: Images and other assets are usually stored in the `public` folder, so paths start from that folder. Don't write the path as `public/assets/imagen.png`; write it as `assets/imagen.png`.

---
[![Variables in Angular](https://img.youtube.com/vi/8QVG8JA495Q/0.jpg)](https://www.youtube.com/watch?v=8QVG8JA495Q&list=PLzA2VyZwsq_9cD3JIxBymaIVyef07PJ-y)

---

In the next topic, we will see how to work with events and two-way data binding using `ngModel`.
