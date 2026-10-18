# **Exercises - Topic 10: Lists, Index and Object Lists**

Below you will find **10 practical exercises** to learn how to render lists in React with `.map()`, use `key` correctly, and work with **lists of objects**.

Try to solve them before looking at the solution.

---

## **Exercise 1: Simple list of strings**

Create a `CitiesList.jsx` component that renders a `ul` with these cities:

```js
const cities = ["Madrid", "Sevilla", "Valencia", "Bilbao"];
```

- Render each city in an `li`.
- Use a stable `key` (don't use the index).

<details><summary>Show solution</summary>

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

## **Exercise 2: Also show the index (without using it as a key)**

Create a `Steps.jsx` component with this array:

```js
const steps = ["Install", "Create", "Run", "Build"];
```

- Render each step as: `1. Install`, `2. Create`, etc.
- Show the number using the `index`.
- The `key` must NOT be the `index` (use the step's text).

<details><summary>Show solution</summary>

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

## **Exercise 3: When to use the index as `key` (static list)**

Create a `FixedRules.jsx` component with a fixed list of 3 rules:

- "Be respectful"
- "Write clear code"
- "Keep components small"

In this case, use the **index** as `key` and add a comment in the code explaining why it is acceptable here.

<details><summary>Show solution</summary>

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

## **Exercise 4: List of objects with `id` as key**

Create a `ProductsList.jsx` component with this array:

```js
const products = [
  { id: 10, name: "Keyboard", price: 30 },
  { id: 11, name: "Mouse", price: 15 },
  { id: 12, name: "Monitor", price: 120 },
];
```

Render a `ul` where each `li` displays:

- `Keyboard - 30€`

Use `product.id` as `key`.

<details><summary>Show solution</summary>

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

## **Exercise 5: Render components inside a list**

Create a `SkillItem.jsx` component that receives `name` through props and renders:

- An `li` with the skill text.

Then create `SkillsList.jsx` with this array:

```js
const skills = [
  { id: 1, name: "React" },
  { id: 2, name: "JavaScript" },
  { id: 3, name: "CSS" },
];
```

Render `SkillItem` using `.map()` and put the `key` on the component that repeats.

<details><summary>Show solution</summary>

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

## **Exercise 6: Filter and render (without modifying the original array)**

Create an `ExpensiveProducts.jsx` component with this array:

```js
const products = [
  { id: 1, name: "USB", price: 8 },
  { id: 2, name: "Headphones", price: 45 },
  { id: 3, name: "Laptop Stand", price: 25 },
];
```

- Render only the products with `price >= 25`.
- Use `.filter()` before `.map()`.

<details><summary>Show solution</summary>

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

## **Exercise 7: Sort and render (create a copy)**

Create a `SortedUsers.jsx` component with this array:

```js
const users = [
  { id: 21, name: "Zoe" },
  { id: 22, name: "Ana" },
  { id: 23, name: "Luis" },
];
```

- Render the users sorted alphabetically by `name`.
- Do not modify the original array: create a copy before sorting.

<details><summary>Show solution</summary>

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

## **Exercise 8: Render a formatted list (simple card)**

Create a `BookCards.jsx` component with this array:

```js
const books = [
  { id: 1, title: "Clean Code", author: "Robert C. Martin" },
  { id: 2, title: "Eloquent JavaScript", author: "Marijn Haverbeke" },
];
```

Render each book in a `div` (card style) with:

- `h4` for the title
- `p` for the author

Remember to put the `key` on the `div` that repeats.

<details><summary>Show solution</summary>

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

## **Exercise 9: Spot an incorrect `key`**

This code has a bad `key`. Explain why and fix it.

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

<details><summary>Show solution</summary>

The problem is that `tag` is not unique ("sale" appears twice). The `key` must be unique within the list.

Possible solutions:

- If the tags can be repeated, create a key combined with the index.
- Or use objects with an id.

Simple example (combined key):

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

## **Exercise 10: Mini-case (choose the best `key`)**

You have a list of tasks:

```js
const tasks = [
  { id: 501, text: "Study" },
  { id: 502, text: "Practice" },
];
```

Which is the best `key` and why?

- a) `key={index}`
- b) `key={task.text}`
- c) `key={task.id}`

<details><summary>Show solution</summary>

The best option is **c) `key={task.id}`**.

Reason:

- It's unique.
- It's stable.
- It does not depend on the order or the text.

</details>
