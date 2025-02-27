# **Ejercicios - Tema 10: Funciones Especiales en JavaScript**

A continuación, encontrarás 5 ejercicios prácticos sobre las funciones especiales en JavaScript.

Intenta resolverlos antes de consultar la solución.

---

### **Ejercicio 1: Retrasar la ejecución de un mensaje con `setTimeout()`**
Escribe una función que muestre el mensaje "Hola, después de 3 segundos" en la consola después de 3 segundos.

<details><summary>Mostrar solución</summary>

```js
function delayedMessage() {
  setTimeout(() => {
    console.log("Hola, después de 3 segundos");
  }, 3000);
}

delayedMessage();
```

</details>

---

### **Ejercicio 2: Contador con `setInterval()`**
Crea una función que inicie un contador en la consola que muestre "Contador: X" cada segundo, y se detenga después de 5 segundos.

<details><summary>Mostrar solución</summary>

```js
function startCounter() {
  let count = 1;
  const intervalId = setInterval(() => {
    console.log(`Contador: ${count}`);
    count++;
    if (count > 5) {
      clearInterval(intervalId);
      console.log("Contador detenido");
    }
  }, 1000);
}

startCounter();
```

</details>

---

### **Ejercicio 3: Cancelar un `setTimeout()` antes de que ocurra**
Escribe un código que inicie un `setTimeout()` para mostrar un mensaje después de 4 segundos, pero que lo cancele en 2 segundos.

<details><summary>Mostrar solución</summary>

```js
function cancelTimeout() {
  const timeoutId = setTimeout(() => {
    console.log("Este mensaje no debería aparecer");
  }, 4000);

  setTimeout(() => {
    clearTimeout(timeoutId);
    console.log("Tiempo cancelado antes de que ocurra");
  }, 2000);
}

cancelTimeout();
```

</details>

---

### **Ejercicio 4: Uso de `requestAnimationFrame()` para una animación simple**
Crea una función que use `requestAnimationFrame()` para incrementar un número en la consola hasta que llegue a 10.

<details><summary>Mostrar solución</summary>

```js
function animateCounter(counter = 1) {
  if (counter > 10) return;
  console.log(`Frame: ${counter}`);
  requestAnimationFrame(() => animateCounter(counter + 1));
}

animateCounter();
```

</details>

---

### **Ejercicio 5: `debounce()` para evitar múltiples llamadas seguidas**
Crea una función `debounce()` que evite que una función se ejecute múltiples veces en un corto período de tiempo. Úsala con una función que imprima un mensaje cuando el usuario "escriba".

<details><summary>Mostrar solución</summary>

```js
function debounce(func, delay) {
  let timer;
  return function(...args) {
    clearTimeout(timer);
    timer = setTimeout(() => func(...args), delay);
  };
}

const onType = debounce(() => console.log("Usuario terminó de escribir"), 500);

onType();
onType();
onType(); // Solo este último se ejecutará después de 500ms
```

</details>

