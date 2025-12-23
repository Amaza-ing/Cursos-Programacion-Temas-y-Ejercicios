# **Tema 1: Empezar con React**

## **1. ¿Qué es React?**

React es una **librería de JavaScript** desarrollada por Meta (Facebook) para construir interfaces de usuario de forma **declarativa**, **componentizada** y **reactiva**. Su objetivo principal es facilitar la creación de aplicaciones web modernas, mantenibles y escalables.

A diferencia de frameworks completos como Angular, React se centra exclusivamente en la **capa de vista**, dejando al desarrollador libertad para elegir el resto de herramientas del ecosistema.

### **Características principales de React**

- Basado en **componentes reutilizables**.
- Utiliza un **Virtual DOM** para optimizar el rendimiento.
- Programación **declarativa**.
- Flujo de datos **unidireccional**.
- Amplio ecosistema y comunidad.

---

## **2. Requisitos previos**

Antes de comenzar a trabajar con React, es necesario tener instalado:

- **Node.js** (incluye npm)
- Conocimientos básicos de **HTML**, **CSS** y **JavaScript**

Puedes comprobar si tienes Node instalado ejecutando en la terminal:

```sh
node -v
npm -v
```

Si no lo tienes instalado, puedes descargarlo desde [https://nodejs.org](https://nodejs.org)

---

## **3. Crear un proyecto React con Vite**

Actualmente, una de las formas más recomendadas de iniciar un proyecto React es utilizando **Vite**, ya que ofrece un entorno de desarrollo rápido y moderno.

### **3.1. Crear el proyecto**

Ejecuta el siguiente comando en la terminal:

```sh
npm create vite@latest my-react-app
```

Durante el proceso se te preguntará:

- Nombre del proyecto
- Framework: **React**
- Variante: **JavaScript**

Una vez creado, accede a la carpeta del proyecto:

```sh
cd my-react-app
npm install
```

---

## **4. Levantar el servidor de desarrollo**

Para arrancar el proyecto en modo desarrollo, ejecuta:

```sh
npm run dev
```

Esto iniciará un servidor local y mostrará una URL similar a:

```
http://localhost:5173
```

Cada cambio que realices en el código se reflejará automáticamente en el navegador.

---

## **5. Estructura básica del proyecto React**

Un proyecto React creado con Vite tiene una estructura similar a esta:

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

### **Archivos clave**

- **main.jsx**: punto de entrada donde React se monta en el DOM.
- **App.jsx**: componente raíz de la aplicación.
- **index.html**: contiene el div donde se renderiza React.

---

## **6. Primer vistazo a React**

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

Aquí ocurre lo siguiente:

- Se importa React y ReactDOM.
- Se monta el componente `App` dentro del elemento con id `root`.

---

### **App.jsx**

```js
function App() {
  return <h1>¡Hola React!</h1>;
}

export default App;
```

Este es un **componente funcional**, que devuelve JSX (una mezcla de JavaScript y HTML).

---

## **7. ¿Qué es JSX?**

JSX es una extensión de JavaScript que permite escribir estructuras similares a HTML dentro del código JavaScript.

Ejemplo:

```js
const title = "Bienvenido a React";

function App() {
  return <h1>{title}</h1>;
}
```

Características importantes de JSX:

- Se escribe como HTML, pero **no es HTML**.
- Permite usar expresiones JavaScript con `{}`.
- Cada componente debe devolver **un único elemento padre**.

---

## **8. A tener en cuenta**

- React es una **librería**, no un framework completo.
- Todo en React gira en torno a **componentes**.
- JSX facilita la escritura de interfaces de usuario.
- El proyecto se ejecuta en tiempo real gracias al servidor de desarrollo.

---

En el próximo tema veremos en detalle el **esquema de ficheros** y cómo organizar correctamente un proyecto React desde el inicio.
