# **Ejercicios - Tema 25: Lazy Loading en React**

A continuación, encontrarás **10 ejercicios prácticos** para aprender a aplicar Lazy Loading usando `React.lazy` y `Suspense`, especialmente en combinación con React Router.

Intenta resolverlos antes de consultar la solución.

---

## **Ejercicio 1: Importar un componente de forma lazy**

Convierte este import normal en un import lazy:

```js
import Profile from "./pages/Profile";
```

<details><summary>Mostrar Solución</summary>

```js
import { lazy } from "react";

const Profile = lazy(() => import("./pages/Profile"));
```

</details>

---

## **Ejercicio 2: Usar `Suspense` correctamente**

Envuelve un componente lazy con `Suspense` y muestra un texto **"Loading..."** mientras se carga.

<details><summary>Mostrar Solución</summary>

```js
import { Suspense } from "react";

<Suspense fallback={<p>Loading...</p>}>
  <Profile />
</Suspense>;
```

</details>

---

## **Ejercicio 3: Error típico sin `Suspense`**

¿Qué ocurre si intentas renderizar un componente lazy sin `Suspense`?

<details><summary>Mostrar Solución</summary>

Se produce un error en tiempo de ejecución indicando que falta un `Suspense`.

</details>

---

## **Ejercicio 4: Lazy Loading con React Router**

Crea una ruta `/settings` que cargue el componente `Settings` de forma lazy.

<details><summary>Mostrar Solución</summary>

```js
const Settings = lazy(() => import("./pages/Settings"));

<Suspense fallback={<p>Loading page...</p>}>
  <Routes>
    <Route path="/settings" element={<Settings />} />
  </Routes>
</Suspense>;
```

</details>

---

## **Ejercicio 5: Lazy Loading solo en páginas**

Explica por qué es buena práctica aplicar lazy principalmente a páginas y no a componentes pequeños.

<details><summary>Mostrar Solución</summary>

Porque las páginas suelen ser más pesadas y no siempre se visitan, mientras que los componentes pequeños suelen renderizarse siempre.

</details>

---

## **Ejercicio 6: Fallback personalizado**

Cambia el `fallback` de `Suspense` para mostrar un componente `Spinner`.

<details><summary>Mostrar Solución</summary>

```js
<Suspense fallback={<Spinner />}>
  <Profile />
</Suspense>
```

</details>

---

## **Ejercicio 7: Lazy Loading innecesario**

Da un ejemplo de un componente donde **no** tendría sentido usar Lazy Loading.

<details><summary>Mostrar Solución</summary>

Un botón, un input o un header que se muestra siempre.

</details>

---

## **Ejercicio 8: Lazy Loading vs React.memo**

Indica qué técnica usarías en cada caso:

- Evitar descargar código innecesario.
- Evitar renderizados innecesarios.

<details><summary>Mostrar Solución</summary>

- Lazy Loading → evitar descargar código innecesario.
- React.memo → evitar renderizados innecesarios.

</details>

---

## **Ejercicio 9: Suspense a nivel de App**

¿Por qué suele ser buena idea colocar `Suspense` envolviendo las rutas y no cada componente individual?

<details><summary>Mostrar Solución</summary>

Porque centraliza la gestión de carga de páginas y evita duplicar código.

</details>

---

## **Ejercicio 10: Lazy Loading como optimización**

Explica por qué Lazy Loading es una optimización que se aplica cuando la app empieza a crecer.

<details><summary>Mostrar Solución</summary>

Porque en apps pequeñas el coste de dividir el código no compensa, pero en apps grandes mejora claramente el rendimiento inicial.

</details>
