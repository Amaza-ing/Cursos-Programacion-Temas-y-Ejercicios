# **Ejercicios - Temas 1 y 2**

## **Ejercicios del Tema 1: Introducción a Angular y Configuración del Entorno**

A continuación, encontrarás 10 ejercicios prácticos sobre los aspectos básicos de Angular.

Intenta resolverlos antes de consultar la solución.

### **Ejercicio 1: Instalación de Angular CLI**

Instala Angular CLI en tu sistema y verifica la instalación con los comandos adecuados.

<details><summary>Mostrar solución</summary>

```sh
npm install -g @angular/cli
ng version
```

</details>

---

### **Ejercicio 2: Creación de un nuevo proyecto Angular**

Crea un nuevo proyecto en Angular llamado `mi-proyecto-angular` utilizando Angular CLI.

<details><summary>Mostrar solución</summary>

```sh
ng new mi-proyecto-angular
```

</details>

---

### **Ejercicio 3: Estructura del proyecto**

Explica brevemente la función de los siguientes archivos:

- `src/app/app.component.ts`
- `src/main.ts`
- `angular.json`
- `package.json`
<details><summary>Mostrar solución</summary>

- `src/app/app.component.ts`: Define la lógica del componente principal de la aplicación.
- `src/main.ts`: Punto de entrada de la aplicación.
- `angular.json`: Configuración del proyecto Angular.
- `package.json`: Lista de dependencias y scripts del proyecto.

</details>

---

### **Ejercicio 4: Servidor de desarrollo**

Inicia el servidor de desarrollo y explica qué ocurre cuando cambias `app.component.html`.

<details><summary>Mostrar solución</summary>

```sh
ng serve
```

Cualquier cambio en `app.component.html` se reflejará automáticamente en el navegador sin necesidad de recargar la página.

</details>

---

### **Ejercicio 5: Modificación del template inicial**

Modifica `app.component.html` para mostrar un mensaje personalizado.

<details><summary>Mostrar solución</summary>

```html
<h1>Bienvenido a mi aplicación en Angular</h1>
```

</details>

---

## **Ejercicios del Tema 2: Componentes en Angular**

### **Ejercicio 6: Creación de un componente**

Crea un componente `header` dentro de la carpeta `components`.

<details><summary>Mostrar solución</summary>

```sh
ng generate component components/header
```

Este comando genera los archivos necesarios: `.ts`, `.html`, `.css` y `.spec.ts`.

</details>

---

### **Ejercicio 7: Uso de un componente**

Añade el componente `header` dentro de `app.component.html`.

<details><summary>Mostrar solución</summary>

```html
<app-header></app-header>
```

</details>

---

### **Ejercicio 8: Interpolación**

Define una variable `title` en el componente `header` y muéstrala en su plantilla.

<details><summary>Mostrar solución</summary>

```ts
export class HeaderComponent {
  title = "Bienvenido a mi aplicación";
}
```

```html
<h1>{{ title }}</h1>
```

</details>

---

### **Ejercicio 9: Binding de propiedades**

Crea un input con `placeholder` dinámico basado en una variable.

<details><summary>Mostrar solución</summary>

```ts
export class HeaderComponent {
  placeholderText = "Introduce tu nombre";
}
```

```html
<input [placeholder]="placeholderText" />
```

</details>

---

### **Ejercicio 10: Componentes dentro de componentes**

Crea un componente `footer` que contenga otros tres componentes internos.

<details><summary>Mostrar solución</summary>

```sh
ng generate component components/footer
ng generate component components/footer/info
ng generate component components/footer/social
ng generate component components/footer/contact
```

```html
<app-info></app-info>
<app-social></app-social>
<app-contact></app-contact>
```

</details>
