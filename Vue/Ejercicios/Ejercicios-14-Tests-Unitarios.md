# **Exercises - Topic 14: Writing Unit Tests in Vue 3 with Vitest**

Below you'll find 5 practical exercises on writing unit tests in Vue 3 with Vitest.

Try to solve them before looking at the solution.

---

## **Exercise 1: Basic rendering test**

Create a test for a `Header.vue` component that checks that the component correctly displays an `<h1>` title with the text "Bienvenido a la aplicación" ("Welcome to the application").

<details><summary>Show solution</summary>

```javascript
import { mount } from "@vue/test-utils";
import { describe, it, expect } from "vitest";
import Header from "../components/Header.vue";

describe("Header", () => {
  it("muestra el título correcto", () => {
    const wrapper = mount(Header);
    expect(wrapper.find("h1").text()).toBe("Bienvenido a la aplicación");
  });
});
```

</details>

---

## **Exercise 2: Simulating a click**

Create a test for `Counter.vue` that checks that the counter goes up when a button is clicked.

<details><summary>Show solution</summary>

```javascript
import { mount } from "@vue/test-utils";
import { describe, it, expect } from "vitest";
import Counter from "../components/Counter.vue";

describe("Counter", () => {
  it("incrementa al hacer clic", async () => {
    const wrapper = mount(Counter);
    expect(wrapper.find("p").text()).toContain("Contador: 0");

    await wrapper.find("button").trigger("click");

    expect(wrapper.find("p").text()).toContain("Contador: 1");
  });
});
```

</details>

---

## **Exercise 3: Test with an initial prop**

Create a test for `Message.vue`, which receives a `text` prop and displays that message.

<details><summary>Show solution</summary>

```javascript
import { mount } from "@vue/test-utils";
import { describe, it, expect } from "vitest";
import Message from "../components/Message.vue";

describe("Message", () => {
  it("muestra el mensaje recibido como prop", () => {
    const wrapper = mount(Message, {
      props: { text: "Hola Mundo" },
    });

    expect(wrapper.text()).toContain("Hola Mundo");
  });
});
```

</details>

---

## **Exercise 4: Check conditional rendering**

Create a test for `UserStatus.vue`, which displays "Usuario activo" ("Active user") if `isActive` is true, and "Usuario inactivo" ("Inactive user") if it's false.

<details><summary>Show solution</summary>

```javascript
import { mount } from "@vue/test-utils";
import { describe, it, expect } from "vitest";
import UserStatus from "../components/UserStatus.vue";

describe("UserStatus", () => {
  it('muestra "Usuario activo" cuando isActive es true', () => {
    const wrapper = mount(UserStatus, {
      props: { isActive: true },
    });
    expect(wrapper.text()).toContain("Usuario activo");
  });

  it('muestra "Usuario inactivo" cuando isActive es false', () => {
    const wrapper = mount(UserStatus, {
      props: { isActive: false },
    });
    expect(wrapper.text()).toContain("Usuario inactivo");
  });
});
```

</details>

---

## **Exercise 5: Simulating input and v-model**

Create a test for `NameForm.vue` that checks that the input updates the model correctly.

<details><summary>Show solution</summary>

```javascript
import { mount } from "@vue/test-utils";
import { describe, it, expect } from "vitest";
import NameForm from "../components/NameForm.vue";

describe("NameForm", () => {
  it("actualiza el nombre con v-model", async () => {
    const wrapper = mount(NameForm);
    const input = wrapper.find("input");

    await input.setValue("Sara");

    expect(input.element.value).toBe("Sara");
  });
});
```

</details>
