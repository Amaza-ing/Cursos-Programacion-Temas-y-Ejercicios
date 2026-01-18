# Tema 3. Operadores y expresiones

## 1. Introducción

Ya sabes crear variables y guardar valores. Ahora toca lo que de verdad hace útil un programa: **hacer cosas con esos valores**.

En Java, para trabajar con valores usamos:

- **Operadores**: símbolos como `+`, `-`, `==`, `&&`...
- **Expresiones**: combinaciones de valores, variables y operadores que producen un resultado

Por ejemplo:

```java
int total = 5 + 3;          // expresión aritmética
boolean isAdult = age >= 18; // expresión relacional
```

En este tema aprenderás, con ejemplos claros y guiados:

- Operadores aritméticos
- Operadores relacionales (comparaciones)
- Operadores lógicos (combinar condiciones)
- Operadores de asignación (incluyendo compuestos)
- Incremento y decremento (`++` y `--`)
- Prioridad de operadores y uso de paréntesis
- Errores típicos (muy comunes al empezar)

---

## 2. Qué es un operador y qué es una expresión

### 2.1. Operador

Un **operador** es un símbolo que indica una operación:

- `+` suma
- `==` compara igualdad
- `&&` combina condiciones

### 2.2. Expresión

Una **expresión** es algo que se puede evaluar y produce un valor.

Ejemplos de expresiones:

```java
10 + 5
age >= 18
isPremium && hasPermission
```

Y normalmente guardas el resultado en una variable:

```java
int result = 10 + 5;
boolean isValid = age >= 18;
```

---

## 3. Operadores aritméticos

Los operadores aritméticos se usan para cálculos matemáticos.

### 3.1. Operadores aritméticos disponibles

| Operador | Nombre         | Ejemplo |
| -------- | -------------- | ------- |
| `+`      | Suma           | `a + b` |
| `-`      | Resta          | `a - b` |
| `*`      | Multiplicación | `a * b` |
| `/`      | División       | `a / b` |
| `%`      | Módulo (resto) | `a % b` |

---

### 3.2. Ejemplo guiado: operaciones básicas

```java
int a = 10;
int b = 3;

int sum = a + b;
int difference = a - b;
int product = a * b;
int quotient = a / b;
int remainder = a % b;

System.out.println("sum: " + sum);               // 13
System.out.println("difference: " + difference); // 7
System.out.println("product: " + product);       // 30
System.out.println("quotient: " + quotient);     // 3
System.out.println("remainder: " + remainder);   // 1
```

---

### 3.3. División entre enteros (error típico)

Cuando divides dos `int`, el resultado es `int` y se pierden los decimales:

```java
int result = 5 / 2;
System.out.println(result); // 2
```

Si necesitas decimales, al menos uno debe ser `double`:

```java
double result = 5 / 2.0;
System.out.println(result); // 2.5
```

O usando cast:

```java
int a = 5;
int b = 2;

double result = (double) a / b;
System.out.println(result); // 2.5
```

---

### 3.4. Módulo `%` (muy útil)

El módulo devuelve el resto de una división.

Ejemplo:

```java
int remainder = 10 % 3;
System.out.println(remainder); // 1
```

Casos típicos:

- Comprobar si un número es par o impar
- Ejecutar algo “cada N” veces
- Ciclos

Ejemplo: par o impar

```java
int number = 7;

boolean isEven = (number % 2) == 0;
System.out.println(isEven); // false
```

---

## 4. Operadores de asignación

### 4.1. Asignación básica `=`

El operador `=` asigna un valor a una variable.

```java
int age = 25;
```

---

### 4.2. Asignación compuesta (`+=`, `-=`, `*=`, `/=`, `%=`)

Permiten actualizar una variable de forma más compacta.

| Operador | Ejemplo  | Equivale a  |
| -------- | -------- | ----------- |
| `+=`     | `a += 2` | `a = a + 2` |
| `-=`     | `a -= 2` | `a = a - 2` |
| `*=`     | `a *= 2` | `a = a * 2` |
| `/=`     | `a /= 2` | `a = a / 2` |
| `%=`     | `a %= 2` | `a = a % 2` |

Ejemplo:

```java
int score = 10;

score += 5; // 15
score -= 2; // 13
score *= 2; // 26
score /= 2; // 13

System.out.println(score);
```

---

## 5. Incremento y decremento (`++` y `--`)

Estos operadores suman o restan 1.

