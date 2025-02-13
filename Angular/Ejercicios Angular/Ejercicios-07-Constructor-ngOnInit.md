# **Ejercicios - Tema 7: El Constructor y `ngOnInit` en Angular**

## **Instrucciones:**
A continuación, encontrarás ejercicios sobre el constructor y `ngOnInit` en Angular.

Intenta resolverlos antes de consultar la solución.

---

### **Ejercicio 1: Uso del Constructor**
Crea un componente que inicialice una variable `message` en el constructor y la muestre en pantalla.

<details><summary>Mostrar solución</summary>

#### **Archivo: `example.component.ts`**
```ts
import { Component } from '@angular/core';

@Component({
  selector: 'app-example',
  templateUrl: './example.component.html'
})
export class ExampleComponent {
  message: string;

  constructor() {
    this.message = 'Mensaje inicializado en el constructor';
  }
}
```

#### **Archivo: `example.component.html`**
```html
<p>{{ message }}</p>
```

</details>

---

### **Ejercicio 2: Uso de `ngOnInit`**
Modifica el componente para que el mensaje sea asignado en `ngOnInit` en lugar del constructor.

<details><summary>Mostrar solución</summary>

#### **Archivo: `example.component.ts`**
```ts
import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-example',
  templateUrl: './example.component.html'
})
export class ExampleComponent implements OnInit {
  message: string;

  constructor() {
    this.message = 'Mensaje inicializado en el constructor';
  }

  ngOnInit(): void {
    this.message = 'Mensaje modificado en ngOnInit';
  }
}
```

</details>

---

### **Ejercicio 3: Diferenciar Constructor y `ngOnInit`**
Agrega `console.log()` en ambos métodos y observa el orden en que se ejecutan.

<details><summary>Mostrar solución</summary>

#### **Archivo: `example.component.ts`**
```ts
import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-example',
  templateUrl: './example.component.html'
})
export class ExampleComponent implements OnInit {
  message: string;

  constructor() {
    console.log('Constructor ejecutado');
    this.message = 'Mensaje desde el constructor';
  }

  ngOnInit(): void {
    console.log('ngOnInit ejecutado');
    this.message = 'Mensaje desde ngOnInit';
  }
}
```

</details>

---

### **Ejercicio 4: Prueba con un retardo en `ngOnInit`**
Simula una carga de datos retardada utilizando `setTimeout()` dentro de `ngOnInit`.

<details><summary>Mostrar solución</summary>

#### **Archivo: `example.component.ts`**
```ts
import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-example',
  templateUrl: './example.component.html'
})
export class ExampleComponent implements OnInit {
  message: string = 'Cargando...';

  constructor() {}

  ngOnInit(): void {
    setTimeout(() => {
      this.message = 'Datos cargados después de 3 segundos';
    }, 3000);
  }
}
```

#### **Archivo: `example.component.html`**
```html
<p>{{ message }}</p>
```

</details>
