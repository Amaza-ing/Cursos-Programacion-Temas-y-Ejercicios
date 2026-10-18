# **Exercises - Topic 3: Events and Bidirectional Binding (`ngModel`)**

Below you will find 5 practical exercises on events and bidirectional binding.

Try to solve them before consulting the solution.

## **Exercise 1: Handling events with buttons**

Implement a button that changes the text of a paragraph when pressed.

<details><summary>Show solution</summary>

```ts
export class EventosComponent {
  mensaje: string = "Texto original";

  cambiarTexto() {
    this.mensaje = "Texto cambiado!";
  }
}
```


```html
<p>{{ mensaje }}</p>
<button (click)="cambiarTexto()">Cambiar texto</button>
```


</details>

---

## **Exercise 2: Capturing events with `$event`**

Detect what the user writes in an input field and display it on the screen in real time.

<details><summary>Show solution</summary>

```ts
export class EventosComponent {
  inputText: string = "";

  actualizarTexto(event: Event) {
    this.inputText = (event.target as HTMLInputElement).value;
  }
}
```


```html
<input (input)="actualizarTexto($event)" placeholder="Escribe algo" />
<p>Has escrito: {{ inputText }}</p>
```


</details>

---

## **Exercise 3: Bidirectional Binding with `ngModel`**

Create a form where the user enters their name and age, and they automatically update on the screen.

<details><summary>Show solution</summary>

```ts
export class FormularioComponent {
  name: string = "";
  age: number = 0;
}
```


```html
<input [(ngModel)]="name" placeholder="Nombre" />
<input [(ngModel)]="age" type="number" placeholder="Edad" />
<p>Hola {{ name }}, tienes {{ age }} años.</p>
```


</details>

---

## **Exercise 4: Dynamic counter with events**

Implement a counter that increments and decrements when buttons are clicked.

**Requirements:**

1. In `counter.component.ts`, define a variable `counter` with initial value `0`.
2. In `counter.component.html`, add:
   - An `+` button that increments the counter in `+1`.
   - An `-` button that decrements the counter in `-1`.
   - An `<p>` paragraph showing the current value of the counter.
3. Implement logic to prevent the counter from going below `0`.
4. When the counter reaches `10`, display an `"Has alcanzado el límite"` alert.

Expected output:
[User clicks "+" 3 times] → Displays: "3" [User clicks "-" 1 time] → Displays: "2"

<details><summary>Show solution</summary>

```ts
export class ContadorComponent {
  counter: number = 0;

  increase() {
    if (this.counter < 10) {
      this.counter++;
    } else {
      alert("Has alcanzado el límite");
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

## **Exercise 5: Interactive form with validations**

Create a form that captures a user's name, email, and age with simple validations.

<details><summary>Show solution</summary>

```ts
export class FormComponent {
  name: string = "";
  email: string = "";
  age: number | null = null;
  message: string = "";

  validateForm() {
    if (!this.name) {
      this.message = "El nombre es obligatorio";
      return;
    }
    if (!this.email.includes("@")) {
      this.message = "Email no válido";
      return;
    }
    if (!this.age || this.age < 18) {
      this.message = "Debes ser mayor de edad";
      return;
    }
    this.message = "Formulario enviado correctamente";
  }
}
```


```html
<input [(ngModel)]="name" placeholder="Nombre" />
<input [(ngModel)]="email" placeholder="Email" />
<input [(ngModel)]="age" type="number" placeholder="Edad" />
<button (click)="validateForm()">Enviar</button>
<p>{{ message }}</p>
```


</details>
