# Ejercicios - Tema 29: Expresiones Lambda

A continuación encontrarás **10 ejercicios prácticos** para trabajar con **lambdas, interfaces funcionales, `Predicate`, `Function`, `Consumer`, `Supplier`, `removeIf`, `sort` y method references**.

Intenta resolverlos antes de consultar la solución.

---

## Ejercicio 1: Interfaz funcional

Crea `MessagePrinter` e impleméntala con lambda.

<details><summary>Mostrar solución</summary>

```java
@FunctionalInterface
public interface MessagePrinter {
    void print(String message);
}

public class Main {
    public static void main(String[] args) {
        MessagePrinter printer = message -> System.out.println("Message: " + message);
        printer.print("Learning lambdas");
    }
}
```

</details>

---

## Ejercicio 2: Dos parámetros

Crea `Multiplier` con lambda.

<details><summary>Mostrar solución</summary>

```java
@FunctionalInterface
public interface Multiplier {
    int multiply(int a, int b);
}

public class Main {
    public static void main(String[] args) {
        Multiplier multiplier = (a, b) -> a * b;
        System.out.println(multiplier.multiply(6, 7));
    }
}
```

</details>

---

## Ejercicio 3: Bloque lambda

Limpia espacios y convierte a mayúsculas.

<details><summary>Mostrar solución</summary>

```java
@FunctionalInterface
public interface TextFormatter {
    String format(String text);
}

public class Main {
    public static void main(String[] args) {
        TextFormatter formatter = text -> {
            String cleanText = text.trim();
            return cleanText.toUpperCase();
        };
        System.out.println(formatter.format("  java  "));
    }
}
```

</details>

---

## Ejercicio 4: `Predicate`

Comprueba si una edad es adulta.

<details><summary>Mostrar solución</summary>

```java
import java.util.function.Predicate;

public class Main {
    public static void main(String[] args) {
        Predicate<Integer> isAdultAge = age -> age >= 18;
        System.out.println(isAdultAge.test(20));
    }
}
```

</details>

---

## Ejercicio 5: `Function`

Crea una función que devuelva un saludo.

<details><summary>Mostrar solución</summary>

```java
import java.util.function.Function;

public class Main {
    public static void main(String[] args) {
        Function<String, String> greeter = name -> "Hello, " + name;
        System.out.println(greeter.apply("Laura"));
    }
}
```

</details>

---

## Ejercicio 6: `Consumer`

Imprime un precio.

<details><summary>Mostrar solución</summary>

```java
import java.util.function.Consumer;

public class Main {
    public static void main(String[] args) {
        Consumer<Double> printer = price -> System.out.println("Price: " + price);
        printer.accept(19.99);
    }
}
```

</details>

---

## Ejercicio 7: `Supplier`

Devuelve un código generado.

<details><summary>Mostrar solución</summary>

```java
import java.util.function.Supplier;

public class Main {
    public static void main(String[] args) {
        Supplier<String> supplier = () -> "Generated code";
        System.out.println(supplier.get());
    }
}
```

</details>

---

## Ejercicio 8: `removeIf`

Elimina números negativos.

<details><summary>Mostrar solución</summary>

```java
import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<Integer> numbers = new ArrayList<>(List.of(10, -3, 5, -8));
        numbers.removeIf(number -> number < 0);
        System.out.println(numbers);
    }
}
```

</details>

---

## Ejercicio 9: Ordenar

Ordena palabras por longitud.

<details><summary>Mostrar solución</summary>

```java
import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> words = new ArrayList<>(List.of("java", "lambda", "api"));
        words.sort((a, b) -> Integer.compare(a.length(), b.length()));
        System.out.println(words);
    }
}
```

</details>

---

## Ejercicio 10: Method reference

Imprime nombres con `System.out::println`.

<details><summary>Mostrar solución</summary>

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> names = List.of("Laura", "Alex", "Maria");
        names.forEach(System.out::println);
    }
}
```

</details>

---
