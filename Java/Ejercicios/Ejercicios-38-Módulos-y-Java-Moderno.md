# Ejercicios - Tema 38: Anotaciones

A continuación encontrarás **10 ejercicios prácticos** para trabajar con **anotaciones**: `@Override`, `@Deprecated`, `@SuppressWarnings`, `@FunctionalInterface`, creación de anotaciones propias, `@Retention`, `@Target` y lectura básica con reflexión.

Intenta resolverlos antes de consultar la solución.

---

## Ejercicio 1: Usar `@Override`

Crea una clase `BasePrinter` con un método `print()`.

Crea una clase `ConsolePrinter` que herede de `BasePrinter` y sobrescriba `print()` usando `@Override`.

<details><summary>Mostrar solución</summary>

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

## Ejercicio 2: Marcar un método como `@Deprecated`

Crea una clase `ReportService` con:

- método `generateOldReport()` marcado como `@Deprecated`
- método `generateNewReport()`

Desde `main`, llama a ambos métodos.

<details><summary>Mostrar solución</summary>

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

## Ejercicio 3: Usar `@SuppressWarnings`

Crea una clase `Main` con una variable local que no se use.

Aplica `@SuppressWarnings("unused")` al método `main`.

<details><summary>Mostrar solución</summary>

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

## Ejercicio 4: Crear una interfaz funcional

Crea una interfaz `TextFormatter` marcada con `@FunctionalInterface`.

Debe tener un único método abstracto:

```java
String format(String text);
```

En `main`, crea una lambda que convierta el texto a mayúsculas.

<details><summary>Mostrar solución</summary>

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

## Ejercicio 5: Crear una anotación simple

Crea una anotación propia llamada `Important`.

Después úsala sobre una clase `PaymentService`.

<details><summary>Mostrar solución</summary>

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

## Ejercicio 6: Anotación con un valor

Crea una anotación `Author` con un elemento:

```java
String name();
```

Úsala sobre una clase `Article`.

<details><summary>Mostrar solución</summary>

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

## Ejercicio 7: Anotación con `value`

Crea una anotación `Version` con un elemento llamado `value`.

Úsala de forma abreviada sobre una clase `ApiClient`.

<details><summary>Mostrar solución</summary>

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

## Ejercicio 8: Usar `@Retention` y `@Target`

Crea una anotación `RunNow` que:

- se conserve en tiempo de ejecución
- solo pueda aplicarse a métodos

<details><summary>Mostrar solución</summary>

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

## Ejercicio 9: Leer una anotación de una clase

Crea una anotación `Category` con:

- `RetentionPolicy.RUNTIME`
- un valor `String value()`

Anota una clase `BookService` con `@Category("books")`.

Desde `main`, lee la anotación con reflexión e imprime su valor.

<details><summary>Mostrar solución</summary>

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

## Ejercicio 10: Ejecutar métodos anotados

Crea una anotación `Execute` para métodos en tiempo de ejecución.

Crea una clase `JobService` con dos métodos:

- `clean()` anotado con `@Execute`
- `helper()` sin anotación

Desde `main`, usa reflexión para ejecutar solo los métodos anotados.

<details><summary>Mostrar solución</summary>

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
