# Tema 06 — Copilot Chat aplicado al desarrollo

## 1. Objetivos del tema

En este tema aprenderás a usar **GitHub Copilot Chat** como asistente de desarrollo dentro del editor.

Al finalizar este tema deberías ser capaz de:

- Abrir y utilizar Copilot Chat en el IDE.
- Preguntar sobre un archivo concreto.
- Preguntar sobre una selección de código.
- Pedir explicaciones técnicas adaptadas al nivel del usuario.
- Solicitar refactorizaciones.
- Pedir generación de tests.
- Pedir ayuda con errores.
- Usar Copilot Chat para documentar código.
- Diferenciar entre pedir código nuevo y pedir análisis de código existente.
- Revisar críticamente las respuestas de Copilot Chat.

---

## 2. Qué es Copilot Chat

**Copilot Chat** es una interfaz conversacional integrada en el entorno de desarrollo.

A diferencia de las sugerencias inline, que aparecen mientras escribes código, Copilot Chat permite mantener una conversación con Copilot.

Puedes preguntarle cosas como:

```text
What does this function do?
```

```text
Can you refactor this code to make it more readable?
```

```text
Generate unit tests for this file.
```

```text
Why am I getting this error?
```

```text
Document this class using JSDoc.
```

Copilot Chat es especialmente útil cuando necesitas explicación, análisis o cambios más amplios.

---

## 3. Diferencia entre Copilot Chat y sugerencias inline

| Función           | Sugerencias inline           | Copilot Chat                                 |
| ----------------- | ---------------------------- | -------------------------------------------- |
| Forma de uso      | Aparecen mientras escribes   | Se usa mediante conversación                 |
| Mejor para        | Completar código rápidamente | Analizar, explicar y transformar código      |
| Nivel de contexto | Código cercano al cursor     | Archivo, selección, proyecto y prompt        |
| Interacción       | Aceptar o rechazar           | Preguntar, responder, iterar                 |
| Ejemplo           | Completar una función        | Pedir tests, explicar errores o refactorizar |

En general:

- Usa **sugerencias inline** para escribir código más rápido.
- Usa **Copilot Chat** para entender, revisar, modificar o planificar código.

---

## 4. Abrir Copilot Chat en Visual Studio Code

En Visual Studio Code puedes abrir Copilot Chat de varias maneras.

### Opción 1: Desde la barra lateral

1. Abre Visual Studio Code.
2. Busca el icono de Copilot o Chat en la barra lateral.
3. Haz clic para abrir el panel de chat.

### Opción 2: Desde la paleta de comandos

1. Pulsa:

```text
Ctrl + Shift + P
```

En macOS:

```text
Cmd + Shift + P
```

2. Escribe:

```text
Copilot Chat
```

3. Selecciona la opción correspondiente.

### Opción 3: Desde el editor

En algunas versiones puedes hacer clic derecho sobre una selección de código y elegir una acción relacionada con Copilot.

Por ejemplo:

```text
Copilot > Explain
```

O:

```text
Copilot > Fix
```

La disponibilidad exacta puede variar según la versión del editor y de la extensión.

---

## 5. Abrir Copilot Chat en JetBrains

En los IDEs de JetBrains, Copilot Chat suele estar disponible después de instalar el plugin oficial de GitHub Copilot.

Pasos generales:

1. Abre el IDE.
2. Abre un proyecto.
3. Busca la ventana o herramienta de GitHub Copilot.
4. Inicia sesión si el IDE lo solicita.
5. Abre el chat.
6. Escribe una pregunta relacionada con el archivo o proyecto.

La ubicación exacta puede variar entre IntelliJ IDEA, WebStorm, PyCharm u otros IDEs.

---

## 6. Tipos de preguntas que puedes hacer a Copilot Chat

Copilot Chat puede ayudarte en diferentes tipos de tareas.

### 6.1. Preguntas de explicación

Sirven para entender código.

Ejemplos:

```text
Explain this function step by step.
```

```text
What is the purpose of this file?
```

```text
Explain this code as if I were new to JavaScript modules.
```

---

### 6.2. Preguntas de generación

Sirven para crear código nuevo.

Ejemplos:

```text
Create a function that validates a registration form.
```

```text
Generate a service class for managing products.
```

```text
Create a controller method that returns all users.
```

---

### 6.3. Preguntas de refactorización

Sirven para mejorar código existente.

Ejemplos:

```text
Refactor this function to reduce duplication.
```

```text
Make this code easier to read without changing its behavior.
```

