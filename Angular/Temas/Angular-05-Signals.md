# **Tema 5: Signals y Reactividad en Angular 19**

## **1. Introducción**

En Angular 19, se introduce un nuevo mecanismo de reactividad basado en **Signals**. Las Signals permiten gestionar el estado de manera más eficiente y predecible en comparación con los enfoques tradicionales como `RxJS` y `ChangeDetectionStrategy.OnPush`.

En este tema, aprenderás:

- Qué son las Signals y por qué se han introducido.
- Cómo utilizarlas para gestionar el estado en Angular.
- Comparación entre Signals y otros métodos de reactividad.
- Casos de uso y buenas prácticas.

---

## **2. ¿Qué son las Signals en Angular?**

Las **Signals** son un nuevo modelo de reactividad en Angular que permiten un control más granular sobre el flujo de datos en la aplicación. Son funciones puras que permiten:

- **Propagar cambios automáticamente** sin necesidad de `ChangeDetection` manual.
- **Minimizar el impacto en el rendimiento** evitando cambios innecesarios en la UI.
- **Simplificar la gestión del estado** sin necesidad de suscripciones complejas.

Ejemplo básico de Signal en Angular:

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

En este ejemplo:

- `signal(0)` crea un valor reactivo con un estado inicial de `0`.
- `.set()` actualiza el valor de la Signal.
- `this.count()` permite acceder al valor actual de la Signal.
- `{{ count() }}` muestra el valor en el documento HTML

---

## **3. Operaciones con Signals**

### **3.1. Lectura y Escritura**

- **Lectura**: Se accede al valor de una Signal llamándola como una función `count()`.
- **Escritura**: Se puede actualizar el valor con `.set(nuevoValor)` o modificarlo con `.update(fn)`.

Ejemplo de actualización:

```ts
this.count.set(10); // Fija el valor en 10
this.count.update((value) => value + 1); // Incrementa en 1
```

### **3.2. Computed Signals**

Las **Computed Signals** permiten definir valores derivados que se recalculan automáticamente cuando cambian sus dependencias.

Ejemplo:

```ts
import { signal, computed } from "@angular/core";

export class CartComponent {
  price = signal(100);
  quantity = signal(2);
  total = computed(() => this.price() * this.quantity());
}
```

En este caso, `total()` siempre reflejará la multiplicación de `price` y `quantity`, sin necesidad de lógica adicional.

### **3.3. Effects en Signals**

Los **Effects** permiten ejecutar código cuando una Signal cambia de valor. Son útiles para efectos secundarios como peticiones HTTP o manipulación del DOM.

Ejemplo:

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

Cada vez que `message` cambia, el efecto se ejecuta automáticamente.

---

## **4. Comparación: Signals vs. RxJS vs. ChangeDetection**

| **Característica**     | **Signals** | **RxJS (BehaviorSubject)** | **ChangeDetectionStrategy.OnPush** |
| ---------------------- | ----------- | -------------------------- | ---------------------------------- |
| Reactividad            | Automática  | Basada en observables      | Basada en detección de cambios     |
| Simplicidad            | Alta        | Media                      | Media                              |
| Rendimiento            | Muy alto    | Depende de suscripciones   | Alto                               |
| Necesita suscripciones | No          | Sí                         | No                                 |

---

## **5. Buenas prácticas y recomendaciones**

1. **Usar Signals para datos que cambian frecuentemente** en la UI (por ejemplo, contadores, formularios dinámicos).
2. **No mezclar Signals y RxJS sin necesidad**. Usa uno u otro dependiendo del caso de uso.
3. **Optimizar con `computed()`** para evitar cálculos innecesarios.
4. **Evitar efectos secundarios dentro de Computed Signals**. Usa `effect()` para lógica derivada.

---

## **6. Conclusión**

- Las **Signals** en Angular 19 ofrecen un modelo de reactividad más eficiente y claro.
- Son una alternativa ligera a `RxJS` para gestionar el estado.
- Reducen la necesidad de `ChangeDetectionStrategy.OnPush`, mejorando el rendimiento.
- Facilitan la gestión del estado sin necesidad de suscripciones manuales.

---

En el próximo tema, exploraremos **la comunicación entre componentes padre-hijo con input y output**.
