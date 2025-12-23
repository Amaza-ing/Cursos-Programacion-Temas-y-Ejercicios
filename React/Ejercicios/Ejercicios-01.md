# **Ejercicios - Tema 1: Empezar con React**

A continuación, encontrarás **5 ejercicios prácticos** sobre los contenidos del Tema 1.

Intenta resolverlos antes de consultar la solución.

---

## **Ejercicio 1: Crear un proyecto con Vite**

Crea un proyecto de React con Vite llamado `react-starter`.

**Requisitos:**

- Usa Vite para generar el proyecto.
- Entra en la carpeta.
- Instala dependencias.

<details><summary>Mostrar Solución</summary>

```sh
npm create vite@latest react-starter
cd react-starter
npm install
```

</details>

---

## **Ejercicio 2: Levantar el servidor y localizar la URL**

Levanta el servidor de desarrollo del proyecto y escribe la URL local donde se verá la app.

**Pista:** el comando es el script de desarrollo y Vite suele usar el puerto `5173`.

<details><summary>Mostrar Solución</summary>

```sh
npm run dev
```

La app se verá normalmente en:

```
http://localhost:5173
```

</details>

---

## **Ejercicio 3: Modificar `App.jsx` para mostrar datos dinámicos**

Edita `src/App.jsx` para que:

- Muestre un título con el texto **"React Starter"**.
- Muestre un párrafo con el año actual (por ejemplo: `2025`) usando una variable llamada `currentYear`.

<details><summary>Mostrar Solución</summary>

```js
function App() {
  const currentYear = new Date().getFullYear();

  return (
    <div>
      <h1>React Starter</h1>
      <p>Año actual: {currentYear}</p>
    </div>
  );
}

export default App;
```

</details>

---

## **Ejercicio 4: Entender el punto de entrada (`main.jsx`)**

Responde:

1. ¿En qué archivo se “monta” React en el DOM?
2. ¿Qué id tiene el elemento del HTML donde se renderiza la aplicación?
3. ¿Qué componente se renderiza como raíz?

<details><summary>Mostrar Solución</summary>

1. En `src/main.jsx`.
2. El id es `root` (está en `index.html`).
3. El componente raíz es `App`.

</details>

---

## **Ejercicio 5: JSX con condiciones simples (sin renderizado condicional avanzado)**

Sin usar todavía renderizado condicional (eso se verá más adelante), crea en `App.jsx` lo siguiente:

- Una variable `userName` con tu nombre.
- Un `h2` que diga: **"Hola, {userName}"**.
- Un `p` que muestre el resultado de `2 + 3` dentro de JSX.

<details><summary>Mostrar Solución</summary>

```js
function App() {
  const userName = "Sara";

  return (
    <div>
      <h2>Hola, {userName}</h2>
      <p>2 + 3 = {2 + 3}</p>
    </div>
  );
}

export default App;
```

</details>
