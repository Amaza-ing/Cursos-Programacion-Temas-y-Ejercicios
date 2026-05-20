# Tema 07 — Refactorización, documentación, testing y debugging con GitHub Copilot

## 1. Introducción

En los temas anteriores hemos visto cómo configurar GitHub Copilot, cómo escribir mejores prompts y cómo utilizar Copilot Chat para conversar sobre el código.  
En este tema vamos a utilizar Copilot en tareas habituales del trabajo diario de desarrollo:

- refactorizar código;
- documentar funciones, clases y archivos;
- generar tests;
- analizar errores;
- detectar posibles bugs;
- revisar código antes de integrarlo en un proyecto.

GitHub Copilot puede acelerar mucho estas tareas, pero no debe utilizarse como sustituto del criterio técnico. La persona desarrolladora sigue siendo responsable de entender, revisar, probar y mantener el código.

> **Idea clave:** Copilot ayuda a proponer soluciones, pero no garantiza que esas soluciones sean correctas, seguras, eficientes o coherentes con el proyecto.

---

## 2. Objetivos del tema

Al finalizar este tema deberías ser capaz de:

- Usar Copilot para mejorar la legibilidad de un fragmento de código.
- Pedir refactorizaciones concretas sin cambiar el comportamiento del programa.
- Generar documentación útil y no excesiva.
- Crear tests unitarios a partir de una función existente.
- Pedir a Copilot que explique un error o una traza.
- Usar Copilot como apoyo en tareas de debugging.
- Revisar críticamente las respuestas generadas por Copilot.
- Aplicar una checklist básica de revisión de código generado con IA.

---

## 3. Antes de empezar

Para seguir este tema conviene tener:

- GitHub Copilot activado.
- VS Code o un IDE compatible con Copilot.
- Un proyecto pequeño de JavaScript, TypeScript, Python, Java u otro lenguaje.
- Conocimientos básicos de funciones, condiciones, arrays/listas y tests.

En los ejemplos de este tema usaremos principalmente JavaScript porque permite ver los conceptos de forma sencilla.  
La misma lógica se puede aplicar a otros lenguajes.

---

# Parte 1. Refactorización con GitHub Copilot

## 4. Qué significa refactorizar

Refactorizar significa **mejorar la estructura interna del código sin cambiar su comportamiento externo**.

No consiste en añadir funcionalidades nuevas.  
No consiste en cambiar lo que el programa hace.  
Consiste en hacer que el código sea más claro, mantenible, reutilizable o fácil de probar.

Ejemplos de refactorización:

- Cambiar nombres de variables poco claros.
- Extraer lógica repetida a una función.
- Dividir una función demasiado larga.
- Reducir condiciones anidadas.
- Separar responsabilidades.
- Eliminar duplicaciones.
- Mejorar la organización de archivos.

---

## 5. Cuándo pedir una refactorización a Copilot

Puedes pedir ayuda a Copilot cuando encuentres código como este:

```js
function p(a, b, c) {
  let x = 0;

  for (let i = 0; i < a.length; i++) {
    if (a[i].active === true) {
      if (a[i].type === b) {
        x = x + a[i].price;
      }
    }
  }

  if (c === true) {
    x = x - x * 0.1;
  }

  return x;
}
```

Este código funciona, pero tiene varios problemas:

- Los nombres de variables no explican qué representan.
- Hay condiciones anidadas.
- No queda claro qué significa `c`.
- La operación del descuento está mezclada con el cálculo del total.
- La función hace varias cosas a la vez.

---

## 6. Cómo pedir una refactorización correctamente

Un prompt demasiado general sería:

```text
Refactoriza este código.
```

Este prompt puede funcionar, pero es poco preciso. Copilot no sabe qué tipo de refactorización quieres ni qué debe conservar.

Un prompt mejor sería:

```text
Refactoriza esta función para mejorar la legibilidad, pero sin cambiar su comportamiento.
Usa nombres de variables más descriptivos, reduce las condiciones anidadas y separa el cálculo del descuento en una función auxiliar.
No cambies la firma de la función original.
```

Observa que el segundo prompt indica:

- qué se quiere mejorar;
- qué no se debe cambiar;
- qué tipo de resultado se espera;
- qué restricción debe respetar.

---

## 7. Guía paso a paso: refactorizar una función con Copilot

### Paso 1. Seleccionar el código

Selecciona en el editor la función que quieres mejorar.

### Paso 2. Abrir Copilot Chat

Abre Copilot Chat en el IDE.

En VS Code, normalmente puedes abrirlo desde:

- el icono de Copilot;
- el panel lateral;
- el menú contextual;
- un atajo de teclado, según tu configuración.

