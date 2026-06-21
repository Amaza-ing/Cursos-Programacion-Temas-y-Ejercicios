# Ejercicios - Tema 11: Sobrecarga de métodos

A continuación encontrarás **10 ejercicios prácticos** para trabajar con **sobrecarga de métodos** (mismo nombre, diferentes parámetros).

Intenta resolverlos antes de consultar la solución.

---

## Ejercicio 1: Sobrecargar `sum` (2 y 3 parámetros)

Crea dos métodos `sum`:

- Uno que reciba 2 enteros y devuelva la suma
- Otro que reciba 3 enteros y devuelva la suma

Desde `main`, llama a ambos y muestra los resultados.

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        System.out.println(sum(2, 3));
        System.out.println(sum(2, 3, 4));
    }

    public static int sum(int a, int b) {
        return a + b;
    }

    public static int sum(int a, int b, int c) {
        return a + b + c;
    }
}
```

</details>

---

## Ejercicio 2: Sobrecargar `sum` para `double`

Crea dos métodos `sum`:

- `sum(int, int)`
- `sum(double, double)`

Llama a ambos desde `main`.

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        System.out.println(sum(10, 5));
        System.out.println(sum(10.5, 5.2));
    }

    public static int sum(int a, int b) {
        return a + b;
    }

    public static double sum(double a, double b) {
        return a + b;
    }
}
```

</details>

---

## Ejercicio 3: Sobrecargar `printUser` con y sin edad

Crea dos métodos `printUser`:

- Uno que reciba solo el nombre (`String`) y muestre `"User: <name>"`
- Otro que reciba nombre y edad (`String`, `int`) y muestre `"User: <name> | Age: <age>"`

Llama a ambos desde `main`.

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        printUser("Laura");
        printUser("Laura", 28);
    }

    public static void printUser(String name) {
        System.out.println("User: " + name);
    }

    public static void printUser(String name, int age) {
        System.out.println("User: " + name + " | Age: " + age);
    }
}
```

</details>

---

## Ejercicio 4: Sobrecargar `calculateTotal` (sin descuento y con descuento)

Crea dos métodos `calculateTotal`:

- Uno que reciba `unitPrice` (`double`) y `quantity` (`int`) y devuelva el total
- Otro que además reciba `discountRate` (`double`) y aplique el descuento

Llama a ambos desde `main`.

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        System.out.println(calculateTotal(10.0, 3));
        System.out.println(calculateTotal(10.0, 3, 0.10));
    }

    public static double calculateTotal(double unitPrice, int quantity) {
        return unitPrice * quantity;
    }

    public static double calculateTotal(double unitPrice, int quantity, double discountRate) {
        double base = unitPrice * quantity;
        return base - (base * discountRate);
    }
}
```

</details>

---

## Ejercicio 5: Sobrecargar `isValid` para `int` y `String`

Crea dos métodos `isValid`:

- `isValid(int value)` devuelve `true` si el valor es mayor que 0
- `isValid(String value)` devuelve `true` si no es `null` y no está en blanco

Llama a ambos desde `main` con valores de prueba.

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        System.out.println(isValid(5));
        System.out.println(isValid(-2));
        System.out.println(isValid("Hello"));
        System.out.println(isValid("   "));
    }

    public static boolean isValid(int value) {
        return value > 0;
    }

    public static boolean isValid(String value) {
        return value != null && !value.isBlank();
    }
}
```

</details>

---

## Ejercicio 6: Sobrecargar `buildLabel` con diferentes tipos

Crea dos métodos `buildLabel`:

- `buildLabel(String text, int number)` → `"text-number"`
- `buildLabel(String text, String code)` → `"text-code"`

Imprime ambos resultados desde `main`.

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        System.out.println(buildLabel("Item", 7));
        System.out.println(buildLabel("Item", "A7X"));
    }

    public static String buildLabel(String text, int number) {
        return text + "-" + number;
    }

    public static String buildLabel(String text, String code) {
        return text + "-" + code;
    }
}
```

</details>

---

## Ejercicio 7: Sobrecargar por orden de parámetros

Crea dos métodos `formatPair`:

- `formatPair(String left, int right)` → `"left: <left> | right: <right>"`
- `formatPair(int left, String right)` → `"left: <left> | right: <right>"`

Llama a ambos desde `main` para comprobar que Java elige la versión correcta.

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        System.out.println(formatPair("X", 10));
        System.out.println(formatPair(10, "X"));
    }

    public static String formatPair(String left, int right) {
        return "left: " + left + " | right: " + right;
    }

    public static String formatPair(int left, String right) {
        return "left: " + left + " | right: " + right;
    }
}
```

</details>

---

## Ejercicio 8: Sobrecarga y conversión implícita

Crea dos métodos `multiply`:

- `multiply(int a, int b)`
- `multiply(double a, double b)`

Llama a `multiply(3, 2.5)` desde `main` e imprime el resultado.  
Observa qué versión se usa y por qué.

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        System.out.println(multiply(3, 2.5));
    }

    public static int multiply(int a, int b) {
        return a * b;
    }

    public static double multiply(double a, double b) {
        return a * b;
    }
}
```

Se utiliza `multiply(double, double)` porque `2.5` es `double` y Java convierte `3` a `double`.

</details>

---

## Ejercicio 9: Evitar duplicar lógica usando una sobrecarga que llama a otra

Crea dos métodos `sum`:

- `sum(int a, int b)` debe llamar internamente a `sum(int a, int b, int c)` usando `0` como tercer valor
- `sum(int a, int b, int c)` devuelve la suma de los tres

Llama a ambos desde `main`.

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        System.out.println(sum(5, 6));
        System.out.println(sum(5, 6, 7));
    }

    public static int sum(int a, int b) {
        return sum(a, b, 0);
    }

    public static int sum(int a, int b, int c) {
        return a + b + c;
    }
}
```

</details>

---

## Ejercicio 10: Sobrecargar `calculateScore` con diferentes entradas

Crea dos métodos `calculateScore`:

- `calculateScore(int base)` devuelve `base * 10`
- `calculateScore(int base, int bonus)` devuelve `base * 10 + bonus`

Llama a ambos desde `main` y muestra los resultados.

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        System.out.println(calculateScore(7));
        System.out.println(calculateScore(7, 15));
    }

    public static int calculateScore(int base) {
        return base * 10;
    }

    public static int calculateScore(int base, int bonus) {
        return base * 10 + bonus;
    }
}
```

</details>

---