```java
int count = 0;

count++; // ahora count vale 1
count--; // vuelve a 0
```

---

### 5.1. Pre-incremento vs post-incremento (muy importante)

- `count++` (post): primero usa el valor, luego incrementa
- `++count` (pre): primero incrementa, luego usa el valor

Ejemplo guiado:

```java
int count = 5;

System.out.println(count++); // imprime 5, luego count pasa a 6
System.out.println(count);   // imprime 6
```

Ahora con pre-incremento:

```java
int count = 5;

System.out.println(++count); // count pasa a 6 y luego imprime 6
System.out.println(count);   // imprime 6
```

> Recomendación para principiantes: usa `count++` en líneas separadas para evitar confusiones.

---

## 6. Operadores relacionales (comparaciones)

Los operadores relacionales comparan valores y el resultado siempre es un `boolean`.

### 6.1. Operadores relacionales

| Operador | Significado       | Ejemplo  |
| -------- | ----------------- | -------- |
| `==`     | Igual a           | `a == b` |
| `!=`     | Distinto de       | `a != b` |
| `>`      | Mayor que         | `a > b`  |
| `<`      | Menor que         | `a < b`  |
| `>=`     | Mayor o igual que | `a >= b` |
| `<=`     | Menor o igual que | `a <= b` |

---

### 6.2. Ejemplo guiado: comparación de edad

```java
int age = 17;

boolean isAdult = age >= 18;
boolean isMinor = age < 18;

System.out.println(isAdult); // false
System.out.println(isMinor); // true
```

---

### 6.3. Comparaciones con `double` (precaución)

Comparar decimales exactos puede fallar por representación interna, aunque en ejemplos simples suele funcionar.

```java
double a = 0.1 + 0.2;
System.out.println(a); // puede mostrar 0.30000000000000004
```

Para principiantes, quédate con esta idea:

- Para dinero, suele usarse `BigDecimal` (lo verás mucho más adelante)
- Para ejercicios básicos, `double` está bien, pero sé consciente de esto

---

## 7. Operadores lógicos

Los operadores lógicos combinan valores booleanos.

### 7.1. Operadores lógicos principales

| Operador | Nombre | Significado            |
| -------- | ------ | ---------------------- | --- | ---------------------------- |
| `&&`     | AND    | true si ambos son true |
| `        |        | `                      | OR  | true si al menos uno es true |
| `!`      | NOT    | invierte el booleano   |

---

### 7.2. Ejemplo: AND (`&&`)

```java
int age = 20;
boolean hasId = true;

boolean canEnter = (age >= 18) && hasId;
System.out.println(canEnter); // true
```

---

### 7.3. Ejemplo: OR (`||`)

```java
boolean isVip = true;
boolean hasInvitation = false;

boolean canAccess = isVip || hasInvitation;
System.out.println(canAccess); // true
```

---

### 7.4. Ejemplo: NOT (`!`)

```java
boolean isBlocked = false;

boolean canLogin = !isBlocked;
System.out.println(canLogin); // true
```

---

## 8. Cortocircuito (short-circuit) en `&&` y `||`

Esto es importante porque afecta al comportamiento del programa.

- En `&&`, si la primera condición es `false`, Java no evalúa la segunda.
- En `||`, si la primera condición es `true`, Java no evalúa la segunda.

Ejemplo:

```java
int value = 0;

boolean result = (value != 0) && (10 / value > 1);
System.out.println(result); // false
```

Aquí no hay error, porque `value != 0` es `false` y Java no evalúa `10 / value`.

Si no existiera cortocircuito, este código lanzaría un error por división entre cero.

---

## 9. Operadores con `String` (muy importante)

### 9.1. Concatenación con `+`

Puedes unir texto con variables usando `+`.

```java
String name = "Alex";
int age = 25;

String message = "Name: " + name + ", Age: " + age;
System.out.println(message);
```

---

### 9.2. Error típico: concatenación vs suma

Mira esto:

```java
System.out.println("Result: " + 2 + 3);
```

Salida:

```
Result: 23
```

Porque se interpreta como concatenación: `"Result: " + 2` y luego `+ 3`.

Si quieres suma real, usa paréntesis:

```java
System.out.println("Result: " + (2 + 3));
```

Salida:

```
Result: 5
```

---

### 9.3. Comparar `String`: usa `.equals(...)`

Este es un error clásico de Java.

Incorrecto:

```java
String role = "admin";

if (role == "admin") {
    System.out.println("Admin access");
}
```

