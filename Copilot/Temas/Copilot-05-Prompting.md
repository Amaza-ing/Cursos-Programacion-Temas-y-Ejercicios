# Tema 05 — Prompting para programadores

## 1. Objetivos del tema

En este tema aprenderás a comunicarte con GitHub Copilot de forma eficaz para obtener mejores resultados al programar.

Al finalizar este tema deberías ser capaz de:

- Entender qué es un prompt técnico.
- Diferenciar entre un prompt pobre y un prompt útil.
- Escribir prompts con contexto, objetivo, restricciones y formato esperado.
- Pedir a Copilot que genere funciones.
- Pedir documentación de código.
- Pedir refactorizaciones.
- Pedir tests.
- Pedir detección de bugs.
- Iterar sobre una respuesta de Copilot.
- Revisar críticamente el código generado.

---

## 2. Qué es un prompt

Un **prompt** es la instrucción que damos a una herramienta de inteligencia artificial para que genere una respuesta.

En programación, un prompt puede servir para pedir:

- Una función.
- Una clase.
- Una explicación.
- Una refactorización.
- Un test.
- Una solución a un error.
- Una alternativa de implementación.
- Una documentación técnica.

Ejemplo de prompt sencillo:

```text
Create a function to validate an email.
```

Este prompt puede funcionar, pero es muy general.

Un prompt más útil sería:

```text
Create a JavaScript function called isValidEmail that receives a string and returns true if it has a valid email format. Do not use external libraries. Add simple comments explaining the main steps.
```

La segunda versión es mejor porque indica:

- El lenguaje.
- El nombre de la función.
- El parámetro de entrada.
- El resultado esperado.
- Una restricción.
- El nivel de explicación deseado.

---

## 3. Por qué el prompting es importante para programar

Copilot puede generar código a partir del contexto del editor, pero no siempre sabe exactamente qué quieres.

Un buen prompt ayuda a reducir:

- Código incompleto.
- Código que no sigue el estilo del proyecto.
- Soluciones demasiado complejas.
- Funciones que no devuelven lo esperado.
- Tests poco útiles.
- Explicaciones demasiado generales.

El objetivo no es escribir prompts largos siempre, sino escribir prompts **suficientemente claros**.

---

## 4. Estructura recomendada de un buen prompt técnico

Una estructura práctica es la siguiente:

```text
Contexto + Objetivo + Restricciones + Formato esperado + Criterios de calidad
```

No siempre necesitas incluir todos los elementos, pero es útil conocerlos.

---

### 4.1. Contexto

El contexto explica a Copilot dónde está trabajando y qué debe tener en cuenta.

Ejemplo:

```text
This file contains utility functions for a shopping cart in a JavaScript application.
```

Otro ejemplo:

```text
We are working on a Spring MVC application using controllers, services and repositories.
```

---

### 4.2. Objetivo

El objetivo indica qué quieres conseguir.

Ejemplo:

```text
Create a function that calculates the total price of all products in the cart.
```

---

### 4.3. Restricciones

Las restricciones indican límites o condiciones.

Ejemplo:

```text
Do not use external libraries.
```

```text
Keep the function pure and do not modify the original array.
```

```text
Use async/await instead of promises with .then().
```

---

### 4.4. Formato esperado

Indica cómo quieres recibir la respuesta.

Ejemplo:

```text
Return only the code.
```

```text
Explain the solution step by step before showing the final code.
```

```text
Give me the answer as a Markdown table.
```

---

### 4.5. Criterios de calidad

Indican cómo debe ser la solución.

Ejemplo:

```text
The code should be readable, simple and easy to test.
```

```text
Include edge cases for empty arrays, null values and invalid input.
```

---

## 5. Ejemplo completo de prompt técnico

Prompt poco preciso:

```text
Make a login function.
```

Prompt mejorado:

```text
Create a JavaScript function called loginUser. It should receive an email and a password, validate that both values are not empty, and return an object with success and message properties. Do not connect to a real database. Keep the function simple and easy to test.
```

Una posible respuesta sería:

```javascript
function loginUser(email, password) {
  if (!email || !password) {
    return {
      success: false,
      message: "Email and password are required",
    };
  }

  return {
    success: true,
    message: "Login data is valid",
  };
}
```

---

## 6. Prompting para generar funciones

Cuando pidas una función, intenta indicar:

