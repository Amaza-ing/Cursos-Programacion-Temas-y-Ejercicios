# **Exercises - Topic 11: Creation and Validation of Forms with `ngModel`**

## **Instructions:**

Below you will find exercises on using `ngModel` in Angular forms.

Try to solve them before consulting the solution.

---

### **Exercise 1: Capture Data with `ngModel`**

Create a simple form with a text field and a button that displays the value entered in the console.

<details><summary>Show solution</summary>

#### **File: `form.component.ts`**

```ts
import { FormsModule } from "@angular/forms";

@Component({
  selector: "app-form",
  imports: [FormsModule],
})
export class FormComponent {
  userName: string = "";

  submitForm() {
    console.log("Nombre ingresado:", this.userName);
  }
}
```


#### **File: `form.component.html`**

```html
<form (ngSubmit)="submitForm()">
  <label for="username">Nombre:</label>
  <input
    type="text"
    id="username"
    [(ngModel)]="userName"
    name="name"
    required
  />
  <button type="submit">Enviar</button>
</form>
```


</details>

---

### **Exercise 2: Validate Age with a Custom Restriction**

Create a form where the minimum age allowed is 18 years old.

<details><summary>Show solution</summary>

#### **File: `form.component.ts`**

```ts
export class FormComponent {
  userAge: number | null = null;
}
```


#### **File: `form.component.html`**

```html
<label>Edad:</label>
<input type="number" [(ngModel)]="userAge" name="age" required min="18" />
@if (userAge < 18) {
<div>Debes ser mayor de 18 años.</div>
}
```


</details>

---

### **Exercise 3: Capture and Display Data on Screen**

Create a form where the user enters their name and age, and they are displayed in real time on the screen.

<details><summary>Show solution</summary>

#### **File: `form.component.ts`**

```ts
userName: string: "";
userAge: number: "";
```


#### **File: `form.component.html`**

```html
<form>
  <label for="username">Nombre:</label>
  <input type="text" id="username" [(ngModel)]="userName" name="name" />

  <label for="userAge">Edad:</label>
  <input type="number" id="userAge" [(ngModel)]="userAge" name="age" />
</form>

<p>Nombre: {{ userName }}</p>
<p>Edad: {{ userAge }}</p>
```


</details>
