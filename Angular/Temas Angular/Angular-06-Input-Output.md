# **Tema 6: Comunicación entre Componentes en Angular**

## **1. Introducción**

En Angular, la comunicación entre componentes es clave para la construcción de aplicaciones escalables. Existen varias formas de pasar datos entre componentes, pero las más comunes son:

- `@Input()` y `@Output()`, que permiten la comunicación entre un componente padre y un componente hijo.
- Las **Signals** `input` y `output`, que son una alternativa más eficiente introducida en Angular 16.

En este tema, exploraremos cómo utilizar estas técnicas para la comunicación entre componentes.

---

## **2. Comunicación con `@Input()`**

La directiva `@Input()` permite que un componente hijo reciba datos desde su componente padre.

### **Ejemplo de `@Input()`**

#### **Archivo: `parent.component.ts`**
```ts
import { Component } from '@angular/core';

@Component({
  selector: 'app-parent',
  templateUrl: './parent.component.html'
})
export class ParentComponent {
  parentMsg: string = 'Hola desde el componente padre';
}
```

#### **Archivo: `parent.component.html`**
```html
<app-child [message]="parentMsg"></app-child>
```

#### **Archivo: `child.component.ts`**
```ts
import { Component, Input } from '@angular/core';

@Component({
  selector: 'app-child',
  templateUrl: './child.component.html'
})
export class ChildComponent {
  @Input()
  message: string = '';
}
```

#### **Archivo: `child.component.html`**
```html
<p>Mensaje recibido: {{ message }}</p>
```

Por supuesto, se pueden pasar cualquier tipo de datos, no solamente strings. Se pueden pasar tambien objetos y cualquier otro tipo de dato.

---

## **3. Comunicación con `@Output()`**

La directiva `@Output()` permite que un componente hijo envíe datos al componente padre mediante eventos.

### **Ejemplo de `@Output()`**

#### **Archivo: `parent.component.ts`**
```ts
import { Component } from '@angular/core';

@Component({
  selector: 'app-parent',
  templateUrl: './parent.component.html'
})
export class ParentComponent {
  receivedMsg: string = '';
  
  updateMsg(newMsg: string) {
    this.receivedMsg = newMsg;
  }
}
```

#### **Archivo: `parent.component.html`**
```html
<app-child (emittedMsg)="updateMsg($event)"></app-child>
<p>Mensaje recibido del hijo: {{ receivedMsg }}</p>
```

#### **Archivo: `child.component.ts`**
```ts
import { Component, EventEmitter, Output } from '@angular/core';

@Component({
  selector: 'app-child',
  templateUrl: './child.component.html'
})
export class ChildComponent {
  @Output() emittedMsg = new EventEmitter<string>();

  sendMsg() {
    this.emittedMsg.emit('Mensaje desde el hijo');
  }
}
```

#### **Archivo: `child.component.html`**
```html
<button (click)="sendMsg()">Enviar mensaje al padre</button>
```

---

## **4. Comunicación con Signals `input` y `output`**

En Angular 16, se introdujeron `input()` y `output()`, una alternativa más optimizada a `@Input()` y `@Output()`.

### **Ejemplo de `input()`**

#### **Archivo: `parent.component.html`**
```html
<app-child [message]="'Hola desde el padre con Signals'" ></app-child>
```

#### **Archivo: `child.component.ts`**
```ts
import { Component, input } from '@angular/core';

@Component({
  selector: 'app-child',
  templateUrl: './child.component.html'
})
export class ChildComponent {
  message = input('');
}
```

#### **Archivo: `child.component.html`**
```html
<p>{{ message() }}</p>
```

### **Ejemplo de `output()`**

#### **Archivo: `child.component.ts`**
```ts
import { Component, output } from '@angular/core';

@Component({
  selector: 'app-child',
  templateUrl: './child.component.html'
})
export class ChildComponent {
  emittedMsg = output<string>();

  sendMsg() {
    this.emittedMsg.emit('Mensaje desde el hijo con Signals');
  }
}
```

#### **Archivo: `parent.component.html`**
```html
<app-child (emittedMsg)="updateMsg($event)"></app-child>
```

#### **Archivo: `parent.component.ts`**
```ts
import { Component } from '@angular/core';

@Component({
  selector: 'app-parent',
  templateUrl: './parent.component.html'
})
export class ParentComponent {
  receivedMsg: string = '';
  
  updateMsg(newMsg: string) {
    this.receivedMsg = newMsg;
  }
}
```

---

## **5. Comparación entre `@Input/@Output` y `input()/output()`**

| **Característica** | **@Input/@Output** | **input()/output()** |
|-------------------|------------------|------------------|
| Forma de declarar | Decoradores en la clase | Variables dentro de la clase |
| Reactividad | No reactivo por defecto | Reactivo automáticamente |
| Facilidad de uso | Más conocido y compatible | Más eficiente en rendimiento |
| Requiere `EventEmitter` | Sí | No |

---

## **6. Conclusión**

- `@Input()` y `@Output()` son la forma clásica de comunicación entre componentes en Angular.
- `input()` y `output()` introducen una forma más eficiente y reactiva de manejar el flujo de datos.
- La elección entre ambos depende de la compatibilidad con versiones anteriores y la optimización de rendimiento.

---

En el próximo tema, exploraremos el **constructor y el ngOnInit** y cómo influyen en el ciclo de vida del componente
