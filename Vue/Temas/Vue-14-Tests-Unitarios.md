# **Topic 14: Perform Unit Tests in Vue 3 using Vitest**

## **1. Introduction**

Unit testing is a key tool to ensure that components work correctly in isolation. In a Vue 3 project with Vite, the best option for testing is **Vitest**, a fast library compatible with Vite.

In this topic we will learn:

- Configure Vitest in a Vue 3 project.
- Write tests for components using `@vue/test-utils`.
- Simulate events and check the expected behavior.

---

## **2. Basic Vitest Configuration**

Before starting to do unit tests with Vitest we must install the dependencies:

```sh
npm install vitest @vue/test-utils jsdom -D
```

The `package.json` file must include Vitest as a dependency and add a script to run the tests:

**package.json:**

```json
"scripts": {
    "test": "vitest"
}
```

In the `vite.config.js` file, Vitest must be configured to use the `jsdom` environment, which is necessary for testing Vue components.

**vite.config.js:**

```javascript
import { defineConfig } from "vite";
import vue from "@vitejs/plugin-vue";

export default defineConfig({
  plugins: [vue()],
  test: {
    globals: true,
    environment: "jsdom",
  },
});
```

---

## **3. Creating a basic test**

Unit tests are usually placed in files next to the component or in specific folders (`tests` or `__tests__`). A basic test with `@vue/test-utils` and Vitest looks like this:

**Home.test.js:**

```javascript
import { mount } from "@vue/test-utils";
import { describe, it, expect } from "vitest";
import Home from "./Home.vue";

describe("Home", () => {
  it("renderiza correctamente", () => {
    const wrapper = mount(Home);
    expect(wrapper.find("h1").text()).toBe("Welcome to the Home Page");
  });
});
```

---

## **4. Simulate interactions**

It is also possible to simulate user events, such as clicks or inputs, and verify that the component responds correctly.

```javascript
it("incrementa el contador al hacer clic", async () => {
  const wrapper = mount(Home);

  expect(wrapper.find("#counter").text()).toContain("Counter: 1");

  await wrapper.find("#counter-btn").trigger("click");

  expect(wrapper.find("#counter").text()).toContain("Counter: 2");
});
```

---

## **5. Mock of Stores or Modules**

If the component depends on a Pinia store or other external modules, those dependencies can be **mocked** so that the test is controlled.

```javascript
vi.mock("../stores/user", () => ({
  useUserStore: () => ({
    user: "aaa",
    getUser: () => {},
  }),
}));
```

This ensures that the test does not fail due to external causes, such as the actual implementation of the store.

---

## **6. Test execution**

To run all tests:

```sh
npm run test
```

Vitest will show a summary of executed tests, failures and results.

---

## Summary

| Tool | Usage |
| --------------- | ------------------------------------------ |
| Vitest | Run and manage tests |
| @vue/test-utils | Assemble components and simulate interactions |
| jsdom | Simulate the DOM in a test environment |
| vi.mock() | Simulate external dependencies |

---

[![Unit tests in Vue.js with Vitest](https://img.youtube.com/vi/JtMYK2gKtMU/0.jpg)](https://www.youtube.com/watch?v=JtMYK2gKtMU&list=PLzA2VyZwsq_92Fnb4JEUnXUhSYfNHtcKx)

---
