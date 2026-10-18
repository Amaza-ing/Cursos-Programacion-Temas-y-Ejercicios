# Topic 31. `Optional`

## 1. Introduction

In Java it is very common to work with values that may or may not exist.

For example:

- looking up a user by their id
- getting the first product in a list
- reading an optional setting
- searching for a word in a text
- finding a result that may not be available

For a long time, a common way of representing “no value” has been to use `null`.

Example:

```java
User user = findUserById(1);

if (user != null) {
    System.out.println(user.getName());
}
```

This works, but it has a well-known problem:

> If you forget to check whether the value is `null`, you may get a `NullPointerException`.

To help you work better with values that may be present or absent, Java includes a class called:

- `Optional`

In this topic you will learn:

- What problem `Optional` solves
- What `Optional<T>` is
- How to create an `Optional`
- How to check whether it contains a value
- How to get the value safely
- Methods like `orElse`, `orElseGet`, `orElseThrow`
- How to use `ifPresent`
- How to transform values with `map`
- How to chain operations with `flatMap`
- How to use `Optional` with `Stream API`
- Typical mistakes and good practices

---

## 2. The `null` problem

`null` means that a variable does not point to any object.

Example:

```java
String name = null;
```

If you try to call a method on that variable, the program fails.

```java
String name = null;

System.out.println(name.length()); // NullPointerException
```

This error is very common in Java.

---

## 3. Typical example with `null`

Imagine a method that looks up a user.

```java
public static User findUserById(int id) {
    if (id == 1) {
        return new User("Laura");
    }

    return null;
}
```

Usage:

```java
User user = findUserById(2);

System.out.println(user.getName()); // NullPointerException
```

The method can return a user or it can return `null`.

The problem is that whoever uses the method has to remember to check it.

---

## 4. The classic solution: checking for `null`

```java
User user = findUserById(2);

if (user != null) {
    System.out.println(user.getName());
} else {
    System.out.println("User not found");
}
```

This is correct, but it has some drawbacks:

- it depends on you remembering to check
- it can fill your code with `if (x != null)`
- the type does not clearly state that the value may be missing

This is where `Optional` comes in.

---

## 5. What is `Optional`

`Optional<T>` is a wrapper class that can have:

- a value of type `T`
- or no value

Conceptual example:

```java
Optional<String>
```

It can represent:

- a `String` that is present
- or the absence of a `String`

The important idea is:

> `Optional` makes explicit that a value may or may not be present.

---

## 6. Required import

`Optional` is in the `java.util` package.

```java
import java.util.Optional;
```

---

## 7. Creating an `Optional` with a value: `Optional.of`

If you have a value that you know is not `null`, you can use `Optional.of`.

```java
import java.util.Optional;

public class Main {
    public static void main(String[] args) {
        Optional<String> name = Optional.of("Laura");

        System.out.println(name);
    }
}
```

Result:

```text
Optional[Laura]
```

### 7.1. Beware of `Optional.of(null)`

This throws an error:

```java
// Optional<String> name = Optional.of(null); // NullPointerException
```

Use `Optional.of` only when you know the value is not `null`.

---

## 8. Creating an empty `Optional`: `Optional.empty`

If you want to represent the absence of a value, use `Optional.empty`.

```java
import java.util.Optional;

public class Main {
    public static void main(String[] args) {
        Optional<String> name = Optional.empty();

        System.out.println(name);
    }
}
```

Result:

```text
Optional.empty
```

---

## 9. Creating an `Optional` that can receive `null`: `Optional.ofNullable`

If you have a value that can be `null`, use `Optional.ofNullable`.

```java
import java.util.Optional;

public class Main {
    public static void main(String[] args) {
        String text = null;

        Optional<String> optionalText = Optional.ofNullable(text);

        System.out.println(optionalText);
    }
}
```

Result:

```text
Optional.empty
```

If the value is not `null`:

```java
String text = "Java";

Optional<String> optionalText = Optional.ofNullable(text);

System.out.println(optionalText);
```

Result:

```text
Optional[Java]
```

---

## 10. Summary of the ways to create an `Optional`

### 10.1. A value that is definitely not null

