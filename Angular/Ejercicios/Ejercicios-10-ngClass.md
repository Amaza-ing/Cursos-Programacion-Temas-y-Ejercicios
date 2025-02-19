# **Ejercicios - Tema 10: Uso de Clases y Estilos Dinámicos con `ngClass`**

## **Instrucciones:**

A continuación, encontrarás ejercicios sobre cómo aplicar clases y estilos dinámicos con `ngClass` en Angular.

Intenta resolverlos antes de consultar la solución.

---

### **Ejercicio 1: Aplicar una clase dinámica con `ngClass`**

Crea un componente que aplique una clase CSS definida en función de una variable.

<details><summary>Mostrar solución</summary>

#### **Archivo: `example.component.ts`**

```ts
import { Component } from "@angular/core";

@Component({
  selector: "app-example",
  templateUrl: "./example.component.html",
  styleUrls: ["./example.component.css"],
})
export class ExampleComponent {
  pageTheme: string = "dark";
}
```

#### **Archivo: `example.component.html`**

```html
<p [ngClass]="pageTheme">Este texto tiene una clase dinámica</p>
```

#### **Archivo: `example.component.css`**

```css
.dark {
  color: white;
  background-color: black;
}
```

</details>

---

### **Ejercicio 2: Aplicar múltiples clases con `ngClass`**

Define una lista de clases y aplícalas al mismo elemento con `ngClass`.

<details><summary>Mostrar solución</summary>

#### **Archivo: `example.component.ts`**

```ts
export class ExampleComponent {
  pageStyles: string[] = ["dark", "bold-text"];
}
```

#### **Archivo: `example.component.html`**

```html
<p [ngClass]="pageStyles">Este texto tiene múltiples clases</p>
```

#### **Archivo: `example.component.css`**

```css
.bold-text {
  font-weight: bold;
}
```

</details>

---

### **Ejercicio 3: Aplicar clases condicionales con `ngClass`**

Utiliza un objeto para asignar clases de forma condicional.

<details><summary>Mostrar solución</summary>

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

</details>

---

### **Ejercicio 4: Alternar Clases con un Botón**

Crea un botón que permita alternar la aplicación de una clase en un párrafo.

<details><summary>Mostrar solución</summary>

#### **Archivo: `example.component.ts`**

```ts
export class ExampleComponent {
  isDark: boolean = false;

  toggleDark() {
    this.isDark = !this.isDark;
  }
}
```

#### **Archivo: `example.component.html`**

```html
<button (click)="toggleDark()">Alternar Clase</button>
<p [ngClass]="{ 'dark': isDark }">Texto con clase condicional</p>
```

</details>

---

### **Ejercicio 5: Aplicar múltiples clases con un array dinámico**

Usa un array que cambie dinámicamente para modificar las clases de un elemento.

<details><summary>Mostrar solución</summary>

#### **Archivo: `example.component.ts`**

```ts
export class ExampleComponent {
  classes: string[] = ["text-large"];

  addClass() {
    this.classes.push("highlight");
  }
}
```

#### **Archivo: `example.component.html`**

```html
<button (click)="addClass()">Añadir Clase</button>
<p [ngClass]="classes">Texto con clases dinámicas</p>
```

#### **Archivo: `example.component.css`**

```css
.highlight {
  background-color: yellow;
}

.text-large {
  font-size: 20px;
}
```

</details>
