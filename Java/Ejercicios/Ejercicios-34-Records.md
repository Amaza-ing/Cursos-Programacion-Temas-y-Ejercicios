# Ejercicios - Tema 34: Records

A continuación encontrarás **10 ejercicios prácticos** para trabajar con **records**: creación de records, accesores, validación con constructor compacto, métodos propios, normalización, igualdad automática y uso con colecciones.

Intenta resolverlos antes de consultar la solución.

---

## Ejercicio 1: Crear un record simple

Crea un record `Movie` con:

- `title` (`String`)
- `durationMinutes` (`int`)

En `main`, crea una película e imprime sus dos valores usando los accesores del record.

<details><summary>Mostrar solución</summary>

```java
public record Movie(String title, int durationMinutes) {
}
```

```java
public class Main {
    public static void main(String[] args) {
        Movie movie = new Movie("Interstellar", 169);

        System.out.println(movie.title());
        System.out.println(movie.durationMinutes());
    }
}
```

</details>

---

## Ejercicio 2: Usar `toString` automático

Crea un record `City` con:

- `name`
- `country`

Crea una ciudad en `main` e imprime directamente el objeto.

<details><summary>Mostrar solución</summary>

```java
public record City(String name, String country) {
}
```

```java
public class Main {
    public static void main(String[] args) {
        City city = new City("Madrid", "Spain");

        System.out.println(city);
    }
}
```

</details>

---

## Ejercicio 3: Comparar records con `equals`

Crea un record `Point` con:

- `x`
- `y`

Crea dos puntos con los mismos valores y comprueba si son iguales usando `equals`.

<details><summary>Mostrar solución</summary>

```java
public record Point(int x, int y) {
}
```

```java
public class Main {
    public static void main(String[] args) {
        Point p1 = new Point(10, 20);
        Point p2 = new Point(10, 20);

        System.out.println(p1.equals(p2));
    }
}
```

</details>

---

## Ejercicio 4: Constructor compacto con validación

Crea un record `Course` con:

- `name`
- `hours`

Añade un constructor compacto que:

- lance `IllegalArgumentException` si `name` es `null` o está en blanco
- lance `IllegalArgumentException` si `hours` es menor o igual que `0`

<details><summary>Mostrar solución</summary>

```java
public record Course(String name, int hours) {
    public Course {
        if (name == null || name.isBlank()) {
            throw new IllegalArgumentException("Name cannot be blank");
        }

        if (hours <= 0) {
            throw new IllegalArgumentException("Hours must be positive");
        }
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        Course course = new Course("Java", 40);

        System.out.println(course);
    }
}
```

</details>

---

## Ejercicio 5: Normalizar valores

Crea un record `EmailAddress` con un componente `value`.

En el constructor compacto:

- elimina espacios al principio y al final
- convierte el email a minúsculas

<details><summary>Mostrar solución</summary>

```java
public record EmailAddress(String value) {
    public EmailAddress {
        if (value == null || value.isBlank()) {
            throw new IllegalArgumentException("Email cannot be blank");
        }

        value = value.trim().toLowerCase();
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        EmailAddress email = new EmailAddress("  USER@EXAMPLE.COM  ");

        System.out.println(email.value());
    }
}
```

</details>

---

## Ejercicio 6: Añadir métodos propios

Crea un record `Circle` con:

- `radius`

Añade un método `area()` que devuelva el área usando `Math.PI`.

<details><summary>Mostrar solución</summary>

```java
public record Circle(double radius) {
    public Circle {
        if (radius <= 0) {
            throw new IllegalArgumentException("Radius must be positive");
        }
    }

    public double area() {
        return Math.PI * radius * radius;
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        Circle circle = new Circle(3);

        System.out.println(circle.area());
    }
}
```

</details>

---

## Ejercicio 7: Record con método estático

Crea un record `UserProfile` con:

- `username`
- `active`

Añade un método estático `guest()` que devuelva un usuario con:

- username: `"guest"`
- active: `false`

<details><summary>Mostrar solución</summary>

```java
public record UserProfile(String username, boolean active) {
    public static UserProfile guest() {
        return new UserProfile("guest", false);
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        UserProfile profile = UserProfile.guest();

        System.out.println(profile);
    }
}
```

</details>

---

## Ejercicio 8: Record en una lista

Crea un record `Book` con:

- `title`
- `pages`

En `main`, crea una lista de libros y usa `stream()` para obtener solo los libros con más de `300` páginas.

<details><summary>Mostrar solución</summary>

```java
public record Book(String title, int pages) {
}
```

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<Book> books = List.of(
                new Book("Java Basics", 250),
                new Book("Advanced Java", 450),
                new Book("Clean Code", 380)
        );

        List<Book> longBooks = books.stream()
                .filter(book -> book.pages() > 300)
                .toList();

        System.out.println(longBooks);
    }
}
```

</details>

---

## Ejercicio 9: Crear una copia modificada

Crea un record `Task` con:

- `id`
- `title`
- `completed`

Añade un método `complete()` que devuelva una nueva tarea igual, pero con `completed = true`.

<details><summary>Mostrar solución</summary>

```java
public record Task(int id, String title, boolean completed) {
    public Task complete() {
        return new Task(id, title, true);
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        Task task = new Task(1, "Practice records", false);

        Task completedTask = task.complete();

        System.out.println(task);
        System.out.println(completedTask);
    }
}
```

</details>

---

## Ejercicio 10: Record implementando una interfaz

Crea una interfaz `Printable` con un método `print()`.

Crea un record `Invoice` con:

- `number`
- `total`

Haz que implemente `Printable` e imprima:

```text
Invoice number | Total: total
```

<details><summary>Mostrar solución</summary>

```java
public interface Printable {
    void print();
}
```

```java
public record Invoice(String number, double total) implements Printable {
    @Override
    public void print() {
        System.out.println("Invoice " + number + " | Total: " + total);
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        Printable invoice = new Invoice("INV-1", 199.99);

        invoice.print();
    }
}
```

</details>

---
