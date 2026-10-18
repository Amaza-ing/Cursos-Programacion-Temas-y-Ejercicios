# Topic 38. Modules and Modern Java

## 1. Introduction

So far you have worked with many fundamental elements of Java:

- variables
- conditionals
- loops
- methods
- classes
- objects
- inheritance
- interfaces
- collections
- generics
- lambdas
- streams
-optional
- dates
- files
- records
- sealed classes
- basic concurrency

In this topic we are going to go one step further and see two important ideas:

- **the Java module system**
- **some features of modern Java**

Modules allow you to better organize large applications.  
Modern Java includes improvements designed to make the language clearer, more expressive, and more comfortable.

In this topic you will learn:

- What problem do the modules solve?
- What is a module in Java
- What is `module-info.java`
- How to use `requires`
- How to use `exports`
- How to organize packages within a module
- What is `java.base`
- What are `requires transitive` and `opens`
- What are `import module` statements
- What are compact source files?
- What modern features have you seen in the course
- How to think of Java as a language that continues to evolve

---

## 2. The problem of organizing large applications

In small projects, you can have a few classes:

```text
Main.java
User.java
Product.java
```

But in large applications you can have:

- dozens or hundreds of classes
- many packages
- external libraries
- separate layers
- dependencies between parts of the project
- code that should not be accessible from anywhere

Example:

```text
com.amazaing.app.users
com.amazaing.app.products
com.amazaing.app.orders
com.amazaing.app.database
com.amazaing.app.security
```

Packages help organize code, but they are not always enough to control dependencies and visibility well.

The modules appear there.

---

## 3. What is a module

A **module** is a unit of organization superior to the package.

A module can contain:

- packages
- classes
- interfaces
- records
- resources
- a dependency declaration
- a declaration of which packages it exposes to the outside

The idea is that a module can say:

- what do you need
- what does it offer
- what is hidden

---

## 4. Packages vs modules

### 4.1. Package

A package organizes classes.

Example:

```java
package com.amazaing.users;
```

It is used to group related classes.

### 4.2. Module

A module organizes packages and dependencies.

Example:

```java
module com.amazaing.app {
    exports com.amazaing.users;
}
```

A module can contain multiple packages.

---

## 5. What is `module-info.java`

A module is defined by a special file called:

```text
module-info.java
```

This file is placed at the root of the module source code.

Example:

```java
module com.amazaing.app {
}
```

This would be an empty module that does not yet export packages or declare dependencies.

---

## 6. Basic structure of a modular project

A modular project can have a structure like this:

```text
src
└── com.amazaing.app
    ├── module-info.java
    └── com
        └── amazaing
            └── app
                └── Main.java
```

The important file is:

```text
module-info.java
```

And inside the module is declared:

```java
module com.amazaing.app {
}
```

---

## 7. First module example

### 7.1. `module-info.java`

```java
module com.amazaing.app {
}
```

### 7.2. `Main.java`

```java
package com.amazaing.app;

public class Main {
    public static void main(String[] args) {
        System.out.println("Hello from a Java module");
    }
}
```

Here we have:

- a module called `com.amazaing.app`
- a package called `com.amazaing.app`
- a class `Main`

---

## 8. Module name

Module names usually follow a convention similar to packages.

Examples:

```text
com.amazaing.app
com.amazaing.users
com.amazaing.products
```

It is recommended to use unique and descriptive names.

Avoid names that are too generic like:

```text
app
users
core
```

Better:

```text
com.amazaing.app
com.amazaing.users
com.amazaing.core
```

---

## 9. `java.base`

All Java modules automatically depend on a module called:

```java
java.base
```

This module contains fundamental classes such as:

- `String`
- `Object`
- `Integer`
- `System`
- `Math`
- many basic Java classes

You don't need to write this:

```java
requires java.base;
```

because Java adds it automatically.

---

## 10. Use `requires`

When a module needs to use another module, it is declared with `requires`.

Example:

```java
module com.amazaing.app {
    requires java.sql;
}
```

This means:

> `com.amazaing.app` module needs `java.sql` module

`java.sql` contains database-related classes, such as JDBC.