```java
Optional<String> name = Optional.of("Laura");
```

### 10.2. No value

```java
Optional<String> name = Optional.empty();
```

### 10.3. A value that can be `null`

```java
Optional<String> name = Optional.ofNullable(possibleNullValue);
```

---

## 11. Checking whether there is a value: `isPresent`

`isPresent` returns `true` if the `Optional` contains a value.

```java
import java.util.Optional;

public class Main {
    public static void main(String[] args) {
        Optional<String> name = Optional.of("Laura");

        if (name.isPresent()) {
            System.out.println("There is a value");
        }
    }
}
```

---

## 12. Checking whether it is empty: `isEmpty`

`isEmpty` returns `true` if the `Optional` contains no value.

```java
import java.util.Optional;

public class Main {
    public static void main(String[] args) {
        Optional<String> name = Optional.empty();

        if (name.isEmpty()) {
            System.out.println("There is no value");
        }
    }
}
```

---

## 13. Getting the value with `get`

`get` returns the value of the `Optional`, but only if it exists.

```java
Optional<String> name = Optional.of("Laura");

System.out.println(name.get());
```

Result:

```text
Laura
```

But if the `Optional` is empty:

```java
Optional<String> name = Optional.empty();

// System.out.println(name.get()); // NoSuchElementException
```

That's why `get` should be used very carefully.

---

## 14. The problem with overusing `get`

This is not good practice:

```java
if (name.isPresent()) {
    System.out.println(name.get());
}
```

Although it works, there are often cleaner ways to work with `Optional`.

For example:

- `ifPresent`
- `orElse`
- `orElseGet`
- `orElseThrow`
- `map`

---

## 15. Running an action if there is a value: `ifPresent`

`ifPresent` runs an action only if the value exists.

```java
import java.util.Optional;

public class Main {
    public static void main(String[] args) {
        Optional<String> name = Optional.of("Laura");

        name.ifPresent(value -> System.out.println(value));
    }
}
```

With a method reference:

```java
name.ifPresent(System.out::println);
```

If the `Optional` is empty, nothing happens.

---

## 16. Running an action if there is a value or if it is empty: `ifPresentOrElse`

`ifPresentOrElse` lets you specify:

- what to do if there is a value
- what to do if there is no value

```java
import java.util.Optional;

public class Main {
    public static void main(String[] args) {
        Optional<String> name = Optional.empty();

        name.ifPresentOrElse(
                value -> System.out.println("Name: " + value),
                () -> System.out.println("No name found")
        );
    }
}
```

---

## 17. Default value: `orElse`

`orElse` returns:

- the actual value if it exists
- a default value if it does not exist

```java
import java.util.Optional;

public class Main {
    public static void main(String[] args) {
        Optional<String> name = Optional.empty();

        String result = name.orElse("Unknown");

        System.out.println(result);
    }
}
```

Result:

```text
Unknown
```

If there is a value:

```java
Optional<String> name = Optional.of("Laura");

String result = name.orElse("Unknown");

System.out.println(result);
```

Result:

```text
Laura
```

---

## 18. Computed default value: `orElseGet`

`orElseGet` also returns an alternative value, but it computes it with a `Supplier`.

```java
import java.util.Optional;

public class Main {
    public static void main(String[] args) {
        Optional<String> name = Optional.empty();

        String result = name.orElseGet(() -> "Generated name");

        System.out.println(result);
    }
}
```

The main difference is that `orElseGet` only runs the supplier when necessary.

---

## 19. Difference between `orElse` and `orElseGet`

This point is important.

With `orElse`, the alternative value is evaluated even if the `Optional` has a value.

```java
String result = optionalName.orElse(createDefaultName());
```

With `orElseGet`, the function only runs if the `Optional` is empty.

```java
String result = optionalName.orElseGet(() -> createDefaultName());
```

### 19.1. Rule of thumb

- use `orElse` for simple values
- use `orElseGet` if the default value requires calculations, data access or more expensive logic

---

## 20. Throwing an exception if there is no value: `orElseThrow`

Sometimes you want to get the value, but if it doesn't exist you want to throw an exception.

