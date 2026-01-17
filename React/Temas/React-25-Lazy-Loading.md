# **Tema 25: Lazy Loading en React**

## **1. Introducción**

Cuando una aplicación React crece, el tamaño del JavaScript inicial también aumenta. Cargar **todo** el código desde el principio puede hacer que la app tarde más en mostrarse, especialmente en conexiones lentas.

Para mejorar el rendimiento, React permite **cargar componentes solo cuando se necesitan**. A esta técnica se la llama **Lazy Loading**.

En este tema aprenderás:

- Qué es el Lazy Loading.
- Por qué mejora el rendimiento.
- Cómo usar `React.lazy` y `Suspense`.
- Lazy Loading con rutas.
- Errores comunes y buenas prácticas.

---

## **2. ¿Qué es Lazy Loading?**

Lazy Loading significa:

> No cargar un componente hasta que realmente se vaya a usar.

En lugar de descargar todo el código al inicio:

- Se divide la app en **chunks**.
- Cada chunk se descarga bajo demanda.

Esto reduce:

- El tiempo de carga inicial.
- El tamaño del bundle principal.

---

## **3. Problema sin Lazy Loading**

Ejemplo típico:

```js
import Home from "./pages/Home";
import Profile from "./pages/Profile";
import Settings from "./pages/Settings";
```

Aunque el usuario solo visite `Home`, el navegador descarga **todo**.

---

## **4. Lazy Loading con `React.lazy`**

`React.lazy` permite importar componentes de forma dinámica.

```js
import { lazy } from "react";

const Home = lazy(() => import("./pages/Home"));
const Profile = lazy(() => import("./pages/Profile"));
```

Cada componente se cargará solo cuando se renderice.

---

## **5. `Suspense`: mostrar un fallback**

Los componentes lazy **deben** estar envueltos en `Suspense`.

```js
import { Suspense } from "react";

<Suspense fallback={<p>Loading...</p>}>
  <Home />
</Suspense>;
```

- `fallback` es lo que se muestra mientras se descarga el chunk.

---

## **6. Lazy Loading con React Router**

El caso más común es cargar páginas por ruta.

```js
import { Routes, Route } from "react-router-dom";
import { lazy, Suspense } from "react";

const Home = lazy(() => import("./pages/Home"));
const Profile = lazy(() => import("./pages/Profile"));

function App() {
  return (
    <Suspense fallback={<p>Loading page...</p>}>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/profile" element={<Profile />} />
      </Routes>
    </Suspense>
  );
}

export default App;
```

Cada página se descarga solo cuando se visita.

---

## **7. Qué se puede cargar de forma lazy**

✔️ Ideal para:

- Páginas.
- Componentes grandes.
- Secciones poco usadas.

❌ No recomendable para:

- Componentes muy pequeños.
- Componentes que siempre se muestran.

---

## **8. Lazy Loading vs React.memo**

Aunque ambos optimizan rendimiento, **no hacen lo mismo**:

- `React.memo` → evita renders innecesarios.
- Lazy Loading → evita descargar código innecesario.

Son técnicas complementarias.

---

## **9. Errores típicos**

### **9.1. Olvidar `Suspense`**

Provoca error en tiempo de ejecución.

### **9.2. Usar lazy en todo**

Demasiados chunks pequeños pueden empeorar el rendimiento.

### **9.3. Fallback poco claro**

Siempre informa al usuario de que algo se está cargando.

---

## **10. Buenas prácticas**

- Aplica lazy principalmente a páginas.
- Usa `Suspense` a nivel de rutas.
- Mantén fallbacks simples.
- Combina Lazy Loading con memoización cuando sea necesario.

---

En el siguiente tema aprenderás a escribir **tests en React**.
