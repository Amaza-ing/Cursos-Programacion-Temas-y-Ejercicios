# Exercises - Topic 05: Prompting for programmers

Below, you'll find hands-on exercises to learn how to write clear, complete and useful prompts for programming tasks.

## Exercise 1: Improve a prompt that is too general

Improve the following prompt so that Copilot can generate a more accurate answer:

```text
Haz una función para usuarios.
```


The new prompt must state the language, the goal, the input data, the expected output and some constraint.

<details>
<summary>Show solution</summary>

An improved prompt could be:

```text
Crea una función en JavaScript llamada getActiveUsers que reciba un array de usuarios.
Cada usuario tendrá las propiedades id, name, email y isActive.
La función debe devolver un nuevo array solo con los usuarios activos.
No debe modificar el array original.
Incluye un ejemplo de uso al final.
```


This prompt is better because it states:

1. The programming language.
2. The name of the function.
3. The structure of the input data.
4. The expected output.
5. An important constraint: don't modify the original array.
6. The additional format wanted: include a usage example.

</details>

## Exercise 2: Create a prompt to document code

Imagine that you have a function that calculates discounts in an online store. Write a prompt to ask Copilot to document the function with JSDoc comments.

The prompt should ask for documentation that is clear, brief and useful to other developers.

<details>
<summary>Show solution</summary>

A suitable prompt could be:

```text
Documenta esta función usando JSDoc.
La documentación debe explicar de forma breve qué hace la función, qué parámetros recibe y qué valor devuelve.
No cambies el código de la función.
Usa un lenguaje claro para que otros desarrolladores puedan entenderla rápidamente.
```


If you want to be more specific, you could also write:

```text
Añade documentación JSDoc a la función calculateDiscount.
Explica que recibe el precio original y el porcentaje de descuento.
Indica que devuelve el precio final después de aplicar el descuento.
No modifiques la lógica interna de la función.
```


The key is to clearly separate the documentation task from the code modification task.

</details>

## Exercise 3: Ask for a refactoring without changing the behavior

You have this code:

```javascript
function getFinalPrice(price, discount, tax) {
  let d = (price * discount) / 100;
  let p = price - d;
  let t = (p * tax) / 100;
  let f = p + t;
  return f;
}
```


Write a prompt to ask Copilot to refactor it without changing its behavior.

<details>
<summary>Show solution</summary>

A good prompt could be:

```text
Refactoriza esta función para mejorar la legibilidad, pero sin cambiar su comportamiento.
Usa nombres de variables más descriptivos.
Mantén la misma entrada y la misma salida.
No añadas dependencias externas.
Después de refactorizar, explica brevemente qué cambios has hecho.
```


A possible refactored solution would be:

```javascript
function getFinalPrice(price, discount, tax) {
  const discountAmount = (price * discount) / 100;
  const priceAfterDiscount = price - discountAmount;
  const taxAmount = (priceAfterDiscount * tax) / 100;

  return priceAfterDiscount + taxAmount;
}
```


The behavior stays the same, but the variable names are clearer and the code is easier to read.

</details>

## Exercise 4: Design a prompt to generate tests

Create a prompt to ask Copilot to generate unit tests for a function called `validatePassword`.

The function receives a string and must return `true` if the password has at least 8 characters, an uppercase letter, a lowercase letter and a number. Otherwise, it returns `false`.

<details>
<summary>Show solution</summary>

A suitable prompt could be:

```text
Genera tests unitarios con Jest para una función llamada validatePassword.
La función recibe un string y devuelve true si la contraseña tiene al menos 8 caracteres, una letra mayúscula, una letra minúscula y un número.
Devuelve false si no cumple alguno de esos requisitos.
Incluye casos válidos, casos inválidos y casos límite.
No implementes la función, solo genera los tests.
```


A possible test structure would be:

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


The prompt is correct because it states the testing tool, the expected behavior and the types of cases that should be included.

</details>

## Exercise 5: Spot the problems in an incomplete prompt

Analyze the following prompt and explain why it may produce an unhelpful answer:

```text
Arregla este código.
```


Then write an improved version.

<details>
<summary>Show solution</summary>

The prompt isn't very useful because it doesn't say:

1. What error is happening.
2. What behavior is expected.
3. What language or framework you're working with.
4. Which part of the code needs to be reviewed.
5. Whether the whole function can be modified or just part of it.
6. Whether an explanation, a fix or both are needed.

An improved version could be:

```text
Revisa este código JavaScript y detecta por qué la función devuelve NaN cuando el array está vacío.
Propón una corrección mínima sin cambiar la firma de la función.
Después, explica brevemente cuál era el problema y por qué la solución lo corrige.
```


This version helps a lot more because it gives context, describes the problem and limits the type of change expected.

</details>

## Exercise 6: Create a prompt with style constraints

Write a prompt to ask Copilot to create a React component called `ProductCard`.

The component must receive `name`, `price` and `imageUrl` as props. It must show the product's information and must not include purchase logic or any connection to APIs.

<details>
<summary>Show solution</summary>

A suitable prompt could be:

```text
Crea un componente de React llamado ProductCard.
Debe recibir las props name, price e imageUrl.
El componente debe mostrar una imagen del producto, el nombre y el precio.
No añadas lógica de compra, carrito ni llamadas a APIs.
Usa nombres de variables en inglés.
Mantén el componente sencillo y fácil de reutilizar.
Incluye también un ejemplo básico de uso.
```


A possible response from Copilot would be:

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


Usage example:

```jsx
<ProductCard name="Laptop" price={899} imageUrl="/images/laptop.jpg" />
```


The prompt includes the goal, the props, the constraints and the expected format.

</details>

## Exercise 7: Turn a functional request into a technical prompt

Turn this request into a technical prompt suitable for Copilot:

“I need the cheap products to appear before the expensive ones.”

The prompt must be intended for JavaScript and must ask for a reusable function.

<details>
<summary>Show solution</summary>

A suitable technical prompt could be:

```text
Crea una función en JavaScript llamada sortProductsByPrice.
La función debe recibir un array de productos.
Cada producto tendrá las propiedades id, name y price.
Debe devolver un nuevo array ordenado de menor a mayor precio.
No debe modificar el array original.
Incluye un ejemplo de uso con tres productos.
```


A possible implementation would be:

```javascript
function sortProductsByPrice(products) {
  return [...products].sort((a, b) => a.price - b.price);
}
```


Usage example:

```javascript
const products = [
  { id: 1, name: "Monitor", price: 180 },
  { id: 2, name: "Mouse", price: 20 },
  { id: 3, name: "Keyboard", price: 50 },
];

console.log(sortProductsByPrice(products));
```


The original request was functional, but the technical prompt states the language, the function name, the data structure, the sort order and the constraint of not modifying the original array.

</details>
