# **Topic 5: Signals and Reactivity in Angular 19**

## **1. Introduction**

Angular 19 introduces a new reactivity mechanism based on **Signals**. Signals make state management more efficient and predictable compared to traditional approaches such as `RxJS` and `ChangeDetectionStrategy.OnPush`.

In this topic, you will learn:

- What Signals are and why they were introduced.
- How to use them to manage state in Angular.
- How Signals compare with other reactivity methods.
- Use cases and best practices.

---

## **2. What are Signals in Angular?**

**Signals** are a new reactivity model in Angular that allows more granular control over the data flow in the application. They are pure functions that let you:

- **Automatically propagate changes** without the need for manual `ChangeDetection`.
- **Minimize performance impact** by avoiding unnecessary UI changes.
- **Simplify state management** without the need for complex subscriptions.

A basic Signal example in Angular:

```ts
import { signal } from "@angular/core";

export class CounterComponent {
  count = signal(0);

  increment() {
    this.count.set(this.count() + 1);
  }
}
```


```html
<p>{{ count() }}</p>
```


In this example:

- `signal(0)` creates a reactive value with an initial state of `0`.
- `.set()` updates the Signal's value.
- `this.count()` gives you access to the current value of the Signal.
- `{{ count() }}` displays the value in the HTML document

---

## **3. Operations with Signals**

### **3.1. Reading and writing**

- **Reading**: You access a Signal's value by calling it like a function: `count()`.
- **Writing**: You can update the value with `.set(nuevoValor)` or modify it with `.update(fn)`.

An update example:

```ts
this.count.set(10); // Fija el valor en 10
this.count.update((value) => value + 1); // Incrementa en 1
```


### **3.2. Computed Signals**

**Computed Signals** let you define derived values that are automatically recalculated when their dependencies change.

Example:

```ts
import { signal, computed } from "@angular/core";

export class CartComponent {
  price = signal(100);
  quantity = signal(2);
  total = computed(() => this.price() * this.quantity());
}
```


In this case, `total()` will always reflect the multiplication of `price` and `quantity`, without the need for additional logic.

### **3.3. Effects in Signals**

**Effects** let you run code when a Signal's value changes. They are useful for side effects such as HTTP requests or DOM manipulation.

Example:

```ts
import { effect, signal } from "@angular/core";

export class LoggerComponent {
  message = signal("Inicializando...");

  constructor() {
    effect(() => {
      console.log(`Mensaje cambiado: ${this.message()}`);
    });
  }
}
```


Every time `message` changes, the effect runs automatically.

---

## **4. Comparison: Signals vs. RxJS vs. ChangeDetection**

| **Feature** | **Signals** | **RxJS (BehaviorSubject)** | **ChangeDetectionStrategy.OnPush** |
| ---------------------- | ----------- | -------------------------- | ---------------------------------- |
| Reactivity | Automatic | Based on observables | Based on change detection |
| Simplicity | High | Medium | Medium |
| Performance | Very high | Depends on subscriptions | High |
| Subscriptions needed | No | Yes | No |

---

## **5. Best practices and recommendations**

1. **Use Signals for data that changes frequently** in the UI (e.g., counters, dynamic forms).
2. **Don't mix Signals and RxJS unnecessarily**. Use one or the other depending on the use case.
3. **Optimize with `computed()`** to avoid unnecessary calculations.
4. **Avoid side effects inside Computed Signals**. Use `effect()` for derived logic.

---

## **6. Conclusion**

- **Signals** in Angular 19 offer a more efficient and clearer reactivity model.
- They are a lightweight alternative to `RxJS` for managing state.
- They reduce the need for `ChangeDetectionStrategy.OnPush`, improving performance.
- They make state management easier without the need for manual subscriptions.

---

In the next topic, we will explore **communication between parent and child components with input and output**.
