# **Topic 11: Creating and Validating Forms with `ngModel` in Angular**

## **1. Introduction**

In Angular, `ngModel` enables two-way data binding in forms, making it easier to capture and validate user data.

In this topic, you will learn:

- How to use `ngModel` to capture data in forms.
- How to validate forms with built-in and custom validations.
- How to handle form errors efficiently.

---

## **2. Initial setup**

To use `ngModel`, you need to add the `FormsModule` module to the application's imports.

---

[![ngModel](https://img.youtube.com/vi/2NWc1x-VLcM/0.jpg)](https://www.youtube.com/watch?v=2NWc1x-VLcM&list=PLzA2VyZwsq_9cD3JIxBymaIVyef07PJ-y)

---

## **3. Creating a form with `ngModel`**

The `ngModel` directive enables two-way binding in forms, which automatically keeps the model in sync with the view.

The `(ngSubmit)` event lets you handle the submission of a form.

#### **File: `form.component.ts`**

```ts
import { FormsModule } from "@angular/forms";

@Component({
  selector: "app-form",
  imports: [FormsModule],
})
export class FormComponent {
  user = { name: "", email: "" };

  submitForm() {
    console.log("Formulario enviado:", this.user);
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
    [(ngModel)]="user.name"
    name="username"
    required
  />

  <label for="email">Email:</label>
  <input
    type="email"
    id="email"
    [(ngModel)]="user.email"
    name="email"
    required
  />

  <button type="submit">Enviar</button>
</form>
```


---

## **4. Form validation**

You can define custom validations in a method of the component.

#### **File: `form.component.ts`**

```ts
export class FormComponent {
  user = { name: "", age: null };

  validateAge(age: number): boolean {
    return age >= 18;
  }
}
```


#### **File: `form.component.html`**

```html
<label for="age">Edad:</label>
<input type="number" id="age" [(ngModel)]="user.age" name="age" required />

@if (!validateAge(user.age)) {
<div>Debes ser mayor de edad.</div>
}
```


---

## **5. Conclusion**

- `ngModel` enables two-way binding in forms.
- You can define custom validations for specific rules.
- Handling errors improves the user experience when filling out forms.

---

In the next topic, we will explore **how to manage reactive forms with `FormGroup` and `FormControl` in Angular**.