```java
import java.util.Optional;

public class Main {
    public static void main(String[] args) {
        Optional<String> name = Optional.empty();

        String result = name.orElseThrow();

        System.out.println(result);
    }
}
```

This throws an exception if it is empty.

You can also throw a custom exception:

```java
String result = name.orElseThrow(() -> new IllegalArgumentException("Name not found"));
```

---

## 21. Transforming a value with `map`

`map` lets you transform the value contained in an `Optional`.

Example:

```java
import java.util.Optional;

public class Main {
    public static void main(String[] args) {
        Optional<String> name = Optional.of("Laura");

        Optional<Integer> length = name.map(value -> value.length());

        System.out.println(length);
    }
}
```

Result:

```text
Optional[5]
```

Here:

- you had an `Optional<String>`
- you transform it into an `Optional<Integer>`

---

## 22. `map` with an empty `Optional`

If the `Optional` is empty, `map` does not run the transformation.

```java
import java.util.Optional;

public class Main {
    public static void main(String[] args) {
        Optional<String> name = Optional.empty();

        Optional<Integer> length = name.map(value -> value.length());

        System.out.println(length);
    }
}
```

Result:

```text
Optional.empty
```

This lets you chain operations without checking for `null` manually.

---

## 23. Example with `map` and `orElse`

```java
import java.util.Optional;

public class Main {
    public static void main(String[] args) {
        Optional<String> name = Optional.of("Laura");

        int length = name
                .map(value -> value.length())
                .orElse(0);

        System.out.println(length);
    }
}
```

If there is a name, it returns its length.  
If there is no name, it returns `0`.

---

## 24. Filtering an `Optional` with `filter`

`filter` lets you keep the value only if it meets a condition.

```java
import java.util.Optional;

public class Main {
    public static void main(String[] args) {
        Optional<String> name = Optional.of("Laura");

        Optional<String> result = name.filter(value -> value.length() > 3);

        System.out.println(result);
    }
}
```

Result:

```text
Optional[Laura]
```

If it does not meet the condition:

```java
Optional<String> result = name.filter(value -> value.length() > 10);
```

Result:

```text
Optional.empty
```

---

## 25. Chaining `filter`, `map` and `orElse`

```java
import java.util.Optional;

public class Main {
    public static void main(String[] args) {
        Optional<String> name = Optional.of("Laura");

        String result = name
                .filter(value -> value.length() >= 5)
                .map(value -> value.toUpperCase())
                .orElse("UNKNOWN");

        System.out.println(result);
    }
}
```

Process:

1. if there is a value, it checks the condition
2. if the condition is met, it transforms the value
3. if there is no value or the condition is not met, it returns `"UNKNOWN"`

---

## 26. `flatMap`

`flatMap` is used when the transformation already returns an `Optional`.

Let's first look at the problem.

```java
Optional<String> name = Optional.of("Laura");

Optional<Optional<String>> result = name.map(value -> findEmailByName(value));
```

If `findEmailByName` returns `Optional<String>`, then `map` produces an `Optional` inside another `Optional`.

To avoid that, you use `flatMap`.

```java
Optional<String> result = name.flatMap(value -> findEmailByName(value));
```

---

## 27. Guided example with `flatMap`

```java
import java.util.Optional;

public class Main {
    public static void main(String[] args) {
        Optional<String> name = Optional.of("Laura");

        Optional<String> email = name.flatMap(value -> findEmailByName(value));

        email.ifPresent(System.out::println);
    }

    public static Optional<String> findEmailByName(String name) {
        if (name.equals("Laura")) {
            return Optional.of("laura@example.com");
        }

        return Optional.empty();
    }
}
```

Here `flatMap` avoids having an `Optional<Optional<String>>`.

---

## 28. Complete example: looking up a user by id

### 28.1. `User.java`

```java
public class User {
    private int id;
    private String name;
    private String email;

    public User(int id, String name, String email) {
        this.id = id;
        this.name = name;
        this.email = email;
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getEmail() {
        return email;
    }
}
```

### 28.2. `Main.java`

