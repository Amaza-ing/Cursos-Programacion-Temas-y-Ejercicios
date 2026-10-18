# Exercises - Topic 07: Refactoring, documentation, testing and debugging with GitHub Copilot

Below, you'll find hands-on exercises to work with GitHub Copilot on refactoring, documentation, test creation and error detection tasks.

## Exercise 1: Refactor a hard-to-read function

You have the following code:

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


The function calculates the total of paid orders whose amount is greater than 50.

Write a prompt to ask GitHub Copilot to refactor the code to improve its readability, without changing the behavior.

<details>
<summary>Show solution</summary>

A suitable prompt would be:

```text
Refactoriza esta función para que sea más legible, pero sin cambiar su comportamiento.
Usa nombres de variables y función más descriptivos.
Sustituye el bucle manual por métodos de array si mejora la claridad.
Después, explica brevemente qué cambios has realizado.
```


A possible solution would be:

```javascript
function calculatePaidOrdersTotal(orders) {
  return orders
    .filter((order) => order.status === "paid" && order.total > 50)
    .reduce((total, order) => total + order.total, 0);
}
```


If the property names can't be changed because they come from an external API, an alternative would be:

```javascript
function calculatePaidOrdersTotal(orders) {
  return orders
    .filter((order) => order.s === "paid" && order.t > 50)
    .reduce((total, order) => total + order.t, 0);
}
```


The second option keeps exactly the original properties. The first option is clearer, but it would only be valid if the data structure can also be changed.

</details>

## Exercise 2: Document a function with JSDoc

You have the following function:

```javascript
function calculateDiscount(price, percentage) {
  if (price < 0 || percentage < 0) {
    throw new Error("Invalid values");
  }

  return price - price * (percentage / 100);
}
```


Write a prompt to ask GitHub Copilot to add clear and concise JSDoc documentation.

<details>
<summary>Show solution</summary>

A suitable prompt would be:

```text
Añade documentación JSDoc a esta función.
La documentación debe explicar qué hace la función, qué parámetros recibe, qué devuelve y cuándo lanza un error.
No cambies el código de la función.
Usa una explicación breve y clara.
```


A possible solution would be:

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


Documentation is useful because it lets you understand the function without having to read the whole body of the code. It also helps other developers and improves the help that Copilot can offer in the project.

</details>

## Exercise 3: Generate unit tests with Copilot

You have the following function:

```javascript
function isValidPassword(password) {
  return (
    password.length >= 8 && /[A-Z]/.test(password) && /[0-9]/.test(password)
  );
}
```


The function must return `true` if the password has at least 8 characters, an uppercase letter and a number.

Write a prompt to ask GitHub Copilot to generate unit tests using Jest.

<details>
<summary>Show solution</summary>

A suitable prompt would be:

```text
Genera tests unitarios con Jest para la función isValidPassword.
Incluye casos válidos, contraseñas demasiado cortas, contraseñas sin mayúsculas y contraseñas sin números.
No modifiques la función original.
```


A possible solution would be:

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


The tests cover both a valid case and several invalid ones. This lets you check that the function works not only when the password is valid, but also when it must reject values that don't meet the conditions.

</details>

## Exercise 4: Detect a bug in a generated function

Copilot has generated this function to search for a product by its `id`:

```javascript
function findProduct(products, productId) {
  return products.filter((product) => product.id === productId);
}
```


The intention was to get a single product, not an array.

Write a prompt to ask Copilot to review the code, detect the problem and propose a minimal fix.

<details>
<summary>Show solution</summary>

A suitable prompt would be:

```text
Revisa esta función. La intención es encontrar un único producto por su id, no devolver una lista de productos.
Detecta el problema y propón una corrección mínima.
No cambies el nombre de la función ni los parámetros.
Explica brevemente por qué la corrección es mejor para este caso.
```


A possible solution would be:

```javascript
function findProduct(products, productId) {
  return products.find((product) => product.id === productId);
}
```


The original function uses `filter`, which always returns an array. If you want to retrieve a single element, it's more appropriate to use `find`, because it returns the first element that meets the condition, or `undefined` if none is found.

</details>

## Exercise 5: Ask for a refactoring without breaking compatibility

You have this code in an existing application:

```javascript
function getUserName(user) {
  return user.profile.name.toUpperCase();
}
```

The problem is that some users don't have `profile` or don't have `name`, and the application may crash.

Write a prompt to ask Copilot to make the function safer without changing the type of result expected when the name exists.

<details>
<summary>Show solution</summary>

A suitable prompt would be:

```text
Haz esta función más segura para evitar errores cuando user, profile o name no existan.
Cuando el nombre exista, debe seguir devolviéndose en mayúsculas.
Si el nombre no existe, devuelve "UNKNOWN".
No cambies el nombre de la función.
Explica brevemente la solución.
```


A possible solution would be:

```javascript
function getUserName(user) {
  return user?.profile?.name ? user.profile.name.toUpperCase() : "UNKNOWN";
}
```


It could also be written like this:

```javascript
function getUserName(user) {
  const name = user?.profile?.name;
  return name ? name.toUpperCase() : "UNKNOWN";
}
```


The second version may be more readable because it separates getting the name from converting it to uppercase.

</details>

## Exercise 6: Create a Copilot-assisted debugging strategy

You have the following code:

```javascript
async function loadUsers() {
  const response = fetch("https://api.example.com/users");
  const users = await response.json();
  return users;
}
```


When you run it, an error related to `response.json` appears.

Write a prompt to ask GitHub Copilot to help you detect the problem and propose a fix.

<details>
<summary>Show solution</summary>

A suitable prompt would be:

```text
Analiza esta función asíncrona y detecta por qué puede fallar en la línea response.json().
Propón una corrección mínima y explica qué papel tiene await en este caso.
Después, añade una comprobación básica para controlar respuestas HTTP no correctas.
```


A possible solution would be:

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


The problem was that `await` was missing before `fetch`. Without `await`, `response` doesn't contain the HTTP response yet, but a promise. That's why `response.json()` can't be called correctly.

</details>
