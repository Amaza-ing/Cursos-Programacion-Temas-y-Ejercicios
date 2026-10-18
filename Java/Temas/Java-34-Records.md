# Topic 34. Records

## 1. Introduction

In previous topics you have learned how to create classes with:

- attributes
- constructors
- getters
- setters
- methods
- `equals`
- `hashCode`
- `toString`

We often create classes whose main purpose is simply to **store data**.

For example:

- a user with `name` and `email`
- a product with `name` and `price`
- a coordinate with `x` and `y`
- a response from an API
- an object to transport data between parts of the program

For these cases, Java includes a modern tool called:

- **record**

A `record` lets you declare, in a very compact way, a class meant mainly to store immutable data.

In this topic you will learn:

- What a `record` is
- What problem it solves
- How to declare records
- What code Java generates automatically
- How to access their values
- Why they are immutable
- How to create compact constructors
- How to validate data in a record
- How to add your own methods
- How to use records with lists, maps and streams
- When to use records and when to use normal classes
- Common mistakes and best practices

---

## 2. The problem: classes with a lot of repetitive code

Imagine a simple class to represent a product.

```java
public class Product {
    private final String name;
    private final double price;

    public Product(String name, double price) {
        this.name = name;
        this.price = price;
    }

    public String getName() {
        return name;
    }

    public double getPrice() {
        return price;
    }

    @Override
    public String toString() {
        return "Product{name='" + name + "', price=" + price + "}";
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }

        if (!(obj instanceof Product other)) {
            return false;
        }

        return Double.compare(price, other.price) == 0
                && name.equals(other.name);
    }

    @Override
    public int hashCode() {
        return name.hashCode();
    }
}
```

This class only stores data, but it has quite a lot of code.

In modern Java, a `record` lets you express this same idea in a much shorter way.

---

## 3. A first `record` example

```java
public record Product(String name, double price) {
}
```

With a single line, Java automatically generates:

- private and final attributes
- a constructor
- accessor methods
- `toString`
- `equals`
- `hashCode`

Usage:

```java
public class Main {
    public static void main(String[] args) {
        Product product = new Product("Mouse", 19.99);

        System.out.println(product.name());
        System.out.println(product.price());
        System.out.println(product);
    }
}
```

Approximate result:

```text
Mouse
19.99
Product[name=Mouse, price=19.99]
```

---

## 4. Basic syntax of a record

The general syntax is:

```java
public record RecordName(Type fieldName, Type fieldName2) {
}
```

Example:

```java
public record User(String name, String email) {
}
```

The elements declared in parentheses are called **record components**.

In this example, the components are:

- `name`
- `email`

---

## 5. Accessor methods

In a normal class, we typically create getters:

```java
getName()
getEmail()
```

In a `record`, Java creates accessor methods with the same name as the component:

```java
name()
email()
```

Example:

```java
public record User(String name, String email) {
}
```

Usage:

```java
public class Main {
    public static void main(String[] args) {
        User user = new User("Laura", "laura@example.com");

        System.out.println(user.name());
        System.out.println(user.email());
    }
}
```

Important:

- `getName()` is not used in records
- `name()` is used

---

## 6. Records are immutable

The components of a record are:

- `private`
- `final`

That means that once the object is created, you cannot change its values.

Example:

```java
User user = new User("Laura", "laura@example.com");

// user.name = "Alex"; // no se puede
// user.setName("Alex"); // no existe
```

If you want another value, you create another object.

```java
User user = new User("Laura", "laura@example.com");
User updatedUser = new User("Alex", user.email());
```

This connects with a very important idea:

> A record represents immutable data.

---

## 7. Difference between a normal class and a record

### 7.1. Normal class

A regular class is better when you need:

- mutable state
- setters
- complex logic
- inheritance from another class
- behavior with its own identity

### 7.2. Record

A record is better when you need:

- store data
- carry information
- represent immutable values
- reduce repetitive code
- have `equals`, `hashCode` and `toString` automatically

---

## 8. Automatic `toString`
Java automatically generates a `toString`.

```java
public record Product(String name, double price) {
}
```

Usage:

