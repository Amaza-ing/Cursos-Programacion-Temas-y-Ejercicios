# **Tema 9: Modelos e Interfaces en Angular para el Tipado de Objetos**

## **1. Introducción**

En Angular, el uso de **modelos** e **interfaces** permite definir estructuras de datos claras y seguras, facilitando el mantenimiento y la escalabilidad del código. TypeScript ofrece herramientas como **interfaces** y **clases** para tipar objetos y garantizar que los datos sean utilizados de forma consistente.

En este tema aprenderás:

- La diferencia entre **interfaces** y **clases** en TypeScript.
- Cuándo usar **interfaces** y cuándo usar **clases**.
- Cómo implementar modelos en un proyecto Angular.

---

## **2. Diferencias entre Interfaces y Clases**

| **Característica**          | **Interface** | **Clase** |
| --------------------------- | ------------- | --------- |
| Definición de estructura    | Sí            | Sí        |
| Implementación de lógica    | No            | Sí        |
| Genera código en JavaScript | No            | Sí        |
| Se puede instanciar         | No            | Sí        |

Las **interfaces** se usan para definir la forma de un objeto (un modelo), mientras que las **clases** pueden incluir lógica adicional y métodos.

---

## **3. Uso de Interfaces en Angular para crear modelos**

Las interfaces en TypeScript permiten definir la forma de un objeto sin incluir lógica adicional.

### **Ejemplo de Interface**

#### **Archivo: `User.ts`**

```ts
export interface User {
  id: number;
  name: string;
  email: string;
  isActive: boolean;
}
```

Se usa para tipar objetos en un servicio o componente:

#### **Archivo: `user.component.ts`**

```ts
import { User } from "../models/User";

export class UserComponent {
  getUser(): User {
    return {
      id: 1,
      name: "Juan",
      email: "juan@email.com",
      isActive: true,
    };
  }
}
```

Ventajas de las interfaces:

- **Claridad**: Separa la estructura de los datos de la lógica.
- **Tipado estático**: Evita errores en tiempo de compilación.

---

[![Modelos e Interfaces](https://img.youtube.com/vi/Hm9DDImpbNQ/0.jpg)](https://www.youtube.com/watch?v=Hm9DDImpbNQ&list=PLzA2VyZwsq_9cD3JIxBymaIVyef07PJ-y)

---

## **4. Conclusión**

- Las **interfaces** permiten definir estructuras de datos sin generar código extra en JavaScript.
- Las **clases** permiten agregar métodos y lógica dentro de los objetos.
- La elección entre **interfaces** y **clases** depende del uso que se les dará en la aplicación.

---

En el próximo tema, exploraremos **cómo usar clases y estilos dinámicos con ngClass**.
