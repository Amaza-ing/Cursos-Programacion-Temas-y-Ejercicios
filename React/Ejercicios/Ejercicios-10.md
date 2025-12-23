# **Ejercicios - Tema 10: Listas, Index y Listas de Objetos**

A continuación, encontrarás **10 ejercicios prácticos** para aprender a renderizar listas en React con `.map()`, usar `key` correctamente, y trabajar con **listas de objetos**.

Intenta resolverlos antes de consultar la solución.

---

## **Ejercicio 1: Lista simple de strings**

Crea un componente `CitiesList.jsx` que renderice un `ul` con estas ciudades:

```js
const cities = ["Madrid", "Sevilla", "Valencia", "Bilbao"];
```

- Renderiza cada ciudad en un `li`.
- Usa una `key` estable (no uses index).

<details><summary>Mostrar Solución</summary>

```js
function CitiesList() {
  const cities = ["Madrid", "Sevilla", "Valencia", "Bilbao"];

  return (
    <ul>
      {cities.map((city) => (
        <li key={city}>{city}</li>
      ))}
    </ul>
  );
}

export default CitiesList;
```

</details>

---

## **Ejercicio 2: Mostrar también el index (sin usarlo como key)**

Crea un componente `Steps.jsx` con este array:

```js
const steps = ["Install", "Create", "Run", "Build"];
```

- Renderiza cada paso como: `1. Install`, `2. Create`, etc.
- Muestra el número usando el `index`.
- La `key` NO debe ser el `index` (usa el texto del paso).

<details><summary>Mostrar Solución</summary>

```js
function Steps() {
  const steps = ["Install", "Create", "Run", "Build"];

  return (
    <ol>
      {steps.map((step, index) => (
        <li key={step}>
          {index + 1}. {step}
        </li>
      ))}
    </ol>
  );
}

export default Steps;
```

</details>

---

## **Ejercicio 3: Cuándo usar index como `key` (lista estática)**

Crea un componente `FixedRules.jsx` con una lista fija de 3 reglas:

- "Be respectful"
- "Write clear code"
- "Keep components small"

En este caso, usa el **index** como `key` y añade un comentario en el código explicando por qué es aceptable aquí.

<details><summary>Mostrar Solución</summary>

```js
function FixedRules() {
  const rules = ["Be respectful", "Write clear code", "Keep components small"];

  return (
    <ul>
      {rules.map((rule, index) => (
        // Usar index es aceptable porque esta lista es fija y no se reordena ni cambia
        <li key={index}>{rule}</li>
      ))}
    </ul>
  );
}

export default FixedRules;
```

</details>

---

## **Ejercicio 4: Lista de objetos con `id` como key**

Crea un componente `ProductsList.jsx` con este array:

```js
const products = [
  { id: 10, name: "Keyboard", price: 30 },
  { id: 11, name: "Mouse", price: 15 },
  { id: 12, name: "Monitor", price: 120 },
];
```

Renderiza un `ul` donde cada `li` muestre:

- `Keyboard - 30€`

Usa `product.id` como `key`.

<details><summary>Mostrar Solución</summary>

```js
function ProductsList() {
  const products = [
    { id: 10, name: "Keyboard", price: 30 },
    { id: 11, name: "Mouse", price: 15 },
    { id: 12, name: "Monitor", price: 120 },
  ];

  return (
    <ul>
      {products.map((product) => (
        <li key={product.id}>
          {product.name} - {product.price}€
        </li>
      ))}
    </ul>
  );
}

export default ProductsList;
```

</details>

---

## **Ejercicio 5: Renderizar componentes dentro de una lista**

Crea un componente `SkillItem.jsx` que reciba `name` por props y renderice:

- Un `li` con el texto del skill.

Luego crea `SkillsList.jsx` con este array:

```js
const skills = [
  { id: 1, name: "React" },
  { id: 2, name: "JavaScript" },
  { id: 3, name: "CSS" },
];
```

Renderiza `SkillItem` usando `.map()` y pon la `key` en el componente que se repite.

<details><summary>Mostrar Solución</summary>

**`SkillItem.jsx`**

```js
function SkillItem({ name }) {
  return <li>{name}</li>;
}

export default SkillItem;
```

**`SkillsList.jsx`**

```js
import SkillItem from "./SkillItem";

function SkillsList() {
  const skills = [
    { id: 1, name: "React" },
    { id: 2, name: "JavaScript" },
    { id: 3, name: "CSS" },
  ];

  return (
    <ul>
      {skills.map((skill) => (
        <SkillItem key={skill.id} name={skill.name} />
      ))}
    </ul>
  );
}

export default SkillsList;
```

