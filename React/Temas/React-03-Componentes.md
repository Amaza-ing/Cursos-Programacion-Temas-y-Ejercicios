# **Topic 3: Components in React**

## **1. Introduction**

In React, a **component** is a reusable piece of interface. Instead of building an entire page in a single file, React encourages you to break the interface into small, maintainable parts.

In this topic you will learn:

- What a component is and why it's the foundation of React.
- Functional components and how to create them.
- How to use one component inside another.
- How to organize components in folders.
- Basic best practices to get started.

---

## **2. What is a component?**

A component is a function (or class, although today a function is almost always used) that **returns JSX**.

Think of a component as a “piece” of the screen:

- A button
- A product card
- A menu
- A form

The key idea is that those pieces can be **reused** and **composed** to build an application.

---

## **3. Functional components**

A functional component is a JavaScript function that returns JSX.

Simple example:

```js
function Title() {
  return <h1>Bienvenido</h1>;
}

export default Title;
```

### **Basic rules**

- The component name must be in **PascalCase**.
- A component must **return a single parent element**.
- To export it and use it in other files, you usually use `export default`.

---

## **4. Create your first component in `components/`**

A typical structure would be:

```
src/
│── components/
│   ├── Header.jsx
│── App.jsx
```

### **4.1. Create `Header.jsx`**

```js
function Header() {
  return (
    <header>
      <h1>My React App</h1>
    </header>
  );
}

export default Header;
```

### **4.2. Use the component in `App.jsx`**

```js
import Header from "./components/Header";

function App() {
  return (
    <div>
      <Header />
      <p>Contenido principal...</p>
    </div>
  );
}

export default App;
```

Here's what happens:

- You import the component with `import`.
- You use it like a tag: `<Header />`.

---

## **5. Component composition**

The big advantage of React is that you can combine components to build complete screens.

Example:

- `Header`
- `Main`
- `Footer`

### **5.1. `Footer.jsx`**

```js
function Footer() {
  return (
    <footer>
      <small>© {new Date().getFullYear()} My React App</small>
    </footer>
  );
}

export default Footer;
```

### **5.2. `App.jsx`**

```js
import Header from "./components/Header";
import Footer from "./components/Footer";

function App() {
  return (
    <div>
      <Header />
      <main>
        <p>Bienvenido a la aplicación.</p>
      </main>
      <Footer />
    </div>
  );
}

export default App;
```

---

## **6. JSX inside components**

Inside JSX you can:

- Show text
- Insert JavaScript expressions with `{}`
- Render other components

Example:

```js
function Welcome() {
  const userName = "Sara";

  return (
    <section>
      <h2>Hola, {userName}</h2>
      <p>2 + 3 = {2 + 3}</p>
    </section>
  );
}

export default Welcome;
```

---

## **7. Importing components correctly**

### **7.1. Default import**

If you export like this:

```js
export default Header;
```

Then you import like this:

```js
import Header from "./components/Header";
```

---

## **8. Best practices to get started**

- One component per file.
- Clear names: `UserCard`, `ProductList`, `Navbar`.
- Keep components small, with a single responsibility.
- Reuse components instead of copying and pasting JSX.

---

## **9. Things to keep in mind**

- Components are the heart of React.
- In React you compose the interface by putting components together like pieces.
- For now, your components will be “static”. In the next topic we'll start styling them.

---

[![Components](https://img.youtube.com/vi/oCXYesB9q7w/0.jpg)](https://www.youtube.com/watch?v=oCXYesB9q7w&list=PLzA2VyZwsq_-dE3Jvunglxq8a6UcH6gnF)

---

In the next topic we'll see how to apply **styles in React** (global CSS, per-component CSS and a few first best practices).
