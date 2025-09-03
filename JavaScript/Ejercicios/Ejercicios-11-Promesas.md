# **Ejercicios - Tema 11: Asincronía en JavaScript**

A continuación, encontrarás 6 ejercicios prácticos sobre la asincronía en JavaScript.

Intenta resolverlos antes de consultar la solución.

---

### **Ejercicio 1: Crear y Consumir una Promesa**

Crea una promesa llamada `checkWeather` que simule una verificación del clima después de 2 segundos. Si el clima es "soleado", resuelve la promesa con el mensaje "Día perfecto". Si es "lluvioso", recházala con el mensaje "Lleva paraguas".

<details><summary>Mostrar solución</summary>

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

### **Ejercicio 2: Gestionar una Promesa con `async/await`**

Convierte el código de la resolución del ejercicio anterior para que use `async/await` en lugar de `.then()` y `.catch()`.

<details><summary>Mostrar solución</summary>

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

### **Ejercicio 3: Usar `Promise.all()` para varias Promesas**

Crea dos promesas: `fetchUserData` que se resuelve en 1 segundo y `fetchPosts` que se resuelve en 2 segundos. Usa `Promise.all()` para ejecutarlas en paralelo y mostrar los resultados juntos.

<details><summary>Mostrar solución</summary>

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

### **Ejercicio 4: Manejar Errores con `Promise.allSettled()`**

Crea tres promesas: una que se resuelva en 1 segundo, otra que falle en 2 segundos y otra que se resuelva en 3 segundos. Usa `Promise.allSettled()` para manejarlas sin que el fallo detenga la ejecución.

<details><summary>Mostrar solución</summary>

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

### **Ejercicio 5: `setTimeout()` dentro de una Promesa**

Crea una función `delayedMessage` que devuelva una promesa que muestre un mensaje después de 3 segundos.

<details><summary>Mostrar solución</summary>

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

### **Ejercicio 6: `async/await` con `try/catch`**

Crea una función `fetchData` que simule una llamada a una API. Si el parámetro `error` es `true`, debe lanzar un error. Usa `async/await` con `try/catch` para manejar el resultado.

<details><summary>Mostrar solución</summary>

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
