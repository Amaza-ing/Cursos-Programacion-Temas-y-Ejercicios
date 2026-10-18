# **Topic 11: Asynchronous JavaScript**

## **1. Introduction to asynchrony**

JavaScript is a **single-threaded** programming language, which means it can only run one task at a time on its main thread. However, we often need to run tasks that take time, such as requesting data from an API or reading files. To handle these situations without blocking the execution of the code, we use asynchronous techniques.

---

## **2. Handling asynchrony in JavaScript**

In JavaScript, we can handle asynchrony in several ways:

1. **Callbacks** (the first way of handling asynchronous operations)
2. **Promises** (introduced in ES6, they allow better control flow)
3. **Async/Await** (cleaner syntax for handling promises, introduced in ES8)

---

[![What is asynchrony](https://img.youtube.com/vi/LZhXXiccCXQ/0.jpg)](https://www.youtube.com/watch?v=LZhXXiccCXQ&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

## **3. Using promises**

**Promises** are objects that represent a value that may be available now, in the future or never. A promise has three possible states:

- **Pending**: The operation hasn't finished yet.
- **Fulfilled** (resolved): The operation was completed successfully.
- **Rejected**: The operation failed.

### **3.1. Creating a promise**

To create a promise, we can use `new Promise()` and add the logic we need inside the callback it receives as a parameter.

Although we usually won't need to create a promise, only consume it, it's good to have an idea of how it's built inside.

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

This example simulates asynchrony with a `setTimeout()` that makes it take 2 seconds to resolve. In a real case, it wouldn't have a set time: it would resolve as soon as it finished running its processes, such as a request to an API or a database query.

---

[![What is a promise](https://img.youtube.com/vi/VcO04YuoglM/0.jpg)](https://www.youtube.com/watch?v=VcO04YuoglM&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

### **3.2. Consuming a promise with `.then()` and `.catch()`**

Consuming a promise is what really matters. There are several syntaxes for this.

With the `.then()` syntax, we need to pass it a callback that will run when the promise resolves, and pass another callback to the `.catch()` method that will run only if the promise fails.

```js
myPromise
  .then((result) => {
    console.log(result); // "Operación exitosa"
  })
  .catch((error) => {
    console.log(error); // "Hubo un error"
  });
```

If the `.then()` returns a promise in turn, we can chain as many as we need. In these cases, you'd only need a single `.catch()`, which can catch an error in any of the previous promises.

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

### **3.3. `finally()` in promises**

The `.finally()` method always runs, regardless of the result of the promise.

```js
myPromise
  .then((result) => console.log(result))
  .catch((error) => console.log(error))
  .finally(() => console.log("Operación completada"));
```

---

[![Consuming a promise with .then](https://img.youtube.com/vi/-Ax2L0YzT4I/0.jpg)](https://www.youtube.com/watch?v=-Ax2L0YzT4I&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

## **4. Using `async/await`**

The `async/await` syntax lets you handle promises in a clearer, more structured way, as if they were synchronous code.

### **4.1. Defining an asynchronous function**

To use `await`, the function must be declared with `async`.

```js
async function fetchData() {
  return "Datos obtenidos";
}
```

This function automatically returns a promise.

### **4.2. Waiting for a promise to resolve with `await`**
As a safety measure, we should wrap our code in a "try/catch" block: everything inside the `try{}` will run as long as there are no problems, and the `catch(error){}` will run only if something fails.

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

In this example, the line `console.log(result);` won't run until the previous line has finished resolving, since it has an await.

---

[![Consuming a promise with async/await](https://img.youtube.com/vi/o1bvYWMmrCI/0.jpg)](https://www.youtube.com/watch?v=o1bvYWMmrCI&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

## **5. Running promises in parallel with `Promise.all()`**

`Promise.all()` lets you run several promises simultaneously and wait for all of them to resolve.

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

In this example, it would take only 2 seconds to resolve all the promises, whereas if we didn't use `Promise.all()` and ran them one after the other, it would take 3 seconds, because the second promise wouldn't start until the first one had resolved.

---

## **6. Waiting for all promises with `Promise.allSettled()`**

Unlike `Promise.all()`, `Promise.allSettled()` waits for all the promises to finish, regardless of whether they were resolved or rejected.

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

## **7. Conclusion**

- **Promises** let you handle asynchronous operations without excessive nesting.
- **Async/Await** makes asynchronous code easier to read and write.
- **Methods like `Promise.all()` and `Promise.allSettled()`** let you manage multiple promises efficiently.

Handling asynchrony correctly in JavaScript is key to improving performance and keeping your code from blocking.

In the next topic, we'll see how to make requests to an API using the fetch method and promises.
