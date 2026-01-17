# **Tema 24: React.memo y Optimización de Renderizados**

## **1. Introducción**

A medida que una aplicación React crece, también aumenta el número de componentes y renderizados. No todos los renderizados son necesarios: a veces un componente se vuelve a renderizar aunque **sus props no hayan cambiado**.

React ofrece una herramienta para optimizar este comportamiento: **`React.memo`**.

En este tema aprenderás:

- Qué es un renderizado innecesario.
- Qué hace `React.memo`.
- Cuándo usarlo y cuándo no.
- Relación entre `React.memo`, props y estado.
- Errores comunes y buenas prácticas.

---

## **2. ¿Qué es un render en React?**

Un componente **se renderiza** cuando:

- Cambia su estado.
- Cambian sus props.
- Se renderiza su componente padre.

Esto último es importante: **un hijo se renderiza cuando su padre se renderiza**, aunque sus props no cambien.

---

## **3. El problema: renderizados innecesarios**

Ejemplo:

```js
function Parent() {
  const [count, setCount] = useState(0);

  return (
    <>
      <button onClick={() => setCount(count + 1)}>+</button>
      <Child />
    </>
  );
}
```

Aunque `Child` no recibe props, **se renderiza cada vez** que cambia `count`.

En apps pequeñas no es un problema, pero en componentes grandes puede afectar al rendimiento.

---

## **4. ¿Qué es `React.memo`?**

`React.memo` es una función que **memoriza** un componente.

- Si las props **no cambian**, React reutiliza el render anterior.
- Si las props **cambian**, el componente se vuelve a renderizar.

---

## **5. Uso básico de `React.memo`**

```js
import { memo } from "react";

function Child() {
  console.log("Child rendered");
  return <p>Child component</p>;
}

export default memo(Child);
```

Ahora `Child` **no se renderiza** si sus props no cambian.

---

## **6. `React.memo` con props**

Ejemplo:

```js
function Child({ name }) {
  console.log("Child rendered");
  return <p>Hello {name}</p>;
}

export default memo(Child);
```

- Si `name` no cambia → no hay render.
- Si `name` cambia → sí hay render.

---

## **7. Comparación superficial de props**

`React.memo` hace una **comparación superficial** (_shallow comparison_):

- Valores primitivos (`string`, `number`, `boolean`) → correcto.
- Objetos y arrays → se comparan por referencia.

Ejemplo problemático:

```js
<Child options={{ theme: "dark" }} />
```

Este objeto es **nuevo en cada render**, aunque su contenido sea igual.

---

## **8. `React.memo` y objetos/funciones**

Cuando pasas:

- Objetos
- Arrays
- Funciones

…como props, suelen cambiar de referencia.

Soluciones (se verán más adelante):

- `useCallback`
- `useMemo`

Por ahora, idea clave:

> `React.memo` funciona mejor con props simples.

---

## **9. Cuándo usar `React.memo`**

✔️ Útil cuando:

- El componente es pesado.
- Se renderiza muchas veces.
- Recibe props estables.

❌ No necesario cuando:

- El componente es pequeño.
- El render es barato.
- Las props cambian constantemente.

Optimizar sin medir puede ser contraproducente.

---

## **10. Errores típicos**

### **10.1. Usar `React.memo` en todos los componentes**

No es buena práctica.

### **10.2. Esperar que arregle renders por estado local**

Si el estado está dentro del componente, **se renderiza igual**.

### **10.3. Olvidar que es una optimización**

Primero que funcione, luego optimizar.

---

## **11. Buenas prácticas**

- Usa `React.memo` de forma selectiva.
- Empieza por componentes grandes o listas.
- Evita pasar objetos inline.
- Combínalo con `useCallback` y `useMemo` cuando sea necesario.

---

[![React Memo](https://img.youtube.com/vi/Y9aWic62X7M/0.jpg)](https://www.youtube.com/watch?v=Y9aWic62X7M&list=PLzA2VyZwsq_-dE3Jvunglxq8a6UcH6gnF)

---

En el siguiente tema aprenderás a optimizar la carga con **Lazy Loading**.
