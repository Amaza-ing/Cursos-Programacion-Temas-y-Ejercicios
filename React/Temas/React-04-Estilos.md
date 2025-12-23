# **Tema 4: Estilos en React**

## **1. Introducción**

En React, los estilos se pueden aplicar de varias formas. Elegir un enfoque correcto desde el inicio te ayuda a mantener el código más **ordenado**, **escalable** y fácil de trabajar.

En este tema aprenderás:

- Cómo aplicar estilos globales.
- Cómo usar CSS por componente.
- Cómo escribir estilos inline.
- Cómo usar clases dinámicas con `className`.
- Buenas prácticas básicas para organizar estilos.

---

## **2. Estilos globales (`index.css`)**

Los estilos globales afectan a toda la aplicación. En proyectos con Vite, normalmente se cargan desde `main.jsx`:

```js
import "./index.css";
```

### **Ejemplo de estilos globales**

**`src/index.css`**

```css
body {
  margin: 0;
  font-family: Arial, sans-serif;
}

h1 {
  font-size: 32px;
}
```

Este tipo de estilos es útil para:

- Reset o normalización
- Tipografías
- Estilos base de la aplicación

---

## **3. CSS por componente (archivo `.css` + import)**

Una forma muy común de trabajar en React es crear un CSS específico por componente y **importarlo** en el archivo del componente.

### **Ejemplo: componente con CSS propio**

Estructura recomendada:

```
src/
│── components/
│   ├── Button.jsx
│   ├── Button.css
```

**`src/components/Button.css`**

```css
.primaryButton {
  padding: 10px 14px;
  border: none;
  border-radius: 8px;
  cursor: pointer;
}
```

**`src/components/Button.jsx`**

```js
import "./Button.css";

function Button() {
  return <button className="primaryButton">Click</button>;
}

export default Button;
```

Este enfoque es:

- Sencillo de entender
- Compatible con cualquier proyecto
- Fácil de escalar si eres consistente con nombres

> Nota: Este CSS sigue siendo global (las clases existen en todo el proyecto), pero está **organizado por componente**.

---

## **4. Estilos inline (objeto JavaScript)**

React permite aplicar estilos inline usando un objeto en la propiedad `style`.

### **Características clave**

- `style` recibe un **objeto**.
- Las propiedades CSS se escriben en **camelCase**.
- Los valores numéricos se interpretan como `px` (en muchos casos).

Ejemplo:

```js
function Card() {
  const cardStyle = {
    padding: "16px",
    borderRadius: "12px",
    border: "1px solid #ddd",
  };

  return <div style={cardStyle}>Card</div>;
}

export default Card;
```

### **Cuándo usar inline styles**

- Para estilos muy puntuales
- Para valores calculados en tiempo real
- Para prototipos

### **Cuándo evitarlos**

- Cuando el componente tiene mucho CSS
- Cuando quieres usar pseudo-clases (`:hover`, `:focus`) sin librerías

---

## **5. `className` en React (muy importante)**

En React no se usa `class`, se usa `className`.

Esto es obligatorio:

```js
function Alert() {
  return <div className="alert">Warning</div>;
}
```

---

## **6. Clases dinámicas con `className`**

Muchas veces, queremos cambiar la clase según una condición.

Ejemplo:

```js
function StatusBadge() {
  const isOnline = true;

  const badgeClass = isOnline ? "badgeOnline" : "badgeOffline";

  return <span className={badgeClass}>Status</span>;
}

export default StatusBadge;
```

**`StatusBadge.css`**

```css
.badgeOnline {
  padding: 6px 10px;
  border-radius: 10px;
}

.badgeOffline {
  padding: 6px 10px;
  border-radius: 10px;
  opacity: 0.5;
}
```

---

## **7. CSS Modules (aislar estilos por componente)**

Los **CSS Modules** permiten que las clases queden **aisladas** por archivo, evitando colisiones de nombres.

En Vite (y en muchos entornos), funcionan creando el archivo con extensión:

- `Component.module.css`

### **Ejemplo con CSS Modules**

**`src/components/ProfileCard.module.css`**

```css
.card {
  padding: 16px;
  border: 1px solid #ddd;
  border-radius: 12px;
}

.title {
  margin: 0;
}
```

**`src/components/ProfileCard.jsx`**

```js
import styles from "./ProfileCard.module.css";

function ProfileCard() {
  return (
    <div className={styles.card}>
      <h3 className={styles.title}>Profile</h3>
    </div>
  );
}

export default ProfileCard;
```

Ventajas:

- No hay colisiones de clases.
- Estilos realmente “por componente”.
- Facilita mantener proyectos grandes.

---

## **8. Buenas prácticas para organizar estilos**

- Mantén estilos globales solo para lo imprescindible.
- Para componentes reutilizables, usa CSS por componente o CSS Modules.
- Evita mezclar muchos estilos inline con CSS tradicional.
- Nombra clases con intención: `primaryButton`, `errorText`, `cardHeader`.

---

## **9. A tener en cuenta**

- En React, `className` reemplaza a `class`.
- Puedes aplicar estilos de muchas maneras: global, por componente, inline o CSS Modules.
- Para proyectos que crecen, CSS Modules es una opción muy sólida.

---

En el próximo tema veremos **componentes en una línea** y cómo escribir componentes pequeños y reutilizables de forma limpia.
