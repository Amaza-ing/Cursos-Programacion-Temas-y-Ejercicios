# **Exercises - Topic 2: File Structure in React**

Below, you will find **5 practical exercises** on the file structure and organization of a React project.

Try to solve them before looking at the solution.

---

## **Exercise 1: Identify responsibilities**

In a React project with Vite, indicate **which file or folder** you would use for each case:

1. Store an image that you want to import into a component (`import logo from ...`).
2. Define global styles for the entire application.
3. Mount React on the DOM.
4. Store a static file that can be reached through a direct URL (for example `/robots.txt`).

<details><summary>Show solution</summary>

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

<details><summary>Show solution</summary>

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

Reorganize it using the topic's recommended structure (without changing the content of the files, just their location). Keep names in English.

<details><summary>Show solution</summary>

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

## **Exercise 4: Naming conventions (choose the correct option)**

Select the most appropriate name in each case according to the topic's conventions:

1. User card component:

   - a) `usercard.jsx`
   - b) `UserCard.jsx`
   - c) `userCard.jsx`

2. Function that handles a click:

   - a) `Handle_Click()`
   - b) `handleClick`
   - c) `handle_click`

3. Custom hook for a dark theme:

   - a) `UseDarkMode.js`
   - b) `useDarkMode.js`
   - c) `use-dark-mode.js`

<details><summary>Show solution</summary>

1. b) `UserCard.jsx` (components in PascalCase).
2. b) `handleClick` (functions in camelCase).
3. b) `useDarkMode.js` (hooks in camelCase starting with `use`).

</details>

---

## **Exercise 5: Choose carefully between `public` and `assets`**

Here are some cases. Indicate whether you would store each one in `public/` or `src/assets/` and explain why:

1. A `favicon.ico`.
2. A `banner.png` image that you will use inside a component with `import banner from ...`.
3. A `robots.txt` file.
4. A `terms.pdf` file that you want to open with a direct `/terms.pdf` link.
<details><summary>Show solution</summary>

1. `public/` (a static resource that must be directly accessible, without an import).
2. `src/assets/` (it will be imported from JavaScript and goes through the bundler).
3. `public/` (it must be accessible as `/robots.txt`).
4. `public/` (if you want direct access by URL: `/terms.pdf`).

</details>