---

## 11. Example with `requires java.sql`

### 11.1. `module-info.java`

```java
module com.amazaing.app {
    requires java.sql;
}
```

### 11.2. Class using `java.sql`

```java
package com.amazaing.app;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Main {
    public static void main(String[] args) {
        System.out.println("This module can use java.sql");
    }
}
```

If the module does not declare `requires java.sql`, you would not be able to properly access those classes in a modular project.

---

## 12. Use `exports`

By default, packages from one module are not exposed to other modules.

If you want a package to be used from outside, you must export it.

```java
module com.amazaing.users {
    exports com.amazaing.users;
}
```

This means:

> other modules can use the public classes from the `com.amazaing.users` package

---

## 13. Example with two modules

Imagine two modules:

```text
com.amazaing.users
com.amazaing.app
```

The `users` module contains the `User` class.

### 13.1. `com.amazaing.users/module-info.java`

```java
module com.amazaing.users {
    exports com.amazaing.users;
}
```

### 13.2. `User.java`

```java
package com.amazaing.users;

public class User {
    private String name;

    public User(String name) {
        this.name = name;
    }

    public String name() {
        return name;
    }
}
```

### 13.3. `com.amazaing.app/module-info.java`

```java
module com.amazaing.app {
    requires com.amazaing.users;
}
```

### 13.4. `Main.java`

```java
package com.amazaing.app;

import com.amazaing.users.User;

public class Main {
    public static void main(String[] args) {
        User user = new User("Laura");

        System.out.println(user.name());
    }
}
```

Here:

- `com.amazaing.users` exports your package
- `com.amazaing.app` requires the users module
- `Main` can use `User`

---

## 14. Packages not exported

A module can have internal packages that it does not export.

Example:

```java
module com.amazaing.users {
    exports com.amazaing.users.api;
}
```

Structure:

```text
com.amazaing.users.api
com.amazaing.users.internal
```

Only exported:

```text
com.amazaing.users.api
```

The internal package is hidden from other modules.

This helps separate:

- Public API
- internal implementation

---

## 15. Example of public API and internal implementation

```text
com.amazaing.users.api.UserService
com.amazaing.users.internal.FileUserRepository
```

`module-info.java`:

```java
module com.amazaing.users {
    exports com.amazaing.users.api;
}
```

Other modules can use:

```java
com.amazaing.users.api.UserService
```

But they should not directly access:

```java
com.amazaing.users.internal.FileUserRepository
```

---

## 16. Main advantage of modules

Modules allow a stronger level of encapsulation than packages.

With packages you can organize.  
With modules you can control which parts of the code are actually accessible from the outside.

This helps:

- reduce coupling
- protect internal details
- improve maintenance
- make dependencies clearer
- design cleaner APIs

---

## 17. `requires transitive`

Sometimes one module exposes types that belong to another module.

In that case it may make sense to use:

```java
requires transitive
```

Example:

```java
module com.amazaing.orders {
    requires transitive com.amazaing.users;
    exports com.amazaing.orders;
}
```

This means that whoever requires `com.amazaing.orders` will also have access to `com.amazaing.users`.

It is a more advanced concept, but it is worth knowing it.

---

## 18. Conceptual example of `requires transitive`

Imagine that you have:

```java
public class Order {
    private User user;

    public User getUser() {
        return user;
    }
}
```

If `Order` is part of the public API of the `orders` module, then users of that module also need to know the `User` type.

In that case `requires transitive` may make sense.

---

## 19. `exports ... to`

You can export a package only to specific modules.

```java
module com.amazaing.users {
    exports com.amazaing.users.internal to com.amazaing.app;
}
```

This means:

- the package is exported
- but only to the `com.amazaing.app` module

It is not usually necessary when starting out, but is useful in more controlled designs.

---

## 20. `opens`

`opens` allows opening a packet for reflection.

Reflection is a technique that allows classes, methods, and attributes to be inspected at runtime.

Some tools and frameworks use it.

Example:

```java
module com.amazaing.app {
    opens com.amazaing.app.models;
}
```

This is not the same as `exports`.

### 20.1. Simple difference

