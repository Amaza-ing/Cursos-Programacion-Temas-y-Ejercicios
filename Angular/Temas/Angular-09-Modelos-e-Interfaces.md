# **Topic 9: Models and Interfaces in Angular for Object Typing**

## **1. Introduction**

In Angular, using **models** and **interfaces** lets you define clear and safe data structures, making code easier to maintain and scale. TypeScript provides tools such as **interfaces** and **classes** to type objects and ensure that data is used consistently.

In this topic, you will learn:

- The difference between **interfaces** and **classes** in TypeScript.
- When to use **interfaces** and when to use **classes**.
- How to implement models in an Angular project.

---

## **2. Differences between interfaces and classes**

| **Feature** | **Interface** | **Class** |
| --------------------------- | ------------- | --------- |
| Structure definition | Yes | Yes |
| Logic implementation | No | Yes |
| Generates JavaScript code | No | Yes |
| Can be instantiated | No | Yes |

**Interfaces** are used to define the shape of an object (a model), while **classes** can include additional logic and methods.

---

## **3. Using interfaces in Angular to create models**

Interfaces in TypeScript allow you to define the shape of an object without including additional logic.

### **Interface example**

#### **File: `User.ts`**

```ts
export interface User {
  id: number;
  name: string;
  email: string;
  isActive: boolean;
}
```


It is used to type objects in a service or component:

#### **File: `user.component.ts`**

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


Advantages of interfaces:

- **Clarity**: Separates data structure from logic.
- **Static typing**: Prevents errors at compile time.

---

[![Models and Interfaces](https://img.youtube.com/vi/Hm9DDImpbNQ/0.jpg)](https://www.youtube.com/watch?v=Hm9DDImpbNQ&list=PLzA2VyZwsq_9cD3JIxBymaIVyef07PJ-y)

---

## **4. Conclusion**

- **Interfaces** let you define data structures without generating extra JavaScript code.
- **Classes** let you add methods and logic inside objects.
- The choice between **interfaces** and **classes** depends on how they will be used in the application.

---

In the next topic, we will explore **how to use dynamic classes and styles with ngClass**.
