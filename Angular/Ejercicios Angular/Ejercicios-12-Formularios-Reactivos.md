# **Ejercicios - Tema 12: Gestión de Formularios Reactivos con `FormGroup` y `FormControl`**

## **Instrucciones:**

A continuación, encontrarás ejercicios sobre cómo gestionar formularios reactivos en Angular.

Intenta resolverlos antes de consultar la solución.

---

### **Ejercicio 1: Crear un Formulario Reactivo con `FormGroup`**

Crea un formulario reactivo con los campos `name` y `email` y muestra los datos ingresados en la consola al enviar el formulario.

<details><summary>Mostrar solución</summary>

#### **Archivo: `form.component.ts`**

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

#### **Archivo: `form.component.html`**

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

### **Ejercicio 2: Agregar Validaciones a un Formulario**

Añade validaciones para que el campo `name` sea obligatorio y tenga al menos 3 caracteres, y para que el campo `email` sea obligatorio y tenga formato de correo.

<details><summary>Mostrar solución</summary>

#### **Archivo: `form.component.ts`**

```ts
import { Validators } from "@angular/forms";

export class FormComponent {
  userForm = new FormGroup({
    name: new FormControl("", [Validators.required, Validators.minLength(3)]),
    email: new FormControl("", [Validators.required, Validators.email]),
  });
}
```

#### **Archivo: `form.component.html`**

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

### **Ejercicio 3: Detectar Cambios en Tiempo Real**

Muestra en la consola los valores del formulario cada vez que el usuario realice un cambio.

<details><summary>Mostrar solución</summary>

#### **Archivo: `form.component.ts`**

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