</details>

---

## **Ejercicio 6: Filtrar y renderizar (sin modificar el array original)**

Crea un componente `ExpensiveProducts.jsx` con este array:

```js
const products = [
  { id: 1, name: "USB", price: 8 },
  { id: 2, name: "Headphones", price: 45 },
  { id: 3, name: "Laptop Stand", price: 25 },
];
```

- Renderiza solo los productos con `price >= 25`.
- Usa `.filter()` antes del `.map()`.

<details><summary>Mostrar Solución</summary>

```js
function ExpensiveProducts() {
  const products = [
    { id: 1, name: "USB", price: 8 },
    { id: 2, name: "Headphones", price: 45 },
    { id: 3, name: "Laptop Stand", price: 25 },
  ];

  const expensiveProducts = products.filter((product) => product.price >= 25);

  return (
    <ul>
      {expensiveProducts.map((product) => (
        <li key={product.id}>
          {product.name} - {product.price}€
        </li>
      ))}
    </ul>
  );
}

export default ExpensiveProducts;
```

</details>

---

## **Ejercicio 7: Ordenar y renderizar (crea una copia)**

Crea un componente `SortedUsers.jsx` con este array:

```js
const users = [
  { id: 21, name: "Zoe" },
  { id: 22, name: "Ana" },
  { id: 23, name: "Luis" },
];
```

- Renderiza los usuarios ordenados alfabéticamente por `name`.
- No modifiques el array original: crea una copia antes de ordenar.

<details><summary>Mostrar Solución</summary>

```js
function SortedUsers() {
  const users = [
    { id: 21, name: "Zoe" },
    { id: 22, name: "Ana" },
    { id: 23, name: "Luis" },
  ];

  const sortedUsers = [...users].sort((a, b) => a.name.localeCompare(b.name));

  return (
    <ul>
      {sortedUsers.map((user) => (
        <li key={user.id}>{user.name}</li>
      ))}
    </ul>
  );
}

export default SortedUsers;
```

</details>

---

## **Ejercicio 8: Renderizar una lista con formato (card simple)**

Crea un componente `BookCards.jsx` con este array:

```js
const books = [
  { id: 1, title: "Clean Code", author: "Robert C. Martin" },
  { id: 2, title: "Eloquent JavaScript", author: "Marijn Haverbeke" },
];
```

Renderiza cada libro en un `div` (tipo card) con:

- `h4` para el título
- `p` para el autor

Recuerda poner `key` en el `div` que se repite.

<details><summary>Mostrar Solución</summary>

```js
function BookCards() {
  const books = [
    { id: 1, title: "Clean Code", author: "Robert C. Martin" },
    { id: 2, title: "Eloquent JavaScript", author: "Marijn Haverbeke" },
  ];

  return (
    <div>
      {books.map((book) => (
        <div key={book.id}>
          <h4>{book.title}</h4>
          <p>{book.author}</p>
        </div>
      ))}
    </div>
  );
}

export default BookCards;
```

</details>

---

## **Ejercicio 9: Detectar una `key` incorrecta**

Este código tiene una `key` mala. Explica por qué y corrígelo.

```js
function Tags() {
  const tags = ["new", "sale", "featured", "sale"];

  return (
    <ul>
      {tags.map((tag) => (
        <li key={tag}>{tag}</li>
      ))}
    </ul>
  );
}
```

<details><summary>Mostrar Solución</summary>

El problema es que `tag` no es único ("sale" aparece dos veces). La `key` debe ser única dentro de la lista.

Soluciones posibles:

- Si los tags pueden repetirse, crear una key combinada con el index.
- O usar objetos con id.

Ejemplo simple (key combinada):

```js
function Tags() {
  const tags = ["new", "sale", "featured", "sale"];

  return (
    <ul>
      {tags.map((tag, index) => (
        <li key={`${tag}-${index}`}>{tag}</li>
      ))}
    </ul>
  );
}

export default Tags;
```

</details>

---

## **Ejercicio 10: Mini-caso (elige la mejor `key`)**

Tienes una lista de tareas:

```js
const tasks = [
  { id: 501, text: "Study" },
  { id: 502, text: "Practice" },
];
```

¿Cuál es la mejor `key` y por qué?

- a) `key={index}`
- b) `key={task.text}`
- c) `key={task.id}`

<details><summary>Mostrar Solución</summary>

La mejor opción es **c) `key={task.id}`**.

Motivo:

- Es única.
- Es estable.
- No depende del orden ni del texto.

</details>
