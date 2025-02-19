# **Ejercicios - Tema 9: Modelos e Interfaces en Angular**

## **Instrucciones:**
A continuación, encontrarás ejercicios sobre el uso de interfaces y modelos en Angular.

Intenta resolverlos antes de consultar la solución.

---

### **Ejercicio 1: Crear un Modelos para un objeto que represente a un Producto**
Define una interfaz `Product` con los siguientes atributos:
- `id: number`
- `name: string`
- `price: number`
- `isAvailable: boolean`

<details><summary>Mostrar solución</summary>

#### **Archivo: `Product.ts`**
```ts
export interface Product {
  id: number;
  name: string;
  price: number;
  isAvailable: boolean;
}
```
</details>

---

### **Ejercicio 2: Usar una Interface en un Componente**
Crea un método en un componente que retorne un producto basado en la interfaz `Product`.

<details><summary>Mostrar solución</summary>

#### **Archivo: `product.component.ts`**
```ts
import { Product } from '../models/Product';

export class ProductComponent {
  getProduct(): Product {
    return {
      id: 1,
      name: 'Computer',
      price: 1000,
      isAvailable: true
    };
  }
}
```
</details>
