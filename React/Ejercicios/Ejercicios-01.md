# **Exercises - Topic 1: Getting started with React**

Below, you will find **5 practical exercises** on the contents of Topic 1.

Try to solve them before consulting the solution.

---

## **Exercise 1: Create a project with Vite**

Create a React project with Vite called `react-starter`.

**Requirements:**

- Use Vite to generate the project.
- Enter the folder.
- Install dependencies.

<details><summary>Show Solution</summary>

```sh
npm create vite@latest react-starter
cd react-starter
npm install
```

</details>

---

## **Exercise 2: Raise the server and locate the URL**

Raise the project's development server and write the local URL where the app will be seen.

**Hint:** the command is the development script and Vite usually uses the `5173` port.

<details><summary>Show Solution</summary>

```sh
npm run dev
```

The app will normally be seen in:

```
http://localhost:5173
```

</details>

---

## **Exercise 3: Modify `App.jsx` to display dynamic data**

Edit `src/App.jsx` so that:

- Display a title with the text **"React Starter"**.
- Display a paragraph with the current year (for example: `2025`) using a variable called `currentYear`.

<details><summary>Show Solution</summary>

```js
function App() {
  const currentYear = new Date().getFullYear();

  return (
    <div>
      <h1>React Starter</h1>
      <p>Año actual: {currentYear}</p>
    </div>
  );
}

export default App;
```

</details>

---

## **Exercise 4: Understanding the entry point (`main.jsx`)**

Answer:

1. What file is React “mounted” in the DOM?
2. What id does the HTML element have where the application is rendered?
3. Which component is rendered as root?

<details><summary>Show Solution</summary>

1. In `src/main.jsx`.
2. The id is `root` (it is in `index.html`).
3. The root component is `App`.

</details>

---

## **Exercise 5: JSX with simple conditions (without advanced conditional rendering)**

Without using conditional rendering yet (more on that later), create the following in `App.jsx`:

- An `userName` variable with your name.
- An `h2` that says: **"Hello, {userName}"**.
- An `p` that displays the result of `2 + 3` within JSX.

<details><summary>Show Solution</summary>

```js
function App() {
  const userName = "Sara";

  return (
    <div>
      <h2>Hola, {userName}</h2>
      <p>2 + 3 = {2 + 3}</p>
    </div>
  );
}

export default App;
```

</details>
