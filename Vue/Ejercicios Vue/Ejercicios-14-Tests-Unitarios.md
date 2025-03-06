# **Ejercicios - Tema 14: Realizar Tests Unitarios en Vue 3 usando Vitest**

A continuación, encontrarás 5 ejercicios prácticos sobre cómo realizar tests unitarios en Vue 3 usando Vitest.

Intenta resolverlos antes de consultar la solución.

---

## **Ejercicio 1: Test básico de renderizado**

Crea un test para un componente `Header.vue` que verifique que el componente muestra correctamente un título `<h1>` con el texto "Bienvenido a la aplicación".

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 2: Simulación de un clic**

Crea un test para `Counter.vue` que verifique que el contador incrementa al hacer clic en un botón.

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 3: Test con prop inicial**

Crea un test para `Message.vue` que reciba una prop `text` y muestre ese mensaje.

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 4: Comprobar renderizado condicional**

Crea un test para `UserStatus.vue` que muestre "Usuario activo" si `isActive` es true, y "Usuario inactivo" si es false.

<details><summary>Mostrar Solución</summary>

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

## **Ejercicio 5: Simulación de input y v-model**

Crea un test para `NameForm.vue` que verifique que el input actualiza el modelo correctamente.

<details><summary>Mostrar Solución</summary>

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
