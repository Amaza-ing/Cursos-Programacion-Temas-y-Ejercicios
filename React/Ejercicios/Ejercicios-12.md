# **Ejercicios - Tema 12: className, htmlFor y otros casos similares**

A continuación, encontrarás **10 ejercicios prácticos** sobre los atributos “especiales” en React (`className`, `htmlFor`, `style`, eventos en camelCase, etc.).

Intenta resolverlos antes de consultar la solución.

---

## **Ejercicio 1: Corregir `class` por `className`**

Este componente está escrito como HTML. Corrígelo para React:

```js
function Card() {
  return <div class="card">Card</div>;
}

export default Card;
```

<details><summary>Mostrar Solución</summary>

```js
function Card() {
  return <div className="card">Card</div>;
}

export default Card;
```

</details>

---

## **Ejercicio 2: `className` dinámico con ternario**

Crea un componente `ModeTag.jsx` con una variable `isDarkMode = true`.

- Si es `true`, usa `className="tagDark"`
- Si es `false`, usa `className="tagLight"`

Debe renderizar:

- `span` con el texto: **"Mode"**

<details><summary>Mostrar Solución</summary>

```js
function ModeTag() {
  const isDarkMode = true;

  return <span className={isDarkMode ? "tagDark" : "tagLight"}>Mode</span>;
}

export default ModeTag;
```

</details>

---

## **Ejercicio 3: Corregir `for` por `htmlFor`**

Este formulario tiene un error en React. Corrígelo:

```js
function NameField() {
  return (
    <div>
      <label for="name">Name</label>
      <input id="name" />
    </div>
  );
}

export default NameField;
```

<details><summary>Mostrar Solución</summary>

```js
function NameField() {
  return (
    <div>
      <label htmlFor="name">Name</label>
      <input id="name" />
    </div>
  );
}

export default NameField;
```

</details>

---

## **Ejercicio 4: Asociar `label` e `input` correctamente**

Crea un componente `PasswordField.jsx` que tenga:

- `label` con `htmlFor="password"` y texto **"Password"**
- `input` con `id="password"` y `type="password"`

<details><summary>Mostrar Solución</summary>

```js
function PasswordField() {
  return (
    <div>
      <label htmlFor="password">Password</label>
      <input id="password" type="password" />
    </div>
  );
}

export default PasswordField;
```

</details>

---

## **Ejercicio 5: `style` como objeto (camelCase)**

Crea un componente `InlineBadge.jsx` que renderice un `span` con:

- Texto: **"New"**
- `style` con:

  - `padding: "6px 10px"`
  - `borderRadius: "999px"`
  - `border: "1px solid #ddd"`

<details><summary>Mostrar Solución</summary>

```js
function InlineBadge() {
  return (
    <span
      style={{
        padding: "6px 10px",
        borderRadius: "999px",
        border: "1px solid #ddd",
      }}
    >
      New
    </span>
  );
}

export default InlineBadge;
```

</details>

---

## **Ejercicio 6: Corregir evento `onclick` → `onClick`**

Este botón está mal escrito para React. Corrígelo:

```js
function App() {
  const handleClick = () => console.log("clicked");

  return <button onclick={handleClick}>Ok</button>;
}
```

<details><summary>Mostrar Solución</summary>

```js
function App() {
  const handleClick = () => console.log("clicked");

  return <button onClick={handleClick}>Ok</button>;
}

export default App;
```

</details>

---

## **Ejercicio 7: `tabIndex` y foco**

Crea un componente `FocusableBox.jsx` que renderice un `div`:

- Con `tabIndex={0}`
- Con texto: **"Focus me"**

<details><summary>Mostrar Solución</summary>

```js
function FocusableBox() {
  return <div tabIndex={0}>Focus me</div>;
}

export default FocusableBox;
```

</details>

---

## **Ejercicio 8: `readOnly` y valor fijo**

Crea un componente `FixedInput.jsx` que renderice:

- Un `input` con `value="Read only"`
- Y `readOnly`

<details><summary>Mostrar Solución</summary>

```js
function FixedInput() {
  return <input value="Read only" readOnly />;
}

export default FixedInput;
```

</details>

---

## **Ejercicio 9: `autoFocus` (no `autofocus`)**

Crea un componente `AutoFocusSearch.jsx` que renderice un input con:

- `placeholder="Search"`
- `autoFocus`

<details><summary>Mostrar Solución</summary>

```js
function AutoFocusSearch() {
  return <input placeholder="Search" autoFocus />;
}

export default AutoFocusSearch;
```

</details>

---

## **Ejercicio 10: Mini-caso (elige la forma correcta)**

Quieres aplicar este estilo al `div`:

- background color: `"#f5f5f5"`
- padding: `"12px"`

¿Cuál es la forma correcta en React?

1.

```js
<div style="background-color: #f5f5f5; padding: 12px" />
```

2.

```js
<div style={{ backgroundColor: "#f5f5f5", padding: "12px" }} />
```

3.

```js
<div style={{ "background-color": "#f5f5f5", padding: "12px" }} />
```

<details><summary>Mostrar Solución</summary>

La opción correcta es la **2**:

```js
<div style={{ backgroundColor: "#f5f5f5", padding: "12px" }} />
```

Motivo:

- `style` recibe un objeto.
- Las propiedades van en camelCase (`backgroundColor`).

</details>
