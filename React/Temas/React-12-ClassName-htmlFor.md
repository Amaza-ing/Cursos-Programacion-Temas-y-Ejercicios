# **Tema 12: className, htmlFor y otros casos similares**

## **1. Introducción**

Cuando vienes de HTML/CSS, hay varios atributos que en React **no se escriben igual**. Esto ocurre porque React usa JSX, y JSX está más cerca de JavaScript que del HTML tradicional.

En este tema aprenderás:

- Por qué en React se usa `className` en lugar de `class`.
- Por qué en React se usa `htmlFor` en lugar de `for`.
- Otros atributos “especiales” o con diferencias importantes.
- Buenas prácticas y errores típicos.

---

## **2. `className` en React**

En HTML escribimos:

```html
<div class="card">...</div>
```

En React, **no se usa `class`**, porque `class` es una palabra reservada en JavaScript. En su lugar se usa **`className`**:

```js
function Card() {
  return <div className="card">Card</div>;
}

export default Card;
```

### **2.1. `className` dinámico**

`className` también puede depender de una condición (lo conectamos con lo visto en estilos y renderizado condicional).

```js
function StatusPill() {
  const isActive = true;

  return (
    <span className={isActive ? "pillActive" : "pillInactive"}>Status</span>
  );
}

export default StatusPill;
```

---

## **3. `htmlFor` en React**

En HTML, para asociar un `label` a un `input` se usa `for`:

```html
<label for="email">Email</label> <input id="email" />
```

En React, **no se usa `for`** porque en JavaScript existe la palabra reservada `for`. En JSX se usa **`htmlFor`**.

### **Ejemplo correcto en React**

```js
function EmailField() {
  return (
    <div>
      <label htmlFor="email">Email</label>
      <input id="email" type="email" />
    </div>
  );
}

export default EmailField;
```

**Clave:**

- `htmlFor` debe coincidir con el `id` del input.

---

## **4. Otros atributos y diferencias importantes**

### **4.1. `style` (objeto, no string)**

En HTML:

```html
<div style="background: red; padding: 10px"></div>
```

En React, `style` recibe un **objeto** y las propiedades van en **camelCase**:

```js
function Box() {
  return <div style={{ backgroundColor: "red", padding: "10px" }}>Box</div>;
}

export default Box;
```

---

### **4.2. `onClick`, `onChange`, etc. (camelCase + función)**

En HTML:

```html
<button onclick="doSomething()">Click</button>
```

En React:

- Se escribe en camelCase (`onClick`).
- Se pasa una función (no un string).

```js
function Button() {
  const handleClick = () => {
    console.log("Clicked");
  };

  return <button onClick={handleClick}>Click</button>;
}

export default Button;
```

---

### **4.3. `tabIndex` (no `tabindex`)**

En React se usa:

```js
<div tabIndex={0}>Focusable</div>
```

---

### **4.4. `readOnly` (no `readonly`)**

```js
<input value="Fixed" readOnly />
```

---

### **4.5. Atributos booleanos**

En React, los booleanos se pueden escribir de forma corta:

```js
<input disabled />
<input required />
```

Y también de forma dinámica:

```js
<input disabled={isDisabled} />
```

---

### **4.6. `defaultValue` y `defaultChecked`**

En inputs **no controlados**, se usan:

```js
<input defaultValue="Hello" />
<input type="checkbox" defaultChecked />
```

Esto es útil cuando:

- No quieres usar `useState`.
- Solo quieres un valor inicial.

---

### **4.7. `dangerouslySetInnerHTML` (caso avanzado)**

A veces necesitas insertar HTML que viene de fuera (por ejemplo, de una API). React lo bloquea por seguridad, y exige usar esta propiedad.

```js
function HtmlBlock() {
  const html = "<strong>Bold</strong>";

  return <div dangerouslySetInnerHTML={{ __html: html }} />;
}

export default HtmlBlock;
```

> Nota: úsalo con cuidado, porque puede causar problemas de seguridad (XSS) si el HTML no está sanitizado.

---

## **5. Lista rápida de “traducciones” comunes**

- `class` → `className`
- `for` → `htmlFor`
- `tabindex` → `tabIndex`
- `readonly` → `readOnly`
- `onclick` → `onClick`
- `onchange` → `onChange`
- `autofocus` → `autoFocus`

---

## **6. Errores típicos**

### **6.1. Usar `class` en JSX**

```js
<div class="box">...</div>
```

Debe ser:

```js
<div className="box">...</div>
```

---

### **6.2. Usar `for` en `label`**

```js
<label for="name">Name</label>
```

Debe ser:

```js
<label htmlFor="name">Name</label>
```

---

### **6.3. Escribir `style` como string**

```js
<div style="color: red">...</div>
```

Debe ser un objeto:

```js
<div style={{ color: "red" }}>...</div>
```

---

## **7. Buenas prácticas**

- Sé consistente con `className`.
- Asegúrate de que `htmlFor` y `id` coinciden.
- Prefiere estilos en CSS/CSS Modules y usa inline styles solo cuando tenga sentido.
- Aprende la lista de atributos especiales más comunes: te ahorrará muchos errores.

---

## **8. A tener en cuenta**

- JSX no es HTML: algunos atributos cambian.
- Los más importantes al empezar son `className` y `htmlFor`.
- Los eventos se escriben en camelCase y reciben funciones.
- `style` se escribe como objeto.

---

[![Classname, htmlFor y otros](https://img.youtube.com/vi/CcMlJxlHno8/0.jpg)](https://www.youtube.com/watch?v=CcMlJxlHno8&list=PLzA2VyZwsq_-dE3Jvunglxq8a6UcH6gnF)

---

En el próximo tema veremos **Props Hijo a Padre y Elevar el Estado**, para que un componente hijo pueda comunicar información al padre mediante funciones.
