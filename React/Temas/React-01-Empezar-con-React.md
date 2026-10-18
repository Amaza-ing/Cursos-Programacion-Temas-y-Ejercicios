# **Topic 1: Getting started with React**

## **1. What is React?**

React is a **JavaScript library** developed by Meta (Facebook) to build user interfaces in a **declarative**, **componentized** and **reactive** way. Its main objective is to facilitate the creation of modern, maintainable and scalable web applications.

Unlike complete frameworks like Angular, React focuses exclusively on the **view layer**, leaving the developer free to choose the rest of the tools in the ecosystem.

### **Key Features of React**

- Based on **reusable components**.
- Uses a **Virtual DOM** to optimize performance.
- **declarative** programming.
- **unidirectional** data flow.
- Large ecosystem and community.

---

[![React Course Presentation](https://img.youtube.com/vi/Tyk4X3mU9DA/0.jpg)](https://www.youtube.com/watch?v=Tyk4X3mU9DA&list=PLzA2VyZwsq_-dE3Jvunglxq8a6UcH6gnF)

---

## **2. Prerequisites**

Before starting to work with React, you need to have installed:

- **Node.js** (includes npm)
- Basic knowledge of **HTML**, **CSS** and **JavaScript**

You can check if you have Node installed by running in the terminal:

```sh
node -v
npm -v
```

If you do not have it installed, you can download it from [https://nodejs.org](https://nodejs.org)

---

## **3. Create a React project with Vite**

Currently, one of the most recommended ways to start a React project is using **Vite**, as it offers a fast and modern development environment.

### **3.1. Create the project**

Run the following command in the terminal:

```sh
npm create vite@latest my-react-app
```

During the process you will be asked:

- Project name
- Framework: **React**
- Variant: **JavaScript**

Once created, access the project folder:

```sh
cd my-react-app
npm install
```

---

## **4. Raise the development server**

To start the project in development mode, run:

```sh
npm run dev
```

This will start a local server and display a URL similar to:

```
http://localhost:5173
```

Every change you make to the code will automatically be reflected in the browser.

---

## **5. Basic structure of the React project**

A React project created with Vite has a structure similar to this:

```
my-react-app/
│── node_modules/          # Dependencias del proyecto
│── public/                # Archivos estáticos
│── src/                   # Código fuente
│   ├── assets/            # Imágenes y recursos
│   ├── App.jsx            # Componente principal
│   ├── main.jsx           # Punto de entrada de React
│   ├── index.css          # Estilos globales
│── index.html             # HTML principal
│── package.json           # Dependencias y scripts
│── vite.config.js         # Configuración de Vite
```

### **Key Files**

- **main.jsx**: entry point where React is mounted to the DOM.
- **App.jsx**: root component of the application.
- **index.html**: contains the div where React is rendered.

---

## **6. First look at React**

### **main.jsx**

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

Here the following happens:

- React and ReactDOM are imported.
- The `App` component is mounted inside the element with id `root`.

---

### **App.jsx**

```js
function App() {
  return <h1>¡Hola React!</h1>;
}

export default App;
```

This is a **functional component**, which returns JSX (a mix of JavaScript and HTML).

---

## **7. What is JSX?**

JSX is a JavaScript extension that allows you to write HTML-like structures within JavaScript code.

Example:

```js
const title = "Bienvenido a React";

function App() {
  return <h1>{title}</h1>;
}
```

Important features of JSX:

- It is written as HTML, but it is **not HTML**.
- Allows you to use JavaScript expressions with `{}`.
- Each component must return **a single parent element**.

---

## **8. To take into account**

- React is a **library**, not a complete framework.
- Everything in React revolves around **components**.
- JSX makes it easy to write user interfaces.
- The project runs in real time thanks to the development server.

---

[![How to Get Started with React](https://img.youtube.com/vi/IRfa4mg4tNM/0.jpg)](https://www.youtube.com/watch?v=IRfa4mg4tNM&list=PLzA2VyZwsq_-dE3Jvunglxq8a6UcH6gnF)

---

In the next topic we will see in detail the **file scheme** and how to correctly organize a React project from the beginning.
