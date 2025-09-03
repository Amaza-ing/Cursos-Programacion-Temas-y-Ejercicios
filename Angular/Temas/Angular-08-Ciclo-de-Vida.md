# **Tema 8: Ciclo de Vida Completo de los Componentes en Angular**

## **1. Introducción**

Los componentes en Angular tienen un ciclo de vida definido por una serie de métodos (hooks) que permiten ejecutar lógica en diferentes momentos de la existencia del componente.

En este tema aprenderás:

- Cuáles son los hooks del ciclo de vida de Angular.
- Cuándo se ejecutan y cómo utilizarlos correctamente.
- Ejemplos prácticos de cada hook.

---

## **2. Hooks del Ciclo de Vida en Angular**

| **Hook**                  | **Cuándo se ejecuta**                                      | **Uso principal**                                   |
| ------------------------- | ---------------------------------------------------------- | --------------------------------------------------- |
| `ngOnChanges()`           | Cuando un `@Input()` cambia de valor                       | Detectar cambios en propiedades recibidas del padre |
| `ngOnInit()`              | Después de que Angular inicializa el componente            | Configuración inicial, llamadas a servicios         |
| `ngDoCheck()`             | En cada ciclo de detección de cambios                      | Detectar cambios manualmente en variables           |
| `ngAfterContentInit()`    | Después de insertar contenido en `<ng-content>`            | Detectar cambios en contenido proyectado            |
| `ngAfterContentChecked()` | Después de cada detección de cambios en `<ng-content>`     | Responder a cambios en contenido proyectado         |
| `ngAfterViewInit()`       | Después de que la vista y los hijos han sido inicializados | Acceder a elementos de la vista con `ViewChild`     |
| `ngAfterViewChecked()`    | Después de cada detección de cambios en la vista           | Ajustar elementos visuales dinámicos                |
| `ngOnDestroy()`           | Antes de destruir el componente                            | Limpiar suscripciones y liberar recursos            |

---

## **3. Explicación y Ejemplos de los Hooks**

### **3.1. `ngOnChanges()`**

Se ejecuta cuando uno o más valores de `@Input()` cambian en el componente hijo.

#### **Archivo: `child.component.ts`**

```ts
import { Component, Input, OnChanges, SimpleChanges } from "@angular/core";

@Component({
  selector: "app-child",
  templateUrl: "./child.component.html",
})
export class ChildComponent implements OnChanges {
  @Input() data: string = "";

  ngOnChanges(changes: SimpleChanges): void {
    console.log("ngOnChanges ejecutado:", changes);
  }
}
```

#### **Archivo: `parent.component.html`**

```html
<input [(ngModel)]="message" placeholder="Escribe algo" />
<app-child [data]="message"></app-child>
```

---

### **3.2. `ngOnInit()`**

Se ejecuta una sola vez, después del constructor. Ideal para inicializar datos o hacer llamadas a servicios.

#### **Archivo: `example.component.ts`**

```ts
import { Component, OnInit } from "@angular/core";

@Component({
  selector: "app-example",
  templateUrl: "./example.component.html",
})
export class ExampleComponent implements OnInit {
  message: string = "";

  ngOnInit(): void {
    this.message = "Componente inicializado";
  }
}
```

#### **Archivo: `example.component.html`**

```html
<p>{{ message }}</p>
```

---

### **3.3. `ngDoCheck()`**

Se ejecuta en cada ciclo de detección de cambios. Útil cuando Angular no detecta cambios automáticamente.

#### **Archivo: `example.component.ts`**

```ts
import { Component, DoCheck } from "@angular/core";

@Component({
  selector: "app-example",
  templateUrl: "./example.component.html",
})
export class ExampleComponent implements DoCheck {
  counter: number = 0;

  ngDoCheck(): void {
    console.log("ngDoCheck ejecutado, contador:", this.counter);
  }
}
```

---

### **3.4. `ngAfterContentInit()` y `ngAfterContentChecked()`**

Estos hooks permiten detectar cambios en contenido proyectado dentro de `<ng-content>`.

#### **Archivo: `child.component.html`**

```html
<ng-content></ng-content>
```

#### **Archivo: `child.component.ts`**

```ts
import {
  Component,
  AfterContentInit,
  AfterContentChecked,
} from "@angular/core";

@Component({
  selector: "app-child",
  templateUrl: "./child.component.html",
})
export class ChildComponent implements AfterContentInit, AfterContentChecked {
  ngAfterContentInit(): void {
    console.log("ngAfterContentInit ejecutado");
  }

  ngAfterContentChecked(): void {
    console.log("ngAfterContentChecked ejecutado");
  }
}
```

---

### **3.5. `ngAfterViewInit()` y `ngAfterViewChecked()`**

Se usan para interactuar con elementos de la vista tras su renderización.

#### **Archivo: `example.component.ts`**

```ts
import { Component, AfterViewInit, ViewChild, ElementRef } from "@angular/core";

@Component({
  selector: "app-example",
  templateUrl: "./example.component.html",
})
export class ExampleComponent implements AfterViewInit {
  @ViewChild("title") title!: ElementRef;

  ngAfterViewInit(): void {
    console.log("ngAfterViewInit ejecutado");
    this.title.nativeElement.style.color = "red";
  }
}
```

#### **Archivo: `example.component.html`**

```html
<h1 #title>Título modificado en AfterViewInit</h1>
```

---

### **3.6. `ngOnDestroy()`**

Se ejecuta antes de destruir el componente. Se usa para limpiar suscripciones y liberar recursos.

#### **Archivo: `example.component.ts`**

```ts
import { Component, OnDestroy } from "@angular/core";

@Component({
  selector: "app-example",
  templateUrl: "./example.component.html",
})
export class ExampleComponent implements OnDestroy {
  ngOnDestroy(): void {
    console.log("Componente destruido");
  }
}
```

---

## **4. Conclusión**

- Angular proporciona **hooks de ciclo de vida** que permiten ejecutar lógica en diferentes momentos de la existencia de un componente.
- `ngOnInit()` es el más usado para la inicialización del componente.
- `ngOnChanges()` detecta cambios en `@Input()`.
- `ngDoCheck()` es útil cuando Angular no detecta cambios automáticamente.
- `ngAfterViewInit()` y `ngAfterViewChecked()` permiten manipular la vista tras su carga.
- `ngOnDestroy()` se usa para liberar recursos antes de eliminar un componente.

---

En el próximo tema, exploraremos **los Modelos e Interfaces para el tipado de Objetos**.
