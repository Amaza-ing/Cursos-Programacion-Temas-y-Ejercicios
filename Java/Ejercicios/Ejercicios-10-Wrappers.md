# Ejercicios - Tema 10: Wrappers de tipos de datos primitivos

A continuación encontrarás **10 ejercicios prácticos** para trabajar con **wrappers**, autoboxing, unboxing, `parseXxx`, `valueOf`, comparación y manejo de `null`.

Intenta resolverlos antes de consultar la solución.

---

## Ejercicio 1: Autoboxing básico

Declara una variable primitiva `int` con valor `10` y asígnala a una variable `Integer` usando autoboxing.  
Imprime el valor del wrapper.

<details><summary>Mostrar solución</summary>

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

## Ejercicio 2: Unboxing básico

Declara una variable `Integer` con valor `25` y asígnala a una variable `int` usando unboxing.  
Imprime el valor primitivo.

<details><summary>Mostrar solución</summary>

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

## Ejercicio 3: Convertir texto a entero

Declara una variable `text` con valor `"42"`.

Convierte el texto a `int` usando `Integer.parseInt` y suma `8` al resultado.

<details><summary>Mostrar solución</summary>

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

## Ejercicio 4: Convertir texto a `Double`

Declara una variable `priceText` con valor `"19.99"`.

Convierte el texto a `Double` usando `Double.valueOf` y muestra el valor.

<details><summary>Mostrar solución</summary>

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

## Ejercicio 5: Comparar wrappers correctamente

Declara dos variables `Integer` con valor `100`.

- Compara los valores usando `equals`
- Imprime el resultado

<details><summary>Mostrar solución</summary>

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

## Ejercicio 6: Evitar `NullPointerException`

Declara una variable `Integer` llamada `age` con valor `null`.

Comprueba si es `null` antes de intentar convertirla a `int`.  
Si es `null`, imprime `"No age provided"`.

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

Imprime por consola:

- El valor mínimo de `Integer`
- El valor máximo de `Integer`

<details><summary>Mostrar solución</summary>

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

## Ejercicio 8: Comparar con `compareTo`

Declara dos variables `Integer` con valores `15` y `30`.

Usa `compareTo` para comparar ambos valores e imprime el resultado.

<details><summary>Mostrar solución</summary>

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

## Ejercicio 9: Validar caracteres con `Character`

Declara una variable `char` con valor `'7'`.

Usa `Character.isDigit` para comprobar si es un dígito e imprime el resultado.

<details><summary>Mostrar solución</summary>

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

## Ejercicio 10: Convertir número a texto

Declara una variable `int` con valor `50`.

Convierte el número a `String` usando `String.valueOf` e imprime el resultado.

<details><summary>Mostrar solución</summary>

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