- Nombre de la función.
- Lenguaje.
- Parámetros.
- Qué debe devolver.
- Casos especiales.
- Restricciones.

Plantilla útil:

```text
Create a [language] function called [functionName] that receives [parameters] and returns [expected result]. It should handle [edge cases]. Do not use [restriction].
```

Ejemplo:

```text
Create a JavaScript function called calculateDiscountedPrice that receives a price and a discount percentage. It should return the final price after applying the discount. If the price is negative or the discount is outside the 0-100 range, return null. Do not use external libraries.
```

Posible resultado:

```javascript
function calculateDiscountedPrice(price, discountPercentage) {
  if (price < 0 || discountPercentage < 0 || discountPercentage > 100) {
    return null;
  }

  const discount = price * (discountPercentage / 100);
  return price - discount;
}
```

---

## 7. Prompting para documentar código

Copilot puede ayudar a documentar funciones, clases o archivos completos.

Es importante pedir el tipo de documentación que necesitas.

No es lo mismo pedir:

```text
Document this code.
```

que pedir:

```text
Add JSDoc comments to this function. Explain the parameters, the return value and the possible edge cases. Keep the comments concise.
```

---

### 7.1. Ejemplo de documentación con JSDoc

Código inicial:

```javascript
function calculateAverage(numbers) {
  if (!Array.isArray(numbers) || numbers.length === 0) {
    return 0;
  }

  const total = numbers.reduce((sum, number) => sum + number, 0);
  return total / numbers.length;
}
```

Prompt:

```text
Add JSDoc documentation to this function. Include parameter type, return type and a short description. Do not modify the function logic.
```

Resultado esperado:

```javascript
/**
 * Calculates the average value of an array of numbers.
 *
 * @param {number[]} numbers - The list of numbers to average.
 * @returns {number} The average value, or 0 if the input is not a valid non-empty array.
 */
function calculateAverage(numbers) {
  if (!Array.isArray(numbers) || numbers.length === 0) {
    return 0;
  }

  const total = numbers.reduce((sum, number) => sum + number, 0);
  return total / numbers.length;
}
```

---

## 8. Prompting para refactorizar código

Refactorizar significa mejorar la estructura interna del código sin cambiar su comportamiento externo.

Puedes pedir a Copilot que mejore:

- Legibilidad.
- Repetición de código.
- Nombres de variables.
- Separación de responsabilidades.
- Complejidad de funciones.
- Organización de archivos.

Prompt demasiado general:

```text
Improve this code.
```

Prompt más útil:

```text
Refactor this function to make it easier to read. Do not change its behavior. Keep the same input and output. Explain the changes after the code.
```

---

### 8.1. Ejemplo de refactorización

Código inicial:

```javascript
function getFinalPrice(price, userType) {
  let discount = 0;
  if (userType === "student") {
    discount = 0.15;
  } else if (userType === "premium") {
    discount = 0.2;
  } else if (userType === "regular") {
    discount = 0.05;
  } else {
    discount = 0;
  }
  return price - price * discount;
}
```

Prompt:

```text
Refactor this function to make the discount rules easier to maintain. Do not change the behavior. Keep the same function name and parameters.
```

Posible resultado:

```javascript
function getFinalPrice(price, userType) {
  const discounts = {
    student: 0.15,
    premium: 0.2,
    regular: 0.05,
  };

  const discount = discounts[userType] || 0;
  return price - price * discount;
}
```

---

## 9. Prompting para escribir tests

Una de las tareas más útiles de Copilot es ayudar a crear tests.

Para obtener buenos tests, conviene indicar:

- Framework de testing.
- Función o clase a probar.
- Casos normales.
- Casos límite.
- Casos de error.
- Formato esperado.

Plantilla:

```text
Generate unit tests for [function/class] using [testing framework]. Include normal cases, edge cases and invalid input cases. Do not modify the source code.
```

Ejemplo:

```text
Generate Jest unit tests for the calculateDiscountedPrice function. Include valid discounts, zero discount, 100% discount, negative price and discount values outside the 0-100 range.
```

Posible resultado:

```javascript
const { calculateDiscountedPrice } = require("../src/prices");

describe("calculateDiscountedPrice", () => {
  test("applies a valid discount", () => {
    expect(calculateDiscountedPrice(100, 20)).toBe(80);
  });

  test("returns the original price when discount is 0", () => {
    expect(calculateDiscountedPrice(100, 0)).toBe(100);
  });

  test("returns 0 when discount is 100", () => {
    expect(calculateDiscountedPrice(100, 100)).toBe(0);
  });

  test("returns null for a negative price", () => {
    expect(calculateDiscountedPrice(-100, 20)).toBeNull();
  });

  test("returns null for a discount greater than 100", () => {
    expect(calculateDiscountedPrice(100, 120)).toBeNull();
  });
});
```

