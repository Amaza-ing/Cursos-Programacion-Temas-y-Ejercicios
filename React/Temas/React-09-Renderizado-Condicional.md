# **Tema 9: Renderizado Condicional**

## **1. Introducción**

En una interfaz real, no siempre se muestra todo:

- A veces hay un loader mientras cargan datos.
- A veces aparece un mensaje de error.
- A veces se muestra un botón u otro según el estado.

En React, esto se consigue con **renderizado condicional**: decidir qué JSX se renderiza en función de una condición.

En este tema aprenderás:

- Condicionales con `if`.
- Condicionales con operador ternario.
- Renderizado condicional con `&&`.
- Buenas prácticas para mantener el código limpio.

---

## **2. La idea base: condiciones dentro de JSX**

En React, dentro de JSX puedes usar expresiones JavaScript con `{}`.

Pero recuerda:

- `if` no se puede poner directamente dentro del JSX como una sentencia.
- Sí puedes usar operadores o preparar variables antes del `return`.

---

## **3. Renderizado condicional con `if` (antes del return)**

Cuando la condición es compleja, es común usar `if` antes del `return`.

Ejemplo: mostrar un loader.

```js
function Page() {
  const isLoading = true;

  if (isLoading) {
    return <p>Loading...</p>;
  }

  return <h2>Content loaded</h2>;
}

export default Page;
```

Esto se usa mucho en:

- Pantallas que dependen de datos
- Estados de loading
- Estados de error

---

## **4. Renderizado condicional con ternario**

El operador ternario es muy útil cuando quieres escoger entre **dos opciones**.

```js
function StatusText() {
  const isOnline = false;

  return <p>{isOnline ? "Online" : "Offline"}</p>;
}

export default StatusText;
```

Puedes usarlo también para renderizar bloques de JSX:

```js
function Welcome() {
  const isLoggedIn = true;

  return (
    <div>{isLoggedIn ? <h2>Welcome back</h2> : <h2>Please sign in</h2>}</div>
  );
}

export default Welcome;
```

---

## **5. Renderizado condicional con `&&`**

Si solo quieres renderizar algo cuando la condición sea `true`, puedes usar `&&`.

```js
function Warning() {
  const hasWarning = true;

  return (
    <div>
      <h3>Dashboard</h3>
      {hasWarning && <p>Action required</p>}
    </div>
  );
}

export default Warning;
```

Si `hasWarning` es `false`, React no renderiza nada en esa parte.

---

## **6. Condiciones con valores “falsy” (detalle importante)**

En JavaScript, estos valores son “falsy”:

- `false`
- `0`
- `""` (string vacío)
- `null`
- `undefined`
- `NaN`

Esto importa porque con `&&`:

- Si la parte izquierda es `0`, React puede renderizar `0`.

Ejemplo:

```js
const count = 0;
return <div>{count && <p>Count is {count}</p>}</div>;
```

Aquí se renderiza `0`, lo cual suele ser un comportamiento no deseado.

Solución típica: usar una condición más explícita:

```js
{
  count > 0 && <p>Count is {count}</p>;
}
```

---

## **7. Guardar JSX en variables para mejorar legibilidad**

Si un `return` se llena de condiciones, puedes guardar JSX en una variable.

```js
function Result() {
  const status = "success";

  let message = null;

  if (status === "success") {
    message = <p>Success</p>;
  } else if (status === "error") {
    message = <p>Error</p>;
  }

  return (
    <div>
      <h3>Status</h3>
      {message}
    </div>
  );
}

export default Result;
```

---

## **8. Buenas prácticas**

- Para dos opciones claras, usa ternario.
- Para “mostrar si se cumple”, usa `&&`.
- Para condiciones complejas, usa `if` antes del return.
- Evita JSX demasiado anidado.
- Si el JSX se vuelve difícil de leer, extrae componentes.

---

## **9. A tener en cuenta**

- Renderizado condicional = decidir qué JSX se muestra según una condición.
- Técnicas principales:

  - `if` antes del `return`
  - ternario `cond ? A : B`
  - `cond && A`

- Ojo con `0 && ...` porque puede renderizar `0`.

---

[![Renderizado Condicional](https://img.youtube.com/vi/183eqNQNz3U/0.jpg)](https://www.youtube.com/watch?v=183eqNQNz3U&list=PLzA2VyZwsq_-dE3Jvunglxq8a6UcH6gnF)

---

En el próximo tema veremos **Listas**, para renderizar colecciones de elementos usando `.map()`.
