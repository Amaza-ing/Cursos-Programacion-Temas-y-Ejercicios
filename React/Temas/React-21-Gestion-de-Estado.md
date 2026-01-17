# **Tema 21: Gestión de Estado en React**

## **1. Introducción**

A medida que una aplicación crece, también lo hace la cantidad de datos que necesita manejar: inputs, resultados de una API, estado de autenticación, filtros, preferencias del usuario, etc.

En React, **gestionar correctamente el estado** es clave para que la aplicación sea clara, predecible y fácil de mantener.

En este tema aprenderás:

- Qué es el estado y por qué es importante.
- Estado local vs estado compartido.
- Cuándo elevar el estado.
- Patrones comunes de gestión de estado.
- Errores típicos y buenas prácticas.

---

## **2. ¿Qué es el estado?**

El **estado** es la información que:

- Puede cambiar con el tiempo.
- Afecta a lo que se renderiza en pantalla.
- Pertenece a un componente.

Ejemplos de estado:

- El texto de un input.
- Si un modal está abierto o cerrado.
- Los datos obtenidos de una API.
- Si un usuario está autenticado.

En React, el estado se gestiona principalmente con el hook `useState`.

---

## **3. Estado local con `useState`**

El estado local pertenece a **un solo componente**.

```js
import { useState } from "react";

function Counter() {
  const [count, setCount] = useState(0);

  return (
    <div>
      <p>Count: {count}</p>
      <button onClick={() => setCount(count + 1)}>+</button>
    </div>
  );
}

export default Counter;
```

Este estado:

- Solo lo usa `Counter`.
- No se comparte con otros componentes.

---

## **4. Estado compartido: el problema**

Problema típico:

- Dos componentes necesitan el mismo dato.
- Uno lo modifica y el otro lo muestra.

Ejemplo:

- `SearchInput` actualiza un texto.
- `ResultsList` filtra resultados con ese texto.

Si cada uno tiene su propio estado, **no se sincronizan**.

---

## **5. Elevar el estado (lifting state up)**

La solución es **elevar el estado** al componente padre común.

```js
import { useState } from "react";

function App() {
  const [query, setQuery] = useState("");

  return (
    <>
      <SearchInput value={query} onChange={setQuery} />
      <ResultsList query={query} />
    </>
  );
}
```

Aquí:

- El estado vive en el padre.
- Los hijos reciben datos y funciones.

---

## **6. Flujo de datos en React**

React sigue un flujo **unidireccional**:

- El estado baja (props).
- Las acciones suben (callbacks).

Esto hace que:

- El comportamiento sea predecible.
- Sea más fácil depurar errores.

---

## **7. Patrones comunes de gestión de estado**

### **7.1. Un estado por campo**

```js
const [email, setEmail] = useState("");
const [password, setPassword] = useState("");
```

Claro y explícito.

---

### **7.2. Un solo estado para varios campos**

```js
const [form, setForm] = useState({ email: "", password: "" });
```

Útil para formularios grandes.

---

### **7.3. Estado derivado**

Datos que se calculan a partir de otro estado:

```js
const filteredItems = items.filter((item) => item.includes(query));
```

No necesita `useState`.

---

## **8. Estado y efectos**

Cuando el estado cambia:

- El componente se re-renderiza.
- Los `useEffect` que dependan de ese estado se ejecutan.

```js
useEffect(() => {
  console.log("Query changed", query);
}, [query]);
```

---

## **9. Errores típicos**

### **9.1. Duplicar estado**

Guardar el mismo dato en varios sitios.

### **9.2. Estado innecesario**

Usar `useState` para datos derivados.

### **9.3. Pasar demasiadas props (prop drilling)**

Se resolverá más adelante con **Context**.

---

## **10. Buenas prácticas**

- Mantén el estado lo más arriba posible, pero no más.
- Usa estado local cuando solo lo necesite un componente.
- Eleva el estado cuando se comparta.
- Evita duplicar información.

---

En el siguiente tema aprenderás a usar **Context** para compartir estado sin pasar props manualmente.
