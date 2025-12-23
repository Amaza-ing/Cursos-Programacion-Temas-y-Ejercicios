# **Ejercicios - Tema 6: Eventos en React**

A continuación, encontrarás **10 ejercicios prácticos** sobre eventos en React.

Intenta resolverlos antes de consultar la solución.

---

## **Ejercicio 1: Botón con `onClick`**

Crea un componente `ClickCounter.jsx` con un botón que al hacer click muestre en consola: **"Button clicked"**.

<details><summary>Mostrar Solución</summary>

```js
function ClickCounter() {
  const handleClick = () => {
    console.log("Button clicked");
  };

  return <button onClick={handleClick}>Click me</button>;
}

export default ClickCounter;
```

</details>

---

## **Ejercicio 2: Corregir el evento escrito como en HTML**

Este código está escrito como si fuera HTML tradicional. Corrígelo para React:

```js
function App() {
  return <button onclick="handleClick()">Click</button>;
}
```

<details><summary>Mostrar Solución</summary>

En React, se usa `onClick` y se pasa una función:

```js
function App() {
  const handleClick = () => {
    console.log("Clicked");
  };

  return <button onClick={handleClick}>Click</button>;
}

export default App;
```

</details>

---

## **Ejercicio 3: Pasar parámetros sin ejecutar al renderizar**

Crea un componente `MessageButtons.jsx` con dos botones:

- Uno que envíe el mensaje **"Hello"**.
- Otro que envíe el mensaje **"Goodbye"**.

Al hacer click, debe mostrarse el mensaje con `alert`.

<details><summary>Mostrar Solución</summary>

```js
function MessageButtons() {
  const handleMessage = (text) => {
    alert(text);
  };

  return (
    <div>
      <button onClick={() => handleMessage("Hello")}>Send Hello</button>
      <button onClick={() => handleMessage("Goodbye")}>Send Goodbye</button>
    </div>
  );
}

export default MessageButtons;
```

</details>

---

## **Ejercicio 4: Capturar texto de un input con `onChange`**

Crea un componente `LiveInput.jsx` con un input que:

- En cada cambio muestre en consola el texto que escribe el usuario.

<details><summary>Mostrar Solución</summary>

```js
function LiveInput() {
  const handleChange = (event) => {
    console.log(event.target.value);
  };

  return <input onChange={handleChange} placeholder="Type here" />;
}

export default LiveInput;
```

</details>

---

## **Ejercicio 5: Evento `onMouseEnter` y `onMouseLeave`**

Crea un componente `HoverLogger.jsx` con un `div` que:

- Al entrar el ratón muestre: **"Mouse entered"** en consola.
- Al salir el ratón muestre: **"Mouse left"** en consola.

<details><summary>Mostrar Solución</summary>

```js
function HoverLogger() {
  const handleEnter = () => {
    console.log("Mouse entered");
  };

  const handleLeave = () => {
    console.log("Mouse left");
  };

  return (
    <div onMouseEnter={handleEnter} onMouseLeave={handleLeave}>
      Hover area
    </div>
  );
}

export default HoverLogger;
```

</details>

---

## **Ejercicio 6: `onSubmit` con `preventDefault()`**

Crea un componente `NewsletterForm.jsx` con un formulario que tenga:

- Un input con `name="email"`.
- Un botón de tipo submit.

Cuando se envíe el formulario:

- Evita la recarga con `preventDefault()`.
- Muestra en consola: **"Form submitted"**.

<details><summary>Mostrar Solución</summary>

```js
function NewsletterForm() {
  const handleSubmit = (event) => {
    event.preventDefault();
    console.log("Form submitted");
  };

  return (
    <form onSubmit={handleSubmit}>
      <input name="email" placeholder="Email" />
      <button type="submit">Subscribe</button>
    </form>
  );
}

export default NewsletterForm;
```

</details>

---

## **Ejercicio 7: Obtener el valor de un input en `onSubmit`**

Crea un componente `SimpleSearchForm.jsx` con:

- Un `form`.
- Un `input` con `name="query"`.
- Un botón submit.

Al enviar:

- Usa `preventDefault()`.
- Muestra en consola el texto del input usando `event.target`.

<details><summary>Mostrar Solución</summary>

```js
function SimpleSearchForm() {
  const handleSubmit = (event) => {
    event.preventDefault();

    const query = event.target.query.value;
    console.log(query);
  };

  return (
    <form onSubmit={handleSubmit}>
      <input name="query" placeholder="Search" />
      <button type="submit">Search</button>
    </form>
  );
}

export default SimpleSearchForm;
```

</details>

---

## **Ejercicio 8: Evitar una llamada incorrecta del handler**

Este código ejecuta la función al renderizar. Corrígelo:

```js
function App() {
  const handleClick = () => alert("Hi");

  return <button onClick={handleClick()}>Click</button>;
}
```

<details><summary>Mostrar Solución</summary>

En React debes pasar la función, no llamarla:

```js
function App() {
  const handleClick = () => alert("Hi");

  return <button onClick={handleClick}>Click</button>;
}

export default App;
```

</details>

---

## **Ejercicio 9: Crear handlers con nombres correctos**

Reescribe este componente usando nombres de handlers más recomendables:

```js
function App() {
  const click = () => console.log("clicked");

  return <button onClick={click}>Ok</button>;
}
```

<details><summary>Mostrar Solución</summary>

```js
function App() {
  const handleClick = () => {
    console.log("clicked");
  };

  return <button onClick={handleClick}>Ok</button>;
}

export default App;
```

</details>

---

## **Ejercicio 10: Mini-caso práctico (elige la solución correcta)**

Quieres que un botón llame a una función `handleSelect` pasando el texto `"Option A"`.

¿Cuál es la opción correcta?

1.

```js
<button onClick={handleSelect("Option A")}>Select</button>
```

2.

```js
<button onClick={() => handleSelect("Option A")}>Select</button>
```

3.

```js
<button onclick={() => handleSelect("Option A")}>Select</button>
```

<details><summary>Mostrar Solución</summary>

La opción correcta es la **2**:

```js
<button onClick={() => handleSelect("Option A")}>Select</button>
```

Motivo:

- `onClick` debe ir en camelCase.
- Para pasar parámetros, necesitas una función que se ejecute al hacer click.

</details>

---