```text
Split this function into smaller helper functions.
```

---

### 6.4. Preguntas de testing

Sirven para generar o mejorar pruebas.

Ejemplos:

```text
Generate unit tests for this function using Jest.
```

```text
Add tests for edge cases and invalid input.
```

```text
Review these tests and suggest missing cases.
```

---

### 6.5. Preguntas de debugging

Sirven para analizar errores.

Ejemplos:

```text
I get this error when running the project. Explain the likely cause and suggest a fix.
```

```text
Find possible bugs in this function.
```

```text
Why does this code return undefined?
```

---

### 6.6. Preguntas de documentación

Sirven para generar explicaciones o comentarios.

Ejemplos:

```text
Add JSDoc comments to this function.
```

```text
Create a README section explaining how to use this module.
```

```text
Document the parameters and return value of this method.
```

---

## 7. Trabajar con una selección de código

Una de las formas más útiles de usar Copilot Chat es seleccionar un fragmento de código antes de preguntar.

### Guía paso a paso

1. Abre un archivo de código.
2. Selecciona la función o bloque que quieres analizar.
3. Abre Copilot Chat.
4. Escribe una instrucción concreta.

Ejemplo:

```text
Explain the selected code step by step and identify possible edge cases.
```

Ventajas de seleccionar código:

- Copilot sabe exactamente a qué parte te refieres.
- La respuesta suele ser más precisa.
- Evitas que analice partes irrelevantes del archivo.
- Puedes trabajar poco a poco sobre fragmentos pequeños.

---

## 8. Preguntar sobre un archivo completo

También puedes pedir a Copilot que analice un archivo completo.

Ejemplos:

```text
Summarize the purpose of this file.
```

```text
Identify the main functions in this file and explain how they are related.
```

```text
Review this file and suggest improvements in readability and maintainability.
```

Esta opción es útil cuando:

- Abres código que no conoces.
- Revisas código heredado.
- Quieres documentar un archivo.
- Necesitas una visión general antes de modificar algo.

---

## 9. Preguntar sobre el proyecto

En algunos casos, Copilot Chat puede usar contexto del proyecto o workspace.

Puedes preguntar:

```text
Where is the user validation logic implemented in this project?
```

```text
Which files are related to authentication?
```

```text
Explain the general structure of this project.
```

Sin embargo, debes tener cuidado:

- Copilot puede no tener todo el contexto.
- Puede interpretar mal la estructura del proyecto.
- Puede pasar por alto archivos importantes.
- Sus respuestas deben comprobarse navegando por el código.

---

## 10. Copilot Chat para explicar código

Cuando uses Copilot Chat para explicar código, conviene indicar el nivel de detalle.

Prompt básico:

```text
Explain this code.
```

Prompt mejorado:

```text
Explain this code step by step. Assume I know basic JavaScript but I am new to asynchronous programming.
```

Prompt aún más específico:

```text
Explain this async function step by step. Focus on what await does, how errors are handled and what value the function returns.
```

---

## 11. Copilot Chat para refactorizar

Copilot Chat puede ayudarte a mejorar código, pero debes indicar claramente que no quieres cambiar el comportamiento.

Prompt recomendado:

```text
Refactor the selected code to improve readability. Do not change its behavior. Keep the same function names and return values. Explain the changes after showing the code.
```

Este prompt es mejor que:

```text
Improve this.
```

porque indica:

- Qué debe mejorar.
- Qué no debe cambiar.
- Qué debe conservar.
- Qué explicación se espera.

---

## 12. Ejemplo guiado de refactorización

Código inicial:

```javascript
function getUserStatus(user) {
  if (user) {
    if (user.active) {
      if (user.role === "admin") {
        return "Admin user active";
      } else {
        return "Regular user active";
      }
    } else {
      return "Inactive user";
    }
  } else {
    return "No user";
  }
}
```

Prompt para Copilot Chat:

```text
Refactor this function to reduce nested if statements. Do not change the returned messages. Explain why the refactored version is easier to read.
```

Posible resultado:

```javascript
function getUserStatus(user) {
  if (!user) {
    return "No user";
  }

  if (!user.active) {
    return "Inactive user";
  }

  if (user.role === "admin") {
    return "Admin user active";
  }

  return "Regular user active";
}
```

La versión refactorizada usa retornos tempranos para reducir la anidación.

---

## 13. Copilot Chat para generar tests

Copilot Chat puede generar tests a partir del código seleccionado.

