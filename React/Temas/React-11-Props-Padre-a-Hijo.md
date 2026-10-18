# **Topic 11: Props from Parent to Child**

## **1. Introduction**

So far we've created components and rendered lists, but we're still missing something essential to building real interfaces: **passing data between components**.

In React, data typically “flows down” from parent components to child components. This communication is done through **props**.

In this topic you will learn:

- What props are and what they're for.
- How to pass props from a parent component to a child component.
- How to read props in the child component.
- How to use `props` with destructuring.
- Best practices and common mistakes.

---

## **2. What are props?**

**Props** (properties) are values that a component receives from outside.

- A **parent** component sends data.
- A **child** component receives it.
- The child shouldn't modify those props.

Think of a component as a function:

- You pass it arguments.
- It returns a result.

In React:

- You pass it props.
- It returns JSX.

---

## **3. Passing props from the parent**

To pass props, you write attributes on the child component:

```js
<UserCard name="Alex" role="Admin" />
```

Here:

- `name` and `role` are props.
- Their values are sent from the parent.

---

## **4. Receiving props in the child**

### **4.1. Option 1: Receiving `props` as an object**

```js
function UserCard(props) {
  return (
    <div>
      <h3>{props.name}</h3>
      <p>{props.role}</p>
    </div>
  );
}

export default UserCard;
```

This works, but when there are many props it can be less convenient.

---

### **4.2. Option 2: Destructuring (recommended)**

```js
function UserCard({ name, role }) {
  return (
    <div>
      <h3>{name}</h3>
      <p>{role}</p>
    </div>
  );
}

export default UserCard;
```

Advantages:

- Cleaner code.
- You don't repeat `props.`.

---

## **5. Complete example: Parent → Child**

### **5.1. `UserCard.jsx`**

```js
function UserCard({ name, role }) {
  return (
    <div>
      <h3>{name}</h3>
      <p>Role: {role}</p>
    </div>
  );
}

export default UserCard;
```

### **5.2. `App.jsx`**

```js
import UserCard from "./components/UserCard";

function App() {
  return (
    <div>
      <UserCard name="Alex" role="Admin" />
      <UserCard name="Marta" role="User" />
    </div>
  );
}

export default App;
```

Notice that:

- `App` is the parent.
- `UserCard` is the child.
- The parent reuses the same component with different values.

---

## **6. Passing dynamic values (variables) as props**

You won't always pass strings “by hand”. Usually you'll pass variables.

Example:

```js
function App() {
  const userName = "Sara";
  const userRole = "Editor";

  return <UserCard name={userName} role={userRole} />;
}
```

Here:

- The curly braces `{}` indicate that you're passing a **JavaScript expression**.
- You don't use quotes.

---

## **7. Passing numbers, booleans and objects**

Props can be of any type.

### **7.1. Number**

```js
<ProductPrice price={19} />
```

### **7.2. Boolean**

```js
<Badge isNew={true} />
```

For booleans, you can use the shorthand:

```js
<Badge isNew />
```

### **7.3. Object**

```js
const user = { name: "Leo", role: "User" };

<UserCard name={user.name} role={user.role} />;
```

---

## **8. Props and lists (very common pattern)**

A typical case: you render a list and pass each item as props to a component.

### **8.1. Child component `TaskItem.jsx`**

```js
function TaskItem({ text, done }) {
  return (
    <li>
      {text} - {done ? "Done" : "Pending"}
    </li>
  );
}

export default TaskItem;
```

### **8.2. Parent component `TasksList.jsx`**

```js
import TaskItem from "./TaskItem";

function TasksList() {
  const tasks = [
    { id: 1, text: "Study", done: true },
    { id: 2, text: "Practice", done: false },
  ];

  return (
    <ul>
      {tasks.map((task) => (
        <TaskItem key={task.id} text={task.text} done={task.done} />
      ))}
    </ul>
  );
}

export default TasksList;
```

Here:

- The `key` goes on the repeated component.
- The rest of the data is passed as props.

---

## **9. Common mistakes**

### **9.1. Forgetting the braces in dynamic values**

Incorrect:

```js
<UserCard name=userName />
```

Correct:

```js
<UserCard name={userName} />
```

---

### **9.2. Trying to modify props in the child**

Props are read-only.

Incorrect:

```js
function UserCard({ name }) {
  name = "Other";
  return <p>{name}</p>;
}
```

If you need to change something, that usually means it should be **state** (useState) or that the parent should send different values.

---

## **10. Best practices**

- Name props with intent: `title`, `isOpen`, `price`.
- Keep child components as “presentational” as possible.
- Use destructuring when the component receives several props.
- If you're passing a lot of props, you may need to reorganize your components (or use Context later on).

---

## **11. Things to keep in mind**

- Props = data that a parent sends to a child.
- The usual flow is top-down.
- Props aren't modified in the child.
- You can pass any type of data.

---

[![Props from Parent to Child](https://img.youtube.com/vi/N-uDcR4t9Yk/0.jpg)](https://www.youtube.com/watch?v=N-uDcR4t9Yk&list=PLzA2VyZwsq_-dE3Jvunglxq8a6UcH6gnF)

---

In the next topic we'll look at **`className` and `htmlFor`**, two key attributes in React when you work with CSS and forms.
