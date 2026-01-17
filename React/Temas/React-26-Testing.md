# **Tema 26: Tests Unitarios en React (Testing Library + Vitest)**

## **1. Introducción**

Cuando empiezas a crear aplicaciones más completas, aparece una necesidad real: **asegurarte de que tu código funciona hoy y seguirá funcionando mañana**, incluso después de hacer cambios.

Ahí entran los **tests unitarios**.

En este tema vas a aprender paso a paso:

- Qué son los **tests unitarios** y para qué sirven.
- Cómo configurar **Vitest** y **React Testing Library** en un proyecto React.
- Cómo testear componentes: render, props, eventos, formularios.
- Cómo testear comportamiento **asíncrono** (carga de datos, estados de loading).
- Cómo hacer **mock** de `fetch` (y también de Axios si lo usas).
- Cómo testear **Context** (Provider + consumidores + hooks).

> El objetivo es que puedas seguirlo de forma cómoda, con una configuración inicial clara, y luego puedas repetir el proceso en cualquier proyecto.

---

## **2. ¿Qué son los tests unitarios?**

Un **test unitario** es una prueba que verifica que una **unidad pequeña** de código se comporta como esperamos.

En React, las unidades típicas son:

- Un componente.
- Una función utilitaria.
- Un hook.

Ejemplos de cosas que un test unitario valida:

- “Este componente renderiza un texto cuando recibe una prop”.
- “Este botón llama a una función cuando hago click”.
- “Si la petición falla, se muestra un mensaje de error”.

---

## **3. Por qué son importantes**

Los tests te ayudan a:

- Detectar errores rápidamente.
- Evitar romper cosas cuando refactorizas.
- Aumentar confianza al añadir nuevas features.
- Mantener el código más estable en proyectos grandes.

---

## **4. Qué librerías vamos a usar**

En React, lo más común hoy es esta combinación:

- **Vitest** → runner de tests (muy rápido y perfecto con Vite).
- **React Testing Library** → para testear componentes como si fueras un usuario.
- **@testing-library/jest-dom** → matchers extra (por ejemplo: `toBeInTheDocument`).
- **@testing-library/user-event** → para simular interacciones reales (teclado, clicks).

> Puedes hacerlo con Jest también, pero en proyectos modernos con Vite, **Vitest suele ser la opción más cómoda**.

---

## **5. Configuración inicial paso a paso (Vite + React)**

### **5.1. Instalar dependencias**

Ejecuta:

```bash
npm install -D vitest jsdom @testing-library/react @testing-library/jest-dom @testing-library/user-event
```

Qué instala cada cosa:

- `vitest`: herramienta que ejecuta los tests.
- `jsdom`: simula el navegador.
- `@testing-library/react`: funciones para renderizar componentes en tests.
- `@testing-library/jest-dom`: matchers extra.
- `@testing-library/user-event`: simula uso real.

---

### **5.2. Configurar Vitest en `vite.config.js`**

Abre `vite.config.js` y añade el bloque `test`:

```js
import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";

export default defineConfig({
  plugins: [react()],
  test: {
    environment: "jsdom",
    setupFiles: "./src/test/setup.js",
  },
});
```

Esto significa:

- `environment: "jsdom"` → React necesita DOM.
- `setupFiles` → archivo que se ejecuta antes de los tests (ideal para configurar jest-dom).

---

### **5.3. Crear el archivo `src/test/setup.js`**

Crea esta ruta:

```txt
src/test/setup.js
```

Y dentro añade:

```js
import "@testing-library/jest-dom";
```

Así ya podrás usar matchers como:

- `toBeInTheDocument()`
- `toHaveTextContent()`
- `toBeDisabled()`

---

### **5.4. Añadir scripts en `package.json`**

En tu `package.json` añade:

```json
{
  "scripts": {
    "test": "vitest",
    "test:ui": "vitest --ui",
    "test:run": "vitest run"
  }
}
```

Qué hace cada uno:

- `npm run test` → modo watch.
- `npm run test:run` → ejecuta todos los tests una vez.
- `npm run test:ui` → interfaz visual (si quieres usarla).

---

## **6. Estructura recomendada de tests**

La estructura más típica:

```txt
src/
 ├─ components/
 │   ├─ Counter.jsx
 │   └─ Counter.test.jsx
 ├─ context/
 ├─ pages/
 └─ test/
     └─ setup.js
```

Es decir:

- El test se pone junto al componente.
- Nombre: `Component.test.jsx`.

---

## **7. Tu primer test: render básico**

### **7.1. Componente de ejemplo**

`src/components/Hello.jsx`

