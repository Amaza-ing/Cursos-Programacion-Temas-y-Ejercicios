**Ejercicios - Tema 11: Props Padre a Hijo**

A continuación, encontrarás **10 ejercicios prácticos** para aprender a pasar datos desde un componente padre a un componente hijo usando **props**.

Intenta resolverlos antes de consultar la solución.

---

## **Ejercicio 1: Pasar un texto como prop**

Crea un componente `Headline.jsx` que reciba una prop `text` y renderice un `h2` con ese texto.

Luego, en `App.jsx`, úsalo así:

- `Headline` con `text="React Basics"`

<details><summary>Mostrar Solución</summary>

**`Headline.jsx`**

```js
function Headline({ text }) {
  return <h2>{text}</h2>;
}

export default Headline;
```

**`App.jsx`**

```js
import Headline from "./components/Headline";

function App() {
  return (
    <div>
      <Headline text="React Basics" />
    </div>
  );
}

export default App;
```

</details>

---

## **Ejercicio 2: Pasar un número y mostrarlo**

Crea un componente `PriceTag.jsx` que reciba una prop `price` (número) y muestre:

- `p` con: **"Price: X€"**

En `App.jsx`, pásale `price={29}`.

<details><summary>Mostrar Solución</summary>

**`PriceTag.jsx`**

```js
function PriceTag({ price }) {
  return <p>Price: {price}€</p>;
}

export default PriceTag;
```

**`App.jsx`**

```js
import PriceTag from "./components/PriceTag";

function App() {
  return (
    <div>
      <PriceTag price={29} />
    </div>
  );
}

export default App;
```

</details>

---

## **Ejercicio 3: Prop booleana con renderizado condicional**

Crea un componente `FeatureBadge.jsx` que reciba una prop booleana `isFeatured`.

- Si `isFeatured` es `true`, muestra: `span` con **"Featured"**.
- Si es `false`, no muestres nada.

Pruébalo en `App.jsx` con `isFeatured` en `true`.

<details><summary>Mostrar Solución</summary>

**`FeatureBadge.jsx`**

```js
function FeatureBadge({ isFeatured }) {
  return <>{isFeatured && <span>Featured</span>}</>;
}

export default FeatureBadge;
```

**`App.jsx`**

```js
import FeatureBadge from "./components/FeatureBadge";

function App() {
  return (
    <div>
      <FeatureBadge isFeatured={true} />
    </div>
  );
}

export default App;
```

</details>

---

## **Ejercicio 4: Pasar una variable (no un literal)**

En `App.jsx`, crea:

- `const userName = "Marta";`

Crea un componente `Greeting.jsx` que reciba `name` y muestre:

- `p` con: **"Hello, Marta"** (dinámico).

<details><summary>Mostrar Solución</summary>

**`Greeting.jsx`**

```js
function Greeting({ name }) {
  return <p>Hello, {name}</p>;
}

export default Greeting;
```

**`App.jsx`**

```js
import Greeting from "./components/Greeting";

function App() {
  const userName = "Marta";

  return (
    <div>
      <Greeting name={userName} />
    </div>
  );
}

export default App;
```

</details>

---

## **Ejercicio 5: Pasar varias props (destructuring en el hijo)**

Crea un componente `ProfileSummary.jsx` que reciba:

- `name`
- `jobTitle`

Debe renderizar:

- `h3` con el nombre
- `p` con: **"Job: ..."**

En `App.jsx`, úsalo con `name="Alex"` y `jobTitle="Designer"`.

<details><summary>Mostrar Solución</summary>

**`ProfileSummary.jsx`**

```js
function ProfileSummary({ name, jobTitle }) {
  return (
    <div>
      <h3>{name}</h3>
      <p>Job: {jobTitle}</p>
    </div>
  );
}

export default ProfileSummary;
```

**`App.jsx`**

```js
import ProfileSummary from "./components/ProfileSummary";

function App() {
  return (
    <div>
      <ProfileSummary name="Alex" jobTitle="Designer" />
    </div>
  );
}

export default App;
```

