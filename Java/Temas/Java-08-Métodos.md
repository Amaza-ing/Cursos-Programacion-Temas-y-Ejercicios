# Tema 8. Métodos: definición y uso (parámetros, argumentos y return)

## 1. Introducción

A medida que un programa crece, un problema aparece muy rápido: el código se vuelve largo, repetitivo y difícil de mantener.

Los **métodos** resuelven esto porque te permiten:

- Reutilizar lógica sin copiar y pegar
- Dividir el programa en partes pequeñas y comprensibles
- Dar nombres claros a acciones (“calcular”, “validar”, “mostrar”)
- Organizar el código para que sea más fácil de leer y modificar

En este tema aprenderás:

- Qué es un método y por qué es una pieza básica en Java
- Cómo se define un método (firma, parámetros, cuerpo, retorno)
- Diferencia entre **parámetros** y **argumentos**
- Métodos con `return` y métodos `void`
- Cómo llamar a métodos y usar su resultado
- Errores típicos y buenas prácticas

---

## 2. Qué es un método

Un **método** es un bloque de código con un nombre que:

- Puede recibir datos (parámetros)
- Realiza una tarea concreta
- Puede devolver un resultado (`return`)

Piensa en un método como en una “mini herramienta” dentro de tu programa.

Ejemplo mental:

- `sum(2, 3)` devuelve 5
- `printWelcomeMessage()` muestra un mensaje
- `isEven(10)` devuelve `true`

---

## 3. Dónde se colocan los métodos en Java

En Java, los métodos viven **dentro de clases**.

En un programa básico (un solo archivo), lo más común es:

- La clase `Main`
- El método `main`
- Y otros métodos auxiliares dentro de la misma clase

Ejemplo de estructura:

```java
public class Main {
    public static void main(String[] args) {
        // program starts here
    }

    // other methods here
}
```

---

## 4. Partes de un método (firma y cuerpo)

Un método tiene:

- **Modificadores** (por ejemplo `public`, `private`)
- **static** (lo usaremos por ahora)
- **Tipo de retorno** (`int`, `double`, `boolean`, `String`, `void`, etc.)
- **Nombre del método**
- **Parámetros** (opcionales)
- **Cuerpo** (bloque entre `{}`)

Sintaxis general:

```java
modifier static returnType methodName(parameterList) {
    // method body
}
```

Ejemplo real:

```java
public static int sum(int a, int b) {
    return a + b;
}
```

---

## 5. El método `main` y por qué es especial

El método `main` es el punto de entrada del programa:

```java
public static void main(String[] args) {
    // code starts here
}
```

Características:

- Siempre es `public static void`
- Se llama exactamente `main`
- Recibe un `String[] args` (lo verás con más profundidad más adelante)

Dentro de `main` normalmente:

- Declaras variables
- Llamas a métodos
- Muestras resultados
- Controlas el flujo del programa

---

## 6. Crear tu primer método (sin parámetros y sin return)

Un método puede no recibir nada y no devolver nada.

### 6.1. Método `void`

Si un método no devuelve nada, su tipo de retorno es `void`.

Ejemplo:

```java
public static void printWelcomeMessage() {
    System.out.println("Welcome to Java!");
}
```

### 6.2. Llamar al método desde `main`

```java
public class Main {
    public static void main(String[] args) {
        printWelcomeMessage();
        printWelcomeMessage();
    }

    public static void printWelcomeMessage() {
        System.out.println("Welcome to Java!");
    }
}
```

Esto imprime el mensaje dos veces sin repetir el `System.out.println` en `main`.

---

## 7. Parámetros y argumentos (diferencia clara)

Esta diferencia es fundamental.

- **Parámetros**: variables que aparecen en la definición del método
- **Argumentos**: valores reales que pasas al llamar al método

### 7.1. Ejemplo guiado

Definición (parámetros):

```java
public static void greetUser(String userName) {
    System.out.println("Hello, " + userName);
}
```

Llamada (argumento):

```java
greetUser("Laura");
```

Aquí:

- `userName` es un parámetro
- `"Laura"` es un argumento

---

### 7.2. Método con varios parámetros

```java
public static void printProfile(String userName, int userAge) {
    System.out.println("Name: " + userName + " | Age: " + userAge);
}
```

Llamada:

```java
printProfile("Alex", 25);
```

El orden importa:

- Primer argumento → primer parámetro
- Segundo argumento → segundo parámetro

---

## 8. Métodos con return (devolver un valor)

Un método puede devolver un valor usando `return`.

Cuando un método devuelve un valor:

- El tipo de retorno no puede ser `void`
- Debe devolver un valor compatible con el tipo declarado

### 8.1. Ejemplo: sumar dos números

```java
public static int sum(int a, int b) {
    return a + b;
}
```

Llamada:

```java
int result = sum(5, 3);
System.out.println(result);
```

---

### 8.2. `return` termina el método

Cuando Java encuentra `return`, el método se detiene y devuelve el valor.

Ejemplo:

```java
public static int clampToZero(int value) {
    if (value < 0) {
        return 0;
    }

    return value;
}
```

Qué hace:

- Si `value` es negativo, devuelve 0 inmediatamente
- Si no, devuelve `value`

---

## 9. Métodos que devuelven `boolean` (muy comunes)

