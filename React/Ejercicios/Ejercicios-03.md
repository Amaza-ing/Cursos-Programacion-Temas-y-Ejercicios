# **Ejercicios - Tema 3: Componentes en React**

A continuación, encontrarás **8 ejercicios prácticos** sobre componentes en React.

Intenta resolverlos antes de consultar la solución.

---

## **Ejercicio 1: Crear un componente `Logo`**

Crea un componente llamado `Logo.jsx` dentro de `src/components/` que muestre:

- Un `h2` con el texto: **"MyCompany"**
- Un `p` con el texto: **"Building UI with React"**

Después, úsalo dentro de `App.jsx`.

<details><summary>Mostrar Solución</summary>

**`src/components/Logo.jsx`**

```js
function Logo() {
  return (
    <div>
      <h2>MyCompany</h2>
      <p>Building UI with React</p>
    </div>
  );
}

export default Logo;
```

**`src/App.jsx`**

```js
import Logo from "./components/Logo";

function App() {
  return (
    <div>
      <Logo />
    </div>
  );
}

export default App;
```

</details>

---

## **Ejercicio 2: Corregir el error del “único elemento padre”**

Este componente da error. Arréglalo para que funcione:

```js
function Greeting() {
  return (
    <h1>Hello</h1>
    <p>Welcome to React</p>
  );
}

export default Greeting;
```

<details><summary>Mostrar Solución</summary>

```js
function Greeting() {
  return (
    <div>
      <h1>Hello</h1>
      <p>Welcome to React</p>
    </div>
  );
}

export default Greeting;
```

</details>

---

## **Ejercicio 3: Crear `UserBadge` con variables dentro de JSX**

Crea un componente `UserBadge.jsx` en `src/components/` que:

- Declare una variable `userName` con el valor `"Alex"`.
- Declare una variable `userRole` con el valor `"Admin"`.
- Muestre en JSX:

  - `h3`: **"User: Alex"**
  - `p`: **"Role: Admin"**

Luego úsalo en `App.jsx`.

<details><summary>Mostrar Solución</summary>

**`src/components/UserBadge.jsx`**

```js
function UserBadge() {
  const userName = "Alex";
  const userRole = "Admin";

  return (
    <section>
      <h3>User: {userName}</h3>
      <p>Role: {userRole}</p>
    </section>
  );
}

export default UserBadge;
```

**`src/App.jsx`**

```js
import UserBadge from "./components/UserBadge";

function App() {
  return (
    <div>
      <UserBadge />
    </div>
  );
}

export default App;
```

</details>

---

## **Ejercicio 4: Composición - `Layout` con `Header` y `Footer`**

Crea estos componentes en `src/components/`:

- `Header.jsx` con un `header` y un `h1` que diga **"Dashboard"**.
- `Footer.jsx` con un `footer` y un `small` que diga **"All rights reserved"**.
- `Layout.jsx` que use `Header` y `Footer` y además incluya un `main` con un `p` que diga: **"Content goes here"**.

Por último, renderiza `Layout` en `App.jsx`.

<details><summary>Mostrar Solución</summary>

**`src/components/Header.jsx`**

```js
function Header() {
  return (
    <header>
      <h1>Dashboard</h1>
    </header>
  );
}

export default Header;
```

**`src/components/Footer.jsx`**

```js
function Footer() {
  return (
    <footer>
      <small>All rights reserved</small>
    </footer>
  );
}

export default Footer;
```

**`src/components/Layout.jsx`**

```js
import Header from "./Header";
import Footer from "./Footer";

function Layout() {
  return (
    <div>
      <Header />
      <main>
        <p>Content goes here</p>
      </main>
      <Footer />
    </div>
  );
}

export default Layout;
```

**`src/App.jsx`**

```js
import Layout from "./components/Layout";

function App() {
  return (
    <div>
      <Layout />
    </div>
  );
}

export default App;
```

</details>

---

## **Ejercicio 5: Importación correcta (detecta el problema)**

Tienes este componente:

```js
function Card() {
  return <div>Card</div>;
}

export default Card;
```

Y lo estás importando así en `App.jsx`:

```js
import { Card } from "./components/Card";
```

Corrige la importación para que funcione.

<details><summary>Mostrar Solución</summary>

Como el componente se exporta con `export default`, la importación debe ser sin llaves:

```js
import Card from "./components/Card";
```

</details>

---

## **Ejercicio 6: Crear un componente `Stats` con cálculo simple**

Crea un componente `Stats.jsx` que:

- Declare dos variables: `visits = 120` y `signups = 45`.
- Muestre ambas en JSX.
- Calcule y muestre en un `p` la suma: **"Total: 165"** usando `{}`.

<details><summary>Mostrar Solución</summary>

```js
function Stats() {
  const visits = 120;
  const signups = 45;

  return (
    <section>
      <p>Visits: {visits}</p>
      <p>Signups: {signups}</p>
      <p>Total: {visits + signups}</p>
    </section>
  );
}

export default Stats;
```

</details>

---

## **Ejercicio 7: Reutilizar un componente varias veces**

Crea un componente `Tag.jsx` que muestre un `span` con el texto **"New"**.

Después, en `App.jsx` úsalo **tres veces** seguidas.

<details><summary>Mostrar Solución</summary>

**`src/components/Tag.jsx`**

```js
function Tag() {
  return <span>New</span>;
}

export default Tag;
```

**`src/App.jsx`**

```js
import Tag from "./components/Tag";

function App() {
  return (
    <div>
      <Tag />
      <Tag />
      <Tag />
    </div>
  );
}

export default App;
```

</details>

---

## **Ejercicio 8: Buenas prácticas (elige la opción correcta)**

Marca la opción más recomendable en cada caso:

1. Nombre de componente:

   - a) `navbar.jsx`
   - b) `Navbar.jsx`
   - c) `navBar.jsx`

2. ¿Cuántos componentes por archivo es lo recomendable al empezar?

   - a) Muchos, para tener menos archivos
   - b) Uno por archivo
   - c) Da igual

3. Un componente debería:

   - a) Tener muchas responsabilidades para ahorrar código
   - b) Ser pequeño y con una responsabilidad clara
   - c) No importar otros componentes

<details><summary>Mostrar Solución</summary>

1. b) `Navbar.jsx` (PascalCase).
2. b) Uno por archivo.
3. b) Ser pequeño y con una responsabilidad clara.

</details>
