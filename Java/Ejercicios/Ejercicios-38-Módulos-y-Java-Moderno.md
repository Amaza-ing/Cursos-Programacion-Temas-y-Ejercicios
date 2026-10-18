# Exercises - Topic 38: Notes

Below you will find **10 practical exercises** to work with **annotations**: `@Override`, `@Deprecated`, `@SuppressWarnings`, `@FunctionalInterface`, creating your own annotations, `@Retention`, `@Target` and basic reading with reflection.

Try to solve them before consulting the solution.

---

## Exercise 1: Use `@Override`

Create an `BasePrinter` class with an `print()` method.

Create a class `ConsolePrinter` that inherits from `BasePrinter` and overrides `print()` using `@Override`.

<details><summary>Show solution</summary>

```java
public class BasePrinter {
    public void print() {
        System.out.println("Base print");
    }
}
```

```java
public class ConsolePrinter extends BasePrinter {
    @Override
    public void print() {
        System.out.println("Console print");
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        BasePrinter printer = new ConsolePrinter();

        printer.print();
    }
}
```

</details>

---

## Exercise 2: Mark a method as `@Deprecated`

Create a class `ReportService` with:

- method `generateOldReport()` marked as `@Deprecated`
- `generateNewReport()` method

From `main`, call both methods.

<details><summary>Show solution</summary>

```java
public class ReportService {
    @Deprecated
    public void generateOldReport() {
        System.out.println("Old report");
    }

    public void generateNewReport() {
        System.out.println("New report");
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        ReportService service = new ReportService();

        service.generateOldReport();
        service.generateNewReport();
    }
}
```

</details>

---

## Exercise 3: Use `@SuppressWarnings`

Create a class `Main` with an unused local variable.

Applies `@SuppressWarnings("unused")` to the `main` method.

<details><summary>Show solution</summary>

```java
public class Main {
    @SuppressWarnings("unused")
    public static void main(String[] args) {
        String message = "This variable is not used";

        System.out.println("Program running");
    }
}
```

</details>

---

## Exercise 4: Create a functional interface

Creates an `TextFormatter` interface marked `@FunctionalInterface`.

You must have a single abstract method:

```java
String format(String text);
```

In `main`, create a lambda that converts the text to uppercase.

<details><summary>Show solution</summary>

```java
@FunctionalInterface
public interface TextFormatter {
    String format(String text);
}
```

```java
public class Main {
    public static void main(String[] args) {
        TextFormatter formatter = text -> text.toUpperCase();

        System.out.println(formatter.format("java"));
    }
}
```

</details>

---

## Exercise 5: Create a simple annotation

Create your own annotation called `Important`.

Then use it on an `PaymentService` class.

<details><summary>Show solution</summary>

```java
public @interface Important {
}
```

```java
@Important
public class PaymentService {
}
```

</details>

---

## Exercise 6: Annotation with a value

Create an `Author` annotation with an element:

```java
String name();
```

Use it on an `Article` class.

<details><summary>Show solution</summary>

```java
public @interface Author {
    String name();
}
```

```java
@Author(name = "Laura")
public class Article {
}
```

</details>

---

## Exercise 7: Annotation with `value`

Create an `Version` annotation with an element named `value`.

Use it as a shorthand on an `ApiClient` class.

<details><summary>Show solution</summary>

```java
public @interface Version {
    String value();
}
```

```java
@Version("1.0")
public class ApiClient {
}
```

</details>

---

## Exercise 8: Using `@Retention` and `@Target`

Create an `RunNow` annotation that:

- is preserved at runtime
- can only be applied to methods

<details><summary>Show solution</summary>

```java
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.METHOD)
public @interface RunNow {
}
```

</details>

---

## Exercise 9: Read an annotation of a class

Create an `Category` annotation with:

- `RetentionPolicy.RUNTIME`
- an `String value()` value

Annotate a class `BookService` with `@Category("books")`.

From `main`, read the annotation with reflection and print its value.

<details><summary>Show solution</summary>

```java
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

@Retention(RetentionPolicy.RUNTIME)
public @interface Category {
    String value();
}
```

```java
@Category("books")
public class BookService {
}
```

```java
public class Main {
    public static void main(String[] args) {
        Category category = BookService.class.getAnnotation(Category.class);

        if (category != null) {
            System.out.println(category.value());
        }
    }
}
```

</details>

---

## Exercise 10: Execute annotated methods

Creates an `Execute` annotation for methods at runtime.
Create a class `JobService` with two methods:

- `clean()` annotated with `@Execute`
- `helper()` without annotation

From `main`, use reflection to execute only the annotated methods.

<details><summary>Show solution</summary>

```java
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.METHOD)
public @interface Execute {
}
```

```java
public class JobService {
    @Execute
    public void clean() {
        System.out.println("Cleaning...");
    }

    public void helper() {
        System.out.println("Helper...");
    }
}
```

```java
import java.lang.reflect.Method;

public class Main {
    public static void main(String[] args) {
        JobService service = new JobService();

        for (Method method : JobService.class.getDeclaredMethods()) {
            if (method.isAnnotationPresent(Execute.class)) {
                try {
                    method.invoke(service);
                } catch (Exception e) {
                    System.out.println("Could not execute method");
                }
            }
        }
    }
}
```

</details>

---