```java
public class Main {
    public static void main(String[] args) {
        Product product = new Product("Keyboard", 49.99);

        System.out.println(product);
    }
}
```

Result:

```text
Product[name=Keyboard, price=49.99]
```

This is very useful for debugging and displaying information.

---

## 9. Automatic `equals`

Java also generates `equals`.

Two records are equal if:

- they are the same type
- they have the same values in their components

Example:

```java
public record Product(String name, double price) {
}
```

Usage:

```java
public class Main {
    public static void main(String[] args) {
        Product p1 = new Product("Mouse", 19.99);
        Product p2 = new Product("Mouse", 19.99);
        Product p3 = new Product("Keyboard", 49.99);

        System.out.println(p1.equals(p2)); // true
        System.out.println(p1.equals(p3)); // false
    }
}
```

This saves you from writing `equals` by hand.

---

## 10. Automatic `hashCode`

Java also generates `hashCode`.

This is important when you use records in structures like:

- `HashSet`
- `HashMap`

Example:

```java
import java.util.HashSet;
import java.util.Set;

public class Main {
    public static void main(String[] args) {
        Set<Product> products = new HashSet<>();

        products.add(new Product("Mouse", 19.99));
        products.add(new Product("Mouse", 19.99));
        products.add(new Product("Keyboard", 49.99));

        System.out.println(products.size());
    }
}
```

Result:

```text
2
```

The repeated product is not added twice because `equals` and `hashCode` work automatically.

---

## 11. Canonical constructor

Each record has a constructor with all its components.

Example:

```java
public record User(String name, String email) {
}
```

Java automatically generates something equivalent to:

```java
public User(String name, String email) {
    this.name = name;
    this.email = email;
}
```

Usage:

```java
User user = new User("Laura", "laura@example.com");
```

That constructor is called the **canonical constructor**.

---

## 12. Compact constructor

You can define a compact constructor to validate or adjust values.

Example:

```java
public record User(String name, String email) {
    public User {
        if (name == null || name.isBlank()) {
            throw new IllegalArgumentException("Name cannot be blank");
        }

        if (email == null || email.isBlank()) {
            throw new IllegalArgumentException("Email cannot be blank");
        }
    }
}
```

Notice the syntax:

```java
public User {
    ...
}
```

You don't write the parameters because they are already defined in the record.

---

## 13. Validation in a compact constructor

Complete example:

```java
public record Product(String name, double price) {
    public Product {
        if (name == null || name.isBlank()) {
            throw new IllegalArgumentException("Name cannot be blank");
        }

        if (price < 0) {
            throw new IllegalArgumentException("Price cannot be negative");
        }
    }
}
```

Usage:

```java
public class Main {
    public static void main(String[] args) {
        Product product = new Product("Mouse", 19.99);

        System.out.println(product);

        // Product invalid = new Product("", -10); // excepción
    }
}
```

---

## 14. Normalizing values in a compact constructor

In addition to validating, you can also normalize data.

Example:

```java
public record User(String name, String email) {
    public User {
        name = name.trim();
        email = email.trim().toLowerCase();
    }
}
```

Usage:

```java
public class Main {
    public static void main(String[] args) {
        User user = new User("  Laura  ", "  LAURA@EXAMPLE.COM  ");

        System.out.println(user.name());
        System.out.println(user.email());
    }
}
```

Result:

```text
Laura
laura@example.com
```

Important:

- in a compact constructor you can reassign the parameters
- Java will then assign these normalized values to the components

---

## 15. Full explicit constructor

You can also write the full constructor, although this is usually not necessary.

```java
public record Product(String name, double price) {
    public Product(String name, double price) {
        if (name == null || name.isBlank()) {
            throw new IllegalArgumentException("Name cannot be blank");
        }

        if (price < 0) {
            throw new IllegalArgumentException("Price cannot be negative");
        }

        this.name = name;
        this.price = price;
    }
}
```

In many cases the compact constructor is cleaner.

---

## 16. Adding your own methods to a record

A record can have its own methods.

Example:

```java
public record Product(String name, double price) {
    public boolean isExpensive() {
        return price > 100;
    }
}
```

Usage:

```java
public class Main {
    public static void main(String[] args) {
        Product product = new Product("Monitor", 199.99);

        System.out.println(product.isExpensive());
    }
}
```

