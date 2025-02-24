# **Tema 10: Uso de Clases y Estilos Dinámicos con `ngClass` en Angular**

## **1. Introducción**

En Angular, la directiva `ngClass` permite asignar clases CSS dinámicamente a los elementos HTML en función de condiciones o valores de variables. Esto facilita la personalización del estilo de los componentes en respuesta a eventos o cambios en los datos.

En este tema aprenderás:

- Cómo utilizar `ngClass` para agregar o quitar clases dinámicamente.
- Diferentes formas de aplicar `ngClass`.
- Ejemplos prácticos del uso de `ngClass` en Angular.

---

## **2. ¿Qué es `ngClass` y cómo funciona?**

La directiva `ngClass` se utiliza en plantillas HTML para aplicar clases CSS de manera condicional o dinámica. Se puede usar de diferentes formas:

1. **Como una cadena de texto**: Se asigna directamente una clase.
2. **Como un array de strings**: Se pueden agregar múltiples clases.
3. **Como un objeto**: Se pueden asignar clases de forma condicional.

---

## **3. Diferentes Formas de Usar `ngClass`**

Para usar ngClass debemos añadirlo a los imports: `imports: [NgClass]`

### **3.1. Uso de `ngClass` con una cadena de texto**

Se puede asignar una clase CSS directamente desde el componente.

#### **Archivo: `example.component.ts`**

```ts
import { Component } from "@angular/core";
import { NgClass } from '@angular/common';

@Component({
  selector: "app-example",
  imports: [NgClass],
  templateUrl: "./example.component.html",
  styleUrls: ["./example.component.css"],
})
export class ExampleComponent {
  className: string = "highlight";
}
```

#### **Archivo: `example.component.html`**

```html
<p [ngClass]="className">Este texto tiene una clase dinámica</p>
```

#### **Archivo: `example.component.css`**

```css
.highlight {
  color: white;
  background-color: blue;
  padding: 10px;
}
```

---

### **3.2. Uso de `ngClass` con un array de clases**

Se pueden asignar múltiples clases dinámicamente mediante un array.

#### **Archivo: `example.component.ts`**

```ts
export class ExampleComponent {
  classList: string[] = ["highlight", "bold-text"];
}
```

#### **Archivo: `example.component.html`**

```html
<p [ngClass]="classList">Este texto tiene múltiples clases</p>
```

#### **Archivo: `example.component.css`**

```css
.bold-text {
  font-weight: bold;
}
```

---

### **3.3. Uso de `ngClass` con un objeto**

Se pueden agregar o quitar clases de forma condicional.

#### **Archivo: `example.component.ts`**

```ts
export class ExampleComponent {
  isActive: boolean = true;
  isHighlighted: boolean = false;
}
```

#### **Archivo: `example.component.html`**

```html
<p [ngClass]="{ 'active': isActive, 'highlight': isHighlighted }">
  Este texto cambia de estilo dinámicamente
</p>
```

#### **Archivo: `example.component.css`**

```css
.active {
  color: green;
}
```

---

### **3.4. Alternar Clases con Eventos**

Es posible alternar clases mediante eventos como `click`.

#### **Archivo: `example.component.ts`**

```ts
export class ExampleComponent {
  isHighlighted: boolean = false;

  toggleHighlight() {
    this.isHighlighted = !this.isHighlighted;
  }
}
```

#### **Archivo: `example.component.html`**

```html
<button (click)="toggleHighlight()">Alternar Clase</button>
<p [ngClass]="{ 'highlight': isHighlighted }">Texto con clase condicional</p>
```

---

[![Clases dinámicas con ngClass](https://img.youtube.com/vi/XrZKMaZccmA/0.jpg)](https://www.youtube.com/watch?v=XrZKMaZccmA&list=PLzA2VyZwsq_9cD3JIxBymaIVyef07PJ-y)

---

## **4. Conclusión**

- `ngClass` facilita la aplicación dinámica de clases CSS en Angular.
- Se puede utilizar como cadena de texto, array o un objeto de claves condicionales.
- Permite alternar clases mediante eventos como `click`.
- Mejora la personalización y la interacción en las aplicaciones Angular.

---

En el próximo tema, exploraremos **cómo crear y validar formularios usando ngModel**.