### Paso 3. Escribir un prompt específico

Ejemplo:

```text
Refactoriza el código seleccionado para mejorar su legibilidad.
Mantén exactamente el mismo comportamiento.
No añadas nuevas dependencias.
Explica brevemente qué cambios has hecho.
```

### Paso 4. Leer la propuesta

No aceptes automáticamente el resultado. Comprueba:

- si la lógica se mantiene;
- si los nombres son claros;
- si no se ha eliminado ninguna validación importante;
- si no se ha añadido código innecesario;
- si el estilo encaja con el resto del proyecto.

### Paso 5. Aplicar los cambios de forma controlada

Si el IDE permite aplicar la sugerencia automáticamente, revisa el diff antes de aceptar.

### Paso 6. Ejecutar el proyecto o los tests

Después de refactorizar, ejecuta los tests o prueba manualmente la funcionalidad.

---

## 8. Ejemplo de refactorización

Código inicial:

```js
function p(a, b, c) {
  let x = 0;

  for (let i = 0; i < a.length; i++) {
    if (a[i].active === true) {
      if (a[i].type === b) {
        x = x + a[i].price;
      }
    }
  }

  if (c === true) {
    x = x - x * 0.1;
  }

  return x;
}
```

Prompt recomendado:

```text
Refactoriza esta función de JavaScript para que sea más legible.
Mantén el mismo comportamiento.
Usa nombres de variables claros.
Extrae la lógica del descuento a una función auxiliar.
No añadas librerías externas.
```

Una posible respuesta sería:

```js
function calculateTotalByType(products, selectedType, applyDiscount) {
  let total = 0;

  for (const product of products) {
    const isValidProduct =
      product.active === true && product.type === selectedType;

    if (isValidProduct) {
      total += product.price;
    }
  }

  return applyDiscount ? applyTenPercentDiscount(total) : total;
}

function applyTenPercentDiscount(total) {
  return total - total * 0.1;
}
```

El código es más claro porque:

- `products` es más descriptivo que `a`;
- `selectedType` es más descriptivo que `b`;
- `applyDiscount` es más descriptivo que `c`;
- se ha reducido la anidación;
- el descuento está separado en otra función.

---

## 9. Precaución importante al refactorizar

Copilot puede cambiar el comportamiento del código sin que sea evidente.

Por ejemplo, podría transformar esto:

```js
if (product.active === true)
```

en esto:

```js
if (product.active)
```

En muchos casos será equivalente, pero no siempre.  
Si `active` pudiera tener valores como `"yes"`, `1`, `null` o `undefined`, el comportamiento podría cambiar.

Por eso, después de una refactorización, siempre hay que comprobar:

- entradas normales;
- entradas límite;
- valores nulos;
- valores inesperados;
- casos de error.

---

# Parte 2. Documentación con GitHub Copilot

## 10. Qué documentación puede generar Copilot

Copilot puede ayudar a crear:

- comentarios breves;
- documentación de funciones;
- documentación de clases;
- documentación de componentes;
- archivos `README.md`;
- ejemplos de uso;
- tablas de parámetros;
- instrucciones de instalación;
- documentación de APIs;
- guías de contribución.

Sin embargo, documentar no significa llenar el código de comentarios.  
Una buena documentación debe aclarar lo que no es evidente.

---

## 11. Comentarios útiles frente a comentarios innecesarios

Comentario innecesario:

```js
// Suma 1 a counter
counter++;
```

Este comentario no aporta nada porque el código ya lo dice.

Comentario útil:

```js
// Se aplica un descuento fijo porque la promoción se calcula antes de impuestos.
const finalPrice = applyDiscount(basePrice);
```

Este comentario explica una decisión de negocio que no se deduce solo del código.

---

## 12. Guía paso a paso: documentar una función

Partimos de esta función:

```js
function calculateFinalPrice(price, discountPercentage, taxPercentage) {
  const discountedPrice = price - price * (discountPercentage / 100);
  return discountedPrice + discountedPrice * (taxPercentage / 100);
}
```

### Paso 1. Seleccionar la función

Selecciona la función completa.

### Paso 2. Pedir documentación concreta

Prompt:

```text
Documenta esta función usando JSDoc.
Incluye descripción, parámetros, valor de retorno y un ejemplo breve de uso.
No cambies el código de la función.
```

### Paso 3. Revisar la documentación generada

Una posible salida sería:

