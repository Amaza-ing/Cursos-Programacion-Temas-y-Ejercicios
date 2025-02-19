# **Ejercicios - Tema 11: Creación y Validación de Formularios con `ngModel`**

## **Instrucciones:**
A continuación, encontrarás ejercicios sobre el uso de `ngModel` en formularios Angular.

Intenta resolverlos antes de consultar la solución.

---

### **Ejercicio 1: Capturar Datos con `ngModel`**
Crea un formulario simple con un campo de texto y un botón que muestre el valor ingresado en consola.

<details><summary>Mostrar solución</summary>

#### **Archivo: `form.component.ts`**
```ts
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-form',
  imports: [FormsModule],
})
export class FormComponent {
  userName: string = '';

  submitForm() {
    console.log('Nombre ingresado:', this.userName);
  }
}
```

#### **Archivo: `form.component.html`**
```html
<form (ngSubmit)="submitForm()">
  <label for="username">Nombre:</label>
  <input type="text" id="username" [(ngModel)]="userName" name="name" required>
  <button type="submit">Enviar</button>
</form>
```

</details>

---

### **Ejercicio 2: Validar Edad con una Restricción Personalizada**
Crea un formulario donde la edad mínima permitida sea 18 años.

<details><summary>Mostrar solución</summary>

#### **Archivo: `form.component.ts`**
```ts
export class FormComponent {
  userAge: number | null = null;
}
```

#### **Archivo: `form.component.html`**
```html
<label>Edad:</label>
<input type="number" [(ngModel)]="userAge" name="age" required min="18">
@if (userAge < 18) {
<div>
  Debes ser mayor de 18 años.
</div>
}
```

</details>

---

### **Ejercicio 3: Capturar y Mostrar Datos en Pantalla**
Crea un formulario donde el usuario ingrese su nombre y edad, y se muestren en tiempo real en pantalla.

<details><summary>Mostrar solución</summary>

#### **Archivo: `form.component.ts`**
```ts
userName: string: "";
userAge: number: "";
```

#### **Archivo: `form.component.html`**
```html
<form>
  <label for="username">Nombre:</label>
  <input type="text" id="username" [(ngModel)]="userName" name="name">
  
  <label for="userAge">Edad:</label>
  <input type="number" id="userAge" [(ngModel)]="userAge" name="age">
</form>

<p>Nombre: {{ userName }}</p>
<p>Edad: {{ userAge }}</p>
```

</details>
