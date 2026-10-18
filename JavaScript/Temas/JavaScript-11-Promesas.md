# **Topic 11: Asynchrony in JavaScript**

## **1. Introduction to Asynchrony**

JavaScript is a **single-threaded** programming language, which means that it can only execute one task at a time in its main thread. However, many times we need to execute tasks that take time, such as requesting data from an API or reading files. To handle these situations without blocking code execution, we use asynchronous techniques.

---

## **2. Handling Asynchrony in JavaScript**

In JavaScript, we can handle asynchrony in several ways:

1. **Callbacks** (first way to handle asynchronous operations)
2. **Promises** (introduced in ES6, allow better flow control)
3. **Async/Await** (cleaner syntax for handling promises, introduced in ES8)

---

[![What is Asynchrony](https://img.youtube.com/vi/LZhXXiccCXQ/0.jpg)](https://www.youtube.com/watch?v=LZhXXiccCXQ&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

## **3. Use of Promises**

**Promises** are objects that represent value that may be available now, in the future, or never. A promise has three possible states:

- **Pending**: The operation has not finished yet.
- **Fulfilled** (resolved): The operation was completed successfully.
- **Rejected**: The operation failed.

### **3.1. Creating a Promise**

To create a promise we can use `new Promise()` and add the logic we need within the callback that it receives as a parameter.

Although usually we will not need to create any promise, only consume it, it is good to have an idea of how it is made inside.

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

This example simulates the asynchrony with an `setTimeout()` making it take 2 seconds to resolve. In a real case it would not have a stipulated time, but would be resolved as soon as it finished executing its processes, such as a request to an API or a query to a database.

---

[![What is a Promise](https://img.youtube.com/vi/VcO04YuoglM/0.jpg)](https://www.youtube.com/watch?v=VcO04YuoglM&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

### **3.2. Consume a Promise with `.then()` and `.catch()`**

Consuming a promise is what is truly important. There are several syntaxes for this.

In the `.then()` syntax we need to pass a callback that will be executed when the promise resolves, and another callback to the `.catch()` method that will be executed only if the promise fails.

```js
myPromise
  .then((result) => {
    console.log(result); // "Operación exitosa"
  })
  .catch((error) => {
    console.log(error); // "Hubo un error"
  });
```

If the `.then()` returns a promise, we can nest as many as necessary. In these cases you would only need a single `.catch()` that can catch an error in any of the above promises.

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

### **3.3. `finally()` in Promises**

The `.finally()` method is always executed, regardless of the result of the promise.

```js
myPromise
  .then((result) => console.log(result))
  .catch((error) => console.log(error))
  .finally(() => console.log("Operación completada"));
```

---

[![Consume a Promise with .then](https://img.youtube.com/vi/-Ax2L0YzT4I/0.jpg)](https://www.youtube.com/watch?v=-Ax2L0YzT4I&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

## **4. Using `async/await`**

The `async/await` syntax allows you to handle promises in a clearer and more structured way, as if they were synchronous code.

### **4.1. Define an asynchronous function**

To use `await`, the function must be declared with `async`.

```js
async function fetchData() {
  return "Datos obtenidos";
}
```

This function automatically returns a promise.

### **4.2. Wait for the resolution of a Promise with `await`**
As a security measure we must enclose our code in a "try/catch" block where everything inside the `try{}` will be executed as long as there are no problems and only the `catch(error){}` will be executed if something fails.

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

In this example, the `console.log(result);` line will not be executed until the previous line has finished resolving its execution, since it has an await.

---

[![Consume a Promise with .then](https://img.youtube.com/vi/o1bvYWMmrCI/0.jpg)](https://www.youtube.com/watch?v=o1bvYWMmrCI&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

## **5. Execute Promises in Parallel with `Promise.all()`**

`Promise.all()` allows you to execute multiple promises simultaneously and wait for them all to resolve.

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

In this example it would only take 2 seconds to resolve all the promises, while if we did not use the `Promise.all()` and did it one after the other it would take 3 seconds, because the second promise would not be started until the first had been resolved.

---

## **6. Execute Promises in Sequence with `Promise.allSettled()`**

Unlike `Promise.all()`, `Promise.allSettled()` waits for all promises to finish, regardless of whether they were resolved or rejected.

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

- **Promises** allow asynchronous operations to be handled without excessive nesting.
- **Async/Await** simplifies reading and writing asynchronous code.
- **Methods like `Promise.all()` and `Promise.allSettled()`** allow multiple promises to be managed efficiently.

Handling asynchrony correctly in JavaScript is key to improving performance and avoiding code execution crashes.

In the next topic we will see how we can make requests to an API using the fetch method and promises.