```js
/**
 * Calculates the final price after applying a discount and then adding tax.
 *
 * @param {number} price - Original price before discount and tax.
 * @param {number} discountPercentage - Discount percentage to apply.
 * @param {number} taxPercentage - Tax percentage to apply after the discount.
 * @returns {number} Final price after discount and tax.
 *
 * @example
 * calculateFinalPrice(100, 10, 21); // 108.9
 */
function calculateFinalPrice(price, discountPercentage, taxPercentage) {
  const discountedPrice = price - price * (discountPercentage / 100);
  return discountedPrice + discountedPrice * (taxPercentage / 100);
}
```

### Paso 4. Comprobar que el ejemplo es correcto

No des por hecho que el ejemplo generado por Copilot es correcto.  
Comprueba manualmente:

- Precio inicial: 100.
- Descuento del 10%: 100 - 10 = 90.
- Impuesto del 21% sobre 90: 18.9.
- Precio final: 108.9.

El ejemplo es correcto.

---

## 13. Prompts útiles para documentación

```text
Explica esta función con un lenguaje claro para una persona que está aprendiendo.
```

```text
Genera documentación JSDoc para este archivo.
No cambies el código.
Evita comentarios obvios.
```

```text
Crea una sección de README que explique cómo instalar y ejecutar este proyecto.
Incluye comandos para instalar dependencias, ejecutar en desarrollo y lanzar los tests.
```

```text
Documenta este endpoint indicando método HTTP, ruta, parámetros, cuerpo esperado, respuestas posibles y ejemplo de petición.
```

```text
Resume este archivo en 5 puntos para incluirlo en la documentación técnica del proyecto.
```

---

# Parte 3. Testing con GitHub Copilot

## 14. Qué puede hacer Copilot con los tests

Copilot puede ayudar a:

- generar tests unitarios;
- sugerir casos límite;
- crear mocks;
- detectar casos no cubiertos;
- actualizar tests después de un cambio;
- explicar por qué falla un test;
- proponer nombres de tests más claros;
- mejorar la estructura de un archivo de pruebas.

Pero Copilot no sabe automáticamente todos los requisitos del negocio.  
Por eso, los tests generados deben revisarse cuidadosamente.

---

## 15. Qué es un buen test

Un buen test debería:

- comprobar un comportamiento concreto;
- tener un nombre claro;
- ser fácil de leer;
- no depender de otros tests;
- incluir casos normales y casos límite;
- fallar si el comportamiento esperado se rompe.

Ejemplo de función:

```js
function isAdult(age) {
  return age >= 18;
}

module.exports = { isAdult };
```

Test básico con Jest:

```js
const { isAdult } = require("./isAdult");

test("returns true when age is 18 or greater", () => {
  expect(isAdult(18)).toBe(true);
  expect(isAdult(25)).toBe(true);
});

test("returns false when age is lower than 18", () => {
  expect(isAdult(17)).toBe(false);
});
```

---

## 16. Guía paso a paso: pedir tests unitarios a Copilot

### Paso 1. Seleccionar la función

Selecciona la función que quieres probar.

### Paso 2. Indicar el framework de testing

Copilot necesita saber si usas Jest, Vitest, JUnit, Pytest, NUnit, etc.

Prompt:

```text
Genera tests unitarios para esta función usando Jest.
Incluye casos normales, casos límite y casos de error.
No cambies la función original.
```

### Paso 3. Revisar los casos propuestos

Comprueba si los tests cubren:

- valores esperados;
- valores mínimos;
- valores máximos;
- valores nulos;
- valores vacíos;
- errores;
- comportamiento no permitido.

### Paso 4. Ejecutar los tests

Si trabajas con Node.js y Jest, normalmente puedes ejecutar:

```bash
npm test
```

o:

```bash
npx jest
```

### Paso 5. Corregir los tests si es necesario

Si Copilot ha generado tests incorrectos, puedes pedirle:

```text
Estos tests fallan porque la función no lanza errores con valores nulos.
Corrige los tests para que reflejen el comportamiento real de la función.
```

---

## 17. Ejemplo completo de testing

Función:

```js
function calculateDiscountedPrice(price, discountPercentage) {
  if (price < 0) {
    throw new Error("Price cannot be negative");
  }

  if (discountPercentage < 0 || discountPercentage > 100) {
    throw new Error("Discount percentage must be between 0 and 100");
  }

  return price - price * (discountPercentage / 100);
}

module.exports = { calculateDiscountedPrice };
```

Prompt:

```text
Genera tests unitarios para esta función usando Jest.
Incluye:
- un caso sin descuento;
- un caso con descuento;
- un caso con descuento del 100%;
- un caso con precio negativo;
- un caso con descuento menor que 0;
- un caso con descuento mayor que 100.
```

Posible salida:

