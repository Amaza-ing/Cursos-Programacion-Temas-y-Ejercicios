# Topic 22. `equals`, `hashCode` and `toString`

## 1. Introduction

When you start working with objects in Java, sooner or later these questions appear:

- How do I compare two objects correctly?
- Why do two objects with the same data sometimes seem “different”?
- Why does something strange like `User@5f184fc6` appear when you print an object?
- How does all this relate to collections like `Set`, `Map` or `List`?

The answers lie in three very important methods inherited from `Object`:

- `equals(...)`
- `hashCode()`
- `toString()`

These methods are present in practically all Java classes, because all classes inherit directly or indirectly from `Object`.

In this topic you will learn:

- What `equals` does and why it is not the same as `==`
- What `hashCode` does and why it should be consistent with `equals`
- What `toString` does and why it is so useful when debugging or displaying information
- How to correctly override these methods
- Which mistakes are very common when you are starting out
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

If you do not override these methods in your class, Java will use the default implementation from `Object`.

And that is usually not enough when you want to compare objects by their content.

---

## 3. `==` vs `equals(...)`

This is the most important difference in the whole topic.

### 3.1. `==` compares references

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

But if you don't override it, the default behavior of `Object` is similar to `==`.

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

## 5. Overriding `equals(...)`

To compare by content, you must override `equals`.

### 5.1. What `equals` should do

Typically, a well-written `equals` follows these steps:

1. If both references are exactly the same → `true`
2. If the other object is `null` → `false`
3. If they are not of the same class → `false`
4. Compare the relevant attributes

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

### 5.3. Usage

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

In the previous example we used:

```java
Objects.equals(name, other.name)
```

This is useful because it compares safely even when one of the two values is `null`.

Example:

```java
Objects.equals(null, null);      // true
Objects.equals("A", null);       // false
Objects.equals("A", "A");        // true
```

This way you avoid `NullPointerException`.

---

## 7. Important rules for `equals`

A good `equals` should satisfy these properties:

### 7.1. Reflexive

An object must be equal to itself:

```java
u1.equals(u1) // true
```

### 7.2. Symmetric

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

That number is used a lot in hash-based structures, such as:

- `HashSet`
- `HashMap`
- `Hashtable`

The idea is that Java can quickly place objects into internal “buckets” based on their hash.

### 8.1. Fundamental rule

If two objects are equal according to `equals`, then **they must have the same `hashCode`**.

In other words:

```java
if (a.equals(b)) {
    a.hashCode() == b.hashCode() // debe ser true
}
```

The converse is not always true:

- two objects can have the same hash and not be equal

---

## 9. Overriding `hashCode()` correctly

Whenever you override `equals`, you must also override `hashCode`.

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

`Objects.hash(...)` greatly simplifies the implementation.

---

## 10. What happens if you override `equals` but not `hashCode`

This causes subtle bugs, especially in `HashSet` and `HashMap`.

### 10.1. Conceptual example

Suppose that:

- two objects are equal according to `equals`
- but their `hashCode` values are different

Then a hash-based collection may treat them as if they were in different places, and its behavior will be incorrect or inconsistent.

That is why the practical rule is:

> If you override `equals`, always override `hashCode`.

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

### 11.2. Usage with `HashSet`

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

If `equals` and `hashCode` are implemented correctly, the `HashSet` detects that they are equal and does not duplicate the element.

---

## 12. Comparing `double` values inside `equals`

When comparing `double` values, it is usually recommended to use:

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

This is the more robust and standard way to implement `equals` with decimal values.

---

## 13. What is `toString()`

`toString()` returns a text representation of the object.

If you don't override it, Java uses a default version that looks like this:

```java
User@5f184fc6
```

That is usually not very useful.

### 13.1. Example without overriding

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

## 14. Overriding `toString()`

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

### 14.2. Usage

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

Much more useful for debugging, logging information or displaying objects in the console.

---

## 15. When to use `toString()`

`toString()` is especially useful for:

- Debugging code
- Showing lists of objects in the console
- Quickly checking the internal state
- Writing readable logs

Example with a list:

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

## 17. `equals` and choosing the attributes

You don't always have to compare every attribute.

The decision depends on what “equality” means in your domain.

Example: two users could be considered the same because of their `id`, even if their current names are different.

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

## 18. Common beginner mistakes

### 18.1. Using `==` to compare objects

This only compares references, not content.

### 18.2. Overriding `equals` but not `hashCode`

Especially problematic with `HashSet` and `HashMap`.

### 18.3. Writing an `equals` without checking the type or `null`

It can cause errors or incorrect comparisons.

### 18.4. Not using `@Override`

It is not mandatory, but it helps a lot to catch errors in the signature.

### 18.5. Writing a useless `toString()`

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

- Always use `@Override` on `equals`, `hashCode` and `toString`.
- If you override `equals`, also override `hashCode`.
- Use `Objects.equals(...)` and `Objects.hash(...)` for simplicity.
- Make `toString()` display useful and readable information.
- Think carefully about which attributes define the logical equality of your class.

---

## 20. Things to keep in mind

- `==` compares references; `equals` compares logical equality.
- `hashCode` must be consistent with `equals`.
- `toString` is used to obtain a readable representation of the object.
- `equals`, `hashCode` and `toString` are inherited from `Object`.
- In domain classes, it is very common to override these three methods.
- They are especially important when working with collections and debugging.

---

In the next topic we will keep moving forward with tools that make our programs more robust, and we will see how to **handle exceptions** in Java.