```js
function Hello({ name }) {
  return <h1>Hello {name}</h1>;
}

export default Hello;
```

### **7.2. Test del componente**

`src/components/Hello.test.jsx`

```js
import { render, screen } from "@testing-library/react";
import Hello from "./Hello";

test("renders the name", () => {
  render(<Hello name="Sara" />);

  expect(screen.getByText("Hello Sara")).toBeInTheDocument();
});
```

Puntos clave:

- `render(...)` monta el componente.
- `screen.getByText(...)` busca en el DOM.
- `expect(...).toBeInTheDocument()` verifica que existe.

---

## **8. Tests de eventos (clicks) con user-event**

### **8.1. Componente**

`Counter.jsx`

```js
import { useState } from "react";

function Counter() {
  const [count, setCount] = useState(0);

  return (
    <div>
      <p>Count: {count}</p>
      <button onClick={() => setCount(count + 1)}>+1</button>
    </div>
  );
}

export default Counter;
```

### **8.2. Test**

```js
import { render, screen } from "@testing-library/react";
import userEvent from "@testing-library/user-event";
import Counter from "./Counter";

test("increments count on click", async () => {
  const user = userEvent.setup();

  render(<Counter />);

  expect(screen.getByText("Count: 0")).toBeInTheDocument();

  await user.click(screen.getByRole("button", { name: "+1" }));

  expect(screen.getByText("Count: 1")).toBeInTheDocument();
});
```

Recomendación importante:

- Usa `getByRole` siempre que puedas.
- Es más robusto y más parecido a accesibilidad real.

---

## **9. Tests de formularios (input + submit)**

### **9.1. Componente**

```js
import { useState } from "react";

function NameForm() {
  const [name, setName] = useState("");
  const [message, setMessage] = useState("");

  const handleSubmit = (event) => {
    event.preventDefault();

    if (name.trim() === "") {
      setMessage("Name required");
      return;
    }

    setMessage("Saved");
  };

  return (
    <form onSubmit={handleSubmit}>
      <input
        aria-label="name"
        value={name}
        onChange={(e) => setName(e.target.value)}
      />

      <button type="submit">Save</button>

      {message && <p>{message}</p>}
    </form>
  );
}

export default NameForm;
```

### **9.2. Test**

```js
import { render, screen } from "@testing-library/react";
import userEvent from "@testing-library/user-event";
import NameForm from "./NameForm";

test("shows error when input is empty", async () => {
  const user = userEvent.setup();

  render(<NameForm />);

  await user.click(screen.getByRole("button", { name: "Save" }));

  expect(screen.getByText("Name required")).toBeInTheDocument();
});

test("shows success when input has value", async () => {
  const user = userEvent.setup();

  render(<NameForm />);

  await user.type(screen.getByLabelText("name"), "Sara");
  await user.click(screen.getByRole("button", { name: "Save" }));

  expect(screen.getByText("Saved")).toBeInTheDocument();
});
```

---

## **10. Tests asíncronos: loading y datos**

Una parte clave en React es testear componentes que:

- Cargan datos.
- Muestran loading.
- Muestran resultado.

Para eso usamos:

- `findBy...` (espera automáticamente)
- `waitFor(...)` (espera a que una condición se cumpla)

---

## **11. Mock de Fetch (muy importante)**

Si un componente usa `fetch`, en tests no queremos depender de Internet.

La idea es:

- Reemplazar `fetch` por un mock.
- Decidir qué responde.

### **11.1. Componente que hace fetch**

```js
import { useEffect, useState } from "react";

function UsersLoader() {
  const [users, setUsers] = useState([]);

  useEffect(() => {
    const load = async () => {
      const response = await fetch(
        "https://jsonplaceholder.typicode.com/users"
      );
      const data = await response.json();
      setUsers(data);
    };

    load();
  }, []);

  return <p>Users: {users.length}</p>;
}

export default UsersLoader;
```

### **11.2. Test con mock de fetch**

```js
import { render, screen } from "@testing-library/react";
import { vi } from "vitest";
import UsersLoader from "./UsersLoader";

test("loads users and renders the count", async () => {
  vi.spyOn(global, "fetch").mockResolvedValue({
    json: async () => [{ id: 1 }, { id: 2 }],
  });

  render(<UsersLoader />);

  expect(await screen.findByText("Users: 2")).toBeInTheDocument();

  global.fetch.mockRestore();
});
```

Notas importantes:

- `mockResolvedValue` hace que `fetch` devuelva una promesa resuelta.
- `findByText` espera a que el texto exista.
- `mockRestore()` limpia el mock.