Records are not just “data without methods.”  
They can have behavior related to that data.

---

## 17. Example with a computed method

```java
public record Rectangle(double width, double height) {
    public double area() {
        return width * height;
    }

    public double perimeter() {
        return 2 * (width + height);
    }
}
```

Usage:

```java
public class Main {
    public static void main(String[] args) {
        Rectangle rectangle = new Rectangle(4, 3);

        System.out.println(rectangle.area());
        System.out.println(rectangle.perimeter());
    }
}
```

---

## 18. Records and `BigDecimal`

When a record represents financial data, you can use `BigDecimal`.

```java
import java.math.BigDecimal;

public record Product(String name, BigDecimal price) {
    public Product {
        if (name == null || name.isBlank()) {
            throw new IllegalArgumentException("Name cannot be blank");
        }

        if (price == null || price.compareTo(BigDecimal.ZERO) < 0) {
            throw new IllegalArgumentException("Price cannot be negative");
        }
    }
}
```

Usage:

```java
import java.math.BigDecimal;

public class Main {
    public static void main(String[] args) {
        Product product = new Product("Mouse", new BigDecimal("19.99"));

        System.out.println(product);
    }
}
```

---

## 19. Records and lists

Records work really well with collections.

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<User> users = List.of(
                new User("Laura", "laura@example.com"),
                new User("Alex", "alex@example.com"),
                new User("Maria", "maria@example.com")
        );

        for (User user : users) {
            System.out.println(user.name() + " -> " + user.email());
        }
    }
}
```

Record:

```java
public record User(String name, String email) {
}
```

---

## 20. Records and `Map`

They are also useful as map values.

```java
import java.util.HashMap;
import java.util.Map;

public class Main {
    public static void main(String[] args) {
        Map<Integer, User> usersById = new HashMap<>();

        usersById.put(1, new User("Laura", "laura@example.com"));
        usersById.put(2, new User("Alex", "alex@example.com"));

        User user = usersById.get(1);

        System.out.println(user);
    }
}
```

Record:

```java
public record User(String name, String email) {
}
```

---

## 21. Records and `Stream API`

Records work very well with streams because they are lightweight and expressive.

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<Product> products = List.of(
                new Product("Mouse", 19.99),
                new Product("Keyboard", 49.99),
                new Product("Monitor", 199.99)
        );

        List<String> expensiveNames = products.stream()
                .filter(product -> product.price() > 50)
                .map(product -> product.name())
                .toList();

        System.out.println(expensiveNames);
    }
}
```

Record:

```java
public record Product(String name, double price) {
}
```

---

## 22. Records as DTOs

A very common use of records is to create DTOs.

DTO means:

- **Data Transfer Object**

That is, an object used to transport data between parts of the program.

Example:

```java
public record UserResponse(String name, String email) {
}
```

This record can represent the data that an application returns, displays, or transfers.

Records fit well as DTOs because:

- they are compact
- are immutable
- have `toString`, `equals` and `hashCode`
- clearly express that they are data

---

## 23. Records as method results

A method can return a record to group data.

Example:

```java
public record SearchResult(String keyword, int totalResults) {
}
```

Usage:

```java
public class Main {
    public static void main(String[] args) {
        SearchResult result = search("java");

        System.out.println(result.keyword());
        System.out.println(result.totalResults());
    }

    public static SearchResult search(String keyword) {
        return new SearchResult(keyword, 25);
    }
}
```

This is clearer than returning several separate values.

---

## 24. Nested records

You can declare a record within a class.

```java
public class Main {
    public static void main(String[] args) {
        Point point = new Point(10, 20);

        System.out.println(point);
    }

    public record Point(int x, int y) {
    }
}
```

This can be useful in small examples or when the record is only used within a class.

In real projects, you will usually create records in their own files.

---

## 25. Records and additional attributes

A record cannot have additional instance attributes that are not part of its components.

This is not valid:

```java
public record User(String name, String email) {
    // private int age; // error
}
```

Why?

Because the main state of a record must be defined in its header:

```java
public record User(String name, String email, int age) {
}
```

---

## 26. Records and static attributes

