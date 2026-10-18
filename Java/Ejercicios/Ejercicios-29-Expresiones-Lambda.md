# Exercises - Topic 29: Lambda Expressions

Below you will find **10 practical exercises** to work with **lambdas, functional interfaces, `Predicate`, `Function`, `Consumer`, `Supplier`, `removeIf`, `sort` and method references**.

Try to solve them before looking at the solution.

---

## Exercise 1: Functional interface

Create `MessagePrinter` and implement it with a lambda.

<details><summary>Show solution</summary>

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

## Exercise 2: Two parameters

Create `Multiplier` with a lambda.

<details><summary>Show solution</summary>

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

## Exercise 3: Lambda block

Trim the spaces and convert to uppercase.

<details><summary>Show solution</summary>

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

## Exercise 4: `Predicate`

Check whether an age is that of an adult.

<details><summary>Show solution</summary>

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

## Exercise 5: `Function`

Create a function that returns a greeting.

<details><summary>Show solution</summary>

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

## Exercise 6: `Consumer`

Print a price.

<details><summary>Show solution</summary>

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

## Exercise 7: `Supplier`

Return a generated code.

<details><summary>Show solution</summary>

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

## Exercise 8: `removeIf`

Remove negative numbers.

<details><summary>Show solution</summary>

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

## Exercise 9: Sort

Sort words by length.

<details><summary>Show solution</summary>

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

## Exercise 10: Method reference

Print names with `System.out::println`.

<details><summary>Show solution</summary>

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
