# Ejercicios - Tema 07: Refactorización, documentación, testing y debugging con GitHub Copilot

A continuación, encontrarás ejercicios prácticos para trabajar con GitHub Copilot en tareas de refactorización, documentación, creación de tests y detección de errores.

## Ejercicio 1: Refactorizar una función poco legible

Tienes el siguiente código:

```javascript
function c(a) {
  let r = 0;
  for (let i = 0; i < a.length; i++) {
    if (a[i].s === "paid" && a[i].t > 50) {
      r = r + a[i].t;
    }
  }
  return r;
}
```

La función calcula el total de los pedidos pagados cuyo importe es mayor de 50.

Escribe un prompt para pedir a GitHub Copilot que refactorice el código mejorando la legibilidad, sin cambiar el comportamiento.

<details>
<summary>Mostrar solución</summary>

Un prompt adecuado sería:

```text
Refactoriza esta función para que sea más legible, pero sin cambiar su comportamiento.
Usa nombres de variables y función más descriptivos.
Sustituye el bucle manual por métodos de array si mejora la claridad.
Después, explica brevemente qué cambios has realizado.
```

Una posible solución sería:

```javascript
function calculatePaidOrdersTotal(orders) {
  return orders
    .filter((order) => order.status === "paid" && order.total > 50)
    .reduce((total, order) => total + order.total, 0);
}
```

Si no se pueden cambiar los nombres de las propiedades porque vienen de una API externa, una alternativa sería:

```javascript
function calculatePaidOrdersTotal(orders) {
  return orders
    .filter((order) => order.s === "paid" && order.t > 50)
    .reduce((total, order) => total + order.t, 0);
}
```

La segunda opción mantiene exactamente las propiedades originales. La primera opción es más clara, pero solo sería válida si también se puede modificar la estructura de los datos.

</details>

## Ejercicio 2: Documentar una función con JSDoc

Tienes la siguiente función:

```javascript
function calculateDiscount(price, percentage) {
  if (price < 0 || percentage < 0) {
    throw new Error("Invalid values");
  }

  return price - price * (percentage / 100);
}
```

Escribe un prompt para pedir a GitHub Copilot que añada documentación JSDoc clara y breve.

<details>
<summary>Mostrar solución</summary>

Un prompt adecuado sería:

```text
Añade documentación JSDoc a esta función.
La documentación debe explicar qué hace la función, qué parámetros recibe, qué devuelve y cuándo lanza un error.
No cambies el código de la función.
Usa una explicación breve y clara.
```

Una posible solución sería:

```javascript
/**
 * Calcula el precio final después de aplicar un descuento porcentual.
 *
 * @param {number} price - Precio original del producto.
 * @param {number} percentage - Porcentaje de descuento que se aplicará.
 * @returns {number} Precio final después de aplicar el descuento.
 * @throws {Error} Si el precio o el porcentaje son valores negativos.
 */
function calculateDiscount(price, percentage) {
  if (price < 0 || percentage < 0) {
    throw new Error("Invalid values");
  }

  return price - price * (percentage / 100);
}
```

La documentación es útil porque permite entender la función sin tener que leer todo el cuerpo del código. Además, ayuda a otros desarrolladores y mejora la asistencia que puede ofrecer Copilot en el proyecto.

</details>

## Ejercicio 3: Generar tests unitarios con Copilot

Tienes la siguiente función:

```javascript
function isValidPassword(password) {
  return (
    password.length >= 8 && /[A-Z]/.test(password) && /[0-9]/.test(password)
  );
}
```

La función debe devolver `true` si la contraseña tiene al menos 8 caracteres, una mayúscula y un número.

Escribe un prompt para pedir a GitHub Copilot que genere tests unitarios usando Jest.

<details>
<summary>Mostrar solución</summary>

Un prompt adecuado sería:

```text
Genera tests unitarios con Jest para la función isValidPassword.
Incluye casos válidos, contraseñas demasiado cortas, contraseñas sin mayúsculas y contraseñas sin números.
No modifiques la función original.
```

Una posible solución sería:

