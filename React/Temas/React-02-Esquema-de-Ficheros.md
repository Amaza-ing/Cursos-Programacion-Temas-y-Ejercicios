# **Topic 2: File Schema in React**

## **1. Introduction**

Good **file organization** is key for a React project to be **readable**, **scalable** and **easy to maintain**. Although React does not impose a rigid structure, there are widely used conventions that facilitate individual and team work.

In this topic you will learn:

- What is the basic structure of a React project.
- What responsibility does each folder and file have?
- A recommended structure proposal for small and medium projects.

---

## **2. Initial structure of a React project (Vite)**

When you create a project with Vite, you'll get a structure similar to the following:

```
my-react-app/
│── node_modules/
│── public/
│── src/
│   ├── assets/
│   ├── App.jsx
│   ├── main.jsx
│   ├── index.css
│── index.html
│── package.json
│── vite.config.js
```

This structure is minimal but enough to start working.

---

## **3. Explanation of main folders and files**

### **3.1. `node_modules/`**

Contains all project dependencies installed with npm. It should not be modified manually or uploaded to repositories such as GitHub.

---

### **3.2. `public/`**

It contains static files that do not go through the compilation process.

Examples of use:

- Public images
- Icons
- Static files accessible by direct URL

The files in this folder are referenced from the root:

```html
<img src="/logo.png" />
```

---

### **3.3. `src/`**

It is the most important folder in the project. This is where **all of the React code** lives.

---

#### **3.3.1. `main.jsx`**

It is the **entry point** of the application.

Its function is:

- Create the React root.
- Render the main component.

```js
import React from "react";
import ReactDOM from "react-dom/client";
import App from "./App";
import "./index.css";

ReactDOM.createRoot(document.getElementById("root")).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);
```

---

#### **3.3.2. `App.jsx`**

It is the **root component** of the application.

- From here the rest of the components are built.
- Usually contains the main structure of the interface.

```js
function App() {
  return <h1>Mi primera app en React</h1>;
}

export default App;
```

---

#### **3.3.3. `index.css`**

Application **global styles** file.

Here they are usually defined:

- Base styles
- Fonts
- CSS reset

---

### **3.4. `assets/`**

It is used to store resources that **do pass through the bundler**:

- Images
- Icons
- Sources

Example of use:

```js
import logo from "./assets/react.svg";
```

---

### **3.5. `index.html`**

It is the main HTML file. Contains the element where React is mounted:

```html
<div id="root"></div>
```

React does not generate multiple HTML, but rather works as a **Single Page Application (SPA)**.

---

## **4. Recommended structure proposal**

As the project grows, it is advisable to better organize the files:

```
src/
│── components/
│   ├── Header.jsx
│   ├── Footer.jsx
│── pages/
│   ├── Home.jsx
│   ├── About.jsx
│── services/
│   ├── api.js
│── hooks/
│   ├── useExample.js
│── assets/
│── App.jsx
│── main.jsx
│── index.css
```

This structure helps:

- Separate responsibilities.
- Avoid giant files.
- Facilitate code reuse.

---

## **5. Naming conventions**

- Components: **PascalCase**

  - `Header.jsx`
  - `UserCard.jsx`

- Variables and functions: **camelCase**

  - `userName`
  - `handleClick`

- Folders: lowercase

  - `components`
  - `pages`

---

## **6. To take into account**

- React does not force a specific structure, but following conventions is good practice.
- `App.jsx` acts as the central point of the application.
- Separating components and pages improves scalability.
- Good organization saves time and errors in the long term.

---
[![File and Folder Scheme](https://img.youtube.com/vi/TCfSknh03Lc/0.jpg)](https://www.youtube.com/watch?v=TCfSknh03Lc&list=PLzA2VyZwsq_-dE3Jvunglxq8a6UcH6gnF)

---

In the next topic we will start working with **components in React** and understand how to create and reuse them correctly.
