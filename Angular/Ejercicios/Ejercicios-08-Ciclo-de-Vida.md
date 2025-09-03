# **Ejercicios - Tema 8: Ciclo de Vida Completo de los Componentes en Angular**

## **Instrucciones:**

A continuación, encontrarás ejercicios sobre los hooks del ciclo de vida en Angular.

Intenta resolverlos antes de consultar la solución.

---

### **Ejercicio 1: Uso de `ngOnChanges()`**

Crea un componente hijo que detecte cambios en una propiedad recibida del componente padre.

<details><summary>Mostrar solución</summary>

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

</details>

---

### **Ejercicio 2: Uso de `ngOnInit()`**

Inicializa un valor en `ngOnInit()` y muéstralo en la plantilla.

<details><summary>Mostrar solución</summary>

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
    this.message = "Componente inicializado en ngOnInit";
  }
}
```

#### **Archivo: `example.component.html`**

```html
<p>{{ message }}</p>
```

</details>

---

### **Ejercicio 3: Uso de `ngDoCheck()`**

Implementa `ngDoCheck()` para detectar cambios manualmente.

<details><summary>Mostrar solución</summary>

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

</details>

---

### **Ejercicio 4: Uso de `ngAfterViewInit()`**

Modifica el color de un elemento HTML usando `ngAfterViewInit()`.

<details><summary>Mostrar solución</summary>

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
    this.title.nativeElement.style.color = "blue";
  }
}
```

#### **Archivo: `example.component.html`**

```html
<h1 #title>Título modificado en AfterViewInit</h1>
```

</details>

---

### **Ejercicio 5: Uso de `ngOnDestroy()`**

Ejecuta una acción antes de que el componente sea destruido.

<details><summary>Mostrar solución</summary>

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

</details>
