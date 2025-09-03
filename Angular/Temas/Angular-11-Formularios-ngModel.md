# **Tema 11: Creación y Validación de Formularios con `ngModel` en Angular**

## **1. Introducción**

En Angular, `ngModel` permite la vinculación bidireccional de datos en formularios, lo que facilita la captura y validación de datos del usuario.

En este tema aprenderás:

- Cómo usar `ngModel` para la captura de datos en formularios.
- Cómo validar formularios con validaciones integradas y personalizadas.
- Cómo gestionar errores en formularios de manera eficiente.

---

## **2. Configuración Inicial**

Para utilizar `ngModel`, es necesario importar el módulo `FormsModule` en los imports de la aplicación.

---

[![ngModel](https://img.youtube.com/vi/2NWc1x-VLcM/0.jpg)](https://www.youtube.com/watch?v=2NWc1x-VLcM&list=PLzA2VyZwsq_9cD3JIxBymaIVyef07PJ-y)

---

## **3. Creación de un Formulario con `ngModel`**

La directiva `ngModel` permite la vinculación bidireccional en los formularios, lo que sincroniza automáticamente el modelo con la vista.

El evento `(ngSubmit)` permite gestionar el envío de un formulario.

#### **Archivo: `form.component.ts`**

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

#### **Archivo: `form.component.html`**

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

## **4. Validación de Formularios**

Se pueden definir validaciones personalizadas en un método en el componente.

#### **Archivo: `form.component.ts`**

```ts
export class FormComponent {
  user = { name: "", age: null };

  validateAge(age: number): boolean {
    return age >= 18;
  }
}
```

#### **Archivo: `form.component.html`**

```html
<label for="age">Edad:</label>
<input type="number" id="age" [(ngModel)]="user.age" name="age" required />

@if (!validateAge(user.age)) {
<div>Debes ser mayor de edad.</div>
}
```

---

## **5. Conclusión**

- `ngModel` permite la vinculación bidireccional en formularios.
- Se pueden definir validaciones personalizadas para reglas específicas.
- La gestión de errores mejora la experiencia del usuario al llenar formularios.

---

En el próximo tema, exploraremos **cómo gestionar formularios reactivos con `FormGroup` y `FormControl` en Angular**.
