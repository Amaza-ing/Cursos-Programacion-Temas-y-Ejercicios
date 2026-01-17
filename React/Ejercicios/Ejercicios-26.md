# **Ejercicios - Tema 26: Tests Unitarios en React**

A continuación, encontrarás **10 ejercicios prácticos** para afianzar la configuración y escritura de tests unitarios usando **Vitest** y **React Testing Library**, incluyendo tests de componentes, eventos, comportamiento asíncrono y **Context**.

Intenta resolverlos antes de consultar la solución.

---

## **Ejercicio 1: Comprobar que un componente renderiza**

Crea un componente `Title.jsx` que renderice un `h1` con el texto **"Welcome"**.

Escribe un test que compruebe que el texto aparece en el documento.

<details><summary>Mostrar Solución</summary>

```js
import { render, screen } from "@testing-library/react";
import Title from "./Title";

test("renders title", () => {
  render(<Title />);
  expect(screen.getByText("Welcome")).toBeInTheDocument();
});
```

</details>

---

## **Ejercicio 2: Testear props**

Crea un componente `Greeting.jsx` que reciba una prop `name` y muestre **"Hello {name}"**.

Escribe un test que renderice el componente con `name="Sara"`.

<details><summary>Mostrar Solución</summary>

```js
render(<Greeting name="Sara" />);
expect(screen.getByText("Hello Sara")).toBeInTheDocument();
```

</details>

---

## **Ejercicio 3: Testear un botón y un click**

Crea un componente `LikeButton.jsx` con:

- Estado `likes` inicial `0`.
- Un botón **Like** que incremente el contador.

Escribe un test que haga click y compruebe que el contador pasa a `1`.

<details><summary>Mostrar Solución</summary>

```js
import userEvent from "@testing-library/user-event";

const user = userEvent.setup();
await user.click(screen.getByRole("button", { name: "Like" }));
expect(screen.getByText("Likes: 1")).toBeInTheDocument();
```

</details>

---

## **Ejercicio 4: Usar `getByRole` correctamente**

Modifica un test para localizar un botón usando `getByRole` en lugar de `getByText`.

<details><summary>Mostrar Solución</summary>

```js
screen.getByRole("button", { name: /like/i });
```

</details>

---

## **Ejercicio 5: Testear un formulario con validación**

Crea un formulario con:

- Input controlado.
- Botón **Submit**.
- Mensaje de error si el input está vacío.

Escribe un test que compruebe que aparece el error al enviar vacío.

<details><summary>Mostrar Solución</summary>

```js
await user.click(screen.getByRole("button", { name: "Submit" }));
expect(screen.getByText("Required")).toBeInTheDocument();
```

</details>

---

## **Ejercicio 6: Test asíncrono con `findByText`**

Crea un componente que muestre **"Loading..."** y luego **"Done"** tras un `setTimeout`.

Escribe un test usando `findByText`.

<details><summary>Mostrar Solución</summary>

```js
expect(await screen.findByText("Done")).toBeInTheDocument();
```

</details>

---

## **Ejercicio 7: Mock de `fetch`**

Crea un componente que haga fetch a una API y muestre el número de elementos recibidos.

Escribe un test que **mockee `fetch`** para devolver 3 elementos.

<details><summary>Mostrar Solución</summary>

```js
import { vi } from "vitest";

vi.spyOn(global, "fetch").mockResolvedValue({
  json: async () => [{}, {}, {}],
});
```

</details>

---

## **Ejercicio 8: Envolver un componente con Context en tests**

Dado un `UsersContext`, escribe un test para un componente que consuma `users` desde el contexto.

<details><summary>Mostrar Solución</summary>

```js
render(
  <UsersProvider>
    <UsersList />
  </UsersProvider>
);
```

</details>

---

## **Ejercicio 9: Testear una función del Context**

Crea un botón que use una función `addUser` del contexto.

Escribe un test que haga click y compruebe que el usuario aparece en pantalla.

<details><summary>Mostrar Solución</summary>

```js
await user.click(screen.getByRole("button", { name: "Add" }));
expect(screen.getByText("New user")).toBeInTheDocument();
```

</details>

---

## **Ejercicio 10: Helper `renderWithProviders`**

Crea un helper `renderWithProviders` que envuelva los componentes con los Providers necesarios.

Escribe un test que lo utilice.

<details><summary>Mostrar Solución</summary>

```js
renderWithProviders(<UsersList />);
```

</details>
