# Ejercicios - Tema 2: Variables y tipos de datos (Java)

A continuación, encontrarás **10 ejercicios prácticos** sobre variables, tipos primitivos, `String`, constantes y buenas prácticas de nombrado.

Intenta resolverlos antes de consultar la solución.

---

## Ejercicio 1: Declaración e inicialización de variables básicas

Crea un programa con estas variables (elige tipos correctos):

- `userName` (nombre de usuario) con el valor `"Laura"`
- `userAge` (edad) con el valor `28`
- `heightMeters` (altura en metros) con el valor `1.67`
- `hasDrivingLicense` con el valor `true`
- `favoriteLetter` con el valor `'L'`

Imprime cada variable en una línea distinta.

<details><summary>Mostrar Solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        String userName = "Laura";
        int userAge = 28;
        double heightMeters = 1.67;
        boolean hasDrivingLicense = true;
        char favoriteLetter = 'L';

        System.out.println(userName);
        System.out.println(userAge);
        System.out.println(heightMeters);
        System.out.println(hasDrivingLicense);
        System.out.println(favoriteLetter);
    }
}
```

</details>

---

## Ejercicio 2: Elegir el tipo correcto

Declara e inicializa variables con el tipo más adecuado:

- `minutesInHour` con el valor `60`
- `piApprox` con el valor `3.1416`
- `isWeekend` con el valor `false`
- `worldPopulation` con el valor `8_000_000_000`

Imprime todas en consola.

<details><summary>Mostrar Solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        int minutesInHour = 60;
        double piApprox = 3.1416;
        boolean isWeekend = false;
        long worldPopulation = 8_000_000_000L;

        System.out.println(minutesInHour);
        System.out.println(piApprox);
        System.out.println(isWeekend);
        System.out.println(worldPopulation);
    }
}
```

</details>

---

## Ejercicio 3: Modificar una variable paso a paso

Crea una variable `lives` con valor inicial `3`.

- Resta 1 vida (debe quedar en 2)
- Resta 1 vida (debe quedar en 1)
- Suma 2 vidas (debe quedar en 3)

Imprime el valor final de `lives`.

<details><summary>Mostrar Solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        int lives = 3;

        lives = lives - 1;
        lives = lives - 1;
        lives = lives + 2;

        System.out.println(lives); // 3
    }
}
```

</details>

---

## Ejercicio 4: Concatenación con texto (evita resultados confusos)

Crea estas variables:

- `productName` con valor `"Keyboard"`
- `unitPrice` con valor `29.99`
- `quantity` con valor `2`

Imprime una frase como esta (mismo formato, pero con tus variables):

```
Product: Keyboard | Units: 2 | Total: 59.98
```

Pista: calcula `total` antes de imprimir.

<details><summary>Mostrar Solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        String productName = "Keyboard";
        double unitPrice = 29.99;
        int quantity = 2;

        double total = unitPrice * quantity;

        System.out.println("Product: " + productName + " | Units: " + quantity + " | Total: " + total);
    }
}
```

</details>

---

## Ejercicio 5: `char` vs `String` (corrige los tipos)

Este código tiene errores de tipo. Corrígelo para que compile y mantenga el mismo significado:

```java
public class Main {
    public static void main(String[] args) {
        char middleName = "A";
        String grade = 'B';

        System.out.println(middleName);
        System.out.println(grade);
    }
}
```

<details><summary>Mostrar Solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        char middleName = 'A';
        String grade = "B";

        System.out.println(middleName);
        System.out.println(grade);
    }
}
```

</details>

---

## Ejercicio 6: Constantes con `final`

Crea un programa que defina:

- Una constante `MAX_ATTEMPTS` con valor `5`
- Una variable `attempts` con valor inicial `0`

Imprime:

- `MAX_ATTEMPTS`
- `attempts`

Después, incrementa `attempts` a `1` e imprime de nuevo `attempts`.

<details><summary>Mostrar Solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        final int MAX_ATTEMPTS = 5;
        int attempts = 0;

        System.out.println(MAX_ATTEMPTS);
        System.out.println(attempts);

        attempts = 1;
        System.out.println(attempts);
    }
}
```

</details>

---

## Ejercicio 7: Nombres de variables (refactor para buenas prácticas)

Reescribe este código para que los nombres sean más claros usando **camelCase** y significado real:

```java
public class Main {
    public static void main(String[] args) {
        int a = 35;
        double b = 120.5;
        boolean c = true;

        System.out.println(a);
        System.out.println(b);
        System.out.println(c);
    }
}
```

Mantén los valores, pero cambia los nombres por otros más descriptivos.

<details><summary>Mostrar Solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        int userAge = 35;
        double accountBalance = 120.5;
        boolean isPremiumUser = true;

        System.out.println(userAge);
        System.out.println(accountBalance);
        System.out.println(isPremiumUser);
    }
}
```

</details>

---

## Ejercicio 8: Separadores numéricos para legibilidad

Declara una variable `annualBudget` con valor `2500000` pero escrita usando guiones bajos para que sea más legible.

Imprime el valor por consola.

<details><summary>Mostrar Solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        int annualBudget = 2_500_000;

        System.out.println(annualBudget);
    }
}
```

</details>

---

## Ejercicio 9: Variable local sin inicializar (detecta y corrige el error)

Este programa no compila. Corrígelo **sin cambiar el tipo** de la variable:

```java
public class Main {
    public static void main(String[] args) {
        int points;
        System.out.println(points);
    }
}
```

<details><summary>Mostrar Solución</summary>

En Java, una variable local debe inicializarse antes de usarse:

```java
public class Main {
    public static void main(String[] args) {
        int points = 0;
        System.out.println(points);
    }
}
```

</details>

---

## Ejercicio 10: Crear un “perfil” con tipos variados (sin copiar el ejemplo del tema)

Declara variables para representar un perfil sencillo:

- `nickName` (texto)
- `level` (entero)
- `accuracyRate` (decimal)
- `isOnline` (boolean)
- `rankLetter` (char)

Asigna valores inventados y muestra una salida como esta (mismo estilo, con tus datos):

```
Nick: Neo | Level: 12 | Accuracy: 0.83 | Online: true | Rank: S
```

<details><summary>Mostrar Solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        String nickName = "Neo";
        int level = 12;
        double accuracyRate = 0.83;
        boolean isOnline = true;
        char rankLetter = 'S';

        System.out.println(
            "Nick: " + nickName +
            " | Level: " + level +
            " | Accuracy: " + accuracyRate +
            " | Online: " + isOnline +
            " | Rank: " + rankLetter
        );
    }
}
```

</details>

---