- `exports` allows using public classes from other modules
- `opens` allows access by reflection

For introductory courses, the important thing is to know the general difference.

---

## 21. `opens ... to`

You can also open a package only to a specific module.

```java
module com.amazaing.app {
    opens com.amazaing.app.models to com.fasterxml.jackson.databind;
}
```

This can be useful with libraries that convert objects to JSON or work with reflection.

---

## 22. `requires static`

`requires static` indicates a dependency that is required at compile time, but not required at runtime.

Example:

```java
module com.amazaing.app {
    requires static org.jetbrains.annotations;
}
```

It is a more advanced case.

It can appear with annotation libraries or analysis tools.

---

## 23. `uses` and `provides`

The module system can also work with services.

Example:

```java
uses com.amazaing.notifications.NotificationSender;
```

And another module can provide an implementation:

```java
provides com.amazaing.notifications.NotificationSender
        with com.amazaing.email.EmailNotificationSender;
```

This allows you to design extensible applications.

You don't need to master it yet, but it's good to know it exists.

---

## 24. Keyword summary in `module-info.java`

The most important ones are:

```java
requires
exports
opens
uses
provides
```

And some variants:

```java
requires transitive
requires static
exports ... to
opens ... to
```

To begin with, the most important ones are:

```java
requires
exports
```

---

## 25. Complete Example: Products Module

### 25.1. Structure

```text
src
├── com.amazaing.products
│   ├── module-info.java
│   └── com
│       └── amazaing
│           └── products
│               └── Product.java
└── com.amazaing.app
    ├── module-info.java
    └── com
        └── amazaing
            └── app
                └── Main.java
```

### 25.2. `com.amazaing.products/module-info.java`

```java
module com.amazaing.products {
    exports com.amazaing.products;
}
```

### 25.3. `Product.java`

```java
package com.amazaing.products;

import java.math.BigDecimal;

public record Product(String name, BigDecimal price) {
}
```

### 25.4. `com.amazaing.app/module-info.java`

```java
module com.amazaing.app {
    requires com.amazaing.products;
}
```

### 25.5. `Main.java`

```java
package com.amazaing.app;

import com.amazaing.products.Product;
import java.math.BigDecimal;

public class Main {
    public static void main(String[] args) {
        Product product = new Product("Mouse", new BigDecimal("19.99"));

        System.out.println(product);
    }
}
```

---

## 26. Compile modules from terminal

This section is more advanced, but it helps to understand how it works.

Let's assume this structure:

```text
src/com.amazaing.app/module-info.java
src/com.amazaing.app/com/amazing/app/Main.java
```

You could compile with:

```bash
javac -d out --module-source-path src -m com.amazaing.app
```

And run with:

```bash
java --module-path out -m com.amazaing.app/com.amazaing.app.Main
```

In real projects you will normally use an IDE or tools like Maven or Gradle, but knowing these commands helps you understand the basics.

---

## 27. Classpath vs module path

Before the module system, Java mainly used the **classpath**.

The classpath indicates where to look for classes and libraries.

With modules the **module path** appears.

### 27.1. Classpath

```text
Busca clases y librerías de forma tradicional.
```

### 27.2. Module path

```text
Busca módulos con información declarada en module-info.java.
```

At an initial level, you can think like this:

- traditional projects → classpath
- modular projects → module path

---

## 28. Do all Java projects need modules?

No.

Many Java projects do not use modules explicitly.

For example, many projects with:

-Spring
- Jakarta EE
-Maven
- Gradle
they can work without you writing an `module-info.java`.

This does not mean that the modules are not useful, but that they are not always necessary in initial courses or simple projects.

---

## 29. When to use modules

Modules can be useful when:

- you have a big application
- you want to separate parts clearly
- you want to control dependencies
- you want to hide internal packages
- you are creating libraries
- you want to design well-encapsulated APIs
- you want to take advantage of Java's modular system

---

## 30. When not to use modules yet

It may not be worth using them if:

- the project is small
- you are learning the basics
- you use frameworks that already manage the structure
- adding modules complicates more than it helps
- you still don't have a clear architecture