Correcto:

```java
String role = "admin";

if (role.equals("admin")) {
    System.out.println("Admin access");
}
```

Más adelante verás por qué (objetos vs referencias), pero por ahora quédate con la regla:

> Para comparar texto en Java, usa `.equals(...)`.

---

## 10. Prioridad de operadores y paréntesis

Java evalúa expresiones siguiendo un orden de prioridad.

Regla práctica rápida:

1. Paréntesis `( )`
2. Multiplicación/División/Módulo `* / %`
3. Suma/Resta `+ -`
4. Comparaciones `> < >= <=`
5. Igualdad `== !=`
6. AND `&&`
7. OR `||`
8. Asignación `=`

---

### 10.1. Ejemplo: prioridad en aritmética

```java
int result = 5 + 2 * 3;
System.out.println(result); // 11
```

Si quieres cambiar el orden:

```java
int result = (5 + 2) * 3;
System.out.println(result); // 21
```

---

### 10.2. Ejemplo: prioridad en condiciones

```java
boolean result = true || false && false;
System.out.println(result); // true
```

Porque `&&` tiene más prioridad que `||`, se evalúa así:

- `false && false` -> `false`
- `true || false` -> `true`

Si quisieras otra lógica:

```java
boolean result = (true || false) && false;
System.out.println(result); // false
```

---

## 11. Ejemplos guiados (para practicar de verdad)

### 11.1. Ejemplo 1: calcular el precio final con descuento

Queremos:

- `basePrice` (double)
- `discountRate` (double)
- `finalPrice = basePrice - (basePrice * discountRate)`

```java
public class Main {
    public static void main(String[] args) {
        double basePrice = 120.0;
        double discountRate = 0.15;

        double discountAmount = basePrice * discountRate;
        double finalPrice = basePrice - discountAmount;

        System.out.println("Base price: " + basePrice);
        System.out.println("Discount: " + discountAmount);
        System.out.println("Final price: " + finalPrice);
    }
}
```

Puntos clave:

- Separar el cálculo en pasos mejora legibilidad
- Evitas errores al encadenar operaciones

---

### 11.2. Ejemplo 2: validar acceso con condiciones lógicas

Queremos permitir acceso si:

- es mayor de edad **y**
- tiene entrada **o** es VIP

```java
public class Main {
    public static void main(String[] args) {
        int age = 19;
        boolean hasTicket = false;
        boolean isVip = true;

        boolean isAdult = age >= 18;
        boolean canEnter = isAdult && (hasTicket || isVip);

        System.out.println("Can enter: " + canEnter);
    }
}
```

Fíjate en los paréntesis:

- Sin paréntesis la condición puede interpretarse distinto
- Los paréntesis dejan clara la intención

---

### 11.3. Ejemplo 3: par o impar y múltiplos

```java
public class Main {
    public static void main(String[] args) {
        int number = 12;

        boolean isEven = (number % 2) == 0;
        boolean isMultipleOf3 = (number % 3) == 0;

        System.out.println("Is even: " + isEven);
        System.out.println("Is multiple of 3: " + isMultipleOf3);
    }
}
```

---

## 12. Errores comunes (y cómo evitarlos)

### 12.1. Usar `=` en vez de `==`

Incorrecto (no compila en condiciones):

```java
// if (age = 18) { ... } // error
```

Correcto:

```java
if (age == 18) {
    System.out.println("Exactly 18");
}
```

---

### 12.2. Olvidar paréntesis en concatenación

```java
System.out.println("Total: " + 2 + 3); // "Total: 23"
System.out.println("Total: " + (2 + 3)); // "Total: 5"
```

---

### 12.3. Dividir enteros esperando decimales

```java
int a = 7;
int b = 2;

double average = a / b; // 3.0 (incorrecto)
```

Solución:

```java
double average = (double) a / b; // 3.5
```

---

## 13. A tener en cuenta

- Un operador es un símbolo; una expresión combina operadores y valores.
- La división entre enteros es una fuente típica de errores.
- `&&` y `||` usan cortocircuito (a veces evita errores).
- Para `String`, concatena con `+` y compara con `.equals(...)`.
- Usa paréntesis para claridad y para controlar la prioridad.

---

En el próximo tema aprenderás **conversión de tipos**, donde verás cómo pasar de `int` a `double`, de `String` a número, y por qué algunas operaciones dan resultados inesperados si no conviertes correctamente.
