# **Tema 14: Realizar Tests Unitarios en Vue 3 usando Vitest**

## **1. Introducción**

Las pruebas unitarias son una herramienta clave para garantizar que los componentes funcionan correctamente de forma aislada. En un proyecto Vue 3 con Vite, la mejor opción para realizar tests es **Vitest**, una librería rápida y compatible con Vite.

En este tema aprenderemos:

- Configurar Vitest en un proyecto Vue 3.
- Escribir tests para componentes usando `@vue/test-utils`.
- Simular eventos y comprobar el comportamiento esperado.

---

## **2. Configuración básica de Vitest**

Antes de empezar a hacer tests unitarios con Vitest debemos instalar las dependencias:

```sh
npm install vitest @vue/test-utils jsdom -D
```

El archivo `package.json` debe incluir Vitest como dependencia y añadir un script para ejecutar los tests:

**package.json:**

```json
"scripts": {
    "test": "vitest"
}
```

En el archivo `vite.config.js`, se debe configurar Vitest para que utilice el entorno `jsdom`, lo cual es necesario para probar componentes Vue.

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

## **3. Creación de un test básico**

Los tests unitarios suelen colocarse en archivos junto al componente o en carpetas específicas (`tests` o `__tests__`). Un test básico con `@vue/test-utils` y Vitest luce así:

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

## **4. Simular interacciones**

También es posible simular eventos del usuario, como clics o inputs, y verificar que el componente responde correctamente.

```javascript
it("incrementa el contador al hacer clic", async () => {
  const wrapper = mount(Home);

  expect(wrapper.find("#counter").text()).toContain("Counter: 1");

  await wrapper.find("#counter-btn").trigger("click");

  expect(wrapper.find("#counter").text()).toContain("Counter: 2");
});
```

---

## **5. Mock de Stores o Módulos**

Si el componente depende de un store de Pinia o de otros módulos externos, se pueden **mockear** esas dependencias para que el test sea controlado.

```javascript
vi.mock("../stores/user", () => ({
  useUserStore: () => ({
    user: "aaa",
    getUser: () => {},
  }),
}));
```

Esto asegura que el test no falla por causas externas, como la implementación real del store.

---

## **6. Ejecución de tests**

Para ejecutar todos los tests:

```sh
npm run test
```

Vitest mostrará un resumen de tests ejecutados, fallos y resultados.

---

## Resumen

| Herramienta     | Uso                                        |
| --------------- | ------------------------------------------ |
| Vitest          | Ejecutar y gestionar los tests             |
| @vue/test-utils | Montar componentes y simular interacciones |
| jsdom           | Simular el DOM en entorno de test          |
| vi.mock()       | Simular dependencias externas              |

---

[![Test unitarios en Vue.js con Vitest](https://img.youtube.com/vi/JtMYK2gKtMU/0.jpg)](https://www.youtube.com/watch?v=JtMYK2gKtMU&list=PLzA2VyZwsq_92Fnb4JEUnXUhSYfNHtcKx)

---
