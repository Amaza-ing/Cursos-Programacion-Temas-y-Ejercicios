# **Tema 2: Componentes en Angular**

## **1. ¿Qué es un componente en Angular?**

Un componente es la unidad fundamental de una aplicación Angular. Cada componente define una parte de la interfaz de usuario y su comportamiento.

### **Estructura de un componente**

Un componente en Angular está compuesto por tres partes principales:

- **Template (`.html`)**: Define la estructura visual del componente.
- **Estilos (`.css` o `.scss`)**: Contiene las reglas de diseño del componente.
- **Clase TypeScript (`.ts`)**: Contiene la lógica y comportamiento del componente.

---

## **2. Creación de un componente**

Para crear un nuevo componente en Angular, por ejemplo un componente para un menú que se llame menu, usa el siguiente comando:

```sh
ng generate component components/menu
```

O en su versión abreviada:

```sh
ng g c components/menu
```

Este comando generará una nueva carpeta dentro de `src/app/components` con los siguientes archivos (y otros que no son importantes para empezar):

```
menu/
│── menu.component.ts      # Lógica del componente
│── menu.component.html    # Plantilla del componente
│── menu.component.css     # Estilos del componente
│── menu.component.spec.ts # Pruebas unitarias del componente
```

---

## **3. Uso de un componente**

Para usar un componente en otro lugar de la aplicación, agrégalo en la plantilla HTML de otro componente de la siguiente manera:

```html
<app-menu></app-menu>
```

Y asegúrate de que se ha importado en el .ts del componente padre:

```ts
import { MenuComponent } from "./components/menu/menu.component";

@Component({
  ...
  imports: [MenuComponent],
  ...
})
```

El selector del componente está definido en el archivo `menu.component.ts`

```ts
@Component({
  selector: 'app-menu',
  ...
})
```

---

[![Componentes](https://img.youtube.com/vi/K_6ixeC7GbM/0.jpg)](https://www.youtube.com/watch?v=K_6ixeC7GbM&list=PLzA2VyZwsq_9cD3JIxBymaIVyef07PJ-y)

---

## **4. Uso de variables y data-binding en Angular**

### **Variables en un componente**

En Angular, podemos definir variables dentro de la clase del componente para almacenar y manipular datos. Estas variables pueden ser utilizadas en la plantilla para mostrar información o reaccionar a eventos.

Como en Angular trabajamos con TypeScript, todas las variables tienen que estar correctamente tipadas.

[![Tipado de Datos en TypeScript](https://img.youtube.com/vi/r7HrKb2-nDk/0.jpg)](https://www.youtube.com/watch?v=r7HrKb2-nDk&list=PLzA2VyZwsq__tcg5_rW6Ozp4hLYzrtXGX)

Ejemplo de definición de variables en el archivo `menu.component.ts`:

```ts
import { Component } from "@angular/core";

@Component({
  selector: "app-menu",
  templateUrl: "./menu.component.html",
  styleUrls: ["./menu.component.css"],
})
export class MenuComponent {
  title: string = "Menú Principal";
  options: string[] = ["Inicio", "Acerca de", "Contacto"];
}
```

---

### **Data Binding en Angular**

El data-binding en Angular permite sincronizar los datos entre el modelo (clase TypeScript) y la vista (template HTML). Hay cuatro tipos principales de data-binding:

1. **Interpolación (`{{ }}`)**: Se utiliza para mostrar valores dentro de la plantilla HTML.
2. **Binding de propiedad (`[property]`)**: Permite asignar valores a los atributos HTML desde el componente.

---

### **1. Interpolación**

La interpolación permite mostrar valores de variables en el HTML utilizando `{{ }}`.

Ejemplo en `menu.component.html`:

```html
<h1>{{ title }}</h1>
```

En este ejemplo:
`{{ title }}` muestra el valor de la variable `title`.

---

### **2. Binding de propiedad (`[property]`)**

Permite asignar valores dinámicos a propiedades HTML.

Ejemplo en `menu.component.html`:

```html
<img [src]="image" alt="Menú" />
```

Ejemplo en `menu.component.ts`:

```ts
export class MenuComponent {
  image: string = "assets/menu.png";
}
```

Aquí, el valor de `src` en la imagen se obtiene desde la variable `image` del componente.

> Nota: Las imágenes y otros assets se suelen guardar en la carpeta `public` así que las rutas empiezan desde esta carpeta. No es correcto escribir la ruta como `public/assets/imagen.png` hay que escribirla como `assets/imagen.png`.

---

[![Variables en Angular](https://img.youtube.com/vi/8QVG8JA495Q/0.jpg)](https://www.youtube.com/watch?v=8QVG8JA495Q&list=PLzA2VyZwsq_9cD3JIxBymaIVyef07PJ-y)

---

En el siguiente tema veremos cómo trabajar con eventos y con data binding bidireccional usando `ngModel`.