```javascript
describe("isValidPassword", () => {
  test("returns true when the password has at least 8 characters, one uppercase letter and one number", () => {
    expect(isValidPassword("Secure123")).toBe(true);
  });

  test("returns false when the password is shorter than 8 characters", () => {
    expect(isValidPassword("Sec12")).toBe(false);
  });

  test("returns false when the password does not contain an uppercase letter", () => {
    expect(isValidPassword("secure123")).toBe(false);
  });

  test("returns false when the password does not contain a number", () => {
    expect(isValidPassword("SecurePass")).toBe(false);
  });
});
```

Los tests cubren tanto un caso correcto como varios casos incorrectos. Esto permite comprobar que la función no solo funciona cuando la contraseña es válida, sino también cuando debe rechazar valores que no cumplen las condiciones.

</details>

## Ejercicio 4: Detectar un bug en una función generada

Copilot ha generado esta función para buscar un producto por su `id`:

```javascript
function findProduct(products, productId) {
  return products.filter((product) => product.id === productId);
}
```

La intención era obtener un único producto, no un array.

Escribe un prompt para pedir a Copilot que revise el código, detecte el problema y proponga una corrección mínima.

<details>
<summary>Mostrar solución</summary>

Un prompt adecuado sería:

```text
Revisa esta función. La intención es encontrar un único producto por su id, no devolver una lista de productos.
Detecta el problema y propón una corrección mínima.
No cambies el nombre de la función ni los parámetros.
Explica brevemente por qué la corrección es mejor para este caso.
```

Una posible solución sería:

```javascript
function findProduct(products, productId) {
  return products.find((product) => product.id === productId);
}
```

La función original usa `filter`, que siempre devuelve un array. Si se quiere recuperar un único elemento, es más adecuado usar `find`, porque devuelve el primer elemento que cumple la condición o `undefined` si no encuentra ninguno.

</details>

## Ejercicio 5: Pedir una refactorización sin romper compatibilidad

Tienes este código en una aplicación existente:

```javascript
function getUserName(user) {
  return user.profile.name.toUpperCase();
}
```

El problema es que algunos usuarios no tienen `profile` o no tienen `name`, y la aplicación puede fallar.

Escribe un prompt para pedir a Copilot que haga la función más segura sin cambiar el tipo de resultado esperado cuando el nombre existe.

<details>
<summary>Mostrar solución</summary>

Un prompt adecuado sería:

```text
Haz esta función más segura para evitar errores cuando user, profile o name no existan.
Cuando el nombre exista, debe seguir devolviéndose en mayúsculas.
Si el nombre no existe, devuelve "UNKNOWN".
No cambies el nombre de la función.
Explica brevemente la solución.
```

Una posible solución sería:

```javascript
function getUserName(user) {
  return user?.profile?.name ? user.profile.name.toUpperCase() : "UNKNOWN";
}
```

También podría escribirse así:

```javascript
function getUserName(user) {
  const name = user?.profile?.name;
  return name ? name.toUpperCase() : "UNKNOWN";
}
```

La segunda versión puede ser más legible porque separa la obtención del nombre de la transformación a mayúsculas.

</details>

## Ejercicio 6: Crear una estrategia de debugging asistida por Copilot

Tienes el siguiente código:

```javascript
async function loadUsers() {
  const response = fetch("https://api.example.com/users");
  const users = await response.json();
  return users;
}
```

Al ejecutarlo aparece un error relacionado con `response.json`.

Escribe un prompt para pedir a GitHub Copilot que ayude a detectar el problema y proponga una corrección.

<details>
<summary>Mostrar solución</summary>

Un prompt adecuado sería:

```text
Analiza esta función asíncrona y detecta por qué puede fallar en la línea response.json().
Propón una corrección mínima y explica qué papel tiene await en este caso.
Después, añade una comprobación básica para controlar respuestas HTTP no correctas.
```

Una posible solución sería:

```javascript
async function loadUsers() {
  const response = await fetch("https://api.example.com/users");

  if (!response.ok) {
    throw new Error("Error loading users");
  }

  const users = await response.json();
  return users;
}
```

El problema era que faltaba `await` delante de `fetch`. Sin `await`, `response` no contiene todavía la respuesta HTTP, sino una promesa. Por eso no se puede llamar correctamente a `response.json()`.

</details>
