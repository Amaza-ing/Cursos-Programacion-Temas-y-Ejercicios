# **Exercises - Topic 12: Management of Reactive Forms with `FormGroup` and `FormControl`**

## **Instructions:**

Below you will find exercises on how to manage reactive forms in Angular.

Try to solve them before consulting the solution.

---

### **Exercise 1: Create a Reactive Form with `FormGroup`**

Creates a reactive form with the fields `name` and `email` and displays the data entered in the console when submitting the form.

<details><summary>Show solution</summary>

#### **File: `form.component.ts`**

```ts
import { ReactiveFormsModule, FormGroup, FormControl } from "@angular/forms";

@Component({
  imports: [ReactiveFormsModule],
})
export class FormComponent {
  userForm = new FormGroup({
    name: new FormControl(""),
    email: new FormControl(""),
  });

  submitForm() {
    console.log("Datos del formulario:", this.userForm.value);
  }
}
```


#### **File: `form.component.html`**

```html
<form [formGroup]="userForm" (ngSubmit)="submitForm()">
  <label for="username">Nombre:</label>
  <input type="text" id="username" formControlName="name" />

  <label for="email">Email:</label>
  <input type="email" id="email" formControlName="email" />

  <button type="submit">Enviar</button>
</form>
```


</details>

---

### **Exercise 2: Add Validations to a Form**

Add validations so that the `name` field is required and has at least 3 characters, and so that the `email` field is required and has email format.

<details><summary>Show solution</summary>

#### **File: `form.component.ts`**

```ts
import { Validators } from "@angular/forms";

export class FormComponent {
  userForm = new FormGroup({
    name: new FormControl("", [Validators.required, Validators.minLength(3)]),
    email: new FormControl("", [Validators.required, Validators.email]),
  });
}
```


#### **File: `form.component.html`**

```html
<form [formGroup]="userForm" (ngSubmit)="submitForm()">
  <label>Nombre:</label>
  <input type="text" formControlName="name" />
  @if (userForm.controls['name'].invalid && userForm.controls['name'].touched) {
  <div>El nombre debe tener al menos 3 caracteres.</div>
  }

  <label>Email:</label>
  <input type="email" formControlName="email" />
  @if (userForm.controls['email'].invalid && userForm.controls['email'].touched)
  {
  <div>Ingresa un email válido.</div>
  }

  <button type="submit" [disabled]="userForm.invalid">Enviar</button>
</form>
```


</details>

---

### **Exercise 3: Detect Changes in Real Time**

Displays the form values in the console every time the user makes a change.

<details><summary>Show solution</summary>

#### **File: `form.component.ts`**

```ts
export class FormComponent {
  userForm = new FormGroup({
    name: new FormControl(""),
    email: new FormControl(""),
  });

  constructor() {
    this.userForm.valueChanges.subscribe((value) => {
      console.log("Cambio detectado:", value);
    });
  }
}
```


</details>
