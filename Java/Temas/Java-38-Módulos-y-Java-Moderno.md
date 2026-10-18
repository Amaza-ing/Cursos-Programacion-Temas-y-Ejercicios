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
- optional
- dates
- files
- records
- sealed classes
- basic concurrency

In this topic we're going to go one step further and look at two important ideas:

- **the Java module system**
- **some features of modern Java**

Modules allow you to better organize large applications.  
Modern Java includes improvements designed to make the language clearer, more expressive, and more convenient.

In this topic you will learn:

- What problem modules solve
- What a module is in Java
- What `module-info.java` is
- How to use `requires`
- How to use `exports`
- How to organize packages within a module
- What `java.base` is
- What `requires transitive` and `opens` are
- What `import module` declarations are
- What compact source files are
- Which modern features you've already seen in the course
- How to think of Java as a language that continues to evolve

---

## 2. The problem of organizing large applications

In small projects, you might have just a few classes:

```text
Main.java
User.java
Product.java
```

But in large applications you might have:

- dozens or hundreds of classes
- many packages
- external libraries
- separate layers
- dependencies between parts of the project
- code that shouldn't be accessible from just anywhere

Example:

```text
com.amazaing.app.users
com.amazaing.app.products
com.amazaing.app.orders
com.amazaing.app.database
com.amazaing.app.security
```

Packages help organize code, but they are not always enough to control dependencies and visibility well.

That's where modules come in.

---

## 3. What is a module?

A **module** is a unit of organization one level above the package.

A module can contain:

- packages
- classes
- interfaces
- records
- resources
- a dependency declaration
- a declaration of which packages it exposes to the outside

The idea is that a module can say:

- what it needs
- what it offers
- what it hides

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

## 5. What is `module-info.java`?

A module is defined by a special file called:

```text
module-info.java
```

This file is placed at the root of the module's source code.

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

And the module is declared inside it:

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
- a `Main` class

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

Avoid names that are too generic, such as:

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

## 10. Using `requires`

When a module needs to use another module, this is declared with `requires`.

Example:

```java
module com.amazaing.app {
    requires java.sql;
}
```

This means:

> the `com.amazaing.app` module needs the `java.sql` module

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

If the module didn't declare `requires java.sql`, it couldn't properly access those classes in a modular project.

---

## 12. Using `exports`

By default, a module's packages are not exposed to other modules.

If you want a package to be usable from outside, you must export it.

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

- `com.amazaing.users` exports its package
- `com.amazaing.app` requires the users module
- `Main` can use `User`

---

## 14. Non-exported packages

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

Only this is exported:

```text
com.amazaing.users.api
```

The internal package is hidden from other modules.

This helps separate:

- the public API
- the internal implementation

---

## 15. Example of a public API and an internal implementation

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

This helps you:

- reduce coupling
- protect internal details
- improve maintainability
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

It's a more advanced concept, but it's worth knowing about.

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

It is not usually necessary when starting out, but it is useful in more controlled designs.

---

## 20. `opens`

`opens` lets you open a package for reflection.

Reflection is a technique that lets you inspect classes, methods and attributes at runtime.

Some tools and frameworks use it.

Example:

```java
module com.amazaing.app {
    opens com.amazaing.app.models;
}
```

This is not the same as `exports`.

### 20.1. The difference, simply put

- `exports` allows public classes to be used from other modules
- `opens` allows access through reflection

In an introductory course, what matters is knowing the general difference.

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

You may come across it with annotation libraries or analysis tools.

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

## 24. Summary of the keywords in `module-info.java`

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

## 25. Complete example: a products module

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

## 26. Compiling modules from the terminal

This section is more advanced, but it helps you understand how it works.

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

The classpath tells Java where to look for classes and libraries.

Modules bring in the **module path**.

### 27.1. Classpath

```text
Busca clases y librerías de forma tradicional.
```

### 27.2. Module path

```text
Busca módulos con información declarada en module-info.java.
```

For now, you can think of it like this:

- traditional projects → classpath
- modular projects → module path

---

## 28. Do all Java projects need modules?

No.

Many Java projects do not use modules explicitly.

For example, many projects with:

- Spring
- Jakarta EE
- Maven
- Gradle
can work without you writing a `module-info.java`.

This doesn't mean modules aren't useful, just that they aren't always necessary in introductory courses or simple projects.

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
- adding modules makes things more complicated instead of helping
- you don't have a clear architecture yet

To start with, it's enough to understand them and be able to recognize a `module-info.java`.

---

## 31. Modern Java: an overview

Java has evolved a lot in recent years.

Although it long had a reputation for being very verbose, modern versions have added many improvements.

In this course you have already seen several:

- lambdas
- functional interfaces
- Stream API
- Optional
- Date/Time API
- records
- sealed classes
- virtual threads
- improvements to `switch`
- pattern matching
- modules

