# **Topic 9: Models and Interfaces in Angular for Object Typing**

## **1. Introduction**

In Angular, the use of **models** and **interfaces** allows you to define clear and secure data structures, facilitating code maintenance and scalability. TypeScript provides tools such as **interfaces** and **classes** to type objects and ensure that data is used consistently.

In this topic you will learn:

- The difference between **interfaces** and **classes** in TypeScript.
- When to use **interfaces** and when to use **classes**.
- How to implement models in an Angular project.

---

## **2. Differences between Interfaces and Classes**

| **Feature** | **Interface** | **Class** |
| --------------------------- | ------------- | --------- |
| Definition of structure | Yes | Yes |
| Logic implementation | No | Yes |
| Generate code in JavaScript | No | Yes |
| Can be instantiated | No | Yes |

**Interfaces** are used to define the form of an object (a model), while **classes** can include additional logic and methods.

---

## **3. Using Interfaces in Angular to create models**

Interfaces in TypeScript allow you to define the shape of an object without including additional logic.

### **Interface Example**

#### **File: `User.ts`**

```ts
export interface User {
  id: number;
  name: string;
  email: string;
  isActive: boolean;
}
```


Used to type objects in a service or component:

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
- **Static typing**: Avoid errors at compile time.

---

[![Models and Interfaces](https://img.youtube.com/vi/Hm9DDImpbNQ/0.jpg)](https://www.youtube.com/watch?v=Hm9DDImpbNQ&list=PLzA2VyZwsq_9cD3JIxBymaIVyef07PJ-y)

---

## **4. Conclusion**

- **Interfaces** allow you to define data structures without generating extra code in JavaScript.
- **classes** allow you to add methods and logic inside objects.
- The choice between **interfaces** and **classes** depends on the use that will be given to them in the application.

---

In the next topic, we will explore **how to use dynamic classes and styles with ngClass**.