Estos métodos suelen empezar por:

- `is...`
- `has...`
- `can...`

Ejemplo: comprobar si un número es par

```java
public static boolean isEven(int number) {
    return number % 2 == 0;
}
```

Uso:

```java
boolean result = isEven(10);
System.out.println(result);
```

---

## 10. Métodos que devuelven `String`

Ejemplo: construir un mensaje

```java
public static String buildGreeting(String userName) {
    return "Hello, " + userName + "!";
}
```

Uso:

```java
String message = buildGreeting("Sara");
System.out.println(message);
```

---

## 11. Tipos de parámetros (primitivos y `String`)

Por ahora trabajaremos sobre todo con:

- Primitivos (`int`, `double`, `boolean`, `char`)
- `String`

Ejemplo con `double`:

```java
public static double calculateTotal(double unitPrice, int quantity) {
    return unitPrice * quantity;
}
```

Uso:

```java
double total = calculateTotal(19.99, 3);
System.out.println(total);
```

---

## 12. Scope (alcance) de variables en métodos

Las variables declaradas dentro de un método existen **solo dentro de ese método**.

Ejemplo:

```java
public static void example() {
    int value = 10;
    System.out.println(value);
}
```

Fuera del método, `value` no existe.

Esto ayuda a evitar conflictos y a mantener el código organizado.

---

## 13. Métodos que llaman a otros métodos

Es muy común construir métodos pequeños y combinarlos.

Ejemplo: total con descuento

```java
public static double calculateDiscount(double basePrice, double discountRate) {
    return basePrice * discountRate;
}

public static double calculateFinalPrice(double basePrice, double discountRate) {
    double discount = calculateDiscount(basePrice, discountRate);
    return basePrice - discount;
}
```

Uso:

```java
double finalPrice = calculateFinalPrice(120.0, 0.15);
System.out.println(finalPrice);
```

---

## 14. Buenas prácticas al diseñar métodos

### 14.1. Un método debe hacer una cosa

Mal: hace demasiadas cosas a la vez

```java
public static void processUser() {
    // valida, calcula, imprime, guarda...
}
```

Mejor: dividir responsabilidades

- `isValidUser(...)`
- `calculateScore(...)`
- `printSummary(...)`

---

### 14.2. Nombres claros y verbos

Buenas ideas:

- `calculateTotal`
- `printReport`
- `isAdult`
- `buildMessage`

Evita nombres genéricos como `doStuff` o `test`.

---

### 14.3. Evita depender de variables globales (por ahora)

Al principio, es mejor que el método reciba lo que necesita por parámetros y devuelva un resultado.

Esto hace el método más reutilizable y fácil de probar.

---

## 15. Errores comunes al empezar (y cómo evitarlos)

### 15.1. Olvidar usar el resultado del método

Esto compila, pero no aprovecha el `return`:

```java
sum(2, 3);
```

Mejor:

```java
int result = sum(2, 3);
System.out.println(result);
```

---

### 15.2. Tipo de retorno incorrecto

Esto no compila:

```java
public static int getName() {
    return "Alex";
}
```

Solución: el tipo debe coincidir

```java
public static String getName() {
    return "Alex";
}
```

---

### 15.3. `return` faltante

Si un método declara un tipo de retorno, debe devolverlo en todos los caminos posibles.

Esto falla:

```java
public static int getScore(boolean isPremium) {
    if (isPremium) {
        return 100;
    }
}
```

Solución:

```java
public static int getScore(boolean isPremium) {
    if (isPremium) {
        return 100;
    }

    return 50;
}
```

---

### 15.4. Confundir parámetros con argumentos

- Parámetro: `int age`
- Argumento: `25`

Ejemplo:

```java
public static boolean isAdult(int age) {
    return age >= 18;
}

boolean result = isAdult(25);
```

---

## 16. Ejemplo completo (programa organizado con métodos)

Este ejemplo muestra cómo usar varios métodos para que `main` sea más limpio.

```java
public class Main {
    public static void main(String[] args) {
        String userName = "Laura";
        int userAge = 17;

        printWelcomeMessage();

        boolean adult = isAdult(userAge);
        String summary = buildSummary(userName, userAge, adult);

        System.out.println(summary);
    }

    public static void printWelcomeMessage() {
        System.out.println("Welcome!");
    }

    public static boolean isAdult(int age) {
        return age >= 18;
    }

    public static String buildSummary(String userName, int userAge, boolean isAdult) {
        return "User: " + userName + " | Age: " + userAge + " | Adult: " + isAdult;
    }
}
```

Qué aporta este enfoque:

- `main` se convierte en una lectura “de alto nivel” del programa
- Cada método tiene una responsabilidad clara
- Puedes cambiar el formato del resumen sin tocar la lógica de `main`

---

## 17. A tener en cuenta

- Un método es una pieza reutilizable de código con nombre.
- Los métodos ayudan a organizar, reutilizar y mantener programas.
- Parámetros = definición, argumentos = valores al llamar.
- `void` significa que el método no devuelve nada.
- `return` devuelve un valor y termina el método.
- Diseñar métodos pequeños y con nombres claros mejora muchísimo la calidad del código.

---

En el próximo tema profundizaremos en **sobrecarga de métodos**, y verás cómo Java permite métodos con el mismo nombre pero diferentes parámetros.
