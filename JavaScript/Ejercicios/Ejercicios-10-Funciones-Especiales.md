# **Exercises - Topic 10: Special Functions in JavaScript**

Below you'll find 5 practical exercises on special functions in JavaScript.

Try to solve them before looking at the solution.

---

### **Exercise 1: Delay the execution of a message with `setTimeout()`**

Write a function that displays the message "Hello, after 3 seconds" in the console after 3 seconds.

<details><summary>Show solution</summary>

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

### **Exercise 2: Counter with `setInterval()`**

Create a function that starts a counter in the console, which displays "Counter: X" every second and stops after 5 seconds.

<details><summary>Show solution</summary>

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

### **Exercise 3: Cancel a `setTimeout()` before it fires**

Write code that starts a `setTimeout()` to display a message after 4 seconds, but cancels it after 2 seconds.

<details><summary>Show solution</summary>

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

### **Exercise 4: Using `requestAnimationFrame()` for a simple animation**

Create a function that uses `requestAnimationFrame()` to increment a number in the console until it reaches 10.

<details><summary>Show solution</summary>

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

### **Exercise 5: `debounce()` to avoid multiple calls in a row**

Create a function `debounce()` that prevents a function from running multiple times within a short period of time. Use it with a function that prints a message when the user "types".

<details><summary>Show solution</summary>

```js
function debounce(func, delay) {
  let timer;
  return function (...args) {
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
