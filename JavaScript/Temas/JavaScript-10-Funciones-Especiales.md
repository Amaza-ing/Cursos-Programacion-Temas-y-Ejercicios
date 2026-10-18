# **Topic 10: Special Functions in JavaScript**

## **1. Introduction**

JavaScript provides a number of special functions that let you run code with a delay, repeatedly or in specific contexts. In this topic, we'll explore some of the most useful ones:

- `setTimeout()`
- `setInterval()`
- `clearTimeout()` and `clearInterval()`
- `requestAnimationFrame()`
- `debounce()` and `throttle()`

---

## **2. `setTimeout()` - Run code after a while**

`setTimeout()` lets you run a function after a specific amount of time (in milliseconds).

### **Example**

```js
console.log("Inicio");
setTimeout(() => {
  console.log("Esto aparece después de 2 segundos");
}, 2000);
console.log("Fin");
```

**Expected output:**

```
Inicio
Fin
Esto aparece después de 2 segundos
```

> **Note:** The script doesn't stop running while it waits for the `setTimeout()`.

---

[![setTimeout](https://img.youtube.com/vi/L_KqXlJ1Xic/0.jpg)](https://www.youtube.com/watch?v=L_KqXlJ1Xic&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

## **3. `setInterval()` - Run code repeatedly**

`setInterval()` lets you run a function repeatedly at a set time interval.

### **Example**

```js
let count = 0;
setInterval(() => {
  count++;
  console.log(`Contador: ${count}`);
}, 1000);
```

**Expected output:**

```
Contador: 1
Contador: 2
Contador: 3
Contador: 4
Contador: 5
...
```

---

[![setInterval](https://img.youtube.com/vi/tf22mwQKawQ/0.jpg)](https://www.youtube.com/watch?v=tf22mwQKawQ&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

## **4. `clearTimeout()` and `clearInterval()`**

Both `setTimeout()` and `setInterval()` return an identifier that we can use to cancel their execution.

- `clearTimeout(id)` cancels the execution of a `setTimeout()`.
- `clearInterval(id)` stops a `setInterval()`.

### **`clearTimeout()` example**

```js
const timeoutId = setTimeout(() => {
  console.log("Esto nunca se ejecutará");
}, 5000);

clearTimeout(timeoutId); // Cancela la ejecución antes de que ocurra
```

### **`clearInterval()` example**

```js
const interval = setInterval(() => {
  console.log("Esto no se repetirá para siempre");
}, 1000);

setTimeout(() => {
  clearInterval(interval);
  console.log("Intervalo detenido");
}, 4000);
```

---

## **5. `requestAnimationFrame()` - Optimize animations**

`requestAnimationFrame()` lets you run a function before the browser's next repaint, which optimizes animations.

### **Example**

```js
function animate() {
  console.log("Dibujando frame");
  requestAnimationFrame(animate);
}

requestAnimationFrame(animate); // Llama a la animación continuamente
```

> **Note:** Unlike `setInterval()`, this method syncs with the monitor's refresh rate, avoiding unnecessary rendering.

### **"Video game" example**

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
    <script defer src="./a.js"></script>
  </head>
  <style>
    body {
      margin: 0;
    }

    #box {
      width: 100px;
      height: 100px;
      background-color: blue;
    }
  </style>
  <body>
    <div id="box"></div>
  </body>
</html>
```

```js
const box = document.getElementById("box"); // Elemento a animar
let positionX = 0; // Posición en X
let positionY = 0; // Posición en Y
const speed = 5; // Velocidad del movimiento

const keys = {
  ArrowUp: false,
  ArrowDown: false,
  ArrowLeft: false,
  ArrowRight: false,
};

// Detectar cuándo una tecla es presionada
document.addEventListener("keydown", (event) => {
  if (keys.hasOwnProperty(event.key)) {
    keys[event.key] = true;
  }
});

// Detectar cuándo una tecla es soltada
document.addEventListener("keyup", (event) => {
  if (keys.hasOwnProperty(event.key)) {
    keys[event.key] = false;
  }
});

// Función de animación
function animate() {
  if (keys.ArrowUp) positionY -= speed;
  if (keys.ArrowDown) positionY += speed;
  if (keys.ArrowLeft) positionX -= speed;
  if (keys.ArrowRight) positionX += speed;

  // Restringimos los límites para que no se salga de la pantalla
  positionX = Math.max(0, Math.min(window.innerWidth - 100, positionX));
  positionY = Math.max(0, Math.min(window.innerHeight - 100, positionY));

  box.style.transform = `translate(${positionX}px, ${positionY}px)`;

  requestAnimationFrame(animate); // Continuar la animación
}

// Iniciar la animación
requestAnimationFrame(animate);
```

---

## **6. `debounce()` and `throttle()` - Control the execution of functions**

### **6.1. `debounce()` - Run a function after a period of time without events**

It's used to prevent a function from running multiple times while the user is still interacting (for example, typing in a search box).

### **Example**

```js
function debounce(func, delay) {
  let timer;
  return function (...args) {
    clearTimeout(timer);
    timer = setTimeout(() => func(...args), delay);
  };
}

const logMessage = debounce(
  () => console.log("Ejecutado después de escribir"),
  500,
);

// Detectar cuándo una tecla es presionada
document.addEventListener("keydown", logMessage);
```

### **6.2. `throttle()` - Limit how often a function runs within time intervals**

It's used to limit how often a function runs (for example, on `scroll` events).

### **Example**

```js
function throttle(func, limit) {
  let lastCall = 0;
  return function (...args) {
    const now = Date.now();
    if (now - lastCall >= limit) {
      lastCall = now;
      func(...args);
    }
  };
}

const logThrottle = throttle(
  () => console.log("Ejecutado con limitación"),
  1000,
);

logThrottle(); // Se ejecuta inmediatamente
logThrottle(); // Se ignora si se llama antes de 1 segundo
setTimeout(logThrottle, 1100); // Se ejecuta después de 1.1 segundos

// Ejemplos comunes:

window.addEventListener(
  "scroll",
  throttle(() => {
    console.log("Scrolling...");
  }, 500),
); // Sólo se ejecutará como máximo cada 500 ms

window.addEventListener(
  "resize",
  throttle(() => {
    console.log("Ventana redimensionada");
  }, 1000),
); // Sólo se ejecutará cada segundo

const button = document.querySelector("#btn");
button.addEventListener(
  "click",
  throttle(() => {
    console.log("Botón clickeado");
  }, 2000),
); // Sólo permite un clic cada 2 segundos
```

---

## **7. Conclusion**

These special functions let you control when your code runs efficiently, from simple timers to optimizing performance on frequent events.

In the next topic, we'll define what asynchrony is and how we can handle it using promises, both with the classic syntax and with async/await.
