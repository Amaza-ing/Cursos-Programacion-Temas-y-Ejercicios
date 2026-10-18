# **Exercises - Topic 1: Getting started with React**

Below, you will find **5 practical exercises** on the contents of Topic 1.

Try to solve them before looking at the solution.

---

## **Exercise 1: Create a project with Vite**

Create a React project with Vite called `react-starter`.

**Requirements:**

- Use Vite to generate the project.
- Enter the folder.
- Install dependencies.

<details><summary>Show solution</summary>

```sh
npm create vite@latest react-starter
cd react-starter
npm install
```

</details>

---

## **Exercise 2: Start the server and find the URL**

Start the project's development server and write down the local URL where you'll see the app.

**Hint:** the command is the development script, and Vite usually uses port `5173`.

<details><summary>Show solution</summary>

```sh
npm run dev
```

You'll normally see the app at:

```
http://localhost:5173
```

</details>

---

## **Exercise 3: Modify `App.jsx` to display dynamic data**

Edit `src/App.jsx` so that it:

- Displays a title with the text **"React Starter"**.
- Displays a paragraph with the current year (for example: `2025`) using a variable called `currentYear`.

<details><summary>Show solution</summary>

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

## **Exercise 4: Understand the entry point (`main.jsx`)**

Answer:

1. In which file is React “mounted” on the DOM?
2. What is the id of the HTML element where the application is rendered?
3. Which component is rendered as the root?

<details><summary>Show solution</summary>

1. In `src/main.jsx`.
2. The id is `root` (it is in `index.html`).
3. The root component is `App`.

</details>

---

## **Exercise 5: JSX with simple conditions (without advanced conditional rendering)**

Without using conditional rendering yet (more on that later), create the following in `App.jsx`:

- A `userName` variable with your name.
- An `h2` that says: **"Hello, {userName}"**.
- A `p` that displays the result of `2 + 3` inside JSX.

<details><summary>Show solution</summary>

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