A record can have static attributes.

```java
public record User(String name, String email) {
    public static final String DEFAULT_EMAIL = "unknown@example.com";
}
```

It can also have static methods.

```java
public record User(String name, String email) {
    public static User unknown() {
        return new User("Unknown", "unknown@example.com");
    }
}
```

Usage:

```java
public class Main {
    public static void main(String[] args) {
        User user = User.unknown();

        System.out.println(user);
    }
}
```

---

## 27. Records and inheritance

Records have an important limitation:

> A record cannot extend another class.

This cannot be done:

```java
// public record User(String name) extends Person { } // error
```

Internally, all records already extend `java.lang.Record`.

But they can implement interfaces.

---

## 28. Records and interfaces

A record can implement an interface.

Example:

```java
public interface Printable {
    void print();
}
```

Record:

```java
public record User(String name, String email) implements Printable {
    @Override
    public void print() {
        System.out.println(name + " -> " + email);
    }
}
```

Usage:

```java
public class Main {
    public static void main(String[] args) {
        Printable user = new User("Laura", "laura@example.com");

        user.print();
    }
}
```

---

## 29. Records and sealed classes

Records can be combined with sealed interfaces.

We'll cover this later in **Sealed Classes**, but it's worth a quick, simple look now.

```java
public sealed interface PaymentResult permits PaymentSuccess, PaymentError {
}
```

Records:

```java
public record PaymentSuccess(String transactionId) implements PaymentResult {
}
```

```java
public record PaymentError(String message) implements PaymentResult {
}
```

The idea is that records are very useful for representing different types of immutable results.

---

## 30. Records and validation with null objects

Since records don't validate `null` automatically, you have to do it yourself if you need it.

Example:

```java
public record User(String name, String email) {
    public User {
        if (name == null || name.isBlank()) {
            throw new IllegalArgumentException("Name cannot be blank");
        }

        if (email == null || email.isBlank()) {
            throw new IllegalArgumentException("Email cannot be blank");
        }
    }
}
```

If you don't add this validation, this would be possible:

```java
User user = new User(null, null);
```

That's why validation depends on your design.

---

## 31. Overriding methods in a record

Although Java generates `toString`, `equals`, and `hashCode`, you can override them.

For example, customize `toString`:

```java
public record User(String name, String email) {
    @Override
    public String toString() {
        return name + " <" + email + ">";
    }
}
```

Usage:

```java
public class Main {
    public static void main(String[] args) {
        User user = new User("Laura", "laura@example.com");

        System.out.println(user);
    }
}
```

Result:

```text
Laura <laura@example.com>
```

Still, in many cases it's better to keep the automatic behavior.

---

## 32. Complete example: `Course`

### 32.1. `Course.java`

```java
public record Course(String title, int durationHours) {
    public Course {
        if (title == null || title.isBlank()) {
            throw new IllegalArgumentException("Title cannot be blank");
        }

        if (durationHours <= 0) {
            throw new IllegalArgumentException("Duration must be positive");
        }
    }

    public boolean isLongCourse() {
        return durationHours >= 20;
    }
}
```

### 32.2. `Main.java`

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<Course> courses = List.of(
                new Course("Java Basics", 15),
                new Course("Spring MVC", 25),
                new Course("SQL Fundamentals", 12)
        );

        for (Course course : courses) {
            System.out.println(course.title() + " | Long: " + course.isLongCourse());
        }
    }
}
```

---

## 33. Complete example: cart with records

### 33.1. `Product.java`

```java
import java.math.BigDecimal;