> Los tests generados por Copilot deben revisarse. Que un test exista no significa que sea suficiente ni que esté bien diseñado.

---

## 10. Prompting para detectar bugs

Copilot puede ayudar a encontrar errores, pero no debe sustituir al análisis humano.

Prompt útil:

```text
Review this function and identify possible bugs or edge cases. Explain each problem and suggest a minimal fix.
```

Ejemplo de código problemático:

```javascript
function divide(a, b) {
  return a / b;
}
```

Prompt:

```text
Review this function and identify possible bugs or edge cases. Suggest a safer version.
```

Posible respuesta:

```javascript
function divide(a, b) {
  if (b === 0) {
    throw new Error("Cannot divide by zero");
  }

  return a / b;
}
```

Explicación esperada:

```text
The original function does not handle division by zero. In JavaScript, dividing by zero returns Infinity, which may cause unexpected behavior. The revised version throws an explicit error.
```

---

## 11. Prompting para explicar código

Copilot también puede funcionar como apoyo para entender código ajeno o heredado.

Prompts útiles:

```text
Explain this function step by step in simple language.
```

```text
Explain the purpose of this file and how its main functions are connected.
```

```text
Summarize this code for a junior developer.
```

```text
Explain this code as if I already know JavaScript but I am new to React.
```

La última versión es mejor porque indica el nivel del destinatario.

---

## 12. Prompting para generar alternativas

A veces no queremos una única respuesta, sino comparar enfoques.

Ejemplo:

```text
Give me two different ways to implement this validation: one simple and one more scalable. Explain the pros and cons of each option.
```

Esto puede ser útil cuando tienes que decidir entre:

- Código simple o código extensible.
- Función aislada o clase.
- Validación manual o librería externa.
- Solución rápida o solución mantenible.

---

## 13. Prompting iterativo

Trabajar con Copilot no consiste en escribir un único prompt y aceptar la primera respuesta.

Lo habitual es iterar.

Ejemplo de secuencia:

```text
Create a JavaScript function to validate a password.
```

Después:

```text
Modify it so the password must have at least 8 characters, one uppercase letter, one lowercase letter and one number.
```

Después:

```text
Return an object with isValid and errors instead of only true or false.
```

Después:

```text
Add unit tests using Jest.
```

Después:

```text
Refactor the code to make each validation rule easier to maintain.
```

Esta forma de trabajar se parece a colaborar con un compañero de programación.

---

## 14. Prompts con restricciones de estilo

Puedes pedir a Copilot que siga un estilo concreto.

Ejemplos:

```text
Use clear variable names and avoid nested if statements.
```

```text
Use early returns to reduce indentation.
```

```text
Use modern JavaScript syntax, but avoid advanced patterns that would make the code harder for beginners.
```

```text
Follow the existing style of this file.
```

Este tipo de instrucciones ayuda a mantener la coherencia del proyecto.

---

## 15. Prompts para trabajar con errores

Cuando tengas un error, evita escribir solo:

```text
Fix this error.
```

Es mejor incluir:

- Qué estabas intentando hacer.
- El mensaje de error.
- El fragmento relevante de código.
- Qué comportamiento esperabas.
- Qué comportamiento obtuviste.

Plantilla:

```text
I am trying to [goal]. I get this error: [error message]. This is the relevant code: [code]. I expected [expected behavior], but I got [actual behavior]. Explain the likely cause and suggest a fix.
```

Ejemplo:

```text
I am trying to run a Jest test for my calculateAverage function. I get this error: TypeError: calculateAverage is not a function. The function is defined in src/calculator.js and the test imports it from ../src/calculator. Explain the likely cause and suggest a fix.
```

---

## 16. Qué hacer cuando Copilot responde mal

Si Copilot da una respuesta incorrecta, incompleta o demasiado general, no aceptes la respuesta sin más.

Puedes mejorar la conversación con nuevos prompts.

### 16.1. Pedir más precisión

```text
Be more specific and show the exact code changes.
```

### 16.2. Pedir una solución más simple

