# **Tema 12: Gestión de Formularios Reactivos con `FormGroup` y `FormControl`**

## **1. Introducción**

En Angular, los **formularios reactivos** permiten un control avanzado de los datos de entrada, validaciones y eventos sin depender del modelo de datos directamente en la plantilla. Se construyen utilizando `FormGroup` y `FormControl`, lo que facilita su manipulación y validación programática.

En este tema aprenderás:

- Cómo crear y gestionar formularios reactivos con `FormGroup` y `FormControl`.
- Cómo añadir validaciones sin necesidad de atributos HTML.
- Cómo reaccionar a cambios en los formularios dinámicamente.

---

## **2. Configuración Inicial**

Para usar formularios reactivos en Angular 19, es necesario importar `ReactiveFormsModule` en el Componente en el que lo vayamos a utilizar.

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

## **3. Creación de un Formulario Reactivo Básico**

La clave de los formularios reactivos en Angular está en `FormGroup` y `FormControl`.

#### **Archivo: `form.component.ts`**

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

---

[![Formularios Reactivos](https://img.youtube.com/vi/YhmdLiX1RE8/0.jpg)](https://www.youtube.com/watch?v=YhmdLiX1RE8&list=PLzA2VyZwsq_9cD3JIxBymaIVyef07PJ-y)

---

## **4. Validaciones en Formularios Reactivos**

En los formularios reactivos, las validaciones se agregan en el constructor del `FormControl`.

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

#### **Archivo: `form.component.css`**
```css
.field-error {
  color: red;
}
```

---

[![Validators](https://img.youtube.com/vi/U1zcI4JqNpw/0.jpg)](https://www.youtube.com/watch?v=U1zcI4JqNpw&list=PLzA2VyZwsq_9cD3JIxBymaIVyef07PJ-y)

---

## **5. Detectar Cambios en Tiempo Real**

Se pueden suscribir a los cambios en los valores de los formularios utilizando `valueChanges`.

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

---

## **6. Conclusión**

- `FormGroup` y `FormControl` permiten crear formularios altamente estructurados.
- Las validaciones se manejan en el código TypeScript en lugar de en la plantilla.
- `valueChanges` permite detectar cambios en tiempo real.

---

En el próximo tema, exploraremos **qué son los servicios y cómo podemos utilizarlos para gestionar el estado global de nuestra aplicación**.
