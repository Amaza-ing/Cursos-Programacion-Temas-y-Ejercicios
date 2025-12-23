# **Ejercicios - Tema 14: useEffect()**

A continuación, encontrarás **10 ejercicios prácticos** sobre `useEffect()`.

Intenta resolverlos antes de consultar la solución.

---

## **Ejercicio 1: Efecto al montar (solo una vez)**

Crea un componente `MountLogger.jsx` que al montarse muestre en consola:

- **"Component mounted"**

Debe ejecutarse **solo una vez**.

<details><summary>Mostrar Solución</summary>

```js
import { useEffect } from "react";

function MountLogger() {
  useEffect(() => {
    console.log("Component mounted");
  }, []);

  return <p>MountLogger</p>;
}

export default MountLogger;
```

</details>

---

## **Ejercicio 2: Efecto al cambiar una variable**

Crea un componente `TitleWatcher.jsx` con:

- Estado `title` inicial `""`.
- Un input controlado.
- Un `useEffect` que muestre en consola: **"Title changed"** cada vez que cambie `title`.

<details><summary>Mostrar Solución</summary>

```js
import { useEffect, useState } from "react";

function TitleWatcher() {
  const [title, setTitle] = useState("");

  useEffect(() => {
    console.log("Title changed");
  }, [title]);

  return (
    <div>
      <input
        value={title}
        onChange={(event) => setTitle(event.target.value)}
        placeholder="Title"
      />
    </div>
  );
}

export default TitleWatcher;
```

</details>

---

## **Ejercicio 3: `setInterval` con cleanup**

Crea un componente `Stopwatch.jsx` que:

- Tenga estado `seconds` inicial `0`.
- Use un `setInterval` para incrementar `seconds` cada 1 segundo.
- Limpie el intervalo al desmontar el componente.

<details><summary>Mostrar Solución</summary>

```js
import { useEffect, useState } from "react";

function Stopwatch() {
  const [seconds, setSeconds] = useState(0);

  useEffect(() => {
    const intervalId = setInterval(() => {
      setSeconds((prevSeconds) => prevSeconds + 1);
    }, 1000);

    return () => {
      clearInterval(intervalId);
    };
  }, []);

  return <p>Seconds: {seconds}</p>;
}

export default Stopwatch;
```

</details>

---

## **Ejercicio 4: Listener de `resize` con cleanup**

Crea un componente `WindowWidth.jsx` que:

- Guarde en estado `width` el valor `window.innerWidth`.
- Añada un listener a `window` para el evento `resize`.
- Actualice `width` al redimensionar.
- Limpie el listener al desmontar.

<details><summary>Mostrar Solución</summary>

```js
import { useEffect, useState } from "react";

function WindowWidth() {
  const [width, setWidth] = useState(window.innerWidth);

  useEffect(() => {
    const handleResize = () => {
      setWidth(window.innerWidth);
    };

    window.addEventListener("resize", handleResize);

    return () => {
      window.removeEventListener("resize", handleResize);
    };
  }, []);

  return <p>Width: {width}px</p>;
}

export default WindowWidth;
```

</details>

---

## **Ejercicio 5: Guardar estado en `localStorage`**

Crea un componente `NoteSaver.jsx` con:

- Estado `note` inicial `""`.
- Un `textarea` controlado.
- Un `useEffect` que guarde `note` en `localStorage` con la clave `"note"` **cada vez que cambie**.

<details><summary>Mostrar Solución</summary>

```js
import { useEffect, useState } from "react";

function NoteSaver() {
  const [note, setNote] = useState("");

  useEffect(() => {
    localStorage.setItem("note", note);
  }, [note]);

  return (
    <textarea
      value={note}
      onChange={(event) => setNote(event.target.value)}
      placeholder="Write a note"
    />
  );
}

export default NoteSaver;
```

</details>

---

## **Ejercicio 6: Leer `localStorage` al montar**

Crea un componente `NoteLoader.jsx` que:

