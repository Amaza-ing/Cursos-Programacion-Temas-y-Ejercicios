# **Topic 26: Unit Tests in React (Testing Library + Vitest)**

## **1. Introduction**

When you start building more complete applications, a real need comes up: **making sure your code works today and will keep working tomorrow**, even after you make changes.

That's where **unit tests** come in.

In this topic you'll learn, step by step:

- What **unit tests** are and what they're for.
- How to set up **Vitest** and **React Testing Library** in a React project.
- How to test components: render, props, events, forms.
- How to test **asynchronous** behavior (data loading, loading states).
- How to **mock** `fetch` (and Axios too, if you use it).
- How to test **Context** (Provider + consumers + hooks).

> The goal is for you to follow it comfortably, with a clear initial setup, and then be able to repeat the process in any project.

---

## **2. What are unit tests?**

A **unit test** is a test that checks that a **small unit** of code behaves as we expect.

In React, typical units are:

- A component.
- A utility function.
- A hook.

Examples of things a unit test checks:

- “This component renders some text when it receives a prop.”
- “This button calls a function when I click it.”
- “If the request fails, an error message is displayed.”

---

## **3. Why they're important**

Tests help you:

- Detect errors quickly.
- Avoid breaking things when you refactor.
- Gain confidence when adding new features.
- Keep the code more stable in large projects.

---

## **4. Which libraries we're going to use**

In React, the most common combination today is this one:

- **Vitest** → test runner (very fast and a perfect fit for Vite).
- **React Testing Library** → to test components as if you were a user.
- **@testing-library/jest-dom** → extra matchers (for example: `toBeInTheDocument`).
- **@testing-library/user-event** → to simulate real interactions (keyboard, clicks).

> You can do it with Jest too, but in modern Vite projects, **Vitest is usually the most convenient option**.

---

## **5. Initial setup, step by step (Vite + React)**

### **5.1. Installing dependencies**

Run:

```bash
npm install -D vitest jsdom @testing-library/react @testing-library/jest-dom @testing-library/user-event
```

What each package is for:

- `vitest`: the tool that runs the tests.
- `jsdom`: simulates the browser.
- `@testing-library/react`: functions to render components in tests.
- `@testing-library/jest-dom`: extra matchers.
- `@testing-library/user-event`: simulates real usage.

---

### **5.2. Configuring Vitest in `vite.config.js`**

Open `vite.config.js` and add the `test` block:

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

This means:

- `environment: "jsdom"` → React needs a DOM.
- `setupFiles` → a file that runs before the tests (ideal for setting up jest-dom).

---

### **5.3. Creating the `src/test/setup.js` file**

Create this path:

```txt
src/test/setup.js
```

And add this inside it:

```js
import "@testing-library/jest-dom";
```

Now you'll be able to use matchers like:

- `toBeInTheDocument()`
- `toHaveTextContent()`
- `toBeDisabled()`

---

### **5.4. Adding scripts to `package.json`**

Add this to your `package.json`:

```json
{
  "scripts": {
    "test": "vitest",
    "test:ui": "vitest --ui",
    "test:run": "vitest run"
  }
}
```

What each one does:

- `npm run test` → watch mode.
- `npm run test:run` → runs all the tests once.
- `npm run test:ui` → visual interface (if you want to use it).

---

## **6. Recommended test structure**

The most common structure:

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

In other words:

- The test goes next to the component.
- Name: `Component.test.jsx`.

---

## **7. Your first test: basic render**

### **7.1. Example component**

`src/components/Hello.jsx`

```js
function Hello({ name }) {
  return <h1>Hello {name}</h1>;
}

export default Hello;
```

### **7.2. Component test**

`src/components/Hello.test.jsx`

```js
import { render, screen } from "@testing-library/react";
import Hello from "./Hello";

test("renders the name", () => {
  render(<Hello name="Sara" />);

  expect(screen.getByText("Hello Sara")).toBeInTheDocument();
});
```

Key points:

- `render(...)` mounts the component.
- `screen.getByText(...)` searches the DOM.
- `expect(...).toBeInTheDocument()` checks that it exists.

---

## **8. Testing events (clicks) with user-event**

### **8.1. Component**

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

Important recommendation:

- Use `getByRole` whenever you can.
- It's more robust and closer to real accessibility.

---

## **9. Form tests (input + submit)**

### **9.1. Component**

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

## **10. Asynchronous tests: loading and data**

A key part of React is testing components that:

- Load data.
- Show a loading state.
- Show a result.

For that we use:

- `findBy...` (waits automatically)
- `waitFor(...)` (waits for a condition to be met)

---

## **11. Mocking Fetch (very important)**

If a component uses `fetch`, we don't want our tests to depend on the Internet.

The idea is:

- Replace `fetch` with a mock.
- Decide what it responds with.

### **11.1. A component that uses fetch**

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

### **11.2. Test with a fetch mock**

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

Important notes:

- `mockResolvedValue` makes `fetch` return a resolved promise.
- `findByText` waits for the text to exist.
- `mockRestore()` cleans up the mock.

---

## **12. Mocking Axios (if you use it in your project)**

If you're using Axios instead of `fetch`:

```js
import axios from "axios";
```

You can mock it like this:

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

## **13. Testing Context (Provider + consumers)**

This is one of the most important parts if your app already uses Context.

The idea:

- If a component depends on the context, you need to wrap it with its Provider in your tests.

---

## **14. Complete example: UsersContext + Provider**

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

### **14.2. Consumer component**

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

## **15. Testing a component that uses Context**

In the test, we wrap the component with the Provider.

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

## **16. Context with functions: testing updates**

Now, a context that lets you add users.

### **16.1. Provider with a function**

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

### **16.2. Component to add users**

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

### **16.3. Test with interaction**

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

## **17. Useful pattern: a `renderWithProviders` helper**

In projects with several Providers, a helper comes in handy.

`src/test/renderWithProviders.js`

```js
import { render } from "@testing-library/react";
import { UsersProvider } from "../context/UsersContext";

export function renderWithProviders(ui) {
  return render(<UsersProvider>{ui}</UsersProvider>);
}
```

Usage:

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

## **18. What you should take away from this topic**

- A unit test validates a small unit (component, function, hook).
- With Vite, Vitest is a very convenient option.
- React Testing Library teaches you to test like a user.
- Requests should be mocked (`fetch` or Axios).
- To test Context, wrap the component with the Provider.

## **19. Using Jest**

[![Testing Config](https://img.youtube.com/vi/bVTkCyxPwx0/0.jpg)](https://www.youtube.com/watch?v=bVTkCyxPwx0&list=PLzA2VyZwsq_-dE3Jvunglxq8a6UcH6gnF)

---

[![Creating Tests with Jest and React Testing Library](https://img.youtube.com/vi/H4epaNzJCmY/0.jpg)](https://www.youtube.com/watch?v=H4epaNzJCmY&list=PLzA2VyZwsq_-dE3Jvunglxq8a6UcH6gnF)

---

[![Testing & Context](https://img.youtube.com/vi/PgH9srj8Sj4/0.jpg)](https://www.youtube.com/watch?v=PgH9srj8Sj4&list=PLzA2VyZwsq_-dE3Jvunglxq8a6UcH6gnF)

---

In the next topic you'll see **how to build a complete website from scratch** (a notes app).
