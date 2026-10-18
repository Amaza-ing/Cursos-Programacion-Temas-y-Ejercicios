# **Exercises - Topic 26: Unit Tests in React**

Below you will find **10 practical exercises** to master setting up and writing unit tests using **Vitest** and **React Testing Library**, including component, event, asynchronous behavior, and **Context** tests.

Try to solve them before consulting the solution.

---

## **Exercise 1: Check that a component renders**

Create an `Title.jsx` component that renders an `h1` with the text **"Welcome"**.

Write a test that verifies that the text appears in the document.

<details><summary>Show Solution</summary>

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

## **Exercise 2: Test props**

Create an `Greeting.jsx` component that receives an `name` prop and displays **"Hello {name}"**.

Write a test that renders the component with `name="Sara"`.

<details><summary>Show Solution</summary>

```js
render(<Greeting name="Sara" />);
expect(screen.getByText("Hello Sara")).toBeInTheDocument();
```

</details>

---

## **Exercise 3: Test a button and a click**

Create an `LikeButton.jsx` component with:

- Initial `likes` state `0`.
- A **Like** button that increments the counter.

Write a test that clicks and verifies that the counter goes to `1`.

<details><summary>Show Solution</summary>

```js
import userEvent from "@testing-library/user-event";

const user = userEvent.setup();
await user.click(screen.getByRole("button", { name: "Like" }));
expect(screen.getByText("Likes: 1")).toBeInTheDocument();
```

</details>

---

## **Exercise 4: Using `getByRole` correctly**

Modify a test to locate a button using `getByRole` instead of `getByText`.

<details><summary>Show Solution</summary>

```js
screen.getByRole("button", { name: /like/i });
```

</details>

---

## **Exercise 5: Test a form with validation**

Create a form with:

- Controlled input.
- **Submit** button.
- Error message if the input is empty.

Write a test that verifies that the error appears when sending empty.

<details><summary>Show Solution</summary>

```js
await user.click(screen.getByRole("button", { name: "Submit" }));
expect(screen.getByText("Required")).toBeInTheDocument();
```

</details>

---

## **Exercise 6: Asynchronous test with `findByText`**

Create a component that displays **"Loading..."** and then **"Done"** after an `setTimeout`.

Write a test using `findByText`.

<details><summary>Show Solution</summary>

```js
expect(await screen.findByText("Done")).toBeInTheDocument();
```

</details>

---

## **Exercise 7: `fetch` Mock**

Create a component that fetches an API and displays the number of items received.

Write a test that **mocks `fetch`** to return 3 elements.

<details><summary>Show Solution</summary>

```js
import { vi } from "vitest";

vi.spyOn(global, "fetch").mockResolvedValue({
  json: async () => [{}, {}, {}],
});
```

</details>

---

## **Exercise 8: Wrap a component with Context in tests**

Given an `UsersContext`, write a test for a component that consumes `users` from the context.

<details><summary>Show Solution</summary>

```js
render(
  <UsersProvider>
    <UsersList />
  </UsersProvider>
);
```

</details>

---

## **Exercise 9: Test a Context function**

Create a button that uses an `addUser` function from the context.

Write a test that clicks and verifies that the user appears on the screen.

<details><summary>Show Solution</summary>

```js
await user.click(screen.getByRole("button", { name: "Add" }));
expect(screen.getByText("New user")).toBeInTheDocument();
```

</details>

---

## **Exercise 10: Helper `renderWithProviders`**

Create an `renderWithProviders` helper that wraps the components with the necessary Providers.
Write a test that uses it.

<details><summary>Show Solution</summary>

```js
renderWithProviders(<UsersList />);
```

</details>
