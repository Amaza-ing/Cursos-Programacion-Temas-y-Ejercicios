# Exercises - Topic 31: Optional

Below you will find **10 practical exercises** to work with **Optional**: `ofNullable`, `empty`, `isPresent`, `ifPresent`, `orElse`, `orElseGet`, `orElseThrow`, `map`, `filter` and searches that may not return a result.

Try to solve them before looking at the solution.

---

## Exercise 1: Create an `Optional` with `ofNullable`

Declare a `String username = null` variable.

Create an `Optional<String>` using `Optional.ofNullable(username)` and print a default value using `orElse`.

The default value should be `"Guest"`.

<details><summary>Show solution</summary>

```java
import java.util.Optional;

public class Main {
    public static void main(String[] args) {
        String username = null;

        Optional<String> optionalUsername = Optional.ofNullable(username);

        System.out.println(optionalUsername.orElse("Guest"));
    }
}
```

</details>

---

## Exercise 2: Use `ifPresent`

Create an `Optional<String>` with the value `"Java"`.

Use `ifPresent` to print:

```text
Course: Java
```

<details><summary>Show solution</summary>

```java
import java.util.Optional;

public class Main {
    public static void main(String[] args) {
        Optional<String> course = Optional.of("Java");

        course.ifPresent(value -> System.out.println("Course: " + value));
    }
}
```

</details>

---

## Exercise 3: Method that returns `Optional`

Create a method:

```java
public static Optional<String> findEmail(String username)
```

It must return:

- `Optional.of("admin@example.com")` if `username` is `"admin"`
- `Optional.empty()` in any other case

Test the method from `main`.

<details><summary>Show solution</summary>

```java
import java.util.Optional;

public class Main {
    public static void main(String[] args) {
        Optional<String> email = findEmail("admin");

        System.out.println(email.orElse("Email not found"));
    }

    public static Optional<String> findEmail(String username) {
        if ("admin".equals(username)) {
            return Optional.of("admin@example.com");
        }

        return Optional.empty();
    }
}
```

</details>

---

## Exercise 4: Transform a value with `map`

Create an `Optional<String>` with the value `"java"`.

Use `map` to convert the text to uppercase and print the result with `orElse`.

<details><summary>Show solution</summary>

```java
import java.util.Optional;

public class Main {
    public static void main(String[] args) {
        Optional<String> text = Optional.of("java");

        String result = text.map(value -> value.toUpperCase())
                .orElse("EMPTY");

        System.out.println(result);
    }
}
```

</details>

---

## Exercise 5: Filter an `Optional<Integer>`

Create an `Optional<Integer>` with the value `17`.

Use `filter` to keep the value only if it is greater than or equal to `18`.

Then print:

- `"Adult"` if there is a value left
- `"Minor"` if it is empty

<details><summary>Show solution</summary>

```java
import java.util.Optional;

public class Main {
    public static void main(String[] args) {
        Optional<Integer> age = Optional.of(17);

        String result = age.filter(value -> value >= 18)
                .map(value -> "Adult")
                .orElse("Minor");

        System.out.println(result);
    }
}
```

</details>

---

## Exercise 6: `orElseGet`

Create an empty `Optional<String>`.

Use `orElseGet` to return `"Generated value"` as the default value.

<details><summary>Show solution</summary>

```java
import java.util.Optional;

public class Main {
    public static void main(String[] args) {
        Optional<String> value = Optional.empty();

        String result = value.orElseGet(() -> "Generated value");

        System.out.println(result);
    }
}
```

</details>

---

## Exercise 7: `orElseThrow`

Create a method:

```java
public static Optional<String> findToken()
```

It should return `Optional.empty()`.

From `main`, call the method and use `orElseThrow` to throw an exception with the message `"Token not found"`.

<details><summary>Show solution</summary>

```java
import java.util.Optional;

public class Main {
    public static void main(String[] args) {
        String token = findToken()
                .orElseThrow(() -> new IllegalArgumentException("Token not found"));

        System.out.println(token);
    }

    public static Optional<String> findToken() {
        return Optional.empty();
    }
}
```

</details>

---

## Exercise 8: Search for a product by code

Create a class `Product` with:

- `code`
- `name`

Create a list of products and a method:

```java
public static Optional<Product> findByCode(List<Product> products, String code)
```

It must return the first product with that code.

<details><summary>Show solution</summary>

```java
public class Product {
    private String code;
    private String name;

    public Product(String code, String name) {
        this.code = code;
        this.name = name;
    }

    public String getCode() {
        return code;
    }

    public String getName() {
        return name;
    }
}
```

```java
import java.util.List;
import java.util.Optional;

public class Main {
    public static void main(String[] args) {
        List<Product> products = List.of(
                new Product("P-1", "Mouse"),
                new Product("P-2", "Keyboard")
        );

        Optional<Product> product = findByCode(products, "P-2");

        product.ifPresent(value -> System.out.println(value.getName()));
    }

    public static Optional<Product> findByCode(List<Product> products, String code) {
        return products.stream()
                .filter(product -> product.getCode().equals(code))
                .findFirst();
    }
}
```

</details>

---

## Exercise 9: Chain `map` calls

Create a class `User` with:

- `name`
- `email`

Create an `Optional<User>` with a user.  
Use `map` to get the email in lowercase.

<details><summary>Show solution</summary>

```java
public class User {
    private String name;
    private String email;

    public User(String name, String email) {
        this.name = name;
        this.email = email;
    }

    public String getEmail() {
        return email;
    }
}
```

```java
import java.util.Optional;

public class Main {
    public static void main(String[] args) {
        Optional<User> user = Optional.of(new User("Laura", "LAURA@EXAMPLE.COM"));

        String email = user.map(value -> value.getEmail())
                .map(value -> value.toLowerCase())
                .orElse("no-email");

        System.out.println(email);
    }
}
```

</details>

---

## Exercise 10: Avoid unsafe `get()`
Create an empty `Optional<String>`.

Do not use `get()` directly.  
Check whether it has a value with `isPresent()` and:

- if it has a value, print it
- if it has no value, print `"No value"`

<details><summary>Show solution</summary>

```java
import java.util.Optional;

public class Main {
    public static void main(String[] args) {
        Optional<String> value = Optional.empty();

        if (value.isPresent()) {
            System.out.println(value.get());
        } else {
            System.out.println("No value");
        }
    }
}
```

</details>

---
