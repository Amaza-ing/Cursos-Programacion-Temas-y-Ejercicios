# **Tema 11: Asincronía en JavaScript**

## **1. Introducción a la Asincronía**

JavaScript es un lenguaje de programación **single-threaded**, lo que significa que solo puede ejecutar una tarea a la vez en su hilo principal. Sin embargo, muchas veces necesitamos ejecutar tareas que toman tiempo, como solicitar datos de una API o leer archivos. Para manejar estas situaciones sin bloquear la ejecución del código, usamos técnicas asincrónicas.

---

## **2. Manejo de la Asincronía en JavaScript**

En JavaScript, podemos manejar la asincronía de varias maneras:

1. **Callbacks** (primera forma de manejar operaciones asincrónicas)
2. **Promesas** (introducidas en ES6, permiten un mejor control del flujo)
3. **Async/Await** (sintaxis más limpia para manejar promesas, introducida en ES8)

---

[![Qué es la Asincronía](https://img.youtube.com/vi/LZhXXiccCXQ/0.jpg)](https://www.youtube.com/watch?v=LZhXXiccCXQ&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

## **3. Uso de Promesas**

Las **promesas** son objetos que representan un valor que puede estar disponible ahora, en el futuro o nunca. Una promesa tiene tres estados posibles:

- **Pending** (pendiente): La operación aún no ha finalizado.
- **Fulfilled** (resuelta): La operación se completó con éxito.
- **Rejected** (rechazada): La operación falló.

### **3.1. Creación de una Promesa**

Para crear una promesa podemos utilizar `new Promise()` y añadir la lógica que necesitemos dentro del callback que recibe como parámetro.

Aunque habitualmente no vamos a necesitar crear ninguna promesa, únicamente consumirla, viene bien tener una idea de cómo está hecha por dentro.

```js
const myPromise = new Promise((resolve, reject) => {
  setTimeout(() => {
    const success = true; // Simulación de éxito o fallo
    if (success) {
      resolve("Operación exitosa");
    } else {
      reject("Hubo un error");
    }
  }, 2000);
});
```

En este ejemplo se simula la asincronía con un `setTimeout()` haciendo que tarde 2 segundos en resolverse. En un caso real no tendría un tiempo estipulado, sino que se resolvería en cuanto terminase de ejecutar sus procesos, como alguna petición a una API o una consulta a una base de datos.

---

[![Qué es una Promesa](https://img.youtube.com/vi/VcO04YuoglM/0.jpg)](https://www.youtube.com/watch?v=VcO04YuoglM&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

### **3.2. Consumir una Promesa con `.then()` y `.catch()`**

Consumir una promesa es lo verdaderamente importante. Existen varias sintaxis para ello.

En la sintaxis de `.then()` necesitamos pasarle un callback que se ejecutará cuando la promesa se resuelva, y otro callback al método `.catch()` que se ejecutará sólo si la promesa falla.

```js
myPromise
  .then((result) => {
    console.log(result); // "Operación exitosa"
  })
  .catch((error) => {
    console.log(error); // "Hubo un error"
  });
```

Si el `.then()` devuelve a su vez una promesa, podemos anidar tantos como haga falta. En estos casos sólo sería necesario un único `.catch()` que puede capturar un error en cualquiera de las promesas anteriores.

```js
myPromise
  .then((result) => {
    return anotherPromise;
  })
  .then((result) => {
    return oneMorePromise;
  })
  .then((result) => {
    console.log("Execution finished");
    console.log(result);
  })
  .catch((error) => {
    console.log(error); // "Hubo un error"
  });
```

### **3.3. `finally()` en Promesas**

El método `.finally()` se ejecuta siempre, independientemente del resultado de la promesa.

```js
myPromise
  .then((result) => console.log(result))
  .catch((error) => console.log(error))
  .finally(() => console.log("Operación completada"));
```

---

[![Consumir una Promesa con .then](https://img.youtube.com/vi/-Ax2L0YzT4I/0.jpg)](https://www.youtube.com/watch?v=-Ax2L0YzT4I&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

## **4. Uso de `async/await`**

La sintaxis `async/await` permite manejar promesas de forma más clara y estructurada, como si fueran código síncrono.

### **4.1. Definir una función asíncrona**

Para usar `await`, la función debe declararse con `async`.

```js
async function fetchData() {
  return "Datos obtenidos";
}
```

Esta función devuelve automáticamente una promesa.

### **4.2. Esperar la resolución de una Promesa con `await`**

Como medida de seguridad debemos encerrar nuestro código en un bloque "try/catch" donde se ejecutará todo lo que hay dentro del `try{}` mientras no haya problemas y únicamente se ejecutará el `catch(error){}` si algo falla.

```js
async function getData() {
  try {
    const result = await myPromise;
    console.log(result); // "Operación exitosa"
  } catch (error) {
    console.log(error); // "Hubo un error"
  } finally {
    console.log("Proceso finalizado");
  }
}

getData();
```

En este ejemplo no se ejecutará la linea `console.log(result);` hasta que la linea anterior no haya terminado de resolver su ejecución, ya que tiene un await.

---

[![Consumir una Promesa con .then](https://img.youtube.com/vi/o1bvYWMmrCI/0.jpg)](https://www.youtube.com/watch?v=o1bvYWMmrCI&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

## **5. Ejecutar Promesas en Paralelo con `Promise.all()`**

`Promise.all()` permite ejecutar varias promesas simultáneamente y esperar a que todas se resuelvan.

```js
const promise1 = new Promise((resolve) =>
  setTimeout(() => resolve("Resultado 1"), 1000),
);
const promise2 = new Promise((resolve) =>
  setTimeout(() => resolve("Resultado 2"), 2000),
);

async function executePromises() {
  const results = await Promise.all([promise1, promise2]);
  console.log(results); // ["Resultado 1", "Resultado 2"]
}

executePromises();
```

En este ejemplo sólo se tardaría 2 segundos en resolver todas las promesas, mientras que si no usamos el `Promise.all()` y lo hiciéramos una detrás de otra tardaríamos 3 segundos, porque no se iniciaría la segunda promesa hasta que no se hubiese resuelto la primera.

---

## **6. Ejecutar Promesas en Secuencia con `Promise.allSettled()`**

A diferencia de `Promise.all()`, `Promise.allSettled()` espera que todas las promesas finalicen, sin importar si fueron resueltas o rechazadas.

```js
const failingPromise = new Promise((_, reject) =>
  setTimeout(() => reject("Fallo"), 1500),
);

async function executeAllSettled() {
  const results = await Promise.allSettled([promise1, failingPromise]);
  console.log(results);
}

executeAllSettled();
```

---

## **7. Conclusión**

- **Las promesas** permiten manejar operaciones asincrónicas sin anidaciones excesivas.
- **Async/Await** simplifica la lectura y escritura del código asincrónico.
- **Métodos como `Promise.all()` y `Promise.allSettled()`** permiten gestionar múltiples promesas eficientemente.

Manejar la asincronía correctamente en JavaScript es clave para mejorar el rendimiento y evitar bloqueos en la ejecución del código.

En el próximo tema veremos cómo podemos hacer peticiones a una API utilizando el método fetch y promesas.