```java
import java.util.List;
import java.util.Optional;

public class Main {
    public static void main(String[] args) {
        List<User> users = List.of(
                new User(1, "Laura", "laura@example.com"),
                new User(2, "Alex", "alex@example.com")
        );

        Optional<User> result = findUserById(users, 1);

        result.ifPresent(user -> System.out.println(user.getName()));
    }

    public static Optional<User> findUserById(List<User> users, int id) {
        for (User user : users) {
            if (user.getId() == id) {
                return Optional.of(user);
            }
        }

        return Optional.empty();
    }
}
```

The method makes it clear that it may or may not find a user.

---

## 29. Improving the example with `orElse`

```java
Optional<User> result = findUserById(users, 3);

User user = result.orElse(new User(0, "Unknown", "unknown@example.com"));

System.out.println(user.getName());
```

Here, if the user is not found, a default one is used.

---

## 30. Improving the example with `orElseThrow`

In many applications, if the user does not exist, you may want to throw an exception.

```java
User user = findUserById(users, 3)
        .orElseThrow(() -> new IllegalArgumentException("User not found"));
```

This is clearer than returning `null`.

---

## 31. `Optional` and `Stream API`

`Optional` appears a lot with streams.

For example, `findFirst` returns an `Optional`.

```java
import java.util.List;
import java.util.Optional;

public class Main {
    public static void main(String[] args) {
        List<String> names = List.of("Laura", "Alex", "Maria");

        Optional<String> result = names.stream()
                .filter(name -> name.startsWith("A"))
                .findFirst();

        result.ifPresent(System.out::println);
    }
}
```

Why does it return an `Optional`?

Because there may be a first element that meets the condition, or there may be none.

---

## 32. Example with `max` and `Optional`

Some stream methods also return `Optional`.

```java
import java.util.Comparator;
import java.util.List;
import java.util.Optional;

public class Main {
    public static void main(String[] args) {
        List<Integer> numbers = List.of(4, 10, 2, 8);

        Optional<Integer> max = numbers.stream()
                .max(Comparator.naturalOrder());

        max.ifPresent(System.out::println);
    }
}
```

If the list were empty, there would be no maximum.  
That's why the result is an `Optional<Integer>`.

---

## 33. Example with an empty list

```java
import java.util.Comparator;
import java.util.List;
import java.util.Optional;

public class Main {
    public static void main(String[] args) {
        List<Integer> numbers = List.of();

        Optional<Integer> max = numbers.stream()
                .max(Comparator.naturalOrder());

        System.out.println(max.orElse(0));
    }
}
```

Result:

```text
0
```

---

## 34. `Optional` with objects

Example: we want to get a user's email, but the user may not exist.

```java
Optional<User> user = findUserById(users, 1);

String email = user
        .map(value -> value.getEmail())
        .orElse("No email");

System.out.println(email);
```

Here:

- if the user exists, we get their email
- if it does not exist, we use `"No email"`

---

## 35. `Optional` does not replace all checks

`Optional` is useful, but it doesn't mean you should use it everywhere.

There is no need to use `Optional` for every local variable.

Unnecessary example:

```java
Optional<String> name = Optional.of("Laura");
System.out.println(name.orElse("Unknown"));
```

If you know the name exists, simply use:

```java
String name = "Laura";
```

---

## 36. When to use `Optional`

Use `Optional` mainly as the return type of methods that may not find a result.

Suitable examples:

```java
Optional<User> findUserById(int id)
Optional<Product> findProductByCode(String code)
Optional<String> findEmailByUsername(String username)
```

This clearly communicates:

> this method can return a value or it can return nothing.

---

## 37. When to avoid `Optional`

As a rule of thumb to start with, avoid using `Optional`:

- as an attribute of a class
- as a method parameter
- excessively, for simple local variables
- for collections

Not recommended example:

```java
public class User {
    private Optional<String> email;
}
```

It is usually better to write:

```java
public class User {
    private String email;
}
```

and handle the absence in the methods that need it.

---

## 38. `Optional` and collections

It usually doesn't make sense to return this:

```java
Optional<List<User>>
```

It's usually better to return an empty list:

```java
List<User>
```

Because an empty list already expresses that there are no results.

Example:

```java
public static List<User> findActiveUsers() {
    return List.of();
}
```

