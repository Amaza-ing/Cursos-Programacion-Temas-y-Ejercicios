# **Tema 14: useEffect()**

## **1. Introducción**

Hasta ahora hemos usado `useState` para guardar datos y actualizar la interfaz. Pero hay situaciones en las que un componente necesita hacer “cosas extra” además de renderizar:

- Pedir datos a una API.
- Leer o escribir en `localStorage`.
- Configurar un `setInterval` o un `setTimeout`.
- Suscribirse a eventos (por ejemplo, `resize` de ventana).

A este tipo de acciones React las llama **efectos** (_effects_). El hook principal para gestionarlos es **`useEffect`**.

En este tema aprenderás:

- Qué es un efecto.
- Cómo funciona `useEffect`.
- Qué significa la lista de dependencias.
- Cómo ejecutar un efecto:

  - Solo al montar.
  - Cada vez que cambia una variable.
  - Con limpieza (_cleanup_).

---

## **2. ¿Qué es un “efecto”?**

Un efecto es cualquier lógica que:

- No pertenece directamente al render.
- Interactúa con algo “externo” al componente.

Regla mental muy útil:

- **Render**: genera JSX.
- **Efecto**: hace trabajo “secundario” que ocurre después de renderizar.

---

## **3. Sintaxis básica de `useEffect`**

Primero, lo importas:

```js
import { useEffect } from "react";
```

Luego lo usas con una función:

```js
useEffect(() => {
  console.log("Effect runs");
});
```

Importante:

- Si no pones dependencias, se ejecuta **después de cada render**.

---

## **4. Dependencias: el segundo argumento**

`useEffect` puede recibir un segundo argumento: un array de dependencias.

```js
useEffect(() => {
  // effect
}, [dependencyA, dependencyB]);
```

Ese array le dice a React:

- “Solo vuelve a ejecutar este efecto si cambia alguna de estas variables”.

---

## **5. Ejecutar un efecto solo al montar (equivalente a “on mount”)**

Si quieres que un efecto se ejecute solo **una vez**, al montar el componente, usa un array vacío:

```js
import { useEffect } from "react";

function App() {
  useEffect(() => {
    console.log("Mounted");
  }, []);

  return <h2>App</h2>;
}

export default App;
```

Este patrón se usa mucho para:

- Cargar datos al inicio.
- Inicializar algo una sola vez.

---

## **6. Ejecutar un efecto cuando cambia una variable**

Si pones una dependencia, el efecto se ejecuta:

- Al montar, y
- Cada vez que cambia esa dependencia.

Ejemplo:

```js
import { useEffect, useState } from "react";

function CounterWatcher() {
  const [count, setCount] = useState(0);

  useEffect(() => {
    console.log("Count changed:", count);
  }, [count]);

  return (
    <button onClick={() => setCount((prevCount) => prevCount + 1)}>Add</button>
  );
}

export default CounterWatcher;
```

---

## **7. Cleanup: limpiar un efecto**

Algunos efectos crean “suscripciones” o timers. En esos casos hay que limpiar cuando:

- El componente se desmonta.
- Antes de volver a ejecutar el efecto.

La limpieza se hace devolviendo una función dentro del `useEffect`.

### **7.1. Ejemplo: `setInterval` con cleanup**

```js
import { useEffect, useState } from "react";

function Timer() {
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

export default Timer;
```

Sin cleanup, el interval seguiría funcionando incluso si el componente desaparece.

---

## **8. Caso típico: leer/escribir en `localStorage`**

Un caso práctico muy común:

- Al montar: leer un valor guardado.
- Cuando cambie el estado: guardarlo.

Ejemplo:

```js
import { useEffect, useState } from "react";

function ThemeSaver() {
  const [theme, setTheme] = useState("light");

  useEffect(() => {
    const storedTheme = localStorage.getItem("theme");
    if (storedTheme) {
      setTheme(storedTheme);
    }
  }, []);

  useEffect(() => {
    localStorage.setItem("theme", theme);
  }, [theme]);

  return (
    <div>
      <p>Theme: {theme}</p>
      <button
        onClick={() =>
          setTheme((prevTheme) => (prevTheme === "light" ? "dark" : "light"))
        }
      >
        Toggle
      </button>
    </div>
  );
}

export default ThemeSaver;
```

---

## **9. Errores típicos**

### **9.1. Olvidar dependencias**

Si usas variables dentro del efecto, normalmente deberían estar en el array de dependencias.

```js
useEffect(() => {
  console.log(query);
}, [query]);
```

### **9.2. Hacer “trabajo de render” dentro del efecto**

El efecto no es para generar JSX, sino para lógica secundaria.

---

## **10. Buenas prácticas**

- Usa `[]` si solo quieres ejecutar al montar.
- Añade dependencias cuando el efecto dependa de estado/props.
- Si creas timers o listeners, devuelve un cleanup.
- Mantén los efectos pequeños y con una responsabilidad clara.

---

## **11. A tener en cuenta**

- `useEffect` se ejecuta **después** del render.
- Sin dependencias: se ejecuta tras cada render.
- Con `[]`: solo al montar.
- Con `[x]`: al montar y cuando cambie `x`.
- El cleanup evita fugas y comportamientos inesperados.

---

En el próximo tema veremos **Fetch API**, para pedir datos a una API y combinarlos con `useEffect`.
