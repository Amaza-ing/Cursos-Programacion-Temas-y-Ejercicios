# Ejercicios - Tema 06: Copilot Chat aplicado al desarrollo

A continuación, encontrarás ejercicios prácticos para utilizar Copilot Chat como apoyo en explicación, análisis, mejora y revisión de código.

## Ejercicio 1: Pedir una explicación clara de una función

Tienes la siguiente función:

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

Escribe un mensaje para Copilot Chat pidiendo que explique la función de forma clara para una persona que está aprendiendo JavaScript.

<details>
<summary>Mostrar solución</summary>

Un mensaje adecuado sería:

```text
Explícame esta función paso a paso como si estuviera aprendiendo JavaScript.
Quiero entender qué hace reduce, para qué sirve el objeto customers y por qué se comprueba si existe customers[order.customerId].
No cambies el código, solo explícalo de forma clara.
```

Una buena respuesta debería explicar que:

1. La función recibe un array de pedidos.
2. Usa `reduce` para construir un objeto acumulador.
3. Cada clave del objeto representa el `customerId` de un cliente.
4. Si todavía no existe una entrada para ese cliente, se crea un array vacío.
5. Cada pedido se añade al array correspondiente.
6. El resultado final es un objeto con los pedidos agrupados por cliente.

</details>

## Ejercicio 2: Pedir a Copilot Chat que detecte un bug

Analiza este código:

```javascript
function getAverageScore(scores) {
  const total = scores.reduce((sum, score) => sum + score, 0);
  return total / scores.length;
}

console.log(getAverageScore([]));
```

Escribe un mensaje para Copilot Chat que pida detectar el problema y proponer una corrección mínima.

<details>
<summary>Mostrar solución</summary>

Un mensaje adecuado sería:

```text
Revisa este código y dime qué problema puede aparecer cuando el array scores está vacío.
Propón una corrección mínima sin cambiar el nombre de la función ni el tipo de dato que recibe.
Después, explica brevemente por qué la corrección evita el error.
```

Una posible corrección sería:

```javascript
function getAverageScore(scores) {
  if (scores.length === 0) {
    return 0;
  }

  const total = scores.reduce((sum, score) => sum + score, 0);
  return total / scores.length;
}
```

El problema es que, si el array está vacío, `scores.length` vale `0` y la división `total / scores.length` produce `NaN`. La corrección evita la división entre cero devolviendo un valor controlado.

</details>

## Ejercicio 3: Usar Copilot Chat para mejorar legibilidad

Tienes el siguiente código:

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

Escribe un mensaje para Copilot Chat pidiendo una mejora de legibilidad sin cambiar el comportamiento.

<details>
<summary>Mostrar solución</summary>

Un mensaje adecuado sería:

```text
Refactoriza este código para mejorar su legibilidad sin cambiar su comportamiento.
Usa nombres de función y variables más descriptivos.
Si es posible, utiliza métodos de array modernos de JavaScript.
Después, explica brevemente los cambios realizados.
```

Una posible solución sería:

```javascript
function getAvailablePaidItems(items) {
  return items.filter((item) => item.a === true && item.p > 0);
}
```

Una versión aún más clara, si se conocen los nombres reales de las propiedades, sería:

```javascript
function getAvailablePaidItems(items) {
  return items.filter((item) => item.isAvailable === true && item.price > 0);
}
```

La mejora principal está en usar un nombre de función más claro, evitar variables poco descriptivas y sustituir el bucle manual por `filter`.

</details>

## Ejercicio 4: Pedir una revisión de código antes de aceptar cambios

Imagina que Copilot ha generado esta función:

```javascript
function removeUser(users, userId) {
  users.splice(userId, 1);
  return users;
}
```

La intención era eliminar un usuario por su `id`, no por su posición en el array.

Escribe un mensaje para Copilot Chat que pida revisar el código, detectar el problema y corregirlo.

<details>
<summary>Mostrar solución</summary>

Un mensaje adecuado sería:

```text
Revisa esta función. La intención es eliminar un usuario por su propiedad id, no por la posición que ocupa en el array.
Detecta el problema del código actual y propón una versión corregida.
La función no debe modificar el array original.
Explica brevemente por qué la nueva versión es más segura.
```

Una posible corrección sería:

```javascript
function removeUser(users, userId) {
  return users.filter((user) => user.id !== userId);
}
```

El problema del código original es que `splice(userId, 1)` interpreta `userId` como índice del array. Además, modifica el array original. La nueva versión usa `filter`, elimina el usuario cuya propiedad `id` coincide con `userId` y devuelve un nuevo array.

</details>

## Ejercicio 5: Pedir ayuda con un error de consola

Imagina que en una aplicación de React aparece este error:

```text
Cannot read properties of undefined (reading 'name')
```

El componente contiene este fragmento:

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

Escribe un mensaje para Copilot Chat que pida ayuda para entender y corregir el error.

<details>
<summary>Mostrar solución</summary>

Un mensaje adecuado sería:

```text
Estoy recibiendo el error "Cannot read properties of undefined (reading 'name')" en este componente de React.
Explícame por qué ocurre y propón una corrección sencilla.
Ten en cuenta que la prop user puede no estar disponible al principio.
```

Una posible corrección sería:

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

El error ocurre porque el componente intenta acceder a `user.name` cuando `user` todavía es `undefined`. La condición inicial evita acceder a sus propiedades hasta que el objeto exista.

</details>

## Ejercicio 6: Pedir alternativas de implementación

Necesitas guardar una lista de tareas en el navegador. Escribe un mensaje para Copilot Chat pidiendo dos alternativas posibles y una recomendación final.

<details>
<summary>Mostrar solución</summary>

Un mensaje adecuado sería:

```text
Necesito guardar una lista de tareas en el navegador en una aplicación sencilla de JavaScript.
Dame dos alternativas posibles, por ejemplo localStorage y una API externa.
Compara ventajas e inconvenientes de cada una.
Al final, recomiéndame cuál usarías para una primera versión sencilla y por qué.
```

Una buena respuesta debería comparar:

**localStorage**

- Ventajas: sencillo, rápido, no necesita backend.
- Inconvenientes: solo guarda datos en el navegador actual, no sincroniza entre dispositivos, no es adecuado para datos sensibles.

**API externa o backend**

- Ventajas: permite persistencia real, usuarios, sincronización y acceso desde varios dispositivos.
- Inconvenientes: requiere servidor, base de datos, autenticación y más configuración.

Para una primera versión sencilla, normalmente sería razonable usar `localStorage`, siempre que los datos no sean sensibles.

</details>

## Ejercicio 7: Crear una conversación de mejora iterativa

Escribe una secuencia de tres mensajes que podrías enviar a Copilot Chat para mejorar progresivamente una función que filtra productos por categoría.

La conversación debe incluir una primera petición, una mejora posterior y una petición final de revisión.

<details>
<summary>Mostrar solución</summary>

Una posible secuencia sería:

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

Una posible función final sería:

```javascript
function filterProductsByCategory(products, category) {
  const normalizedCategory = category.toLowerCase();

  return products.filter((product) => {
    return product.category.toLowerCase() === normalizedCategory;
  });
}
```

Una revisión adicional podría comprobar si `category` o `product.category` pueden ser `undefined`. Si ese caso es posible, habría que añadir validaciones.

</details>
