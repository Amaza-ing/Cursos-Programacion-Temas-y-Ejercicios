# **Topic 2: File Structure in React**

## **1. Introduction**

Good **file organization** is key to making a React project **readable**, **scalable** and **easy to maintain**. Although React doesn't impose a rigid structure, there are widely used conventions that make both individual work and teamwork easier.

In this topic you will learn:

- What the basic structure of a React project looks like.
- What each folder and file is responsible for.
- A recommended structure for small and medium-sized projects.

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

## **3. The main folders and files explained**

### **3.1. `node_modules/`**

It contains all the project's dependencies installed with npm. It shouldn't be modified by hand or uploaded to repositories such as GitHub.

---

### **3.2. `public/`**

It contains static files that don't go through the build process.

Typical uses:

- Public images
- Icons
- Static files accessible by direct URL

The files in this folder are referenced from the root:

```html
<img src="/logo.png" />
```

---

### **3.3. `src/`**

It's the most important folder in the project. This is where **all the React code** lives.

---

#### **3.3.1. `main.jsx`**

It's the **entry point** of the application.

Its job is to:

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

It's the **root component** of the application.

- The rest of the components are built from here.
- It usually contains the main structure of the interface.

```js
function App() {
  return <h1>Mi primera app en React</h1>;
}

export default App;
```

---

#### **3.3.3. `index.css`**

The application's **global styles** file.

This is where you usually define:

- Base styles
- Fonts
- CSS reset

---

### **3.4. `assets/`**

It's used to store resources that **do go through the bundler**:

- Images
- Icons
- Fonts

Usage example:

```js
import logo from "./assets/react.svg";
```

---

### **3.5. `index.html`**

It's the main HTML file. It contains the element where React is mounted:

```html
<div id="root"></div>
```

React doesn't generate multiple HTML files: instead, it works as a **Single Page Application (SPA)**.

---

## **4. A recommended structure**

As the project grows, it's a good idea to organize the files better:

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

This structure helps to:

- Separate responsibilities.
- Avoid giant files.
- Make code reuse easier.

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

## **6. Things to keep in mind**

- React doesn't force a specific structure, but following conventions is good practice.
- `App.jsx` acts as the central point of the application.
- Separating components and pages improves scalability.
- Good organization saves time and prevents errors in the long run.

---
[![File and Folder Structure](https://img.youtube.com/vi/TCfSknh03Lc/0.jpg)](https://www.youtube.com/watch?v=TCfSknh03Lc&list=PLzA2VyZwsq_-dE3Jvunglxq8a6UcH6gnF)

---

In the next topic we'll start working with **components in React** and see how to create and reuse them properly.
