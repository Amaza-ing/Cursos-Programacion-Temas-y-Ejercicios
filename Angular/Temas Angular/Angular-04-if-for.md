# **Tema 4: Control de Flujo en Angular (@if y @for)**

## **1. Introducción**
En Angular, el control de flujo nos permite gestionar la lógica de visualización de los elementos en el DOM. A partir de Angular 17, se introdujeron las directivas `@if` y `@for`, que permiten mejorar la legibilidad y eficiencia del código.

Este tema cubrirá:
- La directiva `@if` para renderizar condicionalmente elementos en la vista.
- La directiva `@for` para iterar sobre listas de elementos.
- Comparación con las directivas `*ngIf` y `*ngFor` tradicionales.

---

## **2. La Directiva `@if`**

La directiva `@if` permite mostrar u ocultar elementos en función de una condición. Reemplaza a `*ngIf`, mejorando la estructura y claridad del código.

### **2.1. Uso básico de `@if`**

Ejemplo en `control-flujo.component.html`:

```html
@if (isLoggedIn) {
  <p>Bienvenido, usuario.</p>
} @else {
  <p>Por favor, inicia sesión.</p>
}
```

Ejemplo en `control-flujo.component.ts`:

```ts
import { Component } from '@angular/core';

@Component({
  selector: 'app-control-flujo',
  templateUrl: './control-flujo.component.html',
  styleUrls: ['./control-flujo.component.css']
})
export class ControlFlujoComponent {
  isLoggedIn: boolean = false;
}
```

En este caso:
- Si `isLoggedIn` es `true`, se mostrará el mensaje "Bienvenido, usuario.".
- Si `isLoggedIn` es `false`, se mostrará "Por favor, inicia sesión.".

---

## **3. La Directiva `@for`**

La directiva `@for` permite iterar sobre una lista y generar dinámicamente elementos en la vista, reemplaza a `*ngFor`, mejorando la estructura y claridad del código.

### **3.1. Uso básico de `@for`**

Ejemplo en `control-flujo.component.html`:

```html
<ul>
  @for (item of items; track item) {
    <li>{{ item }}</li>
  }
</ul>
```

Ejemplo en `control-flujo.component.ts`:

```ts
import { Component } from '@angular/core';

@Component({
  selector: 'app-control-flujo',
  templateUrl: './control-flujo.component.html',
  styleUrls: ['./control-flujo.component.css']
})
export class ControlFlujoComponent {
  items: string[] = ['Angular', 'React', 'Vue'];
}
```

En este caso:
- Se genera dinámicamente una lista `ul` con los elementos de `items`.
- Se usa `track` para optimizar la actualización del DOM haciendo que Angular identifique claramente a cada elemento de la lista.

---

## **4. Comparación entre `@if`/`@for` y `*ngIf`/`*ngFor`**

| **Directiva**   | **Nueva Sintaxis** | **Sintaxis Anterior** |
|---------------|----------------|----------------|
| Condicional   | `@if (condición) { ... } @else { ... }` | `<ng-container *ngIf="condición; else otraPlantilla"></ng-container>` |
| Iteración     | `@for (item of items; track item) { ... }` | `<div *ngFor="let item of items">{{ item }}</div>` |

### **4.1. Ventajas de `@if` y `@for`**
- **Mayor legibilidad**: Se parece más a la sintaxis de JavaScript.
- **Mejor rendimiento**: Reduce cálculos innecesarios en el DOM.
- **Estructura más clara**: Evita el uso de `<ng-container>` y plantillas auxiliares.

---

## **5. Conclusión**

- `@if` permite mostrar u ocultar contenido dependiendo de la condición que elijamos.
- `@for` facilita la iteración sobre listas de forma eficiente.
- Estas nuevas directivas simplifican el código y mejoran la organización de la vista.

---

En el siguiente tema, exploraremos las signals y las nuevas formas de gestionar la reactividad en Angular.