This is usually simpler than wrapping the list in `Optional`.

---

## 39. Guided example: looking up a product by code

### 39.1. `Product.java`

```java
public class Product {
    private String code;
    private String name;
    private double price;

    public Product(String code, String name, double price) {
        this.code = code;
        this.name = name;
        this.price = price;
    }

    public String getCode() {
        return code;
    }

    public String getName() {
        return name;
    }

    public double getPrice() {
        return price;
    }
}
```

### 39.2. `Main.java`

```java
import java.util.List;
import java.util.Optional;

public class Main {
    public static void main(String[] args) {
        List<Product> products = List.of(
                new Product("M01", "Mouse", 19.99),
                new Product("K01", "Keyboard", 49.99),
                new Product("C01", "Cable", 5.99)
        );

        Optional<Product> result = findProductByCode(products, "K01");

        String productName = result
                .map(product -> product.getName())
                .orElse("Product not found");

        System.out.println(productName);
    }

    public static Optional<Product> findProductByCode(List<Product> products, String code) {
        for (Product product : products) {
            if (product.getCode().equals(code)) {
                return Optional.of(product);
            }
        }

        return Optional.empty();
    }
}
```

---

## 40. Guided example with streams

The method above can also be written with `Stream API`.

```java
public static Optional<Product> findProductByCode(List<Product> products, String code) {
    return products.stream()
            .filter(product -> product.getCode().equals(code))
            .findFirst();
}
```

This version is more compact and naturally returns an `Optional<Product>`.

---

## 41. Common beginner mistakes

### 41.1. Using `get` without checking

Avoid:

```java
Optional<String> name = Optional.empty();
System.out.println(name.get());
```

Better:

```java
System.out.println(name.orElse("Unknown"));
```

### 41.2. Using `Optional.of` with values that can be `null`

Avoid:

```java
Optional<String> name = Optional.of(possibleNullName);
```

Better:

```java
Optional<String> name = Optional.ofNullable(possibleNullName);
```

### 41.3. Using `Optional` everywhere

`Optional` is useful, but it should not wrap every variable.

### 41.4. Returning `null` from a method that returns `Optional`

This is a design error:

```java
public static Optional<String> findName() {
    return null; // mal
}
```

It must be:

```java
public static Optional<String> findName() {
    return Optional.empty();
}
```

### 41.5. Using `Optional<List<T>>` when an empty list is enough

In many cases, an empty list is simpler.

---

## 42. Good practices

- Use `Optional` mainly as a return type.
- Use `Optional.empty()` to represent the absence of a value.
- Use `Optional.ofNullable` if the value can be `null`.
- Avoid calling `get` directly.
- Prefer `orElse`, `orElseGet`, `orElseThrow`, `ifPresent`, `map` and `flatMap`.
- Do not return `null` from a method that promises to return `Optional`.
- Don't use `Optional` for collections if an empty collection expresses the case well.
- Use `Optional` to make the possibility of absence more explicit.

---

## 43. Things to keep in mind

- `Optional<T>` represents a value that may or may not exist.
- It helps avoid errors caused by `null`.
- `Optional.of` requires a non-null value.
- `Optional.empty` represents absence.
- `Optional.ofNullable` accepts values that can be `null`.
- `ifPresent` runs an action if there is a value.
- `orElse` and `orElseGet` provide default values.
- `orElseThrow` throws an exception if there is no value.
- `map` transforms the internal value.
- `flatMap` avoids nested `Optional` values.
- Many `Stream API` methods return `Optional`.

---

## 44. Final summary

`Optional` is a very useful tool for explicitly representing that a value may be missing.

Its goal is not to remove `null` from Java completely, but to help you design clearer and safer methods.

Instead of returning `null`, you can return:

```java
Optional.empty()
```

And instead of forcing whoever uses the method to remember a manual check, the type itself already communicates:

> this value may or may not be present.

Mastering `Optional` will help you write clearer code, especially when working with:

- searches
- repositories
- streams
- optional values
- modern Java APIs

---

In the next topic we will keep moving forward with modern Java and see the **Date/Time API**, which lets you work correctly with dates, times, durations and time zones.
