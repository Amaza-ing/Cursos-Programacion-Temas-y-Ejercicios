# **Topic 10: Lists, Index and Object Lists**

## **1. Introduction**

In a real application, you rarely render elements “by hand” one by one. The usual approach is to have a collection of data (an array) and generate the interface dynamically.

In React, this is done by rendering **lists** with `.map()`.

In this topic you will learn:

- How to render lists with `.map()`.
- What the `key` prop is and why it's important.
- When to use the **index** as the `key` and when to avoid it.
- How to render **lists of objects**.

---

## **2. Rendering a simple list with `.map()`**

A typical pattern:

- You have an array.
- You loop through it with `.map()`.
- You return JSX for each element.

Example with a list of strings:

```js
function FruitsList() {
  const fruits = ["Apple", "Banana", "Orange"];

  return (
    <ul>
      {fruits.map((fruit) => (
        <li key={fruit}>{fruit}</li>
      ))}
    </ul>
  );
}

export default FruitsList;
```

Important details:

- `.map()` returns a **new array**.
- Each list item in React must have a `key`.

---

## **3. The `key` prop (very important)**

When React renders a list, it needs a stable way to identify each element. That's what `key` is for.

- `key` must be **unique** within that list.
- It must be **stable** (ideally it doesn't change between renders).

Recommended example:

```js
<li key={fruit}>{fruit}</li>
```

---

[![Lists](https://img.youtube.com/vi/c8j6TtAqTYQ/0.jpg)](https://www.youtube.com/watch?v=c8j6TtAqTYQ&list=PLzA2VyZwsq_-dE3Jvunglxq8a6UcH6gnF)

---

## **4. Lists with `index` (Index Lists)**

Sometimes the **index** from `.map()` is used as the `key`:

```js
function ColorsList() {
  const colors = ["Blue", "Gray", "Purple"];

  return (
    <ul>
      {colors.map((color, index) => (
        <li key={index}>{color}</li>
      ))}
    </ul>
  );
}

export default ColorsList;
```

### **4.1. When can you use the index as the `key`?**

You can use `index` if these conditions are met:

- The list is **static** (it isn't reordered).
- No elements are removed or inserted in the middle.
- The elements don't have a stable id.

Typical example: a fixed list of steps in a tutorial.

### **4.2. When should you NOT use the index as the `key`?**

Avoid it if:

- You can reorder the list.
- You can remove/add elements.
- The elements have associated state or inputs.

If React misidentifies the elements, it can:

- Reuse an element where it doesn't belong.
- Show data that has “moved places”.
- Keep state in the wrong item.

---

[![Index Lists](https://img.youtube.com/vi/HFp69Sp1bR0/0.jpg)](https://www.youtube.com/watch?v=HFp69Sp1bR0&list=PLzA2VyZwsq_-dE3Jvunglxq8a6UcH6gnF)

---

## **5. Rendering lists of objects (Object Lists)**

Most commonly, your list is an array of objects.

Example:

```js
function UsersList() {
  const users = [
    { id: 101, name: "Alex", role: "Admin" },
    { id: 102, name: "Marta", role: "User" },
    { id: 103, name: "Leo", role: "User" },
  ];

  return (
    <ul>
      {users.map((user) => (
        <li key={user.id}>
          {user.name} - {user.role}
        </li>
      ))}
    </ul>
  );
}

export default UsersList;
```

Here the ideal `key` is `user.id` because:

- It's unique.
- It doesn't change.
- React can identify each item correctly.

---

[![Object Lists](https://img.youtube.com/vi/RxJ-8PTAuBY/0.jpg)](https://www.youtube.com/watch?v=RxJ-8PTAuBY&list=PLzA2VyZwsq_-dE3Jvunglxq8a6UcH6gnF)

---

## **6. Rendering components inside a list**

A very common pattern is to have an “item” component and render it in the `.map()`.

### **6.1. `UserItem.jsx`**

```js
function UserItem({ name, role }) {
  return (
    <li>
      <strong>{name}</strong> - {role}
    </li>
  );
}

export default UserItem;
```

### **6.2. `UsersList.jsx`**

```js
import UserItem from "./UserItem";

function UsersList() {
  const users = [
    { id: 1, name: "Alex", role: "Admin" },
    { id: 2, name: "Marta", role: "User" },
  ];

  return (
    <ul>
      {users.map((user) => (
        <UserItem key={user.id} name={user.name} role={user.role} />
      ))}
    </ul>
  );
}

export default UsersList;
```

Notice that:

- The `key` goes on the **repeated component** (`UserItem`).
- `UserItem` receives data through props.

---

## **7. Best practices with lists**

- Use a stable `key` (ideally an `id`).
- Avoid using `index` as `key` if the list may change.
- If the JSX inside `.map()` becomes large, create a component for each item.
- Keep lists simple and readable.

---

## **8. Things to keep in mind**

- To render lists in React, you use `.map()`.
- Each item must have a `key`.
- `index` as `key` only in static lists.
- In lists of objects, use `id` as `key`.

In the next topic we'll look at **Props from Parent to Child** to share dynamic information between components.
