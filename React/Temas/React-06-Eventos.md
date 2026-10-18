# **Topic 6: Events in React**

## **1. Introduction**

In a real application, the user continuously interacts with the interface:

- Clicks buttons
- Types into inputs
- Submits forms
- Hovers the mouse over elements

In React, these interactions are handled with **events**. Learning to handle events is the first step to turning your components from “static” into **interactive** ones.

In this topic you will learn:

- How events are written in React.
- How to create handler functions.
- How to use parameters.
- How to use the event object.
- Important differences from HTML.

---

## **2. How do you write events in React?**

In React, events are written using:

- Props in **camelCase**: `onClick`, `onChange`, `onSubmit`, etc.
- You pass them a **function**, not a string.

Example:

```js
function App() {
  const handleClick = () => {
    alert("Clicked!");
  };

  return <button onClick={handleClick}>Click</button>;
}

export default App;
```

Here:

- `onClick={handleClick}` passes a function to React.
- The function runs when the user clicks.

---

## **3. Handler functions**

The most common convention is to name them `handle...`:

- `handleClick`
- `handleChange`
- `handleSubmit`

Example:

```js
function LikeButton() {
  const handleLike = () => {
    console.log("Like!");
  };

  return <button onClick={handleLike}>Like</button>;
}

export default LikeButton;
```

---

## **4. Passing parameters to a function in an event**

If you want to pass parameters, you shouldn't call the function directly.

Incorrect (runs on render):

```js
<button onClick={handleMessage("Hello")}>Send</button>
```

Correct (runs on click):

```js
<button onClick={() => handleMessage("Hello")}>Send</button>
```

Complete example:

```js
function MessageButton() {
  const handleMessage = (text) => {
    alert(text);
  };

  return <button onClick={() => handleMessage("Hello")}>Send</button>;
}

export default MessageButton;
```

---

## **5. The event object (`event`)**

React automatically passes the event object to the handler.

Example with `onChange` in an input:

```js
function Search() {
  const handleChange = (event) => {
    console.log(event.target.value);
  };

  return <input onChange={handleChange} placeholder="Search..." />;
}

export default Search;
```

Here:

- `event.target.value` contains what the user is typing.

---

## **6. Common events in React**

Some of the most commonly used ones:

- `onClick`: click
- `onChange`: a change in inputs, selects and textareas
- `onSubmit`: form submission
- `onMouseEnter`: the mouse enters an element
- `onMouseLeave`: the mouse leaves it

Quick example with `onMouseEnter`:

```js
function HoverBox() {
  const handleEnter = () => {
    console.log("Mouse enter");
  };

  return <div onMouseEnter={handleEnter}>Hover me</div>;
}

export default HoverBox;
```

---

## **7. Preventing the default behavior (`preventDefault`)**

In forms, the browser tries to reload the page on submit.

In React, you usually prevent this with `event.preventDefault()`:

```js
function SimpleForm() {
  const handleSubmit = (event) => {
    event.preventDefault();
    console.log("Form submitted");
  };

  return (
    <form onSubmit={handleSubmit}>
      <button type="submit">Submit</button>
    </form>
  );
}

export default SimpleForm;
```

---

## **8. Important differences from HTML**

In traditional HTML you might see:

```html
<button onclick="doSomething()">Click</button>
```

In React it isn't done like that. In React:

- You don't use strings.
- You don't write `onclick` in lowercase.
- You use `onClick` and pass a function.

Correct example:

```js
<button onClick={doSomething}>Click</button>
```

---

## **9. Best practices**

- Name handlers with `handle...`.
- If you pass parameters, use an arrow function.
- Use `preventDefault()` in `onSubmit`.
- Keep the handler logic simple (we'll organize the complexity later with state and hooks).

---

## **10. Things to keep in mind**

- Events in React are written in camelCase.
- Handlers receive the `event` object.
- To pass parameters, use `() => ...`.
- For forms, remember `preventDefault()`.

---

[![Events](https://img.youtube.com/vi/t-L_Lo8XduQ/0.jpg)](https://www.youtube.com/watch?v=t-L_Lo8XduQ&list=PLzA2VyZwsq_-dE3Jvunglxq8a6UcH6gnF)

---

In the next topic we'll look at **useState**, which will let us store information in the component and update the UI when it changes.
