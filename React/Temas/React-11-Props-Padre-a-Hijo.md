# **Topic 11: Props Father to Son**

## **1. Introduction**

So far we've created components and rendered lists, but we're still missing something essential to building real interfaces: **passing data between components**.

In React, data typically “flows down” from parent components to child components. This communication is done through **props**.

In this topic you will learn:

- What props are and what they are for.
- How to pass props from a parent component to a child component.
- How to read props in the child component.
- How to use `props` with destructuring.
- Good practices and typical errors.

---

## **2. What are props?**

**Props** (properties) are values that a component receives from outside.

- A **parent** component sends data.
- A **child** component receives them.
- The son should not modify those props.

Think of a component as a function:

- You pass him arguments.
- Returns a result.

In React:

- You pass him props.
- Returns JSX.

---

## **3. Pass props from parent**

To pass props, you write attributes to the child component:

```js
<UserCard name="Alex" role="Admin" />
```

Here:

- `name` and `role` are props.
- Its values ​​are sent from the parent.

---

## **4. Receive props on child**

### **4.1. Way 1: Receive `props` as an object**

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

This way works, but when there are many props it can be less comfortable.

---

### **4.2. Way 2: Destructuring (recommended)**

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
- Do not repeat `props.`.

---

## **5. Complete example: Father → Son**

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

Note that:

- `App` is the parent.
- `UserCard` is the son.
- The parent reuses the same component with different values.

---

## **6. Pass dynamic values (variables) as props**

You will not always pass strings “by hand”. The normal thing is to pass variables.

Example:

```js
function App() {
  const userName = "Sara";
  const userRole = "Editor";

  return <UserCard name={userName} role={userRole} />;
}
```

Here:

- The `{}` braces indicate that you are passing a **JavaScript expression**.
- There are no quotes.

---

## **7. Pass numbers, booleans and objects**

Props can be of any type.

### **7.1. Number**

```js
<ProductPrice price={19} />
```

### **7.2. Boolean**

```js
<Badge isNew={true} />
```

In booleans, you can use the short version:

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

- The `key` goes in the repeating component.
- The rest of the data is passed as props.

---

## **9. Typical errors**

### **9.1. Forgetting braces in dynamic values**

Incorrect:

```js
<UserCard name=userName />
```

Correct:

```js
<UserCard name={userName} />
```

---

### **9.2. Try to modify props in the child**

Props are read-only.

Incorrect:

```js
function UserCard({ name }) {
  name = "Other";
  return <p>{name}</p>;
}
```

If you need to change something, that usually indicates that it should be **state** (useState) or that the parent should send different values.

---

## **10. Good practices**

- Name props with intention: `title`, `isOpen`, `price`.
- Keep child components as “presentational” as possible.
- Use destructuring when the component receives multiple props.
- If you pass a lot of props, you may need to reorganize components (or use Context later).

---

## **11. To take into account**

- Props = data that a parent sends to a child.
- The usual flow is from top to bottom.
- The props are not modified in the child.
- You can pass any type of data.

---

[![Props Father to Son](https://img.youtube.com/vi/N-uDcR4t9Yk/0.jpg)](https://www.youtube.com/watch?v=N-uDcR4t9Yk&list=PLzA2VyZwsq_-dE3Jvunglxq8a6UcH6gnF)

---

In the next topic we will look at **`className` and `htmlFor`**, two key attributes in React when working with CSS and forms.
