# **Tema 2: Esquema de Ficheros en React**

## **1. Introducción**

Una buena **organización de ficheros** es clave para que un proyecto React sea **legible**, **escalable** y **fácil de mantener**. Aunque React no impone una estructura rígida, existen convenciones ampliamente utilizadas que facilitan el trabajo individual y en equipo.

En este tema aprenderás:

- Cómo es la estructura básica de un proyecto React.
- Qué responsabilidad tiene cada carpeta y archivo.
- Una propuesta de estructura recomendada para proyectos pequeños y medianos.

---

## **2. Estructura inicial de un proyecto React (Vite)**

Al crear un proyecto con Vite, obtendrás una estructura similar a la siguiente:

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

Esta estructura es mínima pero suficiente para comenzar a trabajar.

---

## **3. Explicación de carpetas y archivos principales**

### **3.1. `node_modules/`**

Contiene todas las dependencias del proyecto instaladas con npm. No se debe modificar manualmente ni subir a repositorios como GitHub.

---

### **3.2. `public/`**

Contiene archivos estáticos que no pasan por el proceso de compilación.

Ejemplos de uso:

- Imágenes públicas
- Iconos
- Archivos estáticos accesibles por URL directa

Los archivos de esta carpeta se referencian desde la raíz:

```html
<img src="/logo.png" />
```

---

### **3.3. `src/`**

Es la carpeta más importante del proyecto. Aquí vive **todo el código de React**.

---

#### **3.3.1. `main.jsx`**

Es el **punto de entrada** de la aplicación.

Su función es:

- Crear la raíz de React.
- Renderizar el componente principal.

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

Es el **componente raíz** de la aplicación.

- A partir de aquí se construye el resto de componentes.
- Suele contener la estructura principal de la interfaz.

```js
function App() {
  return <h1>Mi primera app en React</h1>;
}

export default App;
```

---

#### **3.3.3. `index.css`**

Archivo de **estilos globales** de la aplicación.

Aquí se suelen definir:

- Estilos base
- Tipografías
- Reset de CSS

---

### **3.4. `assets/`**

Se utiliza para almacenar recursos que **sí pasan por el bundler**:

- Imágenes
- Iconos
- Fuentes

Ejemplo de uso:

```js
import logo from "./assets/react.svg";
```

---

### **3.5. `index.html`**

Es el archivo HTML principal. Contiene el elemento donde se monta React:

```html
<div id="root"></div>
```

React no genera múltiples HTML, sino que trabaja como una **Single Page Application (SPA)**.

---

## **4. Propuesta de estructura recomendada**

A medida que el proyecto crece, es recomendable organizar mejor los archivos:

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

Esta estructura ayuda a:

- Separar responsabilidades.
- Evitar archivos gigantes.
- Facilitar la reutilización de código.

---

## **5. Convenciones de nombres**

- Componentes: **PascalCase**

  - `Header.jsx`
  - `UserCard.jsx`

- Variables y funciones: **camelCase**

  - `userName`
  - `handleClick`

- Carpetas: minúsculas

  - `components`
  - `pages`

---

## **6. A tener en cuenta**

- React no obliga a una estructura concreta, pero seguir convenciones es una buena práctica.
- `App.jsx` actúa como punto central de la aplicación.
- Separar componentes y páginas mejora la escalabilidad.
- Una buena organización ahorra tiempo y errores a largo plazo.

---

En el próximo tema comenzaremos a trabajar con **componentes en React** y entenderemos cómo crearlos y reutilizarlos correctamente.