Prompt recomendado:

```text
Generate Jest unit tests for the selected function. Include normal cases, edge cases and invalid input. Do not modify the source code.
```

Ejemplo para la función anterior:

```javascript
function getUserStatus(user) {
  if (!user) {
    return "No user";
  }

  if (!user.active) {
    return "Inactive user";
  }

  if (user.role === "admin") {
    return "Admin user active";
  }

  return "Regular user active";
}
```

Prompt:

```text
Generate Jest tests for this function. Include cases for null user, inactive user, active admin user and active regular user.
```

Posible resultado:

```javascript
describe("getUserStatus", () => {
  test("returns No user when user is null", () => {
    expect(getUserStatus(null)).toBe("No user");
  });

  test("returns Inactive user when user is not active", () => {
    expect(getUserStatus({ active: false, role: "admin" })).toBe(
      "Inactive user",
    );
  });

  test("returns Admin user active for active admin users", () => {
    expect(getUserStatus({ active: true, role: "admin" })).toBe(
      "Admin user active",
    );
  });

  test("returns Regular user active for active non-admin users", () => {
    expect(getUserStatus({ active: true, role: "user" })).toBe(
      "Regular user active",
    );
  });
});
```

> Los tests generados deben revisarse y ejecutarse. Copilot puede omitir casos importantes o asumir detalles que no son correctos.

---

## 14. Copilot Chat para detectar errores

Cuando tengas un error, Copilot Chat puede ayudarte mejor si proporcionas información completa.

Prompt débil:

```text
Fix this error.
```

Prompt recomendado:

```text
I am trying to run this function, but I get the following error: [paste error]. Explain the likely cause and suggest a minimal fix. Do not rewrite unrelated parts of the code.
```

La frase **“Do not rewrite unrelated parts of the code”** es útil para evitar que Copilot cambie más de la cuenta.

---

## 15. Copilot Chat para documentar código

Puedes pedir documentación de diferentes tipos.

### 15.1. Comentarios breves

```text
Add short comments to the selected code only where they improve readability. Do not comment obvious lines.
```

### 15.2. Documentación técnica

```text
Add JSDoc comments to this function. Include description, parameters, return value and possible errors.
```

### 15.3. Documentación para README

```text
Write a README section explaining how to use this module. Include installation, usage example and expected output.
```

---

## 16. Copilot Chat para revisar código

Copilot Chat también puede funcionar como una primera revisión de código.

Prompt recomendado:

```text
Review this code as if you were doing a code review. Focus on readability, maintainability, possible bugs and missing tests. Do not rewrite the code yet. First, list the issues you find.
```

Este prompt es útil porque pide primero análisis y no una modificación inmediata.

Después puedes pedir:

```text
Apply only the two most important improvements and keep the public API unchanged.
```

---

## 17. Copilot Chat para aprender conceptos

Copilot Chat puede usarse también como apoyo didáctico.

Ejemplos:

```text
Explain what a callback is using this code as an example.
```

```text
Explain the difference between map, filter and reduce with examples from this file.
```

```text
Explain this error message in beginner-friendly language.
```

```text
Create a short summary of what I should understand before modifying this file.
```

Este uso es especialmente útil cuando estás aprendiendo una tecnología nueva.

---

## 18. Flujo recomendado para trabajar con Copilot Chat

Cuando uses Copilot Chat en una tarea real, puedes seguir este flujo:

### Paso 1: Entender antes de cambiar

Antes de pedir cambios, pregunta qué hace el código.

```text
Explain what this file does and identify the main responsibilities of each function.
```

### Paso 2: Pedir análisis

```text
Review this code and identify possible improvements. Do not modify it yet.
```

### Paso 3: Elegir una mejora concreta

```text
Refactor only the validation logic to reduce duplication. Keep the rest unchanged.
```

### Paso 4: Pedir explicación del cambio

```text
Explain what changed and why.
```

### Paso 5: Pedir tests

```text
Generate tests for the changed behavior and include edge cases.
```

### Paso 6: Ejecutar y revisar

Ejecuta el proyecto o los tests.

No aceptes la solución hasta comprobarla.

---

## 19. Ejemplo completo de uso de Copilot Chat

Supongamos que tenemos este código:

```javascript
function validateUser(user) {
  if (!user.name) {
    return false;
  }
  if (!user.email) {
    return false;
  }
  if (!user.email.includes("@")) {
    return false;
  }
  if (!user.password) {
    return false;
  }
  if (user.password.length < 8) {
    return false;
  }
  return true;
}
```

