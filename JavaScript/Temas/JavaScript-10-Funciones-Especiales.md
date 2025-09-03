# **Tema 10: Funciones Especiales en JavaScript**

## **1. Introducción**

JavaScript proporciona una serie de funciones especiales que permiten ejecutar código de manera diferida, repetitiva o en contextos específicos. En este tema exploraremos algunas de las más útiles:

- `setTimeout()`
- `setInterval()`
- `clearTimeout()` y `clearInterval()`
- `requestAnimationFrame()`
- `debounce()` y `throttle()`

---

## **2. `setTimeout()` - Ejecutar código después de un tiempo**

`setTimeout()` permite ejecutar una función después de un tiempo específico (en milisegundos).

### **Ejemplo**

```js
console.log("Inicio");
setTimeout(() => {
  console.log("Esto aparece después de 2 segundos");
}, 2000);
console.log("Fin");
```

**Salida esperada:**

```
Inicio
Fin
Esto aparece después de 2 segundos
```

> **Nota:** La ejecución del script no se detiene mientras se espera el `setTimeout()`.

---

[![setTimeout](https://img.youtube.com/vi/L_KqXlJ1Xic/0.jpg)](https://www.youtube.com/watch?v=L_KqXlJ1Xic&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

## **3. `setInterval()` - Ejecutar código repetidamente**

`setInterval()` permite ejecutar una función de manera repetitiva en un intervalo de tiempo definido.

### **Ejemplo**

```js
let count = 0;
setInterval(() => {
  count++;
  console.log(`Contador: ${count}`);
}, 1000);
```

**Salida esperada:**

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

## **4. `clearTimeout()` y `clearInterval()`**

Tanto `setTimeout()` como `setInterval()` devuelven un identificador que podemos usar para cancelar su ejecución.

- `clearTimeout(id)` cancela la ejecución de un `setTimeout()`.
- `clearInterval(id)` detiene un `setInterval()`.

### **Ejemplo de `clearTimeout()`**

```js
const timeoutId = setTimeout(() => {
  console.log("Esto nunca se ejecutará");
}, 5000);

clearTimeout(timeoutId); // Cancela la ejecución antes de que ocurra
```

### **Ejemplo de `clearInterval()`**

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

## **5. `requestAnimationFrame()` - Optimizar animaciones**

`requestAnimationFrame()` permite ejecutar una función antes del próximo repintado del navegador, optimizando animaciones.

### **Ejemplo**

```js
function animate() {
  console.log("Dibujando frame");
  requestAnimationFrame(animate);
}

requestAnimationFrame(animate); // Llama a la animación continuamente
```

> **Nota:** A diferencia de `setInterval()`, este método se sincroniza con la velocidad de actualización del monitor, evitando renderizados innecesarios.

### **Ejemplo de "videojuego"**

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

## **6. `debounce()` y `throttle()` - Controlar la ejecución de funciones**

### **6.1. `debounce()` - Ejecutar una función después de un tiempo sin eventos**

Se usa para evitar múltiples ejecuciones de una función mientras el usuario sigue interactuando (por ejemplo, escribir en un buscador).

### **Ejemplo**

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

### **6.2. `throttle()` - Limitar la ejecución de una función en intervalos de tiempo**

Se usa para limitar la frecuencia de ejecución de una función (por ejemplo, eventos `scroll`).

### **Ejemplo**

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

## **7. Conclusión**

Estas funciones especiales permiten manejar tiempos de ejecución de código de manera eficiente, desde temporizadores simples hasta optimización de rendimiento en eventos frecuentes.

En el próximo tema definiremos qué es la asincronía y cómo podemos gestionarla usando promesas tanto con la sintaxis clásica como con async/await.
