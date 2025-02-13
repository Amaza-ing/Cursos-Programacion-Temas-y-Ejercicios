# **Ejercicios - Tema 3: Eventos y Binding Bidireccional (`ngModel`)**

A continuación, encontrarás 5 ejercicios prácticos sobre eventos y binding bidireccional.

Intenta resolverlos antes de consultar la solución.

## **Ejercicio 1: Manejo de eventos con botones**
Implementa un botón que cambie el texto de un párrafo cuando se presiona.

<details><summary>Mostrar solución</summary>

```ts
export class EventosComponent {
  mensaje: string = 'Texto original';

  cambiarTexto() {
    this.mensaje = 'Texto cambiado!';
  }
}
```

```html
<p>{{ mensaje }}</p>
<button (click)="cambiarTexto()">Cambiar texto</button>
```

</details>

---

## **Ejercicio 2: Captura de eventos con `$event`**
Detecta lo que el usuario escribe en un campo de entrada y muéstralo en pantalla en tiempo real.

<details><summary>Mostrar solución</summary>

```ts
export class EventosComponent {
  inputText: string = '';

  actualizarTexto(event: Event) {
    this.inputText = (event.target as HTMLInputElement).value;
  }
}
```

```html
<input (input)="actualizarTexto($event)" placeholder="Escribe algo">
<p>Has escrito: {{ inputText }}</p>
```

</details>

---

## **Ejercicio 3: Binding bidireccional con `ngModel`**
Crea un formulario donde el usuario escriba su nombre y edad, y se actualicen automáticamente en pantalla.

<details><summary>Mostrar solución</summary>

```ts
export class FormularioComponent {
  name: string = '';
  age: number = 0;
}
```

```html
<input [(ngModel)]="name" placeholder="Nombre">
<input [(ngModel)]="age" type="number" placeholder="Edad">
<p>Hola {{ name }}, tienes {{ age }} años.</p>
```

</details>

---

## **Ejercicio 4: Contador dinámico con eventos**
Implementa un contador que aumente y disminuya al hacer clic en botones. 

**Requisitos:**
1. En `counter.component.ts`, define una variable `counter` con valor inicial `0`.
2. En `counter.component.html`, agrega:
   - Un botón `+` que incremente el contador en `+1`.
   - Un botón `-` que disminuya el contador en `-1`.
   - Un párrafo `<p>` donde se muestre el valor actual del contador.
3. Implementa lógica para evitar que el contador baje de `0`.
4. Cuando el contador llegue a `10`, muestra una alerta `"Has alcanzado el límite"`.

Salida esperada:
[Usuario hace clic en "+" 3 veces] → Se muestra: "3" [Usuario hace clic en "-" 1 vez] → Se muestra: "2"

<details><summary>Mostrar solución</summary>

```ts
export class ContadorComponent {
  counter: number = 0;

  increase() {
    if (this.counter < 10) {
      this.counter++;
    } else {
      alert('Has alcanzado el límite');
    }
  }

  decrease() {
    if (this.counter > 0) {
      this.counter--;
    }
  }
}
```

```html
<p>Contador: {{ counter }}</p>
<button (click)="increase()">+</button>
<button (click)="decrease()">-</button>
```

</details>

---

## **Ejercicio 5: Formulario interactivo con validaciones**
Creaa un formulario que capture el nombre, email y edad de un usuario con validaciones simples.

<details><summary>Mostrar solución</summary>

```ts
export class FormComponent {
  name: string = '';
  email: string = '';
  age: number | null = null;
  message: string = '';

  validateForm() {
    if (!this.name) {
      this.message = 'El nombre es obligatorio';
      return;
    }
    if (!this.email.includes('@')) {
      this.message = 'Email no válido';
      return;
    }
    if (!this.age || this.age < 18) {
      this.message = 'Debes ser mayor de edad';
      return;
    }
    this.message = 'Formulario enviado correctamente';
  }
}
```

```html
<input [(ngModel)]="name" placeholder="Nombre">
<input [(ngModel)]="email" placeholder="Email">
<input [(ngModel)]="age" type="number" placeholder="Edad">
<button (click)="validateForm()">Enviar</button>
<p>{{ message }}</p>
```

</details>
