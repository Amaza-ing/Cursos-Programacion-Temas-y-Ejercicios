# **Tema 7: El Constructor y `ngOnInit` en Angular**

## **1. Introducción**

En Angular, los componentes tienen un ciclo de vida que define cómo se crean, actualizan y destruyen. Dos métodos clave en este ciclo de vida son:

- **El constructor**: Se ejecuta cuando se crea una instancia del componente.
- **`ngOnInit`**: Es un hook del ciclo de vida de Angular que se ejecuta después de que el componente ha sido inicializado.

Entender la diferencia entre ambos es fundamental para manejar correctamente la inicialización y configuración de los componentes.

---

## **2. ¿Qué es el constructor en Angular?**

El constructor es un método especial en TypeScript que se ejecuta cuando se crea una nueva instancia de la clase. Se utiliza para inicializar propiedades y para la inyección de dependencias.

### **Ejemplo de uso del constructor**

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
    this.message = 'Este mensaje se inicializó en el constructor';
    console.log('Constructor ejecutado');
  }
}
```

#### **Archivo: `example.component.html`**
```html
<p>{{ message }}</p>
```

### **Características del constructor**
- Se ejecuta **antes de que Angular inicialice el componente**.
- Se usa principalmente para **inicializar variables y recibir dependencias**.
- No se debe realizar lógica pesada dentro del constructor.

---

[![Constructor](https://img.youtube.com/vi/2YPur9wymh0/0.jpg)](https://www.youtube.com/watch?v=2YPur9wymh0&list=PLzA2VyZwsq_9cD3JIxBymaIVyef07PJ-y)

---

## **3. ¿Qué es `ngOnInit` y para qué se usa?**

`ngOnInit` es un método del ciclo de vida de Angular que se ejecuta después de que el constructor ha finalizado y cuando Angular ha inicializado el componente.

### **Ejemplo de uso de `ngOnInit`**

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
    this.message = 'Mensaje inicial';
    console.log('Constructor ejecutado');
  }

  ngOnInit(): void {
    this.message = 'Mensaje actualizado en ngOnInit';
    console.log('ngOnInit ejecutado');
  }
}
```

#### **Archivo: `example.component.html`**
```html
<p>{{ message }}</p>
```

### **Características de `ngOnInit`**
- Se ejecuta **una sola vez**, después del constructor.
- Se usa para **realizar inicializaciones complejas** como:
  - Llamadas a APIs.
  - Asignar valores obtenidos de servicios.
  - Suscribirse a observables.
- Se define implementando la interfaz `OnInit` y el método `ngOnInit()`.

---

[![ngOnInit](https://img.youtube.com/vi/FSZoekTcJn4/0.jpg)](https://www.youtube.com/watch?v=FSZoekTcJn4&list=PLzA2VyZwsq_9cD3JIxBymaIVyef07PJ-y)

---

## **4. Diferencias entre el constructor y `ngOnInit`**

| **Característica** | **Constructor** | **ngOnInit** |
|-------------------|---------------|-------------|
| Cuándo se ejecuta | Al crear el componente | Después de la inicialización del componente |
| Uso principal | Inicialización de variables, inyección de dependencias | Llamadas a APIs, suscripciones y lógica compleja |
| Cantidad de ejecuciones | Una sola vez | Una sola vez |
| Interacción con Angular | No tiene acceso total al framework aún | Ya puede interactuar con Angular |

---

## **5. Cuándo usar `ngOnInit` en lugar del constructor**

Debes usar `ngOnInit` en lugar del constructor cuando:
- Necesitas esperar que el componente haya sido completamente inicializado.
- Debes hacer llamadas a servicios o peticiones HTTP.
- Requieres lógica que dependa de la inyección de dependencias.

Esto se suele utilizar muy a menudo en conjunto con los servicios. Hablaremos de los servicios más adelante en el tema 13.

Ejemplo con servicio:

#### **Archivo: `example.component.ts`**
```ts
import { Component, OnInit } from '@angular/core';
import { DataService } from '../services/data.service';

@Component({
  selector: 'app-example',
  templateUrl: './example.component.html'
})
export class ExampleComponent implements OnInit {
  data: string = '';

  constructor(private dataService: DataService) {}

  ngOnInit(): void {
    this.data = this.dataService.getData();
  }
}
```

En este caso, `ngOnInit` es el lugar adecuado para hacer la llamada al servicio, ya que el constructor no debería contener lógica de negocio.

---

## **6. Conclusión**

- El **constructor** se usa para inicializar variables y recibir dependencias.
- `ngOnInit` es un **hook del ciclo de vida** de Angular que se ejecuta después del constructor.
- Es preferible **realizar lógica compleja dentro de `ngOnInit`** en lugar del constructor.
- Entender la diferencia entre ambos mejora la organización del código y el rendimiento de la aplicación.

---

En el próximo tema, exploraremos **los ciclos de vida completos de los componentes en Angular**.
