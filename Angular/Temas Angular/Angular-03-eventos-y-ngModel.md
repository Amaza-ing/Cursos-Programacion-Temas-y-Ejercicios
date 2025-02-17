# **Tema 3: Eventos y Binding Bidireccional `[(ngModel)]` en Angular**

## **1. Introducción**
En Angular, los eventos y el binding bidireccional `[(ngModel)]` son herramientas esenciales para la interacción del usuario con la aplicación.  
Este tema cubrirá:
- Cómo manejar eventos en Angular con `(event)`.
- El binding bidireccional con `[(ngModel)]` para sincronizar datos entre la vista y el modelo.

---

## **2. Manejo de eventos en Angular**
Un evento en Angular ocurre cuando el usuario interactúa con la aplicación, por ejemplo:
- Hacer clic en un botón.
- Escribir en un campo de entrada.
- Mover el ratón sobre un elemento.

Angular proporciona un mecanismo para manejar estos eventos con el binding de eventos, utilizando la sintaxis `(evento)="función()"`.

---

### **2.1. Sintaxis del binding de eventos**
La sintaxis básica es:

```html
<button (click)="myFunction()">Haz clic</button>
```

Cuando el usuario haga clic en el botón, se ejecutará la función `myFunction()` en el componente.

---

### **2.2. Ejemplo de manejo de eventos**
Supongamos que queremos mostrar un mensaje cuando el usuario haga clic en un botón.

**Ejemplo en `eventos.component.ts`**:

```ts
import { Component } from '@angular/core';

@Component({
  selector: 'app-eventos',
  templateUrl: './eventos.component.html',
  styleUrls: ['./eventos.component.css']
})
export class EventosComponent {
  showMessage() {
    alert('¡Botón clicado!');
  }
}
```

**Ejemplo en `eventos.component.html`**:

```html
<button (click)="showMessage()">Haz clic aquí</button>
```

En este caso, al hacer clic en el botón, se ejecuta `showMessage()`, mostrando una alerta.

---

[![Eventos](https://img.youtube.com/vi/efvtZZDpixc/0.jpg)](https://www.youtube.com/watch?v=efvtZZDpixc&list=PLzA2VyZwsq_9cD3JIxBymaIVyef07PJ-y)

---

### **2.3. Pasar parámetros en eventos**
Podemos pasar valores a la función dentro del componente.

Ejemplo en `eventos.component.html`:

```html
<button (click)="sayHello('Sara')">Saludar</button>
```

Ejemplo en `eventos.component.ts`:

```ts
export class EventosComponent {
  sayHello(nombre: string) {
    alert('¡Hola, ' + nombre + '!');
  }
}
```

Cuando el usuario haga clic en el botón, se ejecutará la función `sayHello('Sara')`, mostrando `"¡Hola, Sara!"`.

---

### **2.4. Eventos con `$event`**
También podemos capturar información del evento utilizando `$event`.

Ejemplo en `eventos.component.html`:

```html
<input (input)="updateText($event)">
<p>{{ mensaje }}</p>
```

Ejemplo en `eventos.component.ts`:

```ts
export class EventosComponent {
  mensaje: string = '';

  updateText(e: Event) {
    this.mensaje = (e.target as HTMLInputElement).value;
  }
}
```

Aquí:
1. Cada vez que el usuario escribe en el campo de entrada, se ejecuta `updateText()`.
2. La variable `mensaje` se actualiza con el texto introducido.
3. La interpolación `{{ mensaje }}` muestra el contenido actualizado en la pantalla.

---

## **3. Binding bidireccional con `ngModel`**
El **binding bidireccional** permite que una variable en el componente y un campo en la vista se mantengan sincronizados automáticamente.

Para lograrlo, usamos la directiva `[(ngModel)]`, que combina el binding de propiedad y el binding de eventos. Por eso usa tanto los corchetes [binding de propiedad] como los paréntesis (binding de eventos).

> Nota: Esta sintaxis es conocida como: Banana in a box.


**Ejemplo básico en `ngmodel.component.ts`**:

```ts
import { Component } from '@angular/core';

@Component({
  selector: 'app-ngmodel',
  templateUrl: './ngmodel.component.html',
  styleUrls: ['./ngmodel.component.css']
})
export class NgModelComponent {
  userName: string = '';
}
```

**Ejemplo en `ngmodel.component.html`**:

```html
<input [(ngModel)]="userName" placeholder="Escribe tu nombre">
<p>Hola, {{ userName }}</p>
```

En este caso:
- `[(ngModel)]="userName"` hace que el valor del input y la variable `userName` estén sincronizados.
- Al escribir en el input, `userName` se actualiza automáticamente.
- El mensaje `"Hola, [nombre]"` se actualiza en tiempo real.

---

### **3.1. Importar `FormsModule`**
Para que `ngModel` funcione, necesitamos importar `FormsModule` en el componente donde se utilice.

Ejemplo en `app.module.ts`:

```ts
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';  // Importar FormsModule

import { AppComponent } from './app.component';
import { NgModelComponent } from './ngmodel/ngmodel.component';

@NgModule({
  declarations: [AppComponent, NgModelComponent],
  imports: [FormsModule],  // Agregar FormsModule aquí
  bootstrap: [AppComponent]
})
export class AppModule { }
```

Sin esta importación, `ngModel` no funcionará.

---

[![ngModel](https://img.youtube.com/vi/2NWc1x-VLcM/0.jpg)](https://www.youtube.com/watch?v=2NWc1x-VLcM&list=PLzA2VyZwsq_9cD3JIxBymaIVyef07PJ-y)

---

## **4. Comparación entre binding de eventos y `ngModel`**
| **Tipo de Binding**      | **Descripción** | **Ejemplo** |
|-------------------------|----------------|-------------|
| **Binding de eventos `(event)`** | Captura eventos del usuario y ejecuta funciones en el componente. | `(click)="myFunction()"` |
| **Binding bidireccional `[(ngModel)]`** | Sincroniza el valor de una variable con el input en tiempo real. | `[(ngModel)]="variable"` |

---

## **5. A Resaltar**
- **Los Eventos en Angular** permiten ejecutar funciones en respuesta a acciones del usuario.
- Podemos usar `$event` para capturar información del evento.
- **Binding bidireccional con `ngModel`** mantiene sincronizados los valores de variables y los inputs.
- Para usar `ngModel`, es necesario importar `FormsModule` en el componente que lo utilice.

---

En el siguiente tema, exploraremos algunas herramientas de control de flujo de Angular como `@if` y `@for`
