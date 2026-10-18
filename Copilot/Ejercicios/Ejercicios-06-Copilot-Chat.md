# Exercises - Topic 06: Copilot Chat applied to development

Below, you'll find hands-on exercises on using Copilot Chat to help you explain, analyze, improve and review code.

## Exercise 1: Ask for a clear explanation of a function

You have the following function:

```javascript
function groupOrdersByCustomer(orders) {
  return orders.reduce((customers, order) => {
    if (!customers[order.customerId]) {
      customers[order.customerId] = [];
    }

    customers[order.customerId].push(order);
    return customers;
  }, {});
}
```


Write a message to Copilot Chat asking it to explain the function clearly to someone who is learning JavaScript.

<details>
<summary>Show solution</summary>

A suitable message would be:

```text
Explícame esta función paso a paso como si estuviera aprendiendo JavaScript.
Quiero entender qué hace reduce, para qué sirve el objeto customers y por qué se comprueba si existe customers[order.customerId].
No cambies el código, solo explícalo de forma clara.
```


A good answer should explain that:

1. The function receives an array of orders.
2. It uses `reduce` to build an accumulator object.
3. Each key in the object represents a customer's `customerId`.
4. If there's no entry for that customer yet, an empty array is created.
5. Each order is added to the corresponding array.
6. The final result is an object with orders grouped by customer.

</details>

## Exercise 2: Ask Copilot Chat to detect a bug

Analyze this code:

```javascript
function getAverageScore(scores) {
  const total = scores.reduce((sum, score) => sum + score, 0);
  return total / scores.length;
}

console.log(getAverageScore([]));
```


Write a message to Copilot Chat asking it to detect the problem and propose a minimal fix.

<details>
<summary>Show solution</summary>

A suitable message would be:

```text
Revisa este código y dime qué problema puede aparecer cuando el array scores está vacío.
Propón una corrección mínima sin cambiar el nombre de la función ni el tipo de dato que recibe.
Después, explica brevemente por qué la corrección evita el error.
```


A possible fix would be:

```javascript
function getAverageScore(scores) {
  if (scores.length === 0) {
    return 0;
  }

  const total = scores.reduce((sum, score) => sum + score, 0);
  return total / scores.length;
}
```


The problem is that if the array is empty, `scores.length` is `0` and dividing `total / scores.length` produces `NaN`. The fix prevents division by zero by returning a controlled value.

</details>

## Exercise 3: Use Copilot Chat to improve readability

You have the following code:

```javascript
function f(items) {
  let r = [];
  for (let i = 0; i < items.length; i++) {
    if (items[i].a === true && items[i].p > 0) {
      r.push(items[i]);
    }
  }
  return r;
}
```


Write a message to Copilot Chat asking it to improve readability without changing the behavior.

<details>
<summary>Show solution</summary>

A suitable message would be:

```text
Refactoriza este código para mejorar su legibilidad sin cambiar su comportamiento.
Usa nombres de función y variables más descriptivos.
Si es posible, utiliza métodos de array modernos de JavaScript.
Después, explica brevemente los cambios realizados.
```


A possible solution would be:

```javascript
function getAvailablePaidItems(items) {
  return items.filter((item) => item.a === true && item.p > 0);
}
```


An even clearer version, if the real property names are known, would be:

```javascript
function getAvailablePaidItems(items) {
  return items.filter((item) => item.isAvailable === true && item.price > 0);
}
```


The main improvement is using a clearer function name, avoiding non-descriptive variables and replacing the manual loop with `filter`.

</details>

## Exercise 4: Ask for a code review before accepting changes

Imagine that Copilot has generated this function:

```javascript
function removeUser(users, userId) {
  users.splice(userId, 1);
  return users;
}
```


The intention was to remove a user by their `id`, not by their position in the array.

Write a message to Copilot Chat asking it to review the code, detect the problem and fix it.

<details>
<summary>Show solution</summary>