</details>

---

## **Ejercicio 6: Pasar un objeto completo como prop**

Crea un componente `UserRow.jsx` que reciba una prop `user` (objeto) con:

- `name`
- `email`

Debe renderizar:

- `p` con: **"Name: ..."**
- `p` con: **"Email: ..."**

En `App.jsx`, crea:

```js
const user = { name: "Leo", email: "leo@mail.com" };
```

Y pásalo como `user={user}`.

<details><summary>Mostrar Solución</summary>

**`UserRow.jsx`**

```js
function UserRow({ user }) {
  return (
    <div>
      <p>Name: {user.name}</p>
      <p>Email: {user.email}</p>
    </div>
  );
}

export default UserRow;
```

**`App.jsx`**

```js
import UserRow from "./components/UserRow";

function App() {
  const user = { name: "Leo", email: "leo@mail.com" };

  return (
    <div>
      <UserRow user={user} />
    </div>
  );
}

export default App;
```

</details>

---

## **Ejercicio 7: Props + lista de objetos**

Crea un componente `CourseItem.jsx` que reciba `title` y `level` y renderice:

- `li` con: **"Title - Level"**

Crea un componente `CoursesList.jsx` que tenga:

```js
const courses = [
  { id: 1, title: "React", level: "Beginner" },
  { id: 2, title: "Node", level: "Intermediate" },
  { id: 3, title: "CSS", level: "Beginner" },
];
```

- Renderiza un `ul`.
- Usa `.map()` para renderizar `CourseItem`.
- Pon la `key` en el componente repetido usando `course.id`.

<details><summary>Mostrar Solución</summary>

**`CourseItem.jsx`**

```js
function CourseItem({ title, level }) {
  return (
    <li>
      {title} - {level}
    </li>
  );
}

export default CourseItem;
```

**`CoursesList.jsx`**

```js
import CourseItem from "./CourseItem";

function CoursesList() {
  const courses = [
    { id: 1, title: "React", level: "Beginner" },
    { id: 2, title: "Node", level: "Intermediate" },
    { id: 3, title: "CSS", level: "Beginner" },
  ];

  return (
    <ul>
      {courses.map((course) => (
        <CourseItem key={course.id} title={course.title} level={course.level} />
      ))}
    </ul>
  );
}

export default CoursesList;
```

</details>

---

## **Ejercicio 8: Corregir el error de llaves en una prop dinámica**

Este código tiene un error. Corrígelo:

```js
function App() {
  const title = "React";

  return <Headline text=title />;
}
```

<details><summary>Mostrar Solución</summary>

En JSX, las variables se pasan con llaves:

```js
function App() {
  const title = "React";

  return <Headline text={title} />;
}

export default App;
```

</details>

---

## **Ejercicio 9: Props con valor por defecto (default)**

Crea un componente `Avatar.jsx` que reciba una prop `altText`.

- Si `altText` no viene, usa por defecto `"User avatar"`.
- Renderiza un `img` con `src="/avatar.png"` y `alt={altText}`.

Pista: puedes definir el valor por defecto en el destructuring.

<details><summary>Mostrar Solución</summary>

```js
function Avatar({ altText = "User avatar" }) {
  return <img src="/avatar.png" alt={altText} />;
}

export default Avatar;
```

</details>

---

## **Ejercicio 10: Elegir qué pasar como prop (mini-caso)**

Tienes este componente hijo:

```js
function ProductCard({ name, price }) {
  return (
    <div>
      <h4>{name}</h4>
      <p>{price}€</p>
    </div>
  );
}
```

Y estos datos en el padre:

```js
const product = { id: 7, name: "Chair", price: 40 };
```

Escribe el JSX correcto para renderizar `ProductCard` pasando las props adecuadas.

<details><summary>Mostrar Solución</summary>

```js
<ProductCard name={product.name} price={product.price} />
```

</details>
