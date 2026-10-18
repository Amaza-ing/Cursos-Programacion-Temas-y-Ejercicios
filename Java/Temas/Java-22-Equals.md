# Topic 22. `equals`, `hashCode` and `toString`

## 1. Introduction

When you start working with objects in Java, sooner or later these questions appear:

- How do I compare two objects correctly?
- Why do two objects with the same data sometimes appear “different”?
- Why does something strange like `User@5f184fc6` appear when printing an object?
- What relationship does all this have with collections like `Set`, `Map` or `List`?

The responses go through three very important methods inherited from `Object`:

- `equals(...)`
- `hashCode()`
- `toString()`

These methods are present in practically all Java classes, because all classes inherit directly or indirectly from `Object`.

In this topic you will learn:

- What `equals` does and why it is not the same as `==`
- What `hashCode` does and why it should be consistent with `equals`
- What `toString` does and why it is so useful when debugging or displaying information
- How to correctly override these methods
- What mistakes are very common when starting out
- How they affect collections like `HashSet` and `HashMap`

---

[![Equals](https://img.youtube.com/vi/7D7EZIKwF3Q/0.jpg)](https://www.youtube.com/watch?v=7D7EZIKwF3Q&list=PLzA2VyZwsq_-30Z1c9LjWZpq24Kf-2MjD)

---

## 2. The `Object` class: the origin of everything

In Java, all classes inherit from `Object`.

That is why any class has, among others, these methods:

```java
public boolean equals(Object obj)
public int hashCode()
public String toString()
```

If you do not override these methods in your class, Java will use the default implementation of `Object`.

And that is usually insufficient when you want to compare objects by their content.

---

## 3. `==` vs `equals(...)`

This is the most important difference of the entire topic.

### 3.1. `==` compare references

When you use `==` with objects, Java checks if both variables point to the **same object in memory**.

Example:

```java
User u1 = new User("Laura", 28);
User u2 = new User("Laura", 28);

System.out.println(u1 == u2); // false
```

Why `false`?

Because `u1` and `u2` are two different objects, even though they have the same data.

### 3.2. `equals(...)` compares “logical equality”

The idea of `equals` is to check whether two objects should be considered equal by their content.

But if you don't overwrite it, the default behavior of `Object` is similar to `==`.

Example:

```java
User u1 = new User("Laura", 28);
User u2 = new User("Laura", 28);

System.out.println(u1.equals(u2)); // false si no sobrescribes equals
```

---

## 4. First example: class without `equals`

```java
public class User {
    private String name;
    private int age;

    public User(String name, int age) {
        this.name = name;
        this.age = age;
    }
}
```

Usage:

```java
public class Main {
    public static void main(String[] args) {
        User u1 = new User("Laura", 28);
        User u2 = new User("Laura", 28);

        System.out.println(u1 == u2);      // false
        System.out.println(u1.equals(u2)); // false
    }
}
```

Even though `u1` and `u2` have the same `name` and the same `age`, Java doesn't know that you want to compare them by that data.

---

## 5. Overwrite `equals(...)`

To compare by content, you must overwrite `equals`.

### 5.1. What `equals` should do

Typically, a well-made `equals` follows these steps:

1. If both references are exactly the same → `true`
2. If the other object is `null` → `false`
3. If they are not the same class → `false`
4. Compare relevant attributes

### 5.2. Complete example of `equals`

```java
import java.util.Objects;

public class User {
    private String name;
    private int age;

    public User(String name, int age) {
        this.name = name;
        this.age = age;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }

        if (obj == null || getClass() != obj.getClass()) {
            return false;
        }

        User other = (User) obj;

        return age == other.age && Objects.equals(name, other.name);
    }
}
```

### 5.3. Use

```java
public class Main {
    public static void main(String[] args) {
        User u1 = new User("Laura", 28);
        User u2 = new User("Laura", 28);
        User u3 = new User("Alex", 30);

        System.out.println(u1.equals(u2)); // true
        System.out.println(u1.equals(u3)); // false
    }
}
```

---

## 6. `Objects.equals(...)` and why it helps

In the previous example we have used:

```java
Objects.equals(name, other.name)
```

This is useful because it safely compares even if one of the two values ​​is `null`.

Example:

```java
Objects.equals(null, null);      // true
Objects.equals("A", null);       // false
Objects.equals("A", "A");        // true
```

This way you avoid `NullPointerException`.

---

## 7. Important rules of `equals`

A good `equals` should meet these properties:

### 7.1. Reflective

An object must be equal to itself:

```java
u1.equals(u1) // true
```

### 7.2. Symmetrical

If `u1.equals(u2)` is `true`, then `u2.equals(u1)` must also be `true`.

### 7.3. Transitive

If `u1.equals(u2)` and `u2.equals(u3)`, then `u1.equals(u3)`.

### 7.4. Consistent

If the data does not change, multiple calls to `equals` should give the same result.

### 7.5. Never equal to `null`

```java
u1.equals(null) // false
```

---

## 8. What is `hashCode()`

`hashCode()` returns an integer associated with the object.

That number is used a lot in hash structures, such as:

- `HashSet`
- `HashMap`
- `Hashtable`

The idea is that Java can quickly place objects into internal “buckets” based on their hash.

### 8.1. Fundamental rule

If two objects are equal according to `equals`, then **they must have the same `hashCode`**.

That is to say:

```java
if (a.equals(b)) {
    a.hashCode() == b.hashCode() // debe ser true
}
```

The converse is not always true:

- two objects can have the same hash and not be equal

---

## 9. Overwrite `hashCode()` correctly

Whenever you overwrite `equals`, you must also overwrite `hashCode`.

### 9.1. Example with `Objects.hash(...)`

```java
import java.util.Objects;

public class User {
    private String name;
    private int age;

    public User(String name, int age) {
        this.name = name;
        this.age = age;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }

        if (obj == null || getClass() != obj.getClass()) {
            return false;
        }

        User other = (User) obj;

        return age == other.age && Objects.equals(name, other.name);
    }

    @Override
    public int hashCode() {
        return Objects.hash(name, age);
    }
}
```

`Objects.hash(...)` greatly simplifies implementation.

---

## 10. What happens if you overwrite `equals` but not `hashCode`

This causes subtle errors, especially in `HashSet` and `HashMap`.

### 10.1. Conceptual example

Let's assume:

- two objects are equal according to `equals`
- but they have different `hashCode`

Then a hash collection can treat them as if they were in different places, and the behavior will be incorrect or inconsistent.

That is why the practical rule is:

> If you overwrite `equals`, always overwrite `hashCode`.

---

## 11. Example with `HashSet`

### 11.1. Correct class

```java
import java.util.Objects;

public class Product {
    private String name;
    private double price;

    public Product(String name, double price) {
        this.name = name;
        this.price = price;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }

        if (obj == null || getClass() != obj.getClass()) {
            return false;
        }

        Product other = (Product) obj;
        return Double.compare(price, other.price) == 0
                && Objects.equals(name, other.name);
    }

    @Override
    public int hashCode() {
        return Objects.hash(name, price);
    }
}
```

### 11.2. Use with `HashSet`

```java
import java.util.HashSet;
import java.util.Set;

public class Main {
    public static void main(String[] args) {
        Set<Product> products = new HashSet<>();

        products.add(new Product("Mouse", 19.99));
        products.add(new Product("Mouse", 19.99));

        System.out.println(products.size()); // 1
    }
}
```

If `equals` and `hashCode` are done correctly, the `HashSet` detects that they are the same and does not duplicate the element.

---

## 12. Compare `double` within `equals`

When comparing `double`, it is often recommended to use:

```java
Double.compare(a, b) == 0
```

Instead of:

```java
a == b
```

Example:

```java
return Double.compare(price, other.price) == 0;
```

This is more robust and standard for implementing `equals` with decimal values.

---

## 13. What is `toString()`

`toString()` returns a text representation of the object.

If you don't override it, Java uses a default version that looks like this:

```java
User@5f184fc6
```

That is usually not very useful.

### 13.1. Example without overwriting

```java
public class User {
    private String name;
    private int age;

    public User(String name, int age) {
        this.name = name;
        this.age = age;
    }
}
```

Usage:

```java
public class Main {
    public static void main(String[] args) {
        User user = new User("Laura", 28);
        System.out.println(user);
    }
}
```

Approximate output:

```java
User@4e25154f
```

---

## 14. Overwrite `toString()`

### 14.1. Simple example

```java
public class User {
    private String name;
    private int age;

    public User(String name, int age) {
        this.name = name;
        this.age = age;
    }

    @Override
    public String toString() {
        return "User{name='" + name + "', age=" + age + "}";
    }
}
```

### 14.2. Use

```java
public class Main {
    public static void main(String[] args) {
        User user = new User("Laura", 28);
        System.out.println(user);
    }
}
```

Output:

```java
User{name='Laura', age=28}
```

Much more useful for debugging, logging information or displaying objects through the console.

---

## 15. When to use `toString()`

`toString()` is especially useful for:

- Debug code
- Show object lists per console
- View internal status quickly
- Register readable logs

Example with list:

```java
import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<User> users = new ArrayList<>();
        users.add(new User("Laura", 28));
        users.add(new User("Alex", 31));

        System.out.println(users);
    }
}
```

If `User` has a good `toString`, the output will be much clearer.

---

## 16. Complete example: `Book` with `equals`, `hashCode` and `toString`

```java
import java.util.Objects;

public class Book {
    private String title;
    private String author;
    private int year;

    public Book(String title, String author, int year) {
        this.title = title;
        this.author = author;
        this.year = year;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }

        if (obj == null || getClass() != obj.getClass()) {
            return false;
        }

        Book other = (Book) obj;

        return year == other.year
                && Objects.equals(title, other.title)
                && Objects.equals(author, other.author);
    }

    @Override
    public int hashCode() {
        return Objects.hash(title, author, year);
    }

    @Override
    public String toString() {
        return "Book{title='" + title + "', author='" + author + "', year=" + year + "}";
    }
}
```

Usage:

```java
import java.util.HashSet;
import java.util.Set;

public class Main {
    public static void main(String[] args) {
        Book b1 = new Book("Clean Code", "Robert C. Martin", 2008);
        Book b2 = new Book("Clean Code", "Robert C. Martin", 2008);

        System.out.println(b1.equals(b2)); // true
        System.out.println(b1.hashCode() == b2.hashCode()); // true
        System.out.println(b1); // Book{title='Clean Code', author='Robert C. Martin', year=2008}

        Set<Book> books = new HashSet<>();
        books.add(b1);
        books.add(b2);

        System.out.println(books.size()); // 1
    }
}
```

---

## 17. `equals` and attribute selection

You don't always have to compare all attributes.

The decision depends on what “equality” means in your domain.

Example: two users could be considered the same because of their `id`, even if they have different current names.

```java
public class User {
    private String id;
    private String name;
    private int age;
}
```

You could decide that `equals` and `hashCode` use only `id`.

That depends on the problem, not just the syntax.

---

## 18. Typical mistakes when starting

### 18.1. Use `==` to compare objects

This only compares references, not content.

### 18.2. Overwrite `equals` but not `hashCode`

Especially problematic on `HashSet` and `HashMap`.

### 18.3. Write an `equals` without type checking or `null`

It may produce errors or incorrect comparisons.

### 18.4. Do not use `@Override`

It is not mandatory, but it helps a lot to detect errors in the signature.

### 18.5. Create a useless `toString()`

Bad example:

```java
@Override
public String toString() {
    return "User";
}
```

That provides almost no information.

---

## 19. Good practices

- Always use `@Override` in `equals`, `hashCode` and `toString`.
- If you overwrite `equals`, also overwrite `hashCode`.
- Use `Objects.equals(...)` and `Objects.hash(...)` for simplicity.
- Make `toString()` display useful and readable information.
- Think carefully about what attributes define the logical equality of your class.

---

## 20. To take into account

- `==` compares references; `equals` compares logical equality.
- `hashCode` must be consistent with `equals`.
- `toString` is used to obtain a readable representation of the object.
- `equals`, `hashCode` and `toString` are inherited from `Object`.
- In domain classes, it is very common to override these three methods.
- They are especially important when working with collections and debugging.

---

In the next topic we will continue advancing with tools to give robustness to our programs and we will see how to manage exceptions in Java.