```js
const { calculateDiscountedPrice } = require("./calculateDiscountedPrice");

describe("calculateDiscountedPrice", () => {
  test("returns the same price when discount is 0", () => {
    expect(calculateDiscountedPrice(100, 0)).toBe(100);
  });

  test("applies the discount correctly", () => {
    expect(calculateDiscountedPrice(100, 20)).toBe(80);
  });

  test("returns 0 when discount is 100", () => {
    expect(calculateDiscountedPrice(100, 100)).toBe(0);
  });

  test("throws an error when price is negative", () => {
    expect(() => calculateDiscountedPrice(-10, 20)).toThrow(
      "Price cannot be negative",
    );
  });

  test("throws an error when discount is lower than 0", () => {
    expect(() => calculateDiscountedPrice(100, -1)).toThrow(
      "Discount percentage must be between 0 and 100",
    );
  });

  test("throws an error when discount is greater than 100", () => {
    expect(() => calculateDiscountedPrice(100, 101)).toThrow(
      "Discount percentage must be between 0 and 100",
    );
  });
});
```

---

## 18. Cómo pedir mejores tests

Un prompt débil sería:

```text
Haz tests.
```

Un prompt mejor sería:

```text
Genera tests unitarios con Jest para esta función.
Quiero que cubras casos normales, casos límite y errores.
Usa nombres de test descriptivos.
No modifiques la función original.
Después, indícame qué casos quedan sin cubrir.
```

También puedes pedir:

```text
Analiza estos tests y dime si falta algún caso importante.
No escribas código todavía. Primero explícame qué cobertura lógica tienen.
```

Este enfoque es útil porque obliga a Copilot a razonar antes de generar más código.

---

# Parte 4. Debugging con GitHub Copilot

## 19. Qué es debugging asistido por IA

Debugging significa encontrar y corregir errores en un programa.

Copilot puede ayudar a:

- explicar una traza de error;
- localizar una posible causa;
- proponer hipótesis;
- sugerir logs;
- revisar condiciones;
- detectar valores inesperados;
- proponer cambios;
- explicar por qué falla un test.

Pero Copilot no ejecuta mentalmente el programa con la misma fiabilidad que un depurador real.  
La depuración debe combinar IA, lectura del código, logs, tests y ejecución real.

---

## 20. Guía paso a paso: analizar un error con Copilot

### Paso 1. Copiar el error completo

No pegues solo la última línea.  
Incluye:

- mensaje de error;
- stack trace;
- archivo;
- línea;
- comando ejecutado;
- contexto mínimo del código.

### Paso 2. Pedir explicación antes de pedir solución

Prompt recomendado:

```text
Explícame este error paso a paso.
No propongas todavía una solución.
Primero dime cuál parece ser la causa más probable y qué información adicional habría que comprobar.
```

### Paso 3. Pedir hipótesis

```text
Dame tres posibles causas de este error, ordenadas de más probable a menos probable.
Indica cómo comprobaría cada una.
```

### Paso 4. Pedir una corrección mínima

```text
Propón la corrección mínima para resolver este error.
No refactorices el resto del archivo.
Explica por qué el cambio debería funcionar.
```

### Paso 5. Probar la solución

Ejecuta de nuevo el comando que fallaba.

### Paso 6. Confirmar que no has introducido otro error

Ejecuta los tests o prueba manualmente la funcionalidad afectada.

---

## 21. Ejemplo de error

Código:

```js
function getUserName(user) {
  return user.profile.name.toUpperCase();
}

console.log(getUserName({ profile: null }));
```

Error:

```text
TypeError: Cannot read properties of null (reading 'name')
```

Prompt:

```text
Explícame por qué aparece este error en el código seleccionado.
Después propón una corrección mínima y otra corrección más robusta.
```

Posible explicación:

- `user.profile` es `null`.
- El código intenta acceder a `user.profile.name`.
- No se puede leer la propiedad `name` de `null`.

Corrección mínima:

```js
function getUserName(user) {
  if (user.profile === null) {
    return "";
  }

  return user.profile.name.toUpperCase();
}
```

Corrección más robusta:

```js
function getUserName(user) {
  return user?.profile?.name?.toUpperCase() ?? "";
}
```

La segunda versión también cubre casos como:

- `user` es `undefined`;
- `profile` no existe;
- `name` no existe;
- `name` es `null`.

---

# Parte 5. Detección de bugs y revisión de código

## 22. Copilot como revisor de código

Copilot puede actuar como un primer revisor, pero no sustituye una code review humana.

Puede ayudar a detectar:

