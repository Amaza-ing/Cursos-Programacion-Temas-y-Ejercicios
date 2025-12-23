# **Tema 5: Componentes en una línea**

## **1. Introducción**

A medida que empiezas a crear componentes en React, te darás cuenta de que algunos son **muy pequeños**: devuelven una sola línea de JSX y no necesitan lógica adicional.

En esos casos, puedes escribir el componente de forma más compacta (en “una línea”), manteniendo el código limpio y fácil de leer.

En este tema aprenderás:

- Qué significa “componente en una línea”.
- Cuándo tiene sentido usarlo y cuándo no.
- Diferencias entre `return (...)` y el retorno implícito.
- Buenas prácticas para mantener legibilidad.

---

## **2. ¿Qué es un componente en una línea?**

Un componente en una línea es un componente funcional que:

- No necesita lógica compleja.
- Devuelve JSX directamente.
- Se puede escribir de forma compacta.

Ejemplo:

```js
function Hello() {
  return <h1>Hello</h1>;
}

export default Hello;
```

Este componente ya es muy simple, pero todavía usa `return`.

---

## **3. Arrow functions y retorno implícito**

En JavaScript, una **arrow function** puede devolver un valor sin escribir `return` si:

- No usas llaves `{}`.
- Devuelves directamente la expresión.

Ejemplo:

```js
const sum = (a, b) => a + b;
```

En React, podemos aplicar lo mismo con JSX.

---

## **4. Componente en una línea con arrow function**

Ejemplo:

```js
const Title = () => <h1>React Course</h1>;

export default Title;
```

Características:

- Se declara como `const`.
- Se usa una arrow function.
- Se devuelve JSX de forma implícita.

---

## **5. Componentes en una línea con JSX más largo**

Si el JSX ocupa varias líneas, puedes envolverlo entre paréntesis:

```js
const EmptyState = () => (
  <div>
    <h3>No data</h3>
    <p>Try again later</p>
  </div>
);

export default EmptyState;
```

Aunque el componente sea pequeño, si ya tiene varias líneas, normalmente lo más importante es mantener **legibilidad**.

---

## **6. Cuándo usar componentes en una línea**

Son útiles cuando:

- El componente es muy pequeño.
- No hay estado ni lógica.
- Es un componente “visual” simple.

Ejemplos típicos:

- Etiquetas (`Tag`)
- Separadores (`Divider`)
- Iconos
- Componentes “estáticos”

Ejemplo:

```js
const Divider = () => <hr />;

export default Divider;
```

---

## **7. Cuándo NO usarlos**

Evita escribirlos en una línea si:

- El JSX es largo y cuesta leerlo.
- Hay lógica dentro del componente.
- Estás empezando y te confunde el retorno implícito.

En estos casos, es mejor usar la forma clásica:

```js
function Profile() {
  const userName = "Alex";

  return (
    <section>
      <h2>{userName}</h2>
      <p>Profile details...</p>
    </section>
  );
}

export default Profile;
```

---

## **8. Diferencias rápidas: `function` vs arrow function**

Ambas son válidas.

### **8.1. Forma clásica (más común al empezar)**

```js
function Header() {
  return <h1>Header</h1>;
}

export default Header;
```

### **8.2. Forma en una línea (compacta)**

```js
const Header = () => <h1>Header</h1>;

export default Header;
```

---

## **9. Buenas prácticas**

- Prioriza **claridad** sobre “ahorrar líneas”.
- Usa componentes en una línea para piezas muy simples.
- Si el JSX crece, cambia a la forma clásica.
- Mantén nombres claros en PascalCase.

---

## **10. A tener en cuenta**

- Un componente en una línea es una forma compacta de escribir componentes pequeños.
- Se apoya en arrow functions y retorno implícito.
- No es “mejor” por defecto: depende del tamaño y la legibilidad.

---

En el próximo tema veremos cómo manejar **eventos en React** (click, input, y funciones manejadoras).
