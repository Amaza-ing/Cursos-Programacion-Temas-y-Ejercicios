# Tema 2. Variables y tipos de datos

## 1. Introducción

En cualquier lenguaje de programación, si no puedes **guardar información**, no puedes construir programas útiles.

En Java, esa información se guarda principalmente en:

- **Variables** (datos que pueden cambiar)
- **Constantes** (datos que no deberían cambiar)

Y para poder guardar información, Java te obliga a ser muy explícito: **toda variable tiene un tipo**.

En este tema aprenderás:

- Qué es una variable y cómo se usa
- Qué significa que Java sea un lenguaje **fuertemente tipado**
- Tipos de datos **primitivos** (los básicos del lenguaje)
- Tipos de referencia esenciales como `String`
- Declaración, asignación y modificación
- Errores típicos al empezar
- Buenas prácticas para escribir código claro

---

## 2. ¿Qué es una variable?

Una **variable** es un espacio en memoria con:

- Un **nombre** (para poder referirte a ella)
- Un **tipo** (para definir qué valores puede guardar)
- Un **valor** (la información que realmente guarda)

Piensa en una variable como una “caja” etiquetada:

- El **tipo** define qué puede haber dentro (números, true/false, texto, etc.)
- El **nombre** te permite usar esa caja en tu código
- El **valor** es el contenido actual

---

## 3. Java es fuertemente tipado

Decimos que Java es un lenguaje **fuertemente tipado** porque:

- Cada variable tiene un tipo fijo
- Ese tipo no puede cambiar
- El compilador revisa que uses correctamente los tipos

Ejemplo:

```java
int age = 25;
age = 30; // OK
```

Pero esto no es válido:

```java
int age = 25;
age = "twenty five"; // Error: no se puede asignar texto a un int
```

Esto es una ventaja porque evita muchos errores antes de ejecutar el programa.

---

## 4. Declaración de variables

Para declarar una variable en Java necesitas:

1. El **tipo**
2. El **nombre**

Sintaxis:

```java
type variableName;
```

Ejemplo:

```java
int age;
```

Aquí todavía **no tiene valor** (y no se puede usar sin inicializar).

---

## 5. Asignación e inicialización

Asignar un valor significa guardar un dato dentro de la variable, usando `=`.

### 5.1. Asignar después de declarar

```java
int age;
age = 25;
```

### 5.2. Declarar e inicializar en la misma línea (lo más habitual)

```java
int age = 25;
```

---

## 6. Modificar una variable

Una variable puede cambiar su valor durante la ejecución.

```java
int score = 10;

score = 15;
score = 30;
```

La variable sigue siendo `int`, pero su valor cambia.

---

## 7. Tipos de datos primitivos

Java tiene **8 tipos primitivos**. Son datos “básicos” que no son objetos.

- Enteros: `byte`, `short`, `int`, `long`
- Decimales: `float`, `double`
- Lógicos: `boolean`
- Caracteres: `char`

> Regla práctica: al empezar, los más comunes son `int`, `double`, `boolean`, `char`.

| Tipo primitivo | Tamaño  | Valores posibles                                                                |
| -------------- | ------- | ------------------------------------------------------------------------------- |
| byte           | 8 bits  | Desde -128 hasta 127                                                            |
| short          | 16 bits | Desde -32,768 hasta 32,767                                                      |
| int            | 32 bits | Desde -2,147,483,648 hasta 2,147,483,647                                        |
| long           | 64 bits | Desde -9,223,372,036,854,775,808 hasta 9,223,372,036,854,775,807                |
| float          | 32 bits | Aproximadamente desde ±1.4E-45 hasta ±3.4028235E38 (precisión simple)           |
| double         | 64 bits | Aproximadamente desde ±4.9E-324 hasta ±1.7976931348623157E308 (doble precisión) |
| char           | 16 bits | Desde '\u0000' (0) hasta '\uFFFF' (65,535), caracteres Unicode                  |
| boolean        | 1 bit\* | true o false                                                                    |

---

## 8. Enteros: `byte`, `short`, `int`, `long`

Se usan para números **sin decimales**.

### 8.1. `int` (el más usado)

```java
int age = 25;
int year = 2026;
int points = -10;
```

### 8.2. `long` (para números más grandes)

Cuando el número puede ser muy grande, usa `long`.

```java
long worldPopulation = 8_000_000_000L;
```

- El sufijo `L` es importante para indicar que es un literal `long`.

### 8.3. `byte` y `short`

Se usan poco al empezar, pero existen por eficiencia en memoria.

```java
byte smallNumber = 120;
short mediumNumber = 30_000;
```

---

## 9. Decimales: `float` y `double`

Para números con decimales.

### 9.1. `double` (recomendado por defecto)

```java
double price = 19.99;
double average = 7.5;
```

### 9.2. `float` (menos precisión)

```java
float temperature = 36.5f;
```

- El sufijo `f` es obligatorio para literales `float`.

> Recomendación: usa `double` salvo que tengas un motivo claro para usar `float`.

---

## 10. Booleanos: `boolean`

Solo puede ser `true` o `false`.