To start, it is enough to understand them and know how to recognize an `module-info.java`.

---

## 31. Modern Java: An Overview

Java has evolved a lot in recent years.

Although it long had a reputation for being very verbose, modern versions have added many improvements.

In this course you have already seen several:

- lambdas
- functional interfaces
- Stream API
-Optional
- Date/Time API
- records
- sealed classes
- virtual threads
- improvements in `switch`
- pattern matching
- modules

Modern Java seeks to be:

- more expressive
- safer
- clearer
- more comfortable to learn
- more prepared for large applications

---

## 32. Module Import Declarations

In modern Java there is a way to import all packages exported by a module with a single statement:

```java
import module java.base;
```

This is called:

- **Module Import Declaration**

The idea is to reduce many individual imports when you are using classes from the same module.

For example, instead of importing multiple concrete classes:

```java
import java.util.List;
import java.util.Map;
import java.util.Optional;
```

you can import the public classes exported by a module:

```java
import module java.base;
```

### 32.1. Important

This does not replace the complete module system.

It is not the same as `requires`.

- `requires` is written to `module-info.java`
- `import module` is written to an `.java` file

---

## 33. Conceptual example with `import module`

```java
import module java.base;

public class Main {
    public static void main(String[] args) {
        List<String> names = List.of("Laura", "Alex");

        Optional<String> firstName = names.stream()
                .findFirst();

        firstName.ifPresent(System.out::println);
    }
}
```

With `import module java.base`, classes exported by `java.base` can be made available without importing them one by one.

Even so, in many projects classic imports are still used because they are explicit and known to everyone.

---

## 34. Classic Imports vs `import module`

### 34.1. Classic imports

```java
import java.util.List;
import java.util.Optional;
```

Advantages:

- they are very explicit
- work on all previous modern versions
- they are family

### 34.2. `import module`

```java
import module java.base;
```

Advantages:

- can reduce repetitive imports
- fits with Java's modular organization
- can be comfortable in examples or small programs

For an initial course, it is a good idea to know it, but it is not mandatory to always use it.

---

## 35. Compact Source Files

Modern Java has also improved the way small programs are written.

Traditionally, the first Java program looked like this:

```java
public class Main {
    public static void main(String[] args) {
        System.out.println("Hello, Java");
    }
}
```

In modern Java, for simple programs you can write more compact code.

Example:

```java
void main() {
    System.out.println("Hello, Java");
}
```

This reduces the amount of code needed to get started.

It is especially useful for:

- learning
- small scripts
- simple examples
- first programs

---

## 36. Does this mean we don't need classes anymore?

No.

In real projects you will still use classes, packages and complete structures.

Compact source files are intended to make it easier to write small programs.

Learning example:

```java
void main() {
    System.out.println("Learning Java");
}
```

Example of a more structured project:

```java
public class Main {
    public static void main(String[] args) {
        Application app = new Application();
        app.run();
    }
}
```

Both styles can coexist.

---

## 37. Instance main methods

Related to the above, modern Java allows simpler `main` methods in certain contexts.

Classic shape:

```java
public static void main(String[] args) {
}
```

Simplest way:

```java
void main() {
}
```

This makes it easier to start without explaining concepts such as:

- `public`
- `static`
- `String[] args`

In a complete course, it is still important to understand the classical form, because you will constantly see it in projects and documentation.

---

## 38. Pattern matching with `instanceof`

You have already seen a modern way to use `instanceof`.

Before:

```java
if (value instanceof String) {
    String text = (String) value;
    System.out.println(text.length());
}
```

Now:

```java
if (value instanceof String text) {
    System.out.println(text.length());
}
```

Java automatically declares the `text` variable if the condition is met.

This reduces repetitive code and makes the program clearer.

---

## 39. Modern `switch`

Modern Java has also improved `switch`.

Traditional example:

```java
switch (status) {
    case "open":
        System.out.println("Open");
        break;
    case "closed":
        System.out.println("Closed");
        break;
    default:
        System.out.println("Unknown");
}
```

Modern shape:

```java
String message = switch (status) {
    case "open" -> "Open";
    case "closed" -> "Closed";
    default -> "Unknown";
};
```

