# **Topic 10: Lists, Index and Object Lists**

## **1. Introduction**

In a real application, you rarely render elements “by hand” one by one. The usual thing is to have a collection of data (array) and generate the interface dynamically.

In React, this is done by rendering **lists** with `.map()`.

In this topic you will learn:

- How to render lists with `.map()`.
- What is the `key` prop and why is it important.
- When to use **index** like `key` and when to avoid it.
- How to render **lists of objects**.

---

## **2. Render a simple list with `.map()`**

A typical pattern:

- You have an array.
- You go through it with `.map()`.
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
- Each list item in React must have an `key`.

---

## **3. The `key` prop (very important)**

When React renders a list, it needs a stable way to identify each element. That's what `key` is for.

- `key` must be **unique** within that list.
- It must be **stable** (ideally it does not change between renders).

Recommended example:

```js
<li key={fruit}>{fruit}</li>
```

---

[![Lists](https://img.youtube.com/vi/c8j6TtAqTYQ/0.jpg)](https://www.youtube.com/watch?v=c8j6TtAqTYQ&list=PLzA2VyZwsq_-dE3Jvunglxq8a6UcH6gnF)

---

## **4. Lists with `index` (Index Lists)**

Sometimes the **index** of `.map()` is used as `key`:

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

### **4.1. When can you use the index like `key`?**

You can use `index` if these conditions are met:

- The list is **static** (it is not reordered).
- No elements are deleted or inserted in between.
- Each element does not have a stable id.

Typical example: a fixed list of steps in a tutorial.

### **4.2. When should you NOT use index like `key`?**

Avoid it if:

- You can reorder the list.
- You can delete/add elements.
- Elements have associated status or inputs.

If React misidentifies elements, you can:

- Reuse an element where it does not belong.
- Show “changed location” data.
- Keep states on the wrong item.

---

[![Index Lists](https://img.youtube.com/vi/HFp69Sp1bR0/0.jpg)](https://www.youtube.com/watch?v=HFp69Sp1bR0&list=PLzA2VyZwsq_-dE3Jvunglxq8a6UcH6gnF)

---

## **5. Render lists of objects (Object Lists)**

The most common thing is that your list is an array of objects.

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
- Doesn't change.
- React can identify each item correctly.

---

[![Item Lists](https://img.youtube.com/vi/RxJ-8PTAuBY/0.jpg)](https://www.youtube.com/watch?v=RxJ-8PTAuBY&list=PLzA2VyZwsq_-dE3Jvunglxq8a6UcH6gnF)

---

## **6. Render components within a list**

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

Note that:

- The `key` is put in the **repeating component** (`UserItem`).
- `UserItem` receives data by props.

---

## **7. Good practices with lists**

- Use a stable `key` (ideally an `id`).
- Avoid using `index` as `key` if the list may change.
- If the JSX inside `.map()` becomes large, create a component for each item.
- Keep lists simple and readable.

---

## **8. To take into account**

- To render lists in React, `.map()` is used.
- Each item must have an `key`.
- `index` as `key` only in static lists.
- In item lists, use `id` as `key`.

In the next topic we will see **Parent to Child Props** to share dynamic information between components.