```java
boolean isActive = true;
boolean hasPermission = false;
```

Muy usado en condiciones (`if`, `while`, etc.).

---

## 11. Caracteres: `char`

Guarda un único carácter, entre comillas simples `' '`.

```java
char initial = 'S';
char grade = 'A';
```

Importante:

- `char` es un solo carácter
- `"A"` (con comillas dobles) es un `String`, no un `char`

---

## 12. `String` (texto) — no es primitivo, pero es esencial

`String` es un tipo de **referencia** (un objeto), no un primitivo, pero lo usarás desde el primer día.

```java
String name = "Alberto";
String city = "Madrid";
```

- Usa comillas dobles `" "`.
- Permite guardar cadenas de texto completas.

---

## 13. Imprimir variables por consola

Para ver el contenido de una variable, usamos:

```java
System.out.println(variableName);
```

Ejemplo:

```java
String name = "Alex";
int age = 25;

System.out.println(name);
System.out.println(age);
```

---

## 14. Concatenación (unir texto con variables)

Con el operador `+` puedes unir texto y variables.

```java
String name = "Alex";
int age = 25;

System.out.println("Name: " + name);
System.out.println("Age: " + age);
```

Salida:

```
Name: Alex
Age: 25
```

---

## 15. Ejemplo guiado: variables en un programa completo

```java
public class Main {
    public static void main(String[] args) {
        String userName = "Alex";
        int userAge = 25;
        double accountBalance = 120.50;
        boolean isPremium = true;
        char userInitial = 'A';

        System.out.println("User name: " + userName);
        System.out.println("User age: " + userAge);
        System.out.println("Balance: " + accountBalance);
        System.out.println("Premium: " + isPremium);
        System.out.println("Initial: " + userInitial);
    }
}
```

Qué ocurre aquí:

- Declaras variables de distintos tipos
- Las inicializas con valores
- Las muestras por consola con texto descriptivo

---

## 16. Declarar varias variables del mismo tipo

Se puede, pero al empezar suele ser menos legible.

```java
int x = 1, y = 2, z = 3;
```

Recomendación (más claro):

```java
int x = 1;
int y = 2;
int z = 3;
```

---

## 17. Constantes con `final`

Una constante es una variable cuyo valor no debería cambiar.

Se crea usando `final`.

```java
final int maxUsers = 100;
```

Si intentas cambiarla:

```java
final int maxUsers = 100;
maxUsers = 200; // Error
```

Convención de nombres para constantes:

- `UPPER_SNAKE_CASE`

```java
final double VAT_RATE = 0.21;
```

---

## 18. Valores por defecto (muy importante)

En Java hay una diferencia importante:

- **Variables locales** (dentro de métodos) NO tienen valor por defecto
- **Atributos** (dentro de clases) SÍ tienen valor por defecto

### 18.1. Variable local sin inicializar (error)

```java
public class Main {
    public static void main(String[] args) {
        int age;
        System.out.println(age); // Error: variable no inicializada
    }
}
```

Solución: inicializar antes de usar

```java
int age = 0;
System.out.println(age);
```

> Atributos de clase los verás en POO, más adelante.

---

## 19. Literales y detalles que te ahorran errores

### 19.1. Separadores en números (más legibles)

Puedes usar `_` para separar miles:

```java
int budget = 1_000_000;
long population = 8_000_000_000L;
```

### 19.2. `L` para long y `f` para float

```java
long distance = 9_000_000_000L;
float ratio = 0.75f;
```

---

## 20. Errores comunes al empezar

### 20.1. Confundir `=` con `==`

- `=` asigna un valor
- `==` compara valores

```java
int a = 10;      // asignación
boolean isTen = (a == 10); // comparación
```

### 20.2. Intentar guardar decimales en `int`

```java
int price = 19.99; // Error
```

Solución:

```java
double price = 19.99;
```

### 20.3. Confundir `char` con `String`

```java
char letter = "A"; // Error
```

Correcto:

```java
char letter = 'A';
String text = "A";
```

---

## 21. Buenas prácticas al nombrar variables

### 21.1. Usa camelCase

- `userName`
- `totalPrice`
- `isLoggedIn`

### 21.2. Nombres descriptivos, no genéricos

Mal:

```java
int x;
double a;
boolean flag;
```

Mejor:

```java
int userAge;
double totalPrice;
boolean isLoggedIn;
```

### 21.3. Booleanos con prefijo claro

Los booleanos suelen empezar con:

- `is...`
- `has...`
- `can...`

Ejemplos:

```java
boolean isActive;
boolean hasPermission;
boolean canAccess;
```

---

## 22. A tener en cuenta

- Una variable es un espacio en memoria con tipo, nombre y valor.
- Java es fuertemente tipado: el tipo importa siempre.
- Los tipos primitivos cubren números, decimales, booleanos y caracteres.
- `String` es esencial para trabajar con texto.
- Inicializa tus variables antes de usarlas.
- Nombra tus variables con intención: te ahorra errores y mejora la lectura.

---

En el próximo tema aprenderás a trabajar con **operadores y expresiones**, para empezar a calcular, comparar y construir condiciones en Java.