Advantages:

- less code
- less `break`
- can return a value
- more expressive

---

## 40. `switch` with sealed classes

One of the most powerful combinations is:

- sealed interfaces
- records
- modern switch

Example:

```java
public sealed interface Result permits Success, Error {
}
```

```java
public record Success(String message) implements Result {
}
```

```java
public record Error(String reason) implements Result {
}
```

Usage:

```java
String text = switch (result) {
    case Success success -> success.message();
    case Error error -> error.reason();
};
```

Since the hierarchy is closed, Java can know which cases exist.

---

## 41. Records as part of modern Java

Records greatly reduce repetitive code for data classes.

Before:

```java
public class User {
    private final String name;
    private final String email;

    public User(String name, String email) {
        this.name = name;
        this.email = email;
    }

    public String getName() {
        return name;
    }

    public String getEmail() {
        return email;
    }
}
```

Now:

```java
public record User(String name, String email) {
}
```

This does not mean that all classes must be records.  
It means that Java offers a better tool for certain cases.

---

## 42. Sealed classes as part of modern Java

Sealed classes allow you to control hierarchies.

Example:

```java
public sealed interface PaymentResult permits PaymentSuccess, PaymentError {
}
```

This clearly communicates:

> a payment result can only be success or error

They are especially useful when combined with records.

---

## 43. Virtual threads as part of modern Java

Virtual threads allow you to create lightweight concurrent tasks.

Example:

```java
public class Main {
    public static void main(String[] args) throws InterruptedException {
        Thread thread = Thread.startVirtualThread(() -> {
            System.out.println("Running in a virtual thread");
        });

        thread.join();
    }
}
```

They don't replace everything that exists about concurrency, but they simplify many scenarios where there are many tasks waiting.

---

## 44. Text blocks

Text blocks allow you to write multi-line text more comfortably.

Example:

```java
String html = """
        <html>
            <body>
                <h1>Hello</h1>
            </body>
        </html>
        """;
```

They are useful for:

-HTML
-JSON
-SQL
- long messages
- templates

Example with JSON:

```java
String json = """
        {
            "name": "Laura",
            "email": "laura@example.com"
        }
        """;
```

---

## 45. `var`

Java allows you to infer the type of local variables with `var`.

Example:

```java
var name = "Laura";
var age = 28;
var users = List.of("Laura", "Alex");
```

Java deduces the type from the value.

### 45.1. When to use `var`

It can be useful when the type is obvious:

```java
var message = "Hello";
```

### 45.2. When to avoid it
Avoid it if it makes the code less clear:

```java
var result = service.process();
```

If you don't understand what type it returns, it may be better to write the type explicit.

---

## 46. Modern APIs that you have already seen

In this course you have also worked with modern APIs such as:

```java
java.time
java.nio.file
java.util.stream
java.util.Optional
java.math.BigDecimal
```

These APIs make Java more convenient and secure.

Examples:

```java
LocalDate.now()
Path.of("data", "notes.txt")
Optional.empty()
List.of("A", "B", "C")
```

---

## 47. Modern Java does not mean always using everything

Learning modern Java doesn't mean using everything new in every file.

The idea is to choose well.

Examples:

- use records for immutable data
- use normal classes for objects with changing state
- use sealed classes for closed hierarchies
- use enums for simple constants
- use streams when they improve clarity
- use loops when they are simpler
- use modules if the project needs it

Good programming is not about using the newest thing, but about using the right tool.

---

## 48. Complete Example – Simple Modern App

### 48.1. `module-info.java`

```java
module com.amazaing.app {
    exports com.amazaing.app;
}
```

### 48.2. `Product.java`

```java
package com.amazaing.app;

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

### 48.3. `ProductResult.java`

```java
package com.amazaing.app;

public sealed interface ProductResult permits ProductFound, ProductNotFound {
}
```

### 48.4. `ProductFound.java`

```java
package com.amazaing.app;

public record ProductFound(Product product) implements ProductResult {
}
```

### 48.5. `ProductNotFound.java`

```java
package com.amazaing.app;

