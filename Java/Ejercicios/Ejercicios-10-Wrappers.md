# Ejercicios - Tema 10: Wrappers de tipos de datos primitivos

Below you will find **10 practical exercises** to work with **wrappers**, autoboxing, unboxing, `parseXxx`, `valueOf`, comparison and handling of `null`.

Try to solve them before consulting the solution.

---

## Exercise 1: Basic Autoboxing

Declara una variable primitiva `int` con valor `10` y asígnala a una variable `Integer` usando autoboxing.  
Prints the value of the wrapper.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        int number = 10;
        Integer boxed = number;

        System.out.println(boxed);
    }
}
```

</details>

---

## Exercise 2: Basic Unboxing

Declara una variable `Integer` con valor `25` y asígnala a una variable `int` usando unboxing.  
Print the primitive value.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        Integer boxed = 25;
        int number = boxed;

        System.out.println(number);
    }
}
```

</details>

---

## Exercise 3: Convert text to integer

Declare a variable `text` with value `"42"`.

Convierte el texto a `int` usando `Integer.parseInt` y suma `8` al resultado.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        String text = "42";

        int value = Integer.parseInt(text);
        System.out.println(value + 8);
    }
}
```

</details>

---

## Exercise 4: Convert text to `Double`

Declares a variable `priceText` with value `"19.99"`.

Convierte el texto a `Double` usando `Double.valueOf` y muestra el valor.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        String priceText = "19.99";

        Double price = Double.valueOf(priceText);
        System.out.println(price);
    }
}
```

</details>

---

## Exercise 5: Compare wrappers correctly

Declara dos variables `Integer` con valor `100`.

- Compare values using `equals`
- Print the result

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        Integer a = 100;
        Integer b = 100;

        System.out.println(a.equals(b));
    }
}
```

</details>

---

## Exercise 6: Avoid `NullPointerException`

Declara una variable `Integer` llamada `age` con valor `null`.

Comprueba si es `null` antes de intentar convertirla a `int`.  
If it is `null`, print `"No age provided"`.

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        Integer age = null;

        if (age == null) {
            System.out.println("No age provided");
        } else {
            int value = age;
            System.out.println(value);
        }
    }
}
```

</details>

---

## Ejercicio 7: Usar constantes `MIN_VALUE` y `MAX_VALUE`

Print via console:

- The minimum value of `Integer`
- The maximum value of `Integer`

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        System.out.println(Integer.MIN_VALUE);
        System.out.println(Integer.MAX_VALUE);
    }
}
```

</details>

---

## Exercise 8: Compare with `compareTo`

Declara dos variables `Integer` con valores `15` y `30`.

Usa `compareTo` para comparar ambos valores e imprime el resultado.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        Integer a = 15;
        Integer b = 30;

        System.out.println(a.compareTo(b));
    }
}
```

</details>

---

## Exercise 9: Validate characters with `Character`

Declare a variable `char` with value `'7'`.

Usa `Character.isDigit` para comprobar si es un dígito e imprime el resultado.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        char c = '7';

        boolean isDigit = Character.isDigit(c);
        System.out.println(isDigit);
    }
}
```

</details>

---

## Exercise 10: Convert number to text

Declara una variable `int` con valor `50`.

Convert the number to `String` using `String.valueOf` and print the result.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        int value = 50;

        String text = String.valueOf(value);
        System.out.println(text);
    }
}
```

</details>
---