Modern Java aims to be:

- more expressive
- safer
- clearer
- easier to learn
- better suited to large applications

---

## 32. Module Import Declarations

In modern Java there is a way to import all packages exported by a module with a single declaration:

```java
import module java.base;
```

This is called:

- **Module Import Declaration**

The idea is to avoid lots of individual imports when you are using classes from the same module.

For example, instead of importing several specific classes:

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

This doesn't replace the full module system.

It is not the same as `requires`.

- `requires` is written in `module-info.java`
- `import module` is written in a `.java` file

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

With `import module java.base`, classes exported by `java.base` can be available without importing them one by one.

Even so, many projects still use classic imports because they are explicit and familiar to everyone.

---

## 34. Classic imports vs `import module`

### 34.1. Classic imports

```java
import java.util.List;
import java.util.Optional;
```

Advantages:

- they are very explicit
- they work in all earlier modern versions
- they are familiar

### 34.2. `import module`

```java
import module java.base;
```

Advantages:

- it can reduce repetitive imports
- it fits in with Java's modular organization
- it can be convenient in examples or small programs

In an introductory course, it's a good idea to know about it, but you don't have to use it all the time.

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

Example for learning:

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

Classic form:

```java
public static void main(String[] args) {
}
```

Simpler form:

```java
void main() {
}
```

This makes it easier to get started without having to explain, from minute one, concepts such as:

- `public`
- `static`
- `String[] args`

In a full course, it's still important to understand the classic form, because you'll see it all the time in projects and documentation.

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

Modern form:

```java
String message = switch (status) {
    case "open" -> "Open";
    case "closed" -> "Closed";
    default -> "Unknown";
};
```

Advantages:

- less code
- fewer `break` statements
- it can return a value
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

Since the hierarchy is closed, Java knows which cases exist.

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

They don't replace everything else in concurrency, but they simplify many scenarios where lots of tasks are waiting.

---

## 44. Text blocks

Text blocks let you write multi-line text more easily.

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

- HTML
- JSON
- SQL
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

Java can infer the type of local variables with `var`.

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

If it isn't clear what type it returns, it may be better to write the type explicitly.

---

## 46. Modern APIs you've already seen

In this course you have also worked with modern APIs such as:

```java
java.time
java.nio.file
java.util.stream
java.util.Optional
java.math.BigDecimal
```

These APIs make Java more convenient and safer.

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

## 48. Complete example: a simple modern application

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
- optional
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
8. get to know modules and modern tools
9. practice with complete projects

The goal is not to memorize syntax, but to understand what problem each tool solves.

---

## 50. Common mistakes when getting started with modules and modern Java

### 50.1. Thinking that a package and a module are the same

They are not.

- package: organizes classes
- module: organizes packages and dependencies

### 50.2. Forgetting `exports`

If a module does not export a package, other modules will not be able to use it directly.

### 50.3. Confusing `requires` with `import`

- `requires` declares a dependency between modules
- `import` lets you refer to classes by shorter names in your code

### 50.4. Using modules in projects that are too simple

For small projects, they can add unnecessary complexity.

### 50.5. Using modern features that don't improve the code

Don't use records, streams, sealed classes or `var` just because they exist.  
Use them when they make the code clearer.

### 50.6. Overusing `var`

If the type is not obvious, writing it explicitly may be better.

---

## 51. Best practices

- Use packages to organize classes.
- Use modules when you need to control dependencies and visibility.
- Export only packages that are part of your public API.
- Keep internal packages unexported.
- Use `requires` to declare real dependencies.
- Use records for immutable data.
- Use sealed classes for closed hierarchies.
- Use modern `switch` when it improves clarity.
- Use streams for clear data flows.
- Use traditional loops when they are more readable.
- Learn the new features as tools, not as obligations.

---

## 52. Things to keep in mind

- `module-info.java` defines a module.
- `requires` declares dependencies.
- `exports` exposes packages.
- `opens` allows access through reflection.
- `java.base` is available automatically.
- `import module` lets you import the packages exported by a module.
- Compact source files simplify small programs.
- Modern Java includes records, sealed classes, streams, optional, virtual threads and improvements to `switch`.
- Not all projects need modules.
- The important thing is to choose the right tool for each case.

---

## 53. Final summary

Modules let you organize Java applications in a clearer, more controlled way.

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

In addition, modern Java has added many improvements that make the language more convenient and expressive:

- records
- sealed classes
- modern switch
- pattern matching
- virtual threads
- compact source files
- module import declarations
- modern APIs like `java.time`, `java.nio.file` and `Stream API`

The main idea is that Java keeps evolving while keeping a solid foundation.

To program well in modern Java you don't need to use all the new features at once.  
The important thing is to understand what problem each one solves and apply it when it improves your code.

---

In the next topic we'll see how to work with **Maven**.
