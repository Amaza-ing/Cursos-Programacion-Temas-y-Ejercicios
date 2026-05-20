# Ejercicios - Tema 05: Prompting para programadores

A continuación, encontrarás ejercicios prácticos para aprender a escribir prompts claros, completos y útiles en tareas de programación.

## Ejercicio 1: Mejorar un prompt demasiado general

Mejora el siguiente prompt para que Copilot pueda generar una respuesta más precisa:

```text
Haz una función para usuarios.
```

El nuevo prompt debe indicar lenguaje, objetivo, datos de entrada, salida esperada y alguna restricción.

<details>
<summary>Mostrar solución</summary>

Un prompt mejorado podría ser:

```text
Crea una función en JavaScript llamada getActiveUsers que reciba un array de usuarios.
Cada usuario tendrá las propiedades id, name, email y isActive.
La función debe devolver un nuevo array solo con los usuarios activos.
No debe modificar el array original.
Incluye un ejemplo de uso al final.
```

Este prompt es mejor porque indica:

1. El lenguaje de programación.
2. El nombre de la función.
3. La estructura de los datos de entrada.
4. La salida esperada.
5. Una restricción importante: no modificar el array original.
6. El formato adicional deseado: incluir un ejemplo de uso.

</details>

## Ejercicio 2: Crear un prompt para documentar código

Imagina que tienes una función que calcula descuentos en una tienda online. Escribe un prompt para pedir a Copilot que documente la función con comentarios JSDoc.

El prompt debe pedir que la documentación sea clara, breve y útil para otros desarrolladores.

<details>
<summary>Mostrar solución</summary>

Un prompt adecuado podría ser:

```text
Documenta esta función usando JSDoc.
La documentación debe explicar de forma breve qué hace la función, qué parámetros recibe y qué valor devuelve.
No cambies el código de la función.
Usa un lenguaje claro para que otros desarrolladores puedan entenderla rápidamente.
```

Si se quiere ser más específico, también se podría escribir:

```text
Añade documentación JSDoc a la función calculateDiscount.
Explica que recibe el precio original y el porcentaje de descuento.
Indica que devuelve el precio final después de aplicar el descuento.
No modifiques la lógica interna de la función.
```

La clave está en separar claramente la tarea de documentación de la tarea de modificación del código.

</details>

## Ejercicio 3: Pedir una refactorización sin cambiar el comportamiento

Tienes este código:

```javascript
function getFinalPrice(price, discount, tax) {
  let d = (price * discount) / 100;
  let p = price - d;
  let t = (p * tax) / 100;
  let f = p + t;
  return f;
}
```

Escribe un prompt para pedir a Copilot que lo refactorice sin cambiar su comportamiento.

<details>
<summary>Mostrar solución</summary>

Un buen prompt podría ser:

```text
Refactoriza esta función para mejorar la legibilidad, pero sin cambiar su comportamiento.
Usa nombres de variables más descriptivos.
Mantén la misma entrada y la misma salida.
No añadas dependencias externas.
Después de refactorizar, explica brevemente qué cambios has hecho.
```

Una posible solución refactorizada sería:

```javascript
function getFinalPrice(price, discount, tax) {
  const discountAmount = (price * discount) / 100;
  const priceAfterDiscount = price - discountAmount;
  const taxAmount = (priceAfterDiscount * tax) / 100;

  return priceAfterDiscount + taxAmount;
}
```

El comportamiento se mantiene, pero los nombres de las variables son más claros y el código es más fácil de leer.

</details>

## Ejercicio 4: Diseñar un prompt para generar tests

Crea un prompt para pedir a Copilot que genere tests unitarios para una función llamada `validatePassword`.

La función recibe un string y debe devolver `true` si la contraseña tiene al menos 8 caracteres, una mayúscula, una minúscula y un número. En caso contrario, devuelve `false`.

<details>
<summary>Mostrar solución</summary>

Un prompt adecuado podría ser:

```text
Genera tests unitarios con Jest para una función llamada validatePassword.
La función recibe un string y devuelve true si la contraseña tiene al menos 8 caracteres, una letra mayúscula, una letra minúscula y un número.
Devuelve false si no cumple alguno de esos requisitos.
Incluye casos válidos, casos inválidos y casos límite.
No implementes la función, solo genera los tests.
```

Una posible estructura de tests sería:

