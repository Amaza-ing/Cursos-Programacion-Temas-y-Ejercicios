# **Exercises - Topic 9: Models and Interfaces in Angular**

## **Instructions:**

Below you will find exercises on using interfaces and models in Angular.

Try to solve them before consulting the solution.

---

### **Exercise 1: Create a Model for an object that represents a Product**

Defines an `Product` interface with the following attributes:

- `id: number`
- `name: string`
- `price: number`
- `isAvailable: boolean`

<details><summary>Show solution</summary>

#### **File: `Product.ts`**

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

### **Exercise 2: Using an Interface in a Component**

Create a method on a component that returns a product based on the `Product` interface.

<details><summary>Show solution</summary>

#### **File: `product.component.ts`**

```ts
import { Product } from "../models/Product";

export class ProductComponent {
  getProduct(): Product {
    return {
      id: 1,
      name: "Computer",
      price: 1000,
      isAvailable: true,
    };
  }
}
```


</details>