public record Product(String name, BigDecimal price) {
    public Product {
        if (name == null || name.isBlank()) {
            throw new IllegalArgumentException("Name cannot be blank");
        }

        if (price == null || price.compareTo(BigDecimal.ZERO) < 0) {
            throw new IllegalArgumentException("Price cannot be negative");
        }
    }
}
```

### 33.2. `CartItem.java`

```java
public record CartItem(Product product, int quantity) {
    public CartItem {
        if (product == null) {
            throw new IllegalArgumentException("Product cannot be null");
        }

        if (quantity <= 0) {
            throw new IllegalArgumentException("Quantity must be positive");
        }
    }
}
```

### 33.3. `Main.java`

```java
import java.math.BigDecimal;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<CartItem> cart = List.of(
                new CartItem(new Product("Mouse", new BigDecimal("19.99")), 2),
                new CartItem(new Product("Keyboard", new BigDecimal("49.99")), 1)
        );

        BigDecimal total = BigDecimal.ZERO;

        for (CartItem item : cart) {
            BigDecimal itemTotal = item.product()
                    .price()
                    .multiply(BigDecimal.valueOf(item.quantity()));

            total = total.add(itemTotal);
        }

        System.out.println("Total: " + total);
    }
}
```

---

## 34. Records vs. classes with setters

A record has no setters.

This is intentional.

If you need to modify the state of an object a lot after creating it, a normal class is probably better.

Example where a normal class may make more sense:

```java
public class BankAccount {
    private BigDecimal balance;

    public void deposit(BigDecimal amount) {
        balance = balance.add(amount);
    }

    public void withdraw(BigDecimal amount) {
        balance = balance.subtract(amount);
    }
}
```

Here the object has a state that changes over time.  
A record would not be the best option.

---

## 35. When to use records

Use records when you want to represent:

- simple data
- immutable values
- method results
- DTOs
- coordinates
- configurations
- value pairs
- simple responses
- objects that are compared by content

Examples:

```java
public record Point(int x, int y) {
}
```

```java
public record UserResponse(String name, String email) {
}
```

```java
public record ProductSummary(String name, double price) {
}
```

---

## 36. When not to use records

Avoid records when you need:

- setters
- mutable state
- class inheritance
- complex lifecycle logic
- an identity of their own beyond their data
- constantly changing objects

Examples where a normal class can be better:

- `BankAccount`
- `ShoppingCart`
- `GameCharacter`
- `ConnectionManager`
- `UserSession`

---

## 37. Records and component names

Component names are important because they become methods.

Example:

```java
public record User(String name, String email) {
}
```

Generates:

```java
name()
email()
```

That's why you should use clear, expressive names.

Avoid:

```java
public record User(String n, String e) {
}
```

Better:

```java
public record User(String name, String email) {
}
```

---

## 38. Common beginner mistakes

### 38.1. Trying to use classic getters

This does not exist automatically:

```java
// user.getName(); // error
```

You must use:

```java
user.name();
```

### 38.2. Expecting setters

Records are immutable:

```java
// user.setName("Alex"); // error
```

### 38.3. Thinking they validate `null` automatically

They don't.  
If you need to validate, use a compact constructor.

### 38.4. Trying to add extra instance attributes

The record's state must be in its header.

### 38.5. Using a record for objects with changing state

If the object changes a lot during its lifetime, you probably need a normal class.

---

## 39. Best practices

- Use records for simple and immutable data.
- Use clear names for components.
- Add validation in a compact constructor if the domain requires it.
- Don't use records as an automatic substitute for all classes.
- Take advantage of automatic `toString`, `equals` and `hashCode`.
- Use records for DTOs, results and values.
- If you need setters or mutable state, use a normal class.

---

## 40. Things to keep in mind

- A record is a compact way to declare a data class.
- Its components are private and final.
- Java generates the constructor, the accessors, `toString`, `equals` and `hashCode`.
- The accessors are named like the components: `name()`, `price()`, etc.
- Records are immutable.
- They can have their own methods.
- They can have compact constructors.
- They can implement interfaces.
- They cannot extend other classes.
- They are ideal for simple data, DTOs and results.

---

## 41. Final summary

Records are a very useful tool in modern Java.

They allow you to write less code when you need to represent immutable data.

Instead of creating a long class with:

- private attributes
- a constructor
- getters
- `toString`
- `equals`
- `hashCode`

you can write:

```java
public record Product(String name, double price) {
}
```

This makes the code shorter, clearer, and less repetitive.

The main idea is:

- use records for immutable data
- use normal classes for objects with mutable state or complex behavior

Mastering records will help you write modern code, especially in applications that handle DTOs, results, configurations, and simple data structures.

---
In the next topic we'll keep moving forward with modern Java and look at **Sealed Classes**, a tool that lets you control which classes can extend or implement a hierarchy.