```javascript
describe("validatePassword", () => {
  test("returns true for a valid password", () => {
    expect(validatePassword("Password1")).toBe(true);
  });

  test("returns false when password has less than 8 characters", () => {
    expect(validatePassword("Pass1")).toBe(false);
  });

  test("returns false when password has no uppercase letter", () => {
    expect(validatePassword("password1")).toBe(false);
  });

  test("returns false when password has no lowercase letter", () => {
    expect(validatePassword("PASSWORD1")).toBe(false);
  });

  test("returns false when password has no number", () => {
    expect(validatePassword("Password")).toBe(false);
  });
});
```

El prompt es correcto porque indica herramienta de testing, comportamiento esperado y tipos de casos que deben incluirse.

</details>

## Ejercicio 5: Detectar problemas en un prompt incompleto

Analiza el siguiente prompt y explica por qué puede producir una respuesta poco útil:

```text
Arregla este código.
```

Después, escribe una versión mejorada.

<details>
<summary>Mostrar solución</summary>

El prompt es poco útil porque no indica:

1. Qué error se está produciendo.
2. Qué comportamiento se espera.
3. En qué lenguaje o framework se está trabajando.
4. Qué parte del código debe revisarse.
5. Si se puede modificar toda la función o solo una parte.
6. Si se necesita explicación, corrección o ambas cosas.

Una versión mejorada podría ser:

```text
Revisa este código JavaScript y detecta por qué la función devuelve NaN cuando el array está vacío.
Propón una corrección mínima sin cambiar la firma de la función.
Después, explica brevemente cuál era el problema y por qué la solución lo corrige.
```

Esta versión ayuda mucho más porque da contexto, describe el problema y limita el tipo de cambio esperado.

</details>

## Ejercicio 6: Crear un prompt con restricciones de estilo

Escribe un prompt para pedir a Copilot que cree un componente de React llamado `ProductCard`.

El componente debe recibir `name`, `price` y `imageUrl` como props. Debe mostrar la información del producto y no debe incluir lógica de compra ni conexión con APIs.

<details>
<summary>Mostrar solución</summary>

Un prompt adecuado podría ser:

```text
Crea un componente de React llamado ProductCard.
Debe recibir las props name, price e imageUrl.
El componente debe mostrar una imagen del producto, el nombre y el precio.
No añadas lógica de compra, carrito ni llamadas a APIs.
Usa nombres de variables en inglés.
Mantén el componente sencillo y fácil de reutilizar.
Incluye también un ejemplo básico de uso.
```

Una posible respuesta de Copilot sería:

```jsx
function ProductCard({ name, price, imageUrl }) {
  return (
    <article className="product-card">
      <img src={imageUrl} alt={name} />
      <h2>{name}</h2>
      <p>{price} €</p>
    </article>
  );
}

export default ProductCard;
```

Ejemplo de uso:

```jsx
<ProductCard name="Laptop" price={899} imageUrl="/images/laptop.jpg" />
```

El prompt incluye objetivo, props, restricciones y formato esperado.

</details>

## Ejercicio 7: Convertir una petición funcional en un prompt técnico

Transforma esta petición en un prompt técnico adecuado para Copilot:

“Necesito que los productos baratos aparezcan antes que los caros”.

El prompt debe estar pensado para JavaScript y debe pedir una función reutilizable.

<details>
<summary>Mostrar solución</summary>

Un prompt técnico adecuado podría ser:

```text
Crea una función en JavaScript llamada sortProductsByPrice.
La función debe recibir un array de productos.
Cada producto tendrá las propiedades id, name y price.
Debe devolver un nuevo array ordenado de menor a mayor precio.
No debe modificar el array original.
Incluye un ejemplo de uso con tres productos.
```

Una posible implementación sería:

```javascript
function sortProductsByPrice(products) {
  return [...products].sort((a, b) => a.price - b.price);
}
```

Ejemplo de uso:

```javascript
const products = [
  { id: 1, name: "Monitor", price: 180 },
  { id: 2, name: "Mouse", price: 20 },
  { id: 3, name: "Keyboard", price: 50 },
];

console.log(sortProductsByPrice(products));
```

La petición original era funcional, pero el prompt técnico indica lenguaje, nombre de función, estructura de datos, criterio de ordenación y restricción sobre no modificar el array original.

</details>