A suitable message would be:

```text
Revisa esta función. La intención es eliminar un usuario por su propiedad id, no por la posición que ocupa en el array.
Detecta el problema del código actual y propón una versión corregida.
La función no debe modificar el array original.
Explica brevemente por qué la nueva versión es más segura.
```


A possible fix would be:

```javascript
function removeUser(users, userId) {
  return users.filter((user) => user.id !== userId);
}
```


The problem with the original code is that `splice(userId, 1)` treats `userId` as an index of the array. Besides, it modifies the original array. The new version uses `filter`, removes the user whose `id` property matches `userId` and returns a new array.

</details>

## Exercise 5: Ask for help with a console error

Imagine that this error appears in a React application:

```text
Cannot read properties of undefined (reading 'name')
```


The component contains this snippet:

```jsx
function UserProfile({ user }) {
  return (
    <section>
      <h2>{user.name}</h2>
      <p>{user.email}</p>
    </section>
  );
}
```

Write a message to Copilot Chat asking for help to understand and fix the error.

<details>
<summary>Show solution</summary>

A suitable message would be:

```text
Estoy recibiendo el error "Cannot read properties of undefined (reading 'name')" en este componente de React.
Explícame por qué ocurre y propón una corrección sencilla.
Ten en cuenta que la prop user puede no estar disponible al principio.
```


A possible fix would be:

```jsx
function UserProfile({ user }) {
  if (!user) {
    return <p>Cargando usuario...</p>;
  }

  return (
    <section>
      <h2>{user.name}</h2>
      <p>{user.email}</p>
    </section>
  );
}
```


The error occurs because the component tries to access `user.name` while `user` is still `undefined`. The initial condition prevents its properties from being accessed until the object exists.

</details>

## Exercise 6: Ask for implementation alternatives

You need to save a list of tasks in the browser. Write a message to Copilot Chat asking for two possible alternatives and a final recommendation.

<details>
<summary>Show solution</summary>

A suitable message would be:

```text
Necesito guardar una lista de tareas en el navegador en una aplicación sencilla de JavaScript.
Dame dos alternativas posibles, por ejemplo localStorage y una API externa.
Compara ventajas e inconvenientes de cada una.
Al final, recomiéndame cuál usarías para una primera versión sencilla y por qué.
```


A good answer should compare:

**localStorage**

- Advantages: simple, fast, no backend needed.
- Disadvantages: only saves data in the current browser, doesn't sync between devices, not suitable for sensitive data.

**External API or backend**

- Advantages: allows real persistence, users, synchronization and access from multiple devices.
- Disadvantages: requires a server, a database, authentication and more configuration.

For a simple first version, it would usually be reasonable to use `localStorage`, as long as the data isn't sensitive.

</details>

## Exercise 7: Create an iterative improvement conversation

Write a sequence of three messages that you could send to Copilot Chat to progressively improve a function that filters products by category.

The conversation should include a first request, a later improvement and a final request for a review.

<details>
<summary>Show solution</summary>

A possible sequence would be:

```text
1. Crea una función en JavaScript llamada filterProductsByCategory.
Debe recibir un array de productos y una categoría.
Cada producto tiene id, name, category y price.
La función debe devolver solo los productos de la categoría indicada.
```


```text
2. Mejora la función para que la comparación de categorías no distinga entre mayúsculas y minúsculas.
No modifiques el array original.
```


```text
3. Revisa la función final y dime si puede fallar en algún caso límite.
Propón mejoras solo si son necesarias y explica brevemente por qué.
```


A possible final function would be:

```javascript
function filterProductsByCategory(products, category) {
  const normalizedCategory = category.toLowerCase();

  return products.filter((product) => {
    return product.category.toLowerCase() === normalizedCategory;
  });
}
```


An additional review could check whether `category` or `product.category` may be `undefined`. If that case is possible, validations would have to be added.

</details>