- condiciones incorrectas;
- validaciones ausentes;
- duplicaciones;
- código muerto;
- posibles errores de tipos;
- problemas de seguridad;
- casos límite no contemplados;
- tests insuficientes.

---

## 23. Prompt para revisión de código

```text
Revisa el código seleccionado como si fueras un revisor técnico.
Busca:
- posibles bugs;
- casos límite no contemplados;
- problemas de legibilidad;
- duplicación;
- riesgos de seguridad;
- tests que deberían añadirse.

No reescribas el código todavía.
Primero dame una lista priorizada de problemas.
```

Este prompt es útil porque pide primero análisis, no solución.  
Después puedes pedir:

```text
Ahora aplica solo las correcciones de prioridad alta.
No cambies el estilo general del archivo.
Explica cada cambio realizado.
```

---

## 24. Checklist para revisar código generado por Copilot

Antes de aceptar código generado por Copilot, comprueba:

- ¿Entiendo todo el código generado?
- ¿El código resuelve realmente el problema?
- ¿Se ha cambiado alguna parte que no debía cambiarse?
- ¿Hay nombres claros?
- ¿Hay validaciones suficientes?
- ¿Hay casos límite sin cubrir?
- ¿Se han añadido dependencias innecesarias?
- ¿Se ha introducido información sensible?
- ¿El código sigue el estilo del proyecto?
- ¿Hay tests?
- ¿Los tests pasan?
- ¿La documentación coincide con el comportamiento real?

---

## 25. Flujo recomendado de trabajo

Un buen flujo de trabajo con Copilot sería:

1. **Entender el código actual.**
2. **Pedir a Copilot una explicación.**
3. **Pedir una propuesta de mejora.**
4. **Revisar la propuesta.**
5. **Aplicar los cambios de forma controlada.**
6. **Ejecutar tests.**
7. **Pedir a Copilot que revise posibles casos límite.**
8. **Documentar los cambios importantes.**
9. **Hacer una revisión humana final.**

---

## 26. Errores habituales al usar Copilot en estas tareas

### Error 1. Aceptar código sin leerlo

Copilot puede generar código que parece correcto pero que contiene errores sutiles.

### Error 2. Pedir cambios demasiado amplios

Prompt problemático:

```text
Mejora todo este proyecto.
```

Es mejor dividir la tarea:

```text
Analiza este archivo y dime tres mejoras de legibilidad.
No modifiques todavía el código.
```

### Error 3. Mezclar refactorización con nuevas funcionalidades

Si pides refactorizar y añadir comportamiento nuevo a la vez, será más difícil detectar errores.

### Error 4. No ejecutar tests

Una refactorización sin tests es arriesgada.

### Error 5. Pedir tests sin explicar la lógica de negocio

Copilot puede generar tests técnicamente correctos pero incompletos desde el punto de vista funcional.

---

## 27. Prompts recopilatorios del tema

### Para refactorizar

```text
Refactoriza el código seleccionado para mejorar la legibilidad.
Mantén el mismo comportamiento.
No añadas dependencias.
Explica qué cambios has hecho.
```

### Para documentar

```text
Documenta esta función usando el formato habitual del lenguaje.
Incluye parámetros, retorno y un ejemplo breve.
Evita comentarios obvios.
```

### Para generar tests

```text
Genera tests unitarios para este código usando [framework].
Incluye casos normales, casos límite y casos de error.
No modifiques el código original.
```

### Para analizar un error

```text
Explícame este error paso a paso.
Dime las causas más probables y cómo comprobar cada una.
No propongas todavía una solución.
```

### Para revisar código

```text
Revisa este código como si fueras un revisor técnico.
Busca bugs, casos límite, problemas de legibilidad, riesgos de seguridad y tests ausentes.
Primero dame una lista priorizada, sin modificar el código.
```

---

## 28. Resumen

En este tema hemos visto que GitHub Copilot puede ser especialmente útil para tareas de mantenimiento y calidad del código:

- refactorización;
- documentación;
- generación de tests;
- debugging;
- revisión técnica.

La clave está en pedir ayuda de forma concreta y revisar siempre el resultado.

Copilot es más útil cuando se usa como compañero de trabajo:

- propone;
- explica;
- sugiere;
- compara;
- revisa.

Pero la decisión final debe seguir siendo humana.

---

## 29. Documentación recomendada

- GitHub Docs — GitHub Copilot.
- GitHub Docs — Prompt engineering for GitHub Copilot.
- GitHub Docs — Copilot Chat.
- GitHub Docs — Responsible use of GitHub Copilot.
- Documentación del framework de testing que se use en clase: Jest, Vitest, Pytest, JUnit, etc.
