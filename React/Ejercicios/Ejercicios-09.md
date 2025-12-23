# **Ejercicios - Tema 9: Renderizado Condicional**

A continuación, encontrarás **10 ejercicios prácticos** sobre renderizado condicional en React.

Intenta resolverlos antes de consultar la solución.

---

## **Ejercicio 1: Loader con `if` antes del return**

Crea un componente `DataBlock.jsx` con una variable `isLoading = true`. Si está cargando, debe devolver **solo**:

- `p` con el texto: **"Loading data..."**

Si no está cargando, debe devolver:

- `div` con `h3` **"Data Ready"**

<details><summary>Mostrar Solución</summary>

```js
function DataBlock() {
  const isLoading = true;

  if (isLoading) {
    return <p>Loading data...</p>;
  }

  return (
    <div>
      <h3>Data Ready</h3>
    </div>
  );
}

export default DataBlock;
```

</details>

---

## **Ejercicio 2: Ternario para mostrar un mensaje de acceso**

Crea un componente `AccessMessage.jsx` con una variable `hasAccess = false`.

- Si `hasAccess` es `true`, muestra: **"Access granted"**
- Si `hasAccess` es `false`, muestra: **"Access denied"**

Hazlo con un ternario dentro de un `p`.

<details><summary>Mostrar Solución</summary>

```js
function AccessMessage() {
  const hasAccess = false;

  return <p>{hasAccess ? "Access granted" : "Access denied"}</p>;
}

export default AccessMessage;
```

</details>

---

## **Ejercicio 3: Renderizar un aviso solo si hay error (`&&`)**

Crea un componente `ErrorNotice.jsx` con una variable `hasError = true`.

- Siempre muestra un `h3` con: **"Profile"**
- Solo si `hasError` es `true`, muestra un `p` con: **"Something went wrong"**

<details><summary>Mostrar Solución</summary>

```js
function ErrorNotice() {
  const hasError = true;

  return (
    <div>
      <h3>Profile</h3>
      {hasError && <p>Something went wrong</p>}
    </div>
  );
}

export default ErrorNotice;
```

</details>

---

## **Ejercicio 4: Bloques grandes con ternario (dos secciones)**

Crea un componente `AuthPanel.jsx` con `isLoggedIn = true`.

- Si está logueado, renderiza un `div` con:

  - `h2` **"Dashboard"**
  - `p` **"Welcome back"**

- Si no está logueado, renderiza un `div` con:

  - `h2` **"Login"**
  - `p` **"Please sign in"**

<details><summary>Mostrar Solución</summary>

```js
function AuthPanel() {
  const isLoggedIn = true;

  return (
    <div>
      {isLoggedIn ? (
        <div>
          <h2>Dashboard</h2>
          <p>Welcome back</p>
        </div>
      ) : (
        <div>
          <h2>Login</h2>
          <p>Please sign in</p>
        </div>
      )}
    </div>
  );
}

export default AuthPanel;
```

</details>

---

## **Ejercicio 5: Evitar el problema de `0 && ...`**

Crea un componente `CartCount.jsx` con `itemsCount = 0`.

- Solo debe mostrar `p` con **"Items: 0"** cuando `itemsCount > 0`.
- Si `itemsCount` es 0, no debe renderizar nada en esa parte (y no debe aparecer el `0` suelto).

<details><summary>Mostrar Solución</summary>

```js
function CartCount() {
  const itemsCount = 0;

  return (
    <div>
      <h3>Cart</h3>
      {itemsCount > 0 && <p>Items: {itemsCount}</p>}
    </div>
  );
}

export default CartCount;
```

</details>

---

## **Ejercicio 6: Guardar JSX en una variable**

Crea un componente `PaymentStatus.jsx` con una variable `status = "pending"`.

- Si `status` es `"success"`, guarda en una variable un `p` con **"Payment complete"**.
- Si `status` es `"pending"`, guarda un `p` con **"Processing..."**.
- Si `status` es `"error"`, guarda un `p` con **"Payment failed"**.

Luego renderiza el `h3` **"Payment"** y la variable debajo.

<details><summary>Mostrar Solución</summary>

```js
function PaymentStatus() {
  const status = "pending";

  let message = null;

  if (status === "success") {
    message = <p>Payment complete</p>;
  } else if (status === "pending") {
    message = <p>Processing...</p>;
  } else if (status === "error") {
    message = <p>Payment failed</p>;
  }

  return (
    <div>
      <h3>Payment</h3>
      {message}
    </div>
  );
}

export default PaymentStatus;
```

</details>

---

## **Ejercicio 7: `&&` con condición compuesta**

Crea un componente `Banner.jsx` con:

- `hasPromo = true`
- `isNewUser = false`

Solo muestra el `p` **"Special offer"** si **ambas** condiciones son true.

<details><summary>Mostrar Solución</summary>

```js
function Banner() {
  const hasPromo = true;
  const isNewUser = false;

  return (
    <div>
      <h3>Home</h3>
      {hasPromo && isNewUser && <p>Special offer</p>}
    </div>
  );
}

export default Banner;
```

</details>

---

## **Ejercicio 8: Extraer condición a una variable para legibilidad**

Reescribe este renderizado creando una variable `showWarning` antes del return:

```js
{
  isAdmin && isExpired && <p>Action required</p>;
}
```

Supón que `isAdmin = true` e `isExpired = true`.

<details><summary>Mostrar Solución</summary>

```js
function Example() {
  const isAdmin = true;
  const isExpired = true;

  const showWarning = isAdmin && isExpired;

  return <div>{showWarning && <p>Action required</p>}</div>;
}

export default Example;
```

</details>

---

## **Ejercicio 9: Elegir técnica correcta (3 mini-casos)**

Indica qué técnica usarías y escribe el JSX (una por caso):

1. Quiero devolver **solo** un loader y nada más cuando `isLoading` sea true.
2. Quiero mostrar un texto entre dos opciones: `"Dark"` o `"Light"` según `isDarkMode`.
3. Quiero mostrar un `p` solo si `hasNotifications` es true.

<details><summary>Mostrar Solución</summary>

1. `if` antes del return:

```js
if (isLoading) {
  return <p>Loading...</p>;
}
```

2. ternario:

```js
<p>{isDarkMode ? "Dark" : "Light"}</p>
```

3. `&&`:

```js
{
  hasNotifications && <p>You have notifications</p>;
}
```

</details>

---

## **Ejercicio 10: Corregir JSX demasiado anidado (mejora simple)**

Este código funciona, pero es poco legible. Reescríbelo guardando el bloque en una variable `content`:

```js
function App() {
  const state = "error";

  return (
    <div>
      {state === "success" ? (
        <p>Success</p>
      ) : state === "error" ? (
        <p>Error</p>
      ) : (
        <p>Pending</p>
      )}
    </div>
  );
}
```

<details><summary>Mostrar Solución</summary>

```js
function App() {
  const state = "error";

  let content = <p>Pending</p>;

  if (state === "success") {
    content = <p>Success</p>;
  } else if (state === "error") {
    content = <p>Error</p>;
  }

  return <div>{content}</div>;
}

export default App;
```

</details>
