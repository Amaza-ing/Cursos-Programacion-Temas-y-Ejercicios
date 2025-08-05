# **Tema 2: Condicionales en JavaScript**

## **1. Introducción a las estructuras condicionales**

Las estructuras condicionales permiten ejecutar diferentes bloques de código según se cumplan o no ciertas condiciones. En JavaScript, las sentencias condicionales más comunes son:

- `if` / `else`
- `else if`
- `switch`
- Operador ternario `? :`

---

## **2. La sentencia `if` / `else`**

La sentencia `if` evalúa una condición y ejecuta un bloque de código si esta es verdadera. Puedes usar `else` para ejecutar otro bloque si la condición no se cumple.

### **Sintaxis básica:**

```js
if (condición) {
  // Código si la condición es verdadera
} else {
  // Código si la condición es falsa
}
```

### **Ejemplo:**

```js
let age = 20;

if (age >= 18) {
  console.log("Eres mayor de edad.");
} else {
  console.log("Eres menor de edad.");
}
```

---

## **3. Uso de `else if` para múltiples condiciones**

Cuando se necesita evaluar múltiples condiciones, se puede usar `else if`.

### **Sintaxis básica:**

```js
if (condición1) {
  // Código si condición1 es verdadera
} else if (condición2) {
  // Código si condición2 es verdadera
} else {
  // Código si ninguna condición es verdadera
}
```

### **Ejemplo:**

```js
let score = 85;

if (score >= 90) {
  console.log("Sobresaliente");
} else if (score >= 75) {
  console.log("Notable");
} else if (score >= 60) {
  console.log("Aprobado");
} else {
  console.log("Reprobado");
}
```

---

