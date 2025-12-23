# **Ejercicios - Tema 2: Esquema de Ficheros en React**

A continuación, encontrarás **5 ejercicios prácticos** sobre el esquema de ficheros y organización de un proyecto React.

Intenta resolverlos antes de consultar la solución.

---

## **Ejercicio 1: Identificar responsabilidades**

En un proyecto React con Vite, indica **qué archivo o carpeta** usarías para cada caso:

1. Guardar una imagen que quieres importar en un componente (`import logo from ...`).
2. Definir estilos globales para toda la aplicación.
3. Montar React en el DOM.
4. Guardar un archivo estático accesible por URL directa (por ejemplo `/robots.txt`).

<details><summary>Mostrar Solución</summary>

1. `src/assets/` (o `src/assets/...`) porque el archivo pasa por el bundler y se importa desde el código.
2. `src/index.css` (o el archivo global que importes desde `main.jsx`).
3. `src/main.jsx`.
4. `public/`.

</details>

---

## **Ejercicio 2: Crear una estructura recomendada**

Dentro de `src/`, crea (en papel o en tu editor) una estructura recomendada que incluya:

- Una carpeta para componentes reutilizables.
- Una carpeta para páginas.
- Una carpeta para servicios.
- Una carpeta para hooks.

Después, añade dentro de cada carpeta **un archivo de ejemplo** con un nombre correcto.

<details><summary>Mostrar Solución</summary>

Ejemplo válido:

```
src/
│── components/
│   ├── Navbar.jsx
│── pages/
│   ├── Home.jsx
│── services/
│   ├── api.js
│── hooks/
│   ├── useLocalStorage.js
│── assets/
│── App.jsx
│── main.jsx
│── index.css
```

</details>

---

## **Ejercicio 3: Corregir una estructura desordenada**

Tienes esta estructura (mal organizada):

```
src/
│── Header.jsx
│── Home.jsx
│── fetchUsers.js
│── useCounter.js
│── images/
│   ├── avatar.png
│── App.jsx
│── main.jsx
```

Reorganízala usando la estructura recomendada del tema (sin cambiar el contenido de los archivos, solo su ubicación). Mantén los nombres en inglés.

<details><summary>Mostrar Solución</summary>

Una reorganización correcta podría ser:

```
src/
│── components/
│   ├── Header.jsx
│── pages/
│   ├── Home.jsx
│── services/
│   ├── fetchUsers.js
│── hooks/
│   ├── useCounter.js
│── assets/
│   ├── avatar.png
│── App.jsx
│── main.jsx
```

Notas:

- `Header.jsx` es un componente reutilizable.
- `Home.jsx` es una página.
- `fetchUsers.js` es lógica de API (servicio).
- `useCounter.js` es un hook.
- La imagen puede ir en `assets/` (si se importará desde código).

</details>

---

## **Ejercicio 4: Convenciones de nombres (elige la opción correcta)**

Selecciona el nombre más correcto en cada caso según las convenciones del tema:

1. Componente de tarjeta de usuario:

   - a) `usercard.jsx`
   - b) `UserCard.jsx`
   - c) `userCard.jsx`

2. Función que maneja un click:

   - a) `Handle_Click()`
   - b) `handleClick`
   - c) `handle_click`

3. Hook personalizado para tema oscuro:

   - a) `UseDarkMode.js`
   - b) `useDarkMode.js`
   - c) `use-dark-mode.js`

<details><summary>Mostrar Solución</summary>

1. b) `UserCard.jsx` (componentes en PascalCase).
2. b) `handleClick` (funciones en camelCase).
3. b) `useDarkMode.js` (hooks en camelCase empezando por `use`).

</details>

---

## **Ejercicio 5: Elegir bien entre `public` y `assets`**

Tienes estos casos. Indica si lo guardarías en `public/` o en `src/assets/` y explica por qué:

1. Un `favicon.ico`.
2. Una imagen `banner.png` que usarás dentro de un componente con `import banner from ...`.
3. Un archivo `robots.txt`.
4. Un archivo `terms.pdf` que quieres abrir con un enlace directo `/terms.pdf`.

<details><summary>Mostrar Solución</summary>

1. `public/` (recurso estático que debe estar accesible directamente y sin importación).
2. `src/assets/` (se importará desde JavaScript y pasa por el bundler).
3. `public/` (debe estar accesible como `/robots.txt`).
4. `public/` (si quieres acceso directo por URL: `/terms.pdf`).

</details>
