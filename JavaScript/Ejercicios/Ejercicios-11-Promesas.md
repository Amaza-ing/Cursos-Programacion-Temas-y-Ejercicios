# **Exercises - Topic 11: Asynchronous JavaScript**

Below you'll find 6 practical exercises on asynchrony in JavaScript.

Try to solve them before looking at the solution.

---

### **Exercise 1: Create and Consume a Promise**

Create a promise called `checkWeather` that simulates a weather check after 2 seconds. If the weather is "sunny", resolve the promise with the message "Perfect day". If it's "rainy", reject it with the message "Take an umbrella".

<details><summary>Show solution</summary>

```js
const checkWeather = new Promise((resolve, reject) => {
  setTimeout(() => {
    const weather = "soleado"; // Cambia a "lluvioso" para probar el rechazo
    weather === "soleado" ? resolve("Día perfecto") : reject("Lleva paraguas");
  }, 2000);
});

checkWeather
  .then((result) => console.log(result))
  .catch((error) => console.log(error));
```

</details>

---

### **Exercise 2: Handle a Promise with `async/await`**

Convert the code from the previous exercise's solution so that it uses `async/await` instead of `.then()` and `.catch()`.

<details><summary>Show solution</summary>

```js
async function getWeather() {
  try {
    const result = await checkWeather;
    console.log(result);
  } catch (error) {
    console.log(error);
  }
}

getWeather();
```

</details>

---

### **Exercise 3: Use `Promise.all()` for multiple Promises**

Create two promises: `fetchUserData`, which resolves in 1 second, and `fetchPosts`, which resolves in 2 seconds. Use `Promise.all()` to run them in parallel and display the results together.

<details><summary>Show solution</summary>

```js
const fetchUserData = new Promise((resolve) =>
  setTimeout(() => resolve("Usuario obtenido"), 1000),
);
const fetchPosts = new Promise((resolve) =>
  setTimeout(() => resolve("Posts cargados"), 2000),
);

async function loadData() {
  const results = await Promise.all([fetchUserData, fetchPosts]);
  console.log(results);
}

loadData();
```

</details>

---

### **Exercise 4: Handling Errors with `Promise.allSettled()`**

Create three promises: one that resolves in 1 second, one that fails in 2 seconds, and one that resolves in 3 seconds. Use `Promise.allSettled()` to handle them without the failure stopping the execution.

<details><summary>Show solution</summary>

```js
const success1 = new Promise((resolve) =>
  setTimeout(() => resolve("Éxito 1"), 1000),
);
const failure = new Promise((_, reject) =>
  setTimeout(() => reject("Error en la segunda promesa"), 2000),
);
const success2 = new Promise((resolve) =>
  setTimeout(() => resolve("Éxito 2"), 3000),
);

async function handlePromises() {
  const results = await Promise.allSettled([success1, failure, success2]);
  console.log(results);
}

handlePromises();
```

</details>

---

### **Exercise 5: `setTimeout()` inside a Promise**

Create a function `delayedMessage` that returns a promise that displays a message after 3 seconds.

<details><summary>Show solution</summary>

```js
function delayedMessage() {
  return new Promise((resolve) => {
    setTimeout(() => {
      resolve("Mensaje mostrado después de 3 segundos");
    }, 3000);
  });
}

async function showMessage() {
  const message = await delayedMessage();
  console.log(message);
}

showMessage();
```

</details>

---

### **Exercise 6: `async/await` with `try/catch`**

Create a function `fetchData` that simulates an API call. If the `error` parameter is `true`, it should throw an error. Use `async/await` with `try/catch` to handle the result.

<details><summary>Show solution</summary>

```js
async function fetchData(error) {
  try {
    if (error) throw new Error("Error en la API");
    return "Datos obtenidos";
  } catch (err) {
    console.log(err.message);
  }
}

fetchData(false); // Salida: "Datos obtenidos"
fetchData(true); // Salida: "Error en la API"
```

</details>
