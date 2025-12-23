# **Tema 6: Eventos en React**

## **1. Introducción**

En una aplicación real, el usuario interactúa continuamente con la interfaz:

- Hace clic en botones
- Escribe en inputs
- Envía formularios
- Pasa el ratón por encima de elementos

En React, estas interacciones se gestionan con **eventos**. Aprender a manejar eventos es el primer paso para que tus componentes pasen de ser “estáticos” a ser **interactivos**.

En este tema aprenderás:

- Cómo se escriben los eventos en React.
- Cómo crear funciones manejadoras.
- Cómo usar parámetros.
- Cómo usar el objeto del evento.
- Diferencias importantes con HTML.

---

## **2. ¿Cómo se escriben los eventos en React?**

En React, los eventos se escriben usando:

- Propiedades en **camelCase**: `onClick`, `onChange`, `onSubmit`, etc.
- Se les pasa una **función**, no un string.

Ejemplo:

```js
function App() {
  const handleClick = () => {
    alert("Clicked!");
  };

  return <button onClick={handleClick}>Click</button>;
}

export default App;
```

Aquí:

- `onClick={handleClick}` le pasa una función a React.
- La función se ejecuta cuando el usuario hace clic.

---

## **3. Funciones manejadoras (handlers)**

La convención más común es nombrarlas con `handle...`:

- `handleClick`
- `handleChange`
- `handleSubmit`

Ejemplo:

```js
function LikeButton() {
  const handleLike = () => {
    console.log("Like!");
  };

  return <button onClick={handleLike}>Like</button>;
}

export default LikeButton;
```

---

## **4. Pasar parámetros a una función en un evento**

Si quieres pasar parámetros, no debes llamar a la función directamente.

Incorrecto (se ejecuta al renderizar):

```js
<button onClick={handleMessage("Hello")}>Send</button>
```

Correcto (se ejecuta al hacer click):

```js
<button onClick={() => handleMessage("Hello")}>Send</button>
```

Ejemplo completo:

```js
function MessageButton() {
  const handleMessage = (text) => {
    alert(text);
  };

  return <button onClick={() => handleMessage("Hello")}>Send</button>;
}

export default MessageButton;
```

---

## **5. El objeto del evento (`event`)**

React te pasa automáticamente el objeto del evento al handler.

Ejemplo con `onChange` en un input:

```js
function Search() {
  const handleChange = (event) => {
    console.log(event.target.value);
  };

  return <input onChange={handleChange} placeholder="Search..." />;
}

export default Search;
```

Aquí:

- `event.target.value` contiene lo que el usuario está escribiendo.

---

## **6. Eventos comunes en React**

Algunos de los más utilizados:

- `onClick`: clic
- `onChange`: cambio en inputs, selects y textareas
- `onSubmit`: envío de formularios
- `onMouseEnter`: el ratón entra en un elemento
- `onMouseLeave`: el ratón sale

Ejemplo rápido con `onMouseEnter`:

```js
function HoverBox() {
  const handleEnter = () => {
    console.log("Mouse enter");
  };

  return <div onMouseEnter={handleEnter}>Hover me</div>;
}

export default HoverBox;
```

---

## **7. Prevenir el comportamiento por defecto (`preventDefault`)**

En formularios, el navegador intenta recargar la página al enviar.

En React, normalmente se evita usando `event.preventDefault()`:

```js
function SimpleForm() {
  const handleSubmit = (event) => {
    event.preventDefault();
    console.log("Form submitted");
  };

  return (
    <form onSubmit={handleSubmit}>
      <button type="submit">Submit</button>
    </form>
  );
}

export default SimpleForm;
```

---

## **8. Diferencias importantes con HTML**

En HTML tradicional podrías ver:

```html
<button onclick="doSomething()">Click</button>
```

En React no se hace así. En React:

- No usas strings.
- No escribes `onclick` en minúsculas.
- Usas `onClick` y pasas una función.

Ejemplo correcto:

```js
<button onClick={doSomething}>Click</button>
```

---

## **9. Buenas prácticas**

- Nombra handlers con `handle...`.
- Si pasas parámetros, usa una arrow function.
- Usa `preventDefault()` en `onSubmit`.
- Mantén la lógica del handler simple (ya la complejidad se organizará más adelante con estado y hooks).

---

## **10. A tener en cuenta**

- Los eventos en React se escriben en camelCase.
- Los handlers reciben el objeto `event`.
- Para pasar parámetros, usa `() => ...`.
- Para formularios, recuerda `preventDefault()`.

---

En el próximo tema veremos **useState**, que nos permitirá guardar información en el componente y actualizar la UI cuando cambie.
