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
  500
);

logMessage(); // Se ejecutará después de 500ms si no hay más llamadas
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
  1000
);

logThrottle();
```

---

## **7. Conclusión**

Estas funciones especiales permiten manejar tiempos de ejecución de código de manera eficiente, desde temporizadores simples hasta optimización de rendimiento en eventos frecuentes.

En el próximo tema definiremos qué es la asincronía y cómo podemos gestionarla usando promesas tanto con la sintaxis clásica como con async/await.
