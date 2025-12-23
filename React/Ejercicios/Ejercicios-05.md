# **Ejercicios - Tema 5: Componentes en una línea**

A continuación, encontrarás **10 ejercicios prácticos** sobre componentes en una línea (arrow functions, retorno implícito y legibilidad).

Intenta resolverlos antes de consultar la solución.

---

## **Ejercicio 1: Convertir a componente en una línea**

Convierte este componente a una versión en una línea usando arrow function y retorno implícito:

```js
function Title() {
  return <h1>Welcome</h1>;
}

export default Title;
```

<details><summary>Mostrar Solución</summary>

```js
const Title = () => <h1>Welcome</h1>;

export default Title;
```

</details>

---

## **Ejercicio 2: JSX en varias líneas con paréntesis**

Crea un componente `EmptyMessage.jsx` en una sola declaración con arrow function que renderice:

- `h3` con el texto: **"No results"**
- `p` con el texto: **"Try a different search"**

El JSX debe estar en varias líneas usando paréntesis.

<details><summary>Mostrar Solución</summary>

```js
const EmptyMessage = () => (
  <div>
    <h3>No results</h3>
    <p>Try a different search</p>
  </div>
);

export default EmptyMessage;
```

</details>

---

## **Ejercicio 3: Detectar el error del retorno implícito**

Este componente no muestra nada. Corrígelo:

```js
const Badge = () => {
  <span>New</span>;
};

export default Badge;
```

<details><summary>Mostrar Solución</summary>

Al usar llaves `{}`, necesitas `return`:

```js
const Badge = () => {
  return <span>New</span>;
};

export default Badge;
```

Alternativa con retorno implícito (sin llaves):

```js
const Badge = () => <span>New</span>;

export default Badge;
```

</details>

---

## **Ejercicio 4: Crear un componente “visual” simple**

Crea un componente `Separator.jsx` en una línea que devuelva un `hr` con `className="separator"`.

<details><summary>Mostrar Solución</summary>

```js
const Separator = () => <hr className="separator" />;

export default Separator;
```

</details>

---

## **Ejercicio 5: Refactorizar para mejorar legibilidad**

Tienes este componente en una línea, pero es poco legible. Reescríbelo usando paréntesis y varias líneas:

```js
const Info = () => (
  <div>
    <h4>Info</h4>
    <p>React is component-based</p>
  </div>
);
```

<details><summary>Mostrar Solución</summary>

```js
const Info = () => (
  <div>
    <h4>Info</h4>
    <p>React is component-based</p>
  </div>
);

export default Info;
```

</details>

---

## **Ejercicio 6: Cuándo NO usar componente en una línea (elige la opción correcta)**

Elige la opción más recomendable:

1. Un componente con 2 etiquetas y sin lógica

   - a) En una línea
   - b) Forma clásica

2. Un componente con JSX largo (muchos elementos)

   - a) En una línea
   - b) Forma clásica o varias líneas con paréntesis

3. Un componente con varias variables y cálculos

   - a) En una línea
   - b) Forma clásica

<details><summary>Mostrar Solución</summary>

1. a) En una línea (si es realmente corto y legible).
2. b) Forma clásica o varias líneas con paréntesis.
3. b) Forma clásica.

</details>

---

## **Ejercicio 7: Comparar `function` vs arrow function**

Escribe el componente `FooterNote` de dos formas:

- Forma clásica con `function`.
- Forma compacta con arrow function en una línea.

Debe renderizar: `small` con el texto **"Built with React"**.

<details><summary>Mostrar Solución</summary>

Forma clásica:

```js
function FooterNote() {
  return <small>Built with React</small>;
}

export default FooterNote;
```

Forma en una línea:

```js
const FooterNote = () => <small>Built with React</small>;

export default FooterNote;
```

</details>

---

## **Ejercicio 8: Componentes en una línea dentro de `App.jsx`**

En `App.jsx`, crea un componente `Label` en una línea y úsalo dos veces. Debe renderizar:

- `span` con el texto: **"Featured"**

<details><summary>Mostrar Solución</summary>

```js
const Label = () => <span>Featured</span>;

function App() {
  return (
    <div>
      <Label />
      <Label />
    </div>
  );
}

export default App;
```

</details>

---

## **Ejercicio 9: Usar paréntesis correctamente (bug típico)**

Este componente intenta devolver JSX en varias líneas, pero no funciona. Arréglalo:

```js
const Tip = () => <p>Remember to save your work</p>;

export default Tip;
```

<details><summary>Mostrar Solución</summary>

En retornos implícitos con varias líneas, usa paréntesis:

```js
const Tip = () => <p>Remember to save your work</p>;

export default Tip;
```

</details>

---

## **Ejercicio 10: Decidir el estilo adecuado (mini-casos)**

Indica cuál elegirías y por qué (una frase por caso):

1. Componente `Dot` que solo renderiza un `span` con un punto (`•`).
2. Componente `UserProfile` con varias variables, JSX largo y estructura compleja.
3. Componente `LoadingText` que renderiza un `p` muy corto.

<details><summary>Mostrar Solución</summary>

1. Componente en una línea: es muy pequeño y visual.
2. Forma clásica: necesita legibilidad y probablemente lógica.
3. En una línea si es corto y legible; si crece, cambiaría a forma clásica.

</details>

---
