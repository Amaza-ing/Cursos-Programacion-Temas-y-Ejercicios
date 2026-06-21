# Ejercicios - Tema 4: Conversión de tipos (Java)

A continuación, encontrarás **10 ejercicios prácticos** sobre conversión implícita, conversión explícita (casting), división entre enteros y conversión entre `String` y tipos numéricos.

Intenta resolverlos antes de consultar la solución.

---

## Ejercicio 1: Conversión implícita de `int` a `double`

Declara:

- Una variable `points` de tipo `int` con valor `7`
- Una variable `finalPoints` de tipo `double` que reciba el valor de `points`

Imprime `finalPoints`.

<details><summary>Mostrar Solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        int points = 7;
        double finalPoints = points;

        System.out.println(finalPoints);
    }
}
```

</details>

---

## Ejercicio 2: Conversión explícita de `double` a `int`

Declara:

- Una variable `price` de tipo `double` con valor `24.75`

Convierte ese valor a `int` y guárdalo en `roundedPrice`.  
Imprime `roundedPrice`.

<details><summary>Mostrar Solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        double price = 24.75;
        int roundedPrice = (int) price;

        System.out.println(roundedPrice);
    }
}
```

</details>

---

## Ejercicio 3: División entre enteros (detecta el problema)

Declara:

- `totalScore` con valor `5`
- `players` con valor `2`

Calcula la media **correcta** usando `double`.

<details><summary>Mostrar Solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        int totalScore = 5;
        int players = 2;

        double average = (double) totalScore / players;
        System.out.println(average);
    }
}
```

</details>

---

## Ejercicio 4: Casting en el lugar incorrecto

Este código no da el resultado esperado. Corrígelo:

```java
int a = 7;
int b = 2;

double result = (double) (a / b);
System.out.println(result);
```

<details><summary>Mostrar Solución</summary>

El problema es que la división ocurre antes del casting.

```java
int a = 7;
int b = 2;

double result = (double) a / b;
System.out.println(result);
```

</details>

---

## Ejercicio 5: Conversión de `char` a `int`

Declara:

- Un `char` llamado `symbol` con valor `'B'`

Convierte ese carácter a `int` y muestra el resultado.

<details><summary>Mostrar Solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        char symbol = 'B';
        int code = symbol;

        System.out.println(code);
    }
}
```

</details>

---

## Ejercicio 6: Conversión de `String` a `int`

Declara:

- Una variable `textValue` con valor `"15"`

Convierte el texto a número y calcula `textValue + 5`.

<details><summary>Mostrar Solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        String textValue = "15";
        int number = Integer.parseInt(textValue);

        System.out.println(number + 5);
    }
}
```

</details>

---

## Ejercicio 7: Conversión de `String` a `double`

Declara:

- `priceText` con valor `"9.99"`

Convierte el valor a `double` y multiplícalo por `2`.

<details><summary>Mostrar Solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        String priceText = "9.99";
        double price = Double.parseDouble(priceText);

        System.out.println(price * 2);
    }
}
```

</details>

---

## Ejercicio 8: Convertir un número a `String`

Declara:

- Una variable `level` de tipo `int` con valor `4`

Convierte ese valor a `String` y concaténalo con el texto `"Level: "`.

<details><summary>Mostrar Solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        int level = 4;
        String levelText = String.valueOf(level);

        System.out.println("Level: " + levelText);
    }
}
```

</details>

---

## Ejercicio 9: Casting peligroso

Declara:

- Un `int` con valor `130`

Haz un cast a `byte` y muestra el resultado.  
Reflexiona sobre por qué el valor no es el esperado.

<details><summary>Mostrar Solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        int value = 130;
        byte smallValue = (byte) value;

        System.out.println(smallValue);
    }
}
```

El resultado no es correcto porque `byte` solo admite valores entre -128 y 127.

</details>

---

## Ejercicio 10: Conversión combinada en una expresión

Declara:

- `hits` con valor `7`
- `attempts` con valor `3`

Calcula el porcentaje de aciertos como `double`.

Resultado esperado:

```
2.3333333333333335
```

<details><summary>Mostrar Solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        int hits = 7;
        int attempts = 3;

        double ratio = (double) hits / attempts;
        System.out.println(ratio);
    }
}
```

</details>

---
