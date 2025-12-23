# **Tema 7: useState**

## **1. Introducción**

Hasta ahora hemos creado componentes y hemos gestionado eventos, pero todavía falta una pieza clave: **guardar información dentro del componente** y hacer que la interfaz se actualice cuando esa información cambie.

En React, esto se hace con **estado (state)**. El hook más importante para comenzar es `useState`.

En este tema aprenderás:

- Qué es el estado y por qué no sirve una variable normal.
- Cómo usar `useState`.
- Cómo actualizar el estado correctamente.
- Casos típicos: contador, toggle e input controlado.

---

## **2. ¿Qué es el estado en React?**

El **estado** es información que:

- Pertenece a un componente.
- Puede cambiar con el tiempo.
- Cuando cambia, React **re-renderiza** el componente para actualizar la UI.

Ejemplos de estado:

- Contador de likes
- Texto escrito en un input
- Si un menú está abierto o cerrado

---

## **3. Por qué una variable normal no funciona**

Mira este ejemplo:

```js
function Counter() {
  let count = 0;

  const handleClick = () => {
    count = count + 1;
    console.log(count);
  };

  return <button onClick={handleClick}>Count: {count}</button>;
}

export default Counter;
```

Aquí pasa algo importante:

- `count` cambia en consola.
- Pero la UI no se actualiza.

Esto ocurre porque React **no re-renderiza** el componente cuando cambias una variable normal.

---

## **4. Crear estado con `useState`**

`useState` es un hook que devuelve:

- El valor del estado.
- Una función para actualizarlo.

### **4.1. Importar `useState`**

```js
import { useState } from "react";
```

### **4.2. Sintaxis básica**

```js
const [count, setCount] = useState(0);
```

- `count` es el valor actual.
- `setCount` es la función para actualizarlo.
- `useState(0)` define el valor inicial.

---

## **5. Ejemplo 1: Contador**

```js
import { useState } from "react";

function Counter() {
  const [count, setCount] = useState(0);

  const handleClick = () => {
    setCount(count + 1);
  };

  return <button onClick={handleClick}>Count: {count}</button>;
}

export default Counter;
```

Aquí sí ocurre lo que queremos:

- Al hacer click, `setCount` actualiza el estado.
- React re-renderiza el componente.
- La UI muestra el nuevo valor.

---

## **6. Actualización segura con función (muy importante)**

A veces, React puede agrupar actualizaciones. Para evitar problemas, es muy recomendable usar la forma funcional:

```js
setCount((prevCount) => prevCount + 1);
```

Ejemplo:

```js
import { useState } from "react";

function Counter() {
  const [count, setCount] = useState(0);

  const handleClick = () => {
    setCount((prevCount) => prevCount + 1);
  };

  return <button onClick={handleClick}>Count: {count}</button>;
}

export default Counter;
```

Esta forma es más segura porque siempre usa el valor más reciente.

---

## **7. Ejemplo 2: Toggle (true/false)**

```js
import { useState } from "react";

function Toggle() {
  const [isOpen, setIsOpen] = useState(false);

  const handleToggle = () => {
    setIsOpen((prevIsOpen) => !prevIsOpen);
  };

  return (
    <div>
      <button onClick={handleToggle}>Toggle</button>
      <p>Open: {isOpen ? "Yes" : "No"}</p>
    </div>
  );
}

export default Toggle;
```

Aquí, el estado `isOpen` cambia entre `true` y `false`.

---

## **8. Ejemplo 3: Input controlado**

Un input controlado es aquel cuyo valor viene del estado.

```js
import { useState } from "react";

function NameInput() {
  const [name, setName] = useState("");

  const handleChange = (event) => {
    setName(event.target.value);
  };

  return (
    <div>
      <input value={name} onChange={handleChange} placeholder="Your name" />
      <p>Hello, {name}</p>
    </div>
  );
}

export default NameInput;
```

Aquí:

- `value={name}` hace que el input dependa del estado.
- `onChange` actualiza el estado.
- La UI se actualiza automáticamente.

---

## **9. Buenas prácticas con `useState`**

- Nombra el estado de forma clara: `count`, `isOpen`, `name`.
- Nombra el setter como `set...`: `setCount`, `setIsOpen`.
- Para actualizar basado en el valor anterior, usa la forma funcional.
- Evita modificar directamente el estado.

---

## **10. A tener en cuenta**

- El estado es lo que hace que React sea reactivo.
- `useState` te permite guardar y actualizar estado.
- Cambiar estado con el setter provoca re-render.
- Para updates basados en el valor anterior, usa `setState((prev) => ...)`.

---

En el próximo tema veremos **Atributos Reactivos**, para conectar estado con atributos HTML (por ejemplo `disabled`, `value`, `checked`).