- Tenga estado `note` inicial `""`.
- Al montar, lea `localStorage.getItem("note")`.
- Si existe, lo guarde en el estado.
- Renderice un `p` con `note`.

<details><summary>Mostrar Solución</summary>

```js
import { useEffect, useState } from "react";

function NoteLoader() {
  const [note, setNote] = useState("");

  useEffect(() => {
    const savedNote = localStorage.getItem("note");
    if (savedNote) {
      setNote(savedNote);
    }
  }, []);

  return <p>{note}</p>;
}

export default NoteLoader;
```

</details>

---

## **Ejercicio 7: Corregir dependencias (bug típico)**

Este componente tiene un bug: el efecto usa `query`, pero el array de dependencias está vacío. Corrígelo.

```js
import { useEffect, useState } from "react";

function SearchLogger() {
  const [query, setQuery] = useState("");

  useEffect(() => {
    console.log("Searching:", query);
  }, []);

  return <input value={query} onChange={(e) => setQuery(e.target.value)} />;
}

export default SearchLogger;
```

<details><summary>Mostrar Solución</summary>

```js
import { useEffect, useState } from "react";

function SearchLogger() {
  const [query, setQuery] = useState("");

  useEffect(() => {
    console.log("Searching:", query);
  }, [query]);

  return <input value={query} onChange={(e) => setQuery(e.target.value)} />;
}

export default SearchLogger;
```

</details>

---

## **Ejercicio 8: Evitar bucle infinito (actualización dentro del efecto)**

Este componente entra en un bucle porque actualiza estado en un `useEffect` que se ejecuta tras cada render. Corrígelo para que solo se ejecute al montar.

```js
import { useEffect, useState } from "react";

function InitFlag() {
  const [ready, setReady] = useState(false);

  useEffect(() => {
    setReady(true);
  });

  return <p>Ready: {ready ? "Yes" : "No"}</p>;
}

export default InitFlag;
```

<details><summary>Mostrar Solución</summary>

```js
import { useEffect, useState } from "react";

function InitFlag() {
  const [ready, setReady] = useState(false);

  useEffect(() => {
    setReady(true);
  }, []);

  return <p>Ready: {ready ? "Yes" : "No"}</p>;
}

export default InitFlag;
```

</details>

---

## **Ejercicio 9: `setTimeout` con cleanup**

Crea un componente `AutoHideMessage.jsx` que:

- Tenga estado `visible` inicial `true`.
- Muestre un `p` con **"Saved"** solo si `visible` es `true`.
- Al montar, programe un `setTimeout` para poner `visible` en `false` tras 2 segundos.
- Limpie el timeout en el cleanup.

<details><summary>Mostrar Solución</summary>

```js
import { useEffect, useState } from "react";

function AutoHideMessage() {
  const [visible, setVisible] = useState(true);

  useEffect(() => {
    const timeoutId = setTimeout(() => {
      setVisible(false);
    }, 2000);

    return () => {
      clearTimeout(timeoutId);
    };
  }, []);

  return <div>{visible && <p>Saved</p>}</div>;
}

export default AutoHideMessage;
```

</details>

---

## **Ejercicio 10: Efecto con función async (patrón recomendado)**

Crea un componente `UserLoader.jsx` que simule una carga asíncrona:

- Estado `status` con valores: `"idle"`, `"loading"`, `"done"`.
- Al montar:

  - Poner `status` en `"loading"`.
  - Esperar 1 segundo.
  - Poner `status` en `"done"`.

Pista: no hagas `async` directamente en el callback de `useEffect`, crea una función dentro.

<details><summary>Mostrar Solución</summary>

```js
import { useEffect, useState } from "react";

function UserLoader() {
  const [status, setStatus] = useState("idle");

  useEffect(() => {
    const run = async () => {
      setStatus("loading");
      await new Promise((resolve) => setTimeout(resolve, 1000));
      setStatus("done");
    };

    run();
  }, []);

  return <p>Status: {status}</p>;
}

export default UserLoader;
```

</details>