---

## **12. Mock de Axios (si lo usas en tu proyecto)**

Si en lugar de `fetch` estás usando Axios:

```js
import axios from "axios";
```

Puedes mockearlo así:

```js
import { vi } from "vitest";
import axios from "axios";

vi.mock("axios");

test("loads users with axios", async () => {
  axios.get.mockResolvedValue({
    data: [{ id: 1 }, { id: 2 }, { id: 3 }],
  });

  // render + assertions
});
```

---

## **13. Testing de Context (Provider + consumidores)**

Aquí está una de las partes más importantes si tu app ya usa Context.

La idea:

- Si un componente depende del contexto, en tests necesitas envolverlo con su Provider.

---

## **14. Ejemplo completo: UsersContext + Provider**

### **14.1. Context + Provider**

`src/context/UsersContext.jsx`

```js
import { createContext, useEffect, useState } from "react";

export const UsersContext = createContext();

export function UsersProvider({ children }) {
  const [users, setUsers] = useState([]);

  useEffect(() => {
    setUsers([{ id: 1, name: "Sara" }]);
  }, []);

  return (
    <UsersContext.Provider value={{ users }}>{children}</UsersContext.Provider>
  );
}
```

### **14.2. Componente consumidor**

`UsersList.jsx`

```js
import { useContext } from "react";
import { UsersContext } from "../context/UsersContext";

function UsersList() {
  const { users } = useContext(UsersContext);

  return (
    <ul>
      {users.map((user) => (
        <li key={user.id}>{user.name}</li>
      ))}
    </ul>
  );
}

export default UsersList;
```

---

## **15. Testear un componente que usa Context**

En el test, envolvemos el componente con el Provider.

```js
import { render, screen } from "@testing-library/react";
import { UsersProvider } from "../context/UsersContext";
import UsersList from "./UsersList";

test("renders users from context", async () => {
  render(
    <UsersProvider>
      <UsersList />
    </UsersProvider>
  );

  expect(await screen.findByText("Sara")).toBeInTheDocument();
});
```

---

## **16. Context con funciones: testear actualizaciones**

Ahora un contexto que permite añadir usuarios.

### **16.1. Provider con función**

```js
import { createContext, useState } from "react";

export const UsersContext = createContext();

export function UsersProvider({ children }) {
  const [users, setUsers] = useState([]);

  const addUser = (newUser) => {
    setUsers((prev) => [...prev, newUser]);
  };

  return (
    <UsersContext.Provider value={{ users, addUser }}>
      {children}
    </UsersContext.Provider>
  );
}
```

### **16.2. Componente para añadir**

```js
import { useContext } from "react";
import { UsersContext } from "../context/UsersContext";

function AddUserButton() {
  const { addUser } = useContext(UsersContext);

  return (
    <button onClick={() => addUser({ id: 1, name: "New user" })}>Add</button>
  );
}

export default AddUserButton;
```

### **16.3. Test con interacción**

```js
import { render, screen } from "@testing-library/react";
import userEvent from "@testing-library/user-event";
import { UsersProvider } from "../context/UsersContext";
import AddUserButton from "./AddUserButton";
import UsersList from "./UsersList";

test("adds user through context", async () => {
  const user = userEvent.setup();

  render(
    <UsersProvider>
      <AddUserButton />
      <UsersList />
    </UsersProvider>
  );

  await user.click(screen.getByRole("button", { name: "Add" }));

  expect(screen.getByText("New user")).toBeInTheDocument();
});
```

---

## **17. Patrón útil: helper `renderWithProviders`**

En proyectos con varios Providers, te conviene un helper.

`src/test/renderWithProviders.js`

```js
import { render } from "@testing-library/react";
import { UsersProvider } from "../context/UsersContext";

export function renderWithProviders(ui) {
  return render(<UsersProvider>{ui}</UsersProvider>);
}
```

Uso:

```js
import { screen } from "@testing-library/react";
import { renderWithProviders } from "../test/renderWithProviders";
import UsersList from "./UsersList";

test("renders users", () => {
  renderWithProviders(<UsersList />);
  // assertions...
});
```

---

## **18. Qué debes quedarte de este tema**

- Un test unitario valida una unidad pequeña (componente, función, hook).
- Con Vite, Vitest es una opción muy cómoda.
- React Testing Library te enseña a testear como usuario.
- Las peticiones se deben mockear (`fetch` o Axios).
- Para testear Context, envuelve el componente con el Provider.

---

En el siguiente tema trabajarás verás **Cómo crear una web completa desde 0** (Una aplicación de notas).
