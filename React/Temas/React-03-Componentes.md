# **Tema 3: Componentes en React**

## **1. Introducción**

En React, un **componente** es una pieza reutilizable de interfaz. En lugar de construir una página entera en un único archivo, React te anima a dividir la interfaz en partes pequeñas y mantenibles.

En este tema aprenderás:

- Qué es un componente y por qué es la base de React.
- Componentes funcionales y cómo se crean.
- Cómo usar un componente dentro de otro.
- Cómo organizar componentes en carpetas.
- Buenas prácticas básicas para empezar.

---

## **2. ¿Qué es un componente?**

Un componente es una función (o clase, aunque hoy se usa casi siempre función) que **devuelve JSX**.

Piensa en un componente como una “pieza” de la pantalla:

- Un botón
- Una tarjeta de producto
- Un menú
- Un formulario

La idea clave es que esas piezas se puedan **reutilizar** y **componer** para construir una aplicación.

---

## **3. Componente funcional (Functional Component)**

Un componente funcional es una función de JavaScript que devuelve JSX.

Ejemplo simple:

```js
function Title() {
  return <h1>Bienvenido</h1>;
}

export default Title;
```

### **Reglas básicas**

- El nombre del componente debe ir en **PascalCase**.
- Un componente debe **devolver un único elemento padre**.
- Para exportarlo y usarlo en otros archivos, se suele usar `export default`.

---

## **4. Crear tu primer componente en `components/`**

Una estructura típica sería:

```
src/
│── components/
│   ├── Header.jsx
│── App.jsx
```

### **4.1. Crear `Header.jsx`**

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

### **4.2. Usar el componente en `App.jsx`**

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

Aquí ocurre lo siguiente:

- Importas el componente con `import`.
- Lo usas como una etiqueta: `<Header />`.

---

## **5. Composición de componentes**

La gran ventaja de React es que puedes combinar componentes para construir pantallas completas.

Ejemplo:

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

## **6. JSX dentro de componentes**

Dentro de JSX puedes:

- Mostrar texto
- Insertar expresiones JavaScript con `{}`
- Renderizar otros componentes

Ejemplo:

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

## **7. Importación correcta de componentes**

### **7.1. Importación por defecto**

Si exportas así:

```js
export default Header;
```

Entonces importas así:

```js
import Header from "./components/Header";
```

---

## **8. Buenas prácticas para empezar**

- Un componente por archivo.
- Nombres claros: `UserCard`, `ProductList`, `Navbar`.
- Mantén los componentes pequeños y con una sola responsabilidad.
- Reutiliza componentes en lugar de copiar y pegar JSX.

---

## **9. A tener en cuenta**

- Los componentes son el corazón de React.
- En React compones la interfaz juntando componentes como piezas.
- Por ahora, tus componentes serán “estáticos”. En el siguiente tema empezaremos a darles estilo.

---

En el próximo tema veremos cómo aplicar **estilos en React** (CSS global, CSS por componente y buenas prácticas iniciales).
