**Exercises - Topic 11: Props from Parent to Child**

Below you will find **10 practical exercises** to learn how to pass data from a parent component to a child component using **props**.

Try to solve them before looking at the solution.

---

## **Exercise 1: Pass a text as a prop**

Create a `Headline.jsx` component that receives a `text` prop and renders an `h2` with that text.

Then in `App.jsx`, use it like this:

- `Headline` with `text="React Basics"`

<details><summary>Show solution</summary>

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

## **Exercise 2: Pass a number and display it**

Create a `PriceTag.jsx` component that receives a `price` (number) prop and displays:

- `p` with: **"Price: X€"**

In `App.jsx`, pass it `price={29}`.

<details><summary>Show solution</summary>

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

## **Exercise 3: Boolean prop with conditional rendering**

Create a `FeatureBadge.jsx` component that receives a boolean `isFeatured` prop.

- If `isFeatured` is `true`, it displays: `span` with **"Featured"**.
- If it is `false`, it doesn't show anything.

Try it in `App.jsx` with `isFeatured` set to `true`.

<details><summary>Show solution</summary>

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

## **Exercise 4: Pass a variable (not a literal)**

In `App.jsx`, create:

- `const userName = "Marta";`

Create a `Greeting.jsx` component that receives `name` and displays:

- `p` with: **"Hello, Marta"** (dynamic).

<details><summary>Show solution</summary>

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

## **Exercise 5: Pass several props (destructuring in the child)**

Create a `ProfileSummary.jsx` component that receives:

- `name`
- `jobTitle`

It must render:

- `h3` with the name
- `p` with: **"Job: ..."**

In `App.jsx`, use it with `name="Alex"` and `jobTitle="Designer"`.

<details><summary>Show solution</summary>

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

## **Exercise 6: Pass an entire object as a prop**

Create a `UserRow.jsx` component that receives a `user` prop (an object) with:

- `name`
- `email`

It must render:

- `p` with: **"Name: ..."**
- `p` with: **"Email: ..."**

In `App.jsx`, create:

```js
const user = { name: "Leo", email: "leo@mail.com" };
```

And pass it as `user={user}`.

<details><summary>Show solution</summary>

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

## **Exercise 7: Props + list of objects**

Create a `CourseItem.jsx` component that receives `title` and `level` and renders:

- `li` with: **"Title - Level"**

Create a `CoursesList.jsx` component that has:

```js
const courses = [
  { id: 1, title: "React", level: "Beginner" },
  { id: 2, title: "Node", level: "Intermediate" },
  { id: 3, title: "CSS", level: "Beginner" },
];
```

- Render a `ul`.
- Use `.map()` to render `CourseItem`.
- Put the `key` on the repeated component using `course.id`.

<details><summary>Show solution</summary>

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

## **Exercise 8: Fix the curly braces error in a dynamic prop**

This code has an error. Fix it:

```js
function App() {
  const title = "React";

  return <Headline text=title />;
}
```

<details><summary>Show solution</summary>

In JSX, variables are passed with curly braces:

```js
function App() {
  const title = "React";

  return <Headline text={title} />;
}

export default App;
```

</details>

---

## **Exercise 9: Props with a default value (default)**

Create an `Avatar.jsx` component that receives an `altText` prop.

- If `altText` is not passed, it uses `"User avatar"` by default.
- It renders an `img` with `src="/avatar.png"` and `alt={altText}`.

Hint: you can define the default value in destructuring.

<details><summary>Show solution</summary>

```js
function Avatar({ altText = "User avatar" }) {
  return <img src="/avatar.png" alt={altText} />;
}

export default Avatar;
```

</details>

---

## **Exercise 10: Choose what to pass as a prop (mini-case)**

You have this child component:

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

And this data in the parent:

```js
const product = { id: 7, name: "Chair", price: 40 };
```

Write the correct JSX to render `ProductCard`, passing the appropriate props.

<details><summary>Show solution</summary>

```js
<ProductCard name={product.name} price={product.price} />
```

</details>