```text
Simplify the solution. Avoid unnecessary abstractions.
```

### 16.3. Pedir explicación

```text
Explain why this solution works.
```

### 16.4. Pedir revisión de problemas

```text
Review your previous answer and identify any possible issue or missing edge case.
```

### 16.5. Pedir que no cambie partes del código

```text
Keep the public function names unchanged because other files depend on them.
```

---

## 17. Errores frecuentes al escribir prompts

### Error 1: Ser demasiado ambiguo

```text
Make this better.
```

Problema: no queda claro qué significa “mejor”.

Versión mejorada:

```text
Refactor this code to reduce duplication and improve readability. Do not change the behavior.
```

---

### Error 2: No indicar el lenguaje o framework

```text
Create a test for this function.
```

Versión mejorada:

```text
Create Jest unit tests for this JavaScript function.
```

---

### Error 3: No indicar restricciones

```text
Validate this email.
```

Versión mejorada:

```text
Create a simple email validation function without external libraries. It should return true or false.
```

---

### Error 4: Aceptar la primera respuesta sin revisar

Copilot puede generar código que parece correcto, pero que:

- No compila.
- No contempla casos límite.
- No sigue el estilo del proyecto.
- Tiene problemas de seguridad.
- Usa dependencias que no existen.
- Resuelve un problema distinto al planteado.

---

## 18. Checklist para revisar código generado por Copilot

Antes de aceptar código generado, revisa:

- ¿Entiendo lo que hace?
- ¿Compila o se ejecuta?
- ¿Cumple exactamente lo que he pedido?
- ¿Respeta el estilo del proyecto?
- ¿Tiene nombres claros?
- ¿Gestiona errores previsibles?
- ¿Cubre casos límite?
- ¿Introduce dependencias innecesarias?
- ¿Puede tener problemas de seguridad?
- ¿Necesita tests?

---

## 19. Guía paso a paso: flujo recomendado de prompting

Cuando uses Copilot para una tarea de programación, puedes seguir este flujo:

### Paso 1: Define el objetivo

Antes de preguntar, aclara qué quieres conseguir.

Ejemplo:

```text
Quiero validar los datos de un formulario de registro.
```

---

### Paso 2: Da contexto

Indica el lenguaje, framework o archivo.

Ejemplo:

```text
This is a JavaScript project using plain functions, without frameworks.
```

---

### Paso 3: Especifica restricciones

Ejemplo:

```text
Do not use external libraries.
```

---

### Paso 4: Pide el resultado

Ejemplo:

```text
Create a function called validateRegisterForm.
```

---

### Paso 5: Pide casos límite

Ejemplo:

```text
Handle empty values, invalid email and password shorter than 8 characters.
```

---

### Paso 6: Revisa la respuesta

No aceptes el código automáticamente.

Comprueba:

- Lógica.
- Nombres.
- Errores.
- Seguridad.
- Casos límite.

---

### Paso 7: Itera

Si falta algo, pídeselo.

Ejemplo:

```text
Modify the function so it returns an array of error messages instead of only true or false.
```

---

### Paso 8: Pide tests

Ejemplo:

```text
Generate Jest tests for this function, including valid data, empty fields and invalid email.
```

---

## 20. Resumen

En este tema has aprendido a escribir mejores prompts para programar con GitHub Copilot.

Has visto:

- Qué es un prompt técnico.
- Por qué el contexto es importante.
- Cómo estructurar un buen prompt.
- Cómo pedir funciones.
- Cómo pedir documentación.
- Cómo pedir refactorizaciones.
- Cómo pedir tests.
- Cómo pedir detección de bugs.
- Cómo iterar sobre respuestas.
- Cómo revisar críticamente el resultado.

La idea principal es que Copilot funciona mejor cuando recibe instrucciones claras, contexto suficiente y criterios concretos.

Un buen uso de Copilot no consiste en aceptar todo lo que propone, sino en usarlo como apoyo para pensar, escribir, revisar y mejorar código.

---

## 21. Documentación oficial recomendada

- GitHub Copilot documentation: `https://docs.github.com/copilot`
- Prompt engineering for GitHub Copilot Chat: `https://docs.github.com/copilot/concepts/prompt-engineering-for-copilot-chat`
- Best practices for using GitHub Copilot: `https://docs.github.com/copilot/get-started/best-practices`
- Writing tests with GitHub Copilot: `https://docs.github.com/copilot/tutorials/write-tests`
