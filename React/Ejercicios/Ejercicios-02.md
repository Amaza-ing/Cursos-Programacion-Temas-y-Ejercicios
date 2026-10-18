# **Exercises - Topic 2: File Schema in React**

Below, you will find **5 practical exercises** on the file schema and organization of a React project.

Try to solve them before consulting the solution.

---

## **Exercise 1: Identify responsibilities**

In a React project with Vite, indicate **which file or folder** you would use for each case:

1. Save an image that you want to import in a component (`import logo from ...`).
2. Define global styles for the entire application.
3. Mount React on the DOM.
4. Save a static file accessible by direct URL (for example `/robots.txt`).

<details><summary>Show Solution</summary>

1. `src/assets/` (or `src/assets/...`) because the file goes through the bundler and is imported from the code.
2. `src/index.css` (or the global file you import from `main.jsx`).
3. `src/main.jsx`.
4. `public/`.

</details>

---

## **Exercise 2: Create a recommended structure**

Within `src/`, create (on paper or in your editor) a recommended structure that includes:

- A folder for reusable components.
- A folder for pages.
- A folder for services.
- A folder for hooks.

Then, add **an example file** with a correct name inside each folder.

<details><summary>Show Solution</summary>

Valid example:

```
src/
│── components/
│   ├── Navbar.jsx
│── pages/
│   ├── Home.jsx
│── services/
│   ├── api.js
│── hooks/
│   ├── useLocalStorage.js
│── assets/
│── App.jsx
│── main.jsx
│── index.css
```

</details>

---

## **Exercise 3: Correct a messy structure**

You have this (poorly organized) structure:

```
src/
│── Header.jsx
│── Home.jsx
│── fetchUsers.js
│── useCounter.js
│── images/
│   ├── avatar.png
│── App.jsx
│── main.jsx
```

Reorganize it using the theme's recommended structure (without changing the content of the files, just their location). Keep names in English.

<details><summary>Show Solution</summary>

A correct reorganization could be:

```
src/
│── components/
│   ├── Header.jsx
│── pages/
│   ├── Home.jsx
│── services/
│   ├── fetchUsers.js
│── hooks/
│   ├── useCounter.js
│── assets/
│   ├── avatar.png
│── App.jsx
│── main.jsx
```

Notes:

- `Header.jsx` is a reusable component.
- `Home.jsx` is a page.
- `fetchUsers.js` is API (service) logic.
- `useCounter.js` is a hook.
- The image can go in `assets/` (if it will be imported from code).

</details>

---

## **Exercise 4: Naming Conventions (choose the correct option)**

Select the most correct name in each case according to the conventions of the theme:

1. User card component:

   - a) `usercard.jsx`
   - b) `UserCard.jsx`
   - c) `userCard.jsx`

2. Function that handles one click:

   - a) `Handle_Click()`
   - b) `handleClick`
   - c) `handle_click`

3. Custom hook for dark theme:

   - a) `UseDarkMode.js`
   - b) `useDarkMode.js`
   - c) `use-dark-mode.js`

<details><summary>Show Solution</summary>

1. b) `UserCard.jsx` (components in PascalCase).
2. b) `handleClick` (functions in camelCase).
3. b) `useDarkMode.js` (hooks in camelCase starting with `use`).

</details>

---

## **Exercise 5: Choose carefully between `public` and `assets`**

You have these cases. Indicate whether you would save it in `public/` or `src/assets/` and explain why:

1. An `favicon.ico`.
2. An `banner.png` image that you will use inside a component with `import banner from ...`.
3. An `robots.txt` file.
4. An `terms.pdf` file that you want to open with a direct `/terms.pdf` link.
<details><summary>Show Solution</summary>

1. `public/` (static resource that must be accessible directly and without import).
2. `src/assets/` (will be imported from JavaScript and goes through the bundler).
3. `public/` (must be accessible as `/robots.txt`).
4. `public/` (if you want direct access by URL: `/terms.pdf`).

</details>