public record ProductNotFound(String code) implements ProductResult {
}
```

### 48.6. `ProductService.java`

```java
package com.amazaing.app;

import java.math.BigDecimal;
import java.util.List;

public class ProductService {
    private List<Product> products = List.of(
            new Product("Mouse", new BigDecimal("19.99")),
            new Product("Keyboard", new BigDecimal("49.99")),
            new Product("Monitor", new BigDecimal("199.99"))
    );

    public ProductResult findByName(String name) {
        return products.stream()
                .filter(product -> product.name().equalsIgnoreCase(name))
                .findFirst()
                .<ProductResult>map(ProductFound::new)
                .orElse(new ProductNotFound(name));
    }
}
```

### 48.7. `Main.java`

```java
package com.amazaing.app;

public class Main {
    public static void main(String[] args) {
        ProductService service = new ProductService();

        ProductResult result = service.findByName("Mouse");

        String message = switch (result) {
            case ProductFound found -> "Product found: " + found.product();
            case ProductNotFound notFound -> "Product not found: " + notFound.code();
        };

        System.out.println(message);
    }
}
```

This example mixes several modern ideas:

- modules
- records
- sealed interfaces
- streams
-optional
- modern switch
- BigDecimal

---

## 49. How to learn modern Java without getting overwhelmed

Java has many tools, but you don't need to master them all at once.

A reasonable progression would be:

1. master classes, objects, collections and exceptions
2. understand generics
3. learn lambdas and streams
4. use Optional correctly
5. use modern APIs like Date/Time and Files
6. learn records and sealed classes
7. understand basic concurrency
8. Learn about modern modules and tools
9. Practice with complete projects

The goal is not to memorize syntax, but to understand what problem each tool solves.

---

## 50. Typical mistakes when getting started with modules and modern Java

### 50.1. Thinking that a package and a module are the same

They are not.

- package: organize classes
- module: organize packages and dependencies

### 50.2. Forget `exports`

If a module does not export a package, other modules will not be able to use it directly.

### 50.3. Confusing `requires` with `import`

- `requires` declares dependency between modules
- `import` allows using classes with shorter names within the code

### 50.4. Using modules in projects that are too simple

For small projects, they can add unnecessary complexity.

### 50.5. Use modern features without improving the code

Don't use records, streams, sealed classes or `var` just because they exist.  
Use them when they make the code clearer.

### 50.6. Abuse `var`

If the type is not obvious, writing it explicitly may be better.

---

## 51. Good practices

- Use packages to organize classes.
- Use modules when you need to control dependencies and visibility.
- Export only packages that are part of your public API.
- Keep internal packages without exporting.
- Use `requires` to declare real dependencies.
- Use records for immutable data.
- Use sealed classes for closed hierarchies.
- Use modern `switch` when clarity improves.
- Use streams for clear data flows.
- Use traditional loops when they are more readable.
- Learn the news as tools, not as obligations.

---

## 52. To take into account

- `module-info.java` defines a module.
- `requires` declares dependencies.
- `exports` exposes packets.
- `opens` allows access by reflection.
- `java.base` is available automatically.
- `import module` allows importing packages exported by a module.
- Compact source files simplify small programs.
- Modern Java includes records, sealed classes, streams, optional, virtual threads and improvements to `switch`.
- Not all projects need modules.
- The important thing is to choose the right tool for each case.

---

## 53. Final summary

The modules allow you to organize Java applications in a clearer and more controlled way.

With a file:

```java
module-info.java
```

you can declare:

```java
module com.amazaing.app {
    requires com.amazaing.products;
    exports com.amazaing.app;
}
```

This helps define what your module needs and what parts it exposes.

In addition, modern Java has added many improvements that make the language more comfortable and expressive:

- records
- sealed classes
- modern switch
- pattern matching
- virtual threads
- compact source files
- module import declarations
- Modern APIs like `java.time`, `java.nio.file` and `Stream API`

The main idea is that Java continues to evolve, but maintains a solid foundation.

To program well in modern Java you don't need to use all the new features at once.  
The important thing is to understand what problem each one solves and apply it when it improves your code.

---

In the next topic we will see how to work with **Maven**.