[![Condicionales: if else](https://img.youtube.com/vi/_o6rkkqpL20/0.jpg)](https://www.youtube.com/watch?v=_o6rkkqpL20&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

## **4. La sentencia `switch`**

La sentencia `switch` es útil cuando se necesita evaluar una variable frente a múltiples valores posibles.

### **Sintaxis básica:**

```js
switch (expresión) {
  case valor1:
    // Código si la expresión es igual a valor1
    break;
  case valor2:
    // Código si la expresión es igual a valor2
    break;
  default:
  // Código si ningún caso coincide
}
```

### **Ejemplo:**

```js
let day = "martes";

switch (day) {
  case "lunes":
    console.log("Inicio de semana");
    break;
  case "martes":
    console.log("Segundo día de la semana");
    break;
  case "viernes":
    console.log("Casi fin de semana");
    break;
  default:
    console.log("Día no reconocido");
}
```

> **Nota:** No olvides usar `break` para evitar la ejecución de los casos siguientes.

---

[![Condicionales: switch](https://img.youtube.com/vi/74jf2XDWFnU/0.jpg)](https://www.youtube.com/watch?v=74jf2XDWFnU&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

## **5. Operador ternario `? :`**

El operador ternario es una forma abreviada de escribir condicionales simples.

### **Sintaxis:**

```js
condición ? expresión_si_verdadero : expresión_si_falso;
```

### **Ejemplo:**

```js
let age = 17;
let message = age >= 18 ? "Eres mayor de edad" : "Eres menor de edad";
console.log(message);
```

> **Salida:** `Eres menor de edad`

---

[![Operador ternario](https://img.youtube.com/vi/CAFZ1y4Dzvo/0.jpg)](https://www.youtube.com/watch?v=CAFZ1y4Dzvo&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

## **6. Comparadores en JavaScript**

Para realizar condiciones, se usan los siguientes operadores de comparación:

| Operador | Descripción          | Ejemplo     | Resultado |
| -------- | -------------------- | ----------- | --------- |
| `==`     | Igualdad débil       | `5 == '5'`  | `true`    |
| `===`    | Igualdad estricta    | `5 === '5'` | `false`   |
| `!=`     | Desigualdad débil    | `5 != '5'`  | `false`   |
| `!==`    | Desigualdad estricta | `5 !== '5'` | `true`    |
| `>`      | Mayor que            | `7 > 5`     | `true`    |
| `<`      | Menor que            | `3 < 5`     | `true`    |
| `>=`     | Mayor o igual que    | `5 >= 5`    | `true`    |
| `<=`     | Menor o igual que    | `4 <= 3`    | `false`   |

La igualdad estricta `===` en JavaScript es equivalente al doble igual `==` en la mayoría de lenguajes de programación.
La igualdad débil compara sólo el valor, pero no el tipo de dato y la igualdad estricta compara tanto el valor como el tipo.

> **Recomendación:** Usa `===` y `!==` para evitar problemas de conversión implícita de tipos.

---

[![Operadores Lógicos](https://img.youtube.com/vi/lNzYA0NA3Gw/0.jpg)](https://www.youtube.com/watch?v=lNzYA0NA3Gw&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

[![Doble igual vs Triple igual](https://img.youtube.com/vi/GuCv3LrxA7A/0.jpg)](https://www.youtube.com/watch?v=GuCv3LrxA7A&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

## **7. Lógica booleana**

En las condiciones, puedes usar operadores lógicos para combinar múltiples expresiones:

| Operador | Descripción | Ejemplo           | Resultado |
| -------- | ----------- | ----------------- | --------- |
| `&&`     | AND (y)     | `true && false`   | `false`   |
| `\|\|`   | OR (o)      | `true \|\| false` | `true`    |
| `!`      | NOT (no)    | `!true`           | `false`   |

Utilizando el "y lógico" `&&` todas las expresiones tienen que ser verdadersa para que el resultado sea verdadero.

Utilizando el "o lógico" `||` con que una de las expresiones sea verdadera, el resultado ya es verdadero.

El operador "negación" transforma un `true` en un `false` y viceversa.

### **Ejemplo combinando condiciones:**

```js
let age = 25;
let hasLicense = true;

if (age >= 18 && hasLicense) {
  console.log("Puedes conducir.");
} else {
  console.log("No puedes conducir.");
}
```

---

[![Qué devuelven los operadores booleanos](https://img.youtube.com/vi/L9qOnh9TK3M/0.jpg)](https://www.youtube.com/watch?v=L9qOnh9TK3M&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

## **8. Valores Truthy y Falsy en JavaScript**

### **8.1. Definición**

En JavaScript, los valores se evalúan en contextos booleanos (como en condicionales) para determinar si son "verdaderos" o "falsos". Sin embargo, no todos los valores verdaderos o falsos son estrictamente `true` o `false`. Aquí es donde entran los conceptos de **truthy** y **falsy**.

- **Truthy:** Un valor que se evalúa como `true` en un contexto booleano.
- **Falsy:** Un valor que se evalúa como `false` en un contexto booleano.

---

### **8.2. Valores Falsy**

Un valor **falsy** es aquel que se considera `false` cuando se evalúa en una condición.

### **Lista de valores falsy en JavaScript:**

1. `false` — El valor booleano falso.
2. `0` — El número cero.
3. `-0` — El número negativo cero.
4. `0n` — El valor BigInt cero.
5. `""` o `''` o `` (string vacío) — Una cadena vacía.
6. `null` — Ausencia intencional de cualquier valor.
7. `undefined` — Una variable declarada pero no inicializada.
8. `NaN` — Resultado de operaciones matemáticas inválidas.

### **Ejemplo:**

```js
if (0) {
  console.log("Este mensaje no se mostrará.");
} else {
  console.log("0 es un valor falsy.");
}

if ("") {
  console.log("Este mensaje no se mostrará.");
} else {
  console.log("Cadena vacía es falsy.");
}
```

**Salida:**

```
0 es un valor falsy.
Cadena vacía es falsy.
```

---

### **8.3. Valores Truthy**

Un valor **truthy** es cualquier valor que no sea falsy. Estos valores se consideran `true` cuando se evalúan en un contexto booleano.

### **Ejemplos de valores truthy:**

1. Cualquier número distinto de `0` (positivo o negativo): `42`, `-7`
2. Cadenas no vacías: `'Hola'`, `'false'`, `'0'`
3. Arrays: `[]`
4. Objetos: `{}`
5. Funciones: `function() {}`
6. Instancias de clases

### **Ejemplo:**

```js
if ("JavaScript") {
  console.log("Esta cadena no está vacía.");
}

if ([]) {
  console.log("Un array vacío es truthy.");
}

if ({}) {
  console.log("Un objeto vacío es truthy.");
}
```

**Salida:**

```
Esta cadena no está vacía.
Un array vacío es truthy.
Un objeto vacío es truthy.
```

> **Nota:** Aunque un array u objeto esté vacío, se consideran truthy.

---

[![Truthy && Falsy](https://img.youtube.com/vi/tRPvHLtIb9U/0.jpg)](https://www.youtube.com/watch?v=tRPvHLtIb9U&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

### **8.4. Conversión implícita a booleano**

JavaScript convierte automáticamente valores a booleanos en contextos donde se espera un `true` o `false`, como en:

- Sentencias condicionales (`if`, `while`, `for`)
- Operadores lógicos (`&&`, `||`, `!`)

### **Ejemplo usando `Boolean()`:**

```js
console.log(Boolean("Hola")); // true
console.log(Boolean("")); // false
console.log(Boolean(100)); // true
console.log(Boolean(0)); // false
console.log(Boolean(null)); // false
```

### **Ejemplo con operador `!` (NOT):**

El operador not (`!`) devolverá true cuando se aplique sobre un valor falsy y devolverá false cuando se evalúe sobre un valor truthy.

```js
console.log(!"hola"); // false
console.log(!0); // true
```

Se pueden aplicar dos operadores negación (`!!`) para volver obtener true de un valor truthy y false de un valor falsy.

```js
console.log(!!"hola"); // true
console.log(!!0); // false
```

---

[![Cómo convertir cualquier variable a booleano](https://img.youtube.com/vi/5lvql3mcmWk/0.jpg)](https://www.youtube.com/watch?v=5lvql3mcmWk&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

### **8.5. Uso práctico: Valores por defecto**

Un uso común de truthy y falsy es proporcionar valores por defecto utilizando el operador "o lógico", ya que aunque la primera expresión sea falsy seguirá evaluando el resto de expresiones hasta encontrar algo truthy y ese será el valor devuelto.

### **Ejemplo con operador lógico `||`:**

```js
let username = "";
let displayName = username || "Invitado";

console.log(displayName); // Salida: Invitado
```

En este caso, como `username` es una cadena vacía (falsy), `displayName` toma el valor "Invitado".

---

### **8.6. Buenas prácticas**

1. **Sé explícito:** Aunque JavaScript permite estas conversiones implícitas, es recomendable ser claro en el código.
2. **Evita errores comunes:** Recuerda que valores como `0`, `""`, `null`, `undefined` y `NaN` son falsy y pueden provocar errores lógicos.

---

### **8.7. Importante**

Comprender los conceptos de **truthy** y **falsy** en JavaScript es esencial para escribir código eficiente y libre de errores. Estos valores afectan la forma en que las condiciones y operaciones lógicas se evalúan en tu código.

## **9. Buenas prácticas**

- Usa `===` y `!==` en lugar de `==` y `!=`.
- Mantén las condiciones simples y legibles.
- Comenta condicionales complejos.
- Usa el operador ternario para condiciones simples.
- No abuses del `switch` si `if/else` es más claro.

---

## **10. Conclusión**

Las estructuras condicionales son fundamentales para el control del flujo en JavaScript. Saber cuándo usar `if/else`, `switch` o el operador ternario te permitirá escribir código más limpio y eficiente.

En el próximo tema, profundizaremos en los **bucles** y cómo iterar sobre datos en JavaScript.
