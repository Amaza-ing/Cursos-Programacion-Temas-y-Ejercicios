# **Topic 14: Writing Unit Tests in Vue 3 with Vitest**

## **1. Introduction**

Unit tests are a key tool for making sure components work correctly in isolation. In a Vue 3 project with Vite, the best option for testing is **Vitest**, a fast library that's compatible with Vite.

In this topic, we'll learn how to:

- Set up Vitest in a Vue 3 project.
- Write tests for components using `@vue/test-utils`.
- Simulate events and check the expected behavior.

---

## **2. Basic Vitest setup**

Before we start writing unit tests with Vitest, we need to install the dependencies:

```sh
npm install vitest @vue/test-utils jsdom -D
```

The `package.json` file must include Vitest as a dependency, plus a script to run the tests:

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

Unit tests usually go in files next to the component or in dedicated folders (`tests` or `__tests__`). A basic test with `@vue/test-utils` and Vitest looks like this:

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

## **4. Simulating interactions**

You can also simulate user events, such as clicks or inputs, and check that the component responds correctly.

```javascript
it("incrementa el contador al hacer clic", async () => {
  const wrapper = mount(Home);

  expect(wrapper.find("#counter").text()).toContain("Counter: 1");

  await wrapper.find("#counter-btn").trigger("click");

  expect(wrapper.find("#counter").text()).toContain("Counter: 2");
});
```

---

## **5. Mocking stores or modules**

If the component depends on a Pinia store or other external modules, you can **mock** those dependencies to keep the test under control.

```javascript
vi.mock("../stores/user", () => ({
  useUserStore: () => ({
    user: "aaa",
    getUser: () => {},
  }),
}));
```

This ensures that the test doesn't fail for external reasons, such as the store's actual implementation.

---

## **6. Running the tests**

To run all the tests:

```sh
npm run test
```

Vitest will show a summary of the tests run, failures and results.

---

## Summary

| Tool            | Usage                                      |
| --------------- | ------------------------------------------ |
| Vitest          | Run and manage the tests                   |
| @vue/test-utils | Mount components and simulate interactions |
| jsdom           | Simulate the DOM in a test environment     |
| vi.mock()       | Simulate external dependencies             |

---

[![Unit tests in Vue.js with Vitest](https://img.youtube.com/vi/JtMYK2gKtMU/0.jpg)](https://www.youtube.com/watch?v=JtMYK2gKtMU&list=PLzA2VyZwsq_92Fnb4JEUnXUhSYfNHtcKx)

---