### Paso 1: Pedir explicación

```text
Explain what this function does step by step.
```

### Paso 2: Pedir problemas

```text
Identify possible problems or limitations in this validation function.
```

Posibles problemas:

- No comprueba si `user` existe.
- No devuelve mensajes de error.
- La validación de email es muy básica.
- Todas las reglas están mezcladas en una única función.

### Paso 3: Pedir refactorización

```text
Refactor this function so it returns an object with isValid and errors. Keep the validation rules simple and do not use external libraries.
```

Posible resultado:

```javascript
function validateUser(user) {
  const errors = [];

  if (!user) {
    return {
      isValid: false,
      errors: ["User is required"],
    };
  }

  if (!user.name) {
    errors.push("Name is required");
  }

  if (!user.email) {
    errors.push("Email is required");
  } else if (!user.email.includes("@")) {
    errors.push("Email is invalid");
  }

  if (!user.password) {
    errors.push("Password is required");
  } else if (user.password.length < 8) {
    errors.push("Password must have at least 8 characters");
  }

  return {
    isValid: errors.length === 0,
    errors,
  };
}
```

### Paso 4: Pedir tests

```text
Generate Jest tests for this function. Include valid user, missing user, missing name, invalid email and short password.
```

### Paso 5: Revisar manualmente

Antes de aceptar la solución, comprueba:

- ¿La nueva función cambia el tipo de retorno?
- ¿Hay otras partes del proyecto que esperaban `true` o `false`?
- ¿Los mensajes de error son adecuados?
- ¿Los tests cubren los casos importantes?
- ¿La solución es demasiado compleja para el objetivo?

---

## 20. Buenas prácticas al usar Copilot Chat

- Selecciona el código relevante antes de preguntar.
- Escribe prompts concretos.
- Indica el lenguaje o framework.
- Pide primero análisis y después cambios.
- Pide cambios pequeños y revisables.
- No aceptes modificaciones grandes sin entenderlas.
- Ejecuta el código después de aplicar cambios.
- Genera o actualiza tests.
- No pegues secretos, claves o datos privados en el chat.
- Pide a Copilot que explique sus cambios.

---

## 21. Límites de Copilot Chat

Copilot Chat puede equivocarse.

Puede:

- Inventar funciones que no existen.
- Asumir dependencias no instaladas.
- No entender todo el proyecto.
- Proponer código que no compila.
- Omitir casos límite.
- Generar tests insuficientes.
- Sugerir soluciones inseguras.

Por eso es importante mantener una actitud crítica.

Copilot Chat debe ser un apoyo, no una autoridad final.

---

## 22. Checklist para usar Copilot Chat de forma profesional

Antes de aplicar una respuesta de Copilot Chat, revisa:

- ¿He dado suficiente contexto?
- ¿La respuesta se ajusta a mi proyecto?
- ¿El código generado compila?
- ¿Entiendo la solución?
- ¿Se han cambiado partes que no quería cambiar?
- ¿Hay casos límite sin cubrir?
- ¿Se han añadido dependencias innecesarias?
- ¿Hay posibles problemas de seguridad?
- ¿Los tests son adecuados?
- ¿El resultado mantiene el estilo del proyecto?

---

## 23. Resumen

En este tema has aprendido a utilizar Copilot Chat como asistente de desarrollo.

Has visto cómo usarlo para:

- Explicar código.
- Analizar archivos.
- Refactorizar funciones.
- Generar tests.
- Detectar errores.
- Documentar código.
- Revisar posibles mejoras.
- Aprender conceptos técnicos.

La idea principal es que Copilot Chat es más útil cuando se usa de forma conversacional e iterativa.

Un buen flujo sería:

1. Entender el código.
2. Pedir análisis.
3. Solicitar cambios concretos.
4. Pedir explicación.
5. Generar tests.
6. Ejecutar y revisar.

---

## 24. Documentación oficial recomendada

- GitHub Copilot Chat documentation: `https://docs.github.com/copilot/using-github-copilot/asking-github-copilot-questions-in-your-ide`
- Getting started with Copilot Chat in your IDE: `https://docs.github.com/copilot/how-tos/chat-with-copilot/get-started-with-chat-in-your-ide`
- Responsible use of Copilot Chat in your IDE: `https://docs.github.com/copilot/responsible-use/chat-in-your-ide`
- Writing tests with GitHub Copilot: `https://docs.github.com/copilot/tutorials/write-tests`
