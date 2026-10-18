# Exercises - Topic 19: Packages

Below you will find **10 practical exercises** on **packages**: creating the folder structure, the `package` declaration, using `import`, avoiding the _default package_, `package-private`, and a first contact with `static import`.

Try to solve them before looking at the solution.

---

## Exercise 1: Create a main package and a `Main`

Create a project with this main package:

```
app
```

Inside, create `Main.java` with:

- `package app;`
- A `main` method that prints `Hello packages`.

<details><summary>Show solution</summary>

```java
package app;

public class Main {
    public static void main(String[] args) {
        System.out.println("Hello packages");
    }
}
```

</details>

---

## Exercise 2: Create `model` and a `User` class

Create the package:

```
app.model
```

Inside, create `User.java` with:

- `private String name`
- `User(String name)` constructor
- `printInfo()` method that prints `User: name`

<details><summary>Show solution</summary>

```java
package app.model;

public class User {
    private String name;

    public User(String name) {
        this.name = name;
    }

    public void printInfo() {
        System.out.println("User: " + name);
    }
}
```

</details>

---

## Exercise 3: Import `User` from `Main`

Using what you did in exercise 2, in `Main.java` (package `app`) create a `User` and print its info.

You must use `import`.

<details><summary>Show solution</summary>

```java
package app;

import app.model.User;

public class Main {
    public static void main(String[] args) {
        User user = new User("Laura");
        user.printInfo();
    }
}
```

</details>

---

## Exercise 4: Use the fully qualified name without `import`

Repeat exercise 3, but this time **do not** use `import`.  
Create the `User` using the fully qualified name of the class.

<details><summary>Show solution</summary>

```java
package app;

public class Main {
    public static void main(String[] args) {
        app.model.User user = new app.model.User("Laura");
        user.printInfo();
    }
}
```

</details>

---

## Exercise 5: Two classes with the same name in different packages

Create two classes called `Logger` in:

- `app.utils.Logger`
- `app.service.Logger`

Each one must have a `log(String message)` method that prints:

- `UTILS: message`
- `SERVICE: message`

In `Main`, create an instance of each `Logger`.  
To avoid confusion, import one and use the full name for the other.

<details><summary>Show solution</summary>

```java
package app.utils;

public class Logger {
    public void log(String message) {
        System.out.println("UTILS: " + message);
    }
}
```

```java
package app.service;

public class Logger {
    public void log(String message) {
        System.out.println("SERVICE: " + message);
    }
}
```

```java
package app;

import app.utils.Logger;

public class Main {
    public static void main(String[] args) {
        Logger utilsLogger = new Logger();
        utilsLogger.log("Hello");

        app.service.Logger serviceLogger = new app.service.Logger();
        serviceLogger.log("Hi");
    }
}
```

</details>

---

## Exercise 6: `package-private` class (no modifier)

Create a class `InternalValidator` in `app.model` without `public` (package-private).

It must have a method `isValidName(String name)` that returns `true` if:

- it is not `null`
- it is not blank (`isBlank()`)

Then, in `User` (same package `app.model`), create a method `setName(String name)` that uses `InternalValidator`.

<details><summary>Show solution</summary>

```java
package app.model;

class InternalValidator {
    boolean isValidName(String name) {
        return name != null && !name.isBlank();
    }
}
```

```java
package app.model;

public class User {
    private String name;

    public User(String name) {
        setName(name);
    }

    public void setName(String name) {
        InternalValidator validator = new InternalValidator();

        if (!validator.isValidName(name)) {
            this.name = "Unknown";
            return;
        }

        this.name = name;
    }

    public void printInfo() {
        System.out.println("User: " + name);
    }
}
```

</details>

---

## Exercise 7: Test that `package-private` is not accessible from another package

With exercise 6 done, in `Main` (package `app`) try to create `InternalValidator`.  
It should fail (it doesn't compile). Leave the code commented out.

<details><summary>Show solution</summary>

```java
package app;

import app.model.User;

public class Main {
    public static void main(String[] args) {
        User user = new User("Laura");
        user.printInfo();

        // app.model.InternalValidator v = new app.model.InternalValidator(); // no compila
    }
}
```

</details>

---

## Exercise 8: Reorganize the structure with `Refactor > Move` (theory and practice)

Imagine you have a class `Order` in `app.model`, but you want to move it to:

```
app.domain
```

Write down the changes that must be made to the `Order.java` file:

1. The correct `package ...;` line
2. The imports that change in the classes that use `Order`

You don't need to run anything: just write an example of how it would look.

<details><summary>Show solution</summary>

```java
// Antes (en app.model)
package app.model;

public class Order {
}
```

```java
// Después (movida a app.domain)
package app.domain;

public class Order {
}
```

```java
// En una clase que antes tenía:
import app.model.Order;

// ahora debería tener:
import app.domain.Order;
```

</details>

---

## Exercise 9: `import *` vs explicit imports

Create three classes in `app.model`:

- `User`
- `Product`
- `Order`

In `Main`, write two versions:

1. Explicit imports of the three classes
2. A wildcard import with `import app.model.*;`

You don't need to instantiate anything, just show what the imports would look like.

<details><summary>Show solution</summary>

```java
// Versión 1: imports explícitos
import app.model.User;
import app.model.Product;
import app.model.Order;
```

```java
// Versión 2: comodín
import app.model.*;
```

</details>

---

## Exercise 10: `static import` with `Math`

In `Main`, calculate:

- The area of a circle with radius `r = 3` using `PI`
- The square root of `81` using `sqrt`

Use `static import` to be able to write `PI` and `sqrt(...)` without `Math.`.

<details><summary>Show solution</summary>

```java
package app;

import static java.lang.Math.PI;
import static java.lang.Math.sqrt;

public class Main {
    public static void main(String[] args) {
        double r = 3;
        double area = PI * r * r;

        System.out.println(area);
        System.out.println(sqrt(81));
    }
}
```

</details>

---
