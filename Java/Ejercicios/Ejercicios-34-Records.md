# Exercises - Topic 34: Records

Below you will find **10 practical exercises** to work with **records**: creating records, accessors, validation with a compact constructor, custom methods, normalization, automatic equality and using them with collections.

Try to solve them before looking at the solution.

---

## Exercise 1: Create a simple record

Create a `Movie` record with:

- `title` (`String`)
- `durationMinutes` (`int`)

In `main`, create a movie and print its two values using the record accessors.

<details><summary>Show solution</summary>

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

## Exercise 2: Use automatic `toString`

Create a `City` record with:

- `name`
- `country`

Create a city in `main` and directly print the object.

<details><summary>Show solution</summary>

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

## Exercise 3: Compare records with `equals`

Create a `Point` record with:

- `x`
- `y`

Create two points with the same values and check if they are equal using `equals`.

<details><summary>Show solution</summary>

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

## Exercise 4: Compact constructor with validation

Create a `Course` record with:

- `name`
- `hours`

Add a compact constructor that:

- throws `IllegalArgumentException` if `name` is `null` or blank
- throws `IllegalArgumentException` if `hours` is less than or equal to `0`

<details><summary>Show solution</summary>

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

## Exercise 5: Normalize values

Create an `EmailAddress` record with a `value` component.

In the compact constructor:

- remove the spaces at the beginning and end
- convert the email to lowercase

<details><summary>Show solution</summary>

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

## Exercise 6: Add custom methods

Create a `Circle` record with:

- `radius`

Add a method `area()` that returns the area using `Math.PI`.

<details><summary>Show solution</summary>

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

## Exercise 7: Record with a static method

Create a `UserProfile` record with:

- `username`
- `active`

Add a static method `guest()` that returns a user with:

- username: `"guest"`
- active: `false`

<details><summary>Show solution</summary>

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

## Exercise 8: Record in a list

Create a `Book` record with:

- `title`
- `pages`

In `main`, create a list of books and use `stream()` to get only the books with more than `300` pages.

<details><summary>Show solution</summary>

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

## Exercise 9: Create a modified copy

Create a `Task` record with:

- `id`
- `title`
- `completed`
Add a method `complete()` that returns a new, identical task, but with `completed = true`.

<details><summary>Show solution</summary>

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

## Exercise 10: Record implementing an interface

Create a `Printable` interface with a `print()` method.

Create an `Invoice` record with:

- `number`
- `total`

Have it implement `Printable` and print:

```text
Invoice number | Total: total
```

<details><summary>Show solution</summary>

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
