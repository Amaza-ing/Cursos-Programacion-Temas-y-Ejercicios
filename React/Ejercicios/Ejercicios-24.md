# **Ejercicios - Tema 24: React.memo**

A continuación, encontrarás **10 ejercicios prácticos** para comprender y aplicar `React.memo` como técnica de optimización de renderizados en React.

Intenta resolverlos antes de consultar la solución.

---

## **Ejercicio 1: Detectar renderizados innecesarios**

Crea dos componentes:

- `Parent.jsx` con estado `count`.
- `Child.jsx` que solo renderice un texto.

Añade un `console.log` en `Child` para comprobar cuántas veces se renderiza al cambiar `count`.

<details><summary>Mostrar Solución</summary>

```js
function Child() {
  console.log("Child rendered");
  return <p>Child</p>;
}
```

</details>

---

## **Ejercicio 2: Usar `React.memo`**

Envuelve el componente `Child` con `React.memo` para evitar renderizados innecesarios.

<details><summary>Mostrar Solución</summary>

```js
import { memo } from "react";

function Child() {
  console.log("Child rendered");
  return <p>Child</p>;
}

export default memo(Child);
```

</details>

---

## **Ejercicio 3: `React.memo` con props**

Modifica `Child` para que reciba una prop `name` y muestre `Hello {name}`.

Comprueba cuándo se vuelve a renderizar.

<details><summary>Mostrar Solución</summary>

```js
function Child({ name }) {
  console.log("Child rendered");
  return <p>Hello {name}</p>;
}

export default memo(Child);
```

</details>

---

## **Ejercicio 4: Props que no cambian**

En `Parent`, pasa siempre el mismo valor de `name` a `Child` y observa el comportamiento.

<details><summary>Mostrar Solución</summary>

```js
<Child name="Sara" />
```

</details>

---

## **Ejercicio 5: Props que sí cambian**

Modifica `Parent` para que `name` dependa del estado y observa cómo `Child` vuelve a renderizarse.

<details><summary>Mostrar Solución</summary>

```js
const [name, setName] = useState("Sara");
```

</details>

---

## **Ejercicio 6: Problema con objetos como props**

Pasa a `Child` una prop `options={{ theme: "dark" }}` y observa los renderizados.

<details><summary>Mostrar Solución</summary>

Cada render crea un nuevo objeto, por lo que `React.memo` no evita el render.

</details>

---

## **Ejercicio 7: Explicar la comparación superficial**

Explica por qué `React.memo` no funciona bien con objetos creados inline.

<details><summary>Mostrar Solución</summary>

Porque compara referencias, no el contenido del objeto.

</details>

---

## **Ejercicio 8: Cuándo NO usar `React.memo`**

Da un ejemplo de un componente donde `React.memo` no aporta beneficios.

<details><summary>Mostrar Solución</summary>

Componentes pequeños con render barato y pocas actualizaciones.

</details>

---

## **Ejercicio 9: `React.memo` y estado local**

¿Se renderiza un componente memoizado si cambia su propio estado?

<details><summary>Mostrar Solución</summary>

Sí. `React.memo` solo afecta a cambios en props, no al estado interno.

</details>

---

## **Ejercicio 10: React.memo como optimización**

Explica por qué no deberías usar `React.memo` de forma indiscriminada.

<details><summary>Mostrar Solución</summary>

Porque puede añadir complejidad innecesaria y no siempre mejora el rendimiento.

</details>
