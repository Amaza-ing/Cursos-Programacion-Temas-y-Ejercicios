# **Topic 12: Managing Reactive Forms with `FormGroup` and `FormControl`**

## **1. Introduction**

In Angular, **reactive forms** give you advanced control over input data, validations and events without depending on the data model directly in the template. They are built with `FormGroup` and `FormControl`, which makes them easy to manipulate and validate programmatically.

In this topic, you will learn:

- How to create and manage reactive forms with `FormGroup` and `FormControl`.
- How to add validations without the need for HTML attributes.
- How to react to form changes dynamically.

---

## **2. Initial setup**

To use reactive forms in Angular 19, you need to import `ReactiveFormsModule` in the component where you are going to use them.

```ts
import { ReactiveFormsModule } from '@angular/forms';

@Component({
  imports: [ReactiveFormsModule]
})
export class ReactiveFormComponent {
  ...
}
```


---

## **3. Creating a basic reactive form**

The key to reactive forms in Angular lies in `FormGroup` and `FormControl`.

#### **File: `form.component.ts`**

```ts
import { Component } from "@angular/core";
import { FormGroup, FormControl } from "@angular/forms";

@Component({
  selector: "app-form",
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


### **3.1. Clearing the fields when the form is submitted**

To reset the fields, we can use the `reset()` method of reactive forms. This way, when the form is submitted, whatever the user has typed will disappear.

> Note: If you reset the form, do it last, after applying the rest of the logic, or you will lose the data.

```ts
  submitForm() {
    console.log("Datos del formulario:", this.userForm.value);

    this.userForm.reset();
  }
```


---

[![Reactive Forms](https://img.youtube.com/vi/YhmdLiX1RE8/0.jpg)](https://www.youtube.com/watch?v=YhmdLiX1RE8&list=PLzA2VyZwsq_9cD3JIxBymaIVyef07PJ-y)

---

## **4. Validations in reactive forms**

In reactive forms, validations are added in the `FormControl` constructor.

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
  <p class="field-error">El nombre debe tener al menos 3 caracteres.</p>
  }

  <label>Email:</label>
  <input type="email" formControlName="email" />
  @if (userForm.controls['email'].invalid && userForm.controls['email'].touched)
  {
  <p class="field-error">Ingresa un email válido.</p>
  }

  <button type="submit" [disabled]="userForm.invalid">Enviar</button>
</form>
```


#### **File: `form.component.css`**

```css
.field-error {
  color: red;
}
```


---

[![Validators](https://img.youtube.com/vi/U1zcI4JqNpw/0.jpg)](https://www.youtube.com/watch?v=U1zcI4JqNpw&list=PLzA2VyZwsq_9cD3JIxBymaIVyef07PJ-y)

---

## **5. Detecting changes in real time**

You can subscribe to changes in form values using `valueChanges`.

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


---

## **6. Conclusion**

- `FormGroup` and `FormControl` let you create highly structured forms.
- Validations are handled in the TypeScript code instead of the template.
- `valueChanges` lets you detect changes in real time.

---

In the next topic, we will explore **what services are and how we can use them to manage the global state of our application**.
