# Topic 19. Packages: organize the project structure

## 1. Introduction

As your Java projects grow, you start to have many classes:

- `User`, `Product`, `Order`, `BankAccount`…
- “Utility” classes such as `Calculator`, `StringUtils`…
- Entry classes like `Main`
- Later: drivers, services, repositories, etc.

If all classes are in the same place, the project becomes difficult to maintain:

- Hard to find files
- Duplicate names appear
- Responsibilities are mixed
- You lose clarity when navigating the code

To avoid this, Java has **packages**, which are used to:

- Organize classes in “logical folders”
- Avoid name collisions (two classes can have the same name in different packages)
- Control visibility using the _package-private_ modifier (no modifier)
- Maintain a professional and scalable structure

In this topic you will learn:

- What is a package and how to write it
- How to organize a project in IntelliJ
- Package naming conventions
- How `import` works
- How to avoid _default package_
- Visibility: `public`, `private`, `protected` and _package-private_
- Complete examples with real folder structure

---

[![Packages](https://img.youtube.com/vi/sb64sWsv4m4/0.jpg)](https://www.youtube.com/watch?v=sb64sWsv4m4&list=PLzA2VyZwsq_-30Z1c9LjWZpq24Kf-2MjD)

---

## 2. What is a package

A **package** is a “namespace” that groups related classes.

In code, it is declared with the word `package` at the beginning of the file:

```java
package com.mycompany.app;
```

Important rules:

- Must be **the first real line** of the file (before `import` and before the class)
- The package name must match the folder path within `src`

Example:

If your file is in:

```
src/com/mycompany/app/Main.java
```

So above you should put:

```java
package com.mycompany.app;
```

---

## 3. Package naming conventions (very important)

In Java, the standard convention for packages is:

- **all lowercase**
- using inverted domain (to avoid collisions)
- separating levels with `.`

Typical examples:

- `com.companyname.projectname`
- `com.amazaing.javacurso`
- `org.example.myapp`

Why inverted domain:

- Two people could create a package called `utils`
- But it is very unlikely that two projects share exactly `com.amazaing.utils`

---

## 4. Recommended project structure

A typical (simple and very common) structure could be:

```
src/
  com/amazaing/java25/
    Main.java
    model/
      User.java
      Product.java
      Order.java
    service/
      UserService.java
    utils/
      Calculator.java
      StringUtils.java
```

Idea:

- `model`: data classes (entities)
- `service`: business logic
- `utils`: supporting functions (if that makes sense)

---

## 5. Create packages in IntelliJ (step by step)

### 5.1. Create a package

1. Open the **Project** panel
2. Go to `src`
3. Right click → **New** → **Package**
4. Write the name, for example:

```
com.amazaing.java25.model
```

IntelliJ will automatically create the folders.

### 5.2. Create a class inside a package

1. Right click on the package (`model`)
2. **New** → **Java Class**
3. Type the name, for example: `User`

IntelliJ will automatically add the `package ...;` line to the file.

---

## 6. Example 1: `Main` in a main package and `User` in `model`
### 6.1. Structure

```
src/
  com/amazaing/java25/
    Main.java
    model/
      User.java
```

### 6.2. `User.java`

Route:

```
src/com/amazaing/java25/model/User.java
```

Content:

```java
package com.amazaing.java25.model;

public class User {
    private String name;
    private int age;

    public User(String name, int age) {
        this.name = name;
        this.age = age;
    }

    public void printInfo() {
        System.out.println("Name: " + name + " | Age: " + age);
    }
}
```

### 6.3. `Main.java`

Route:

```
src/com/amazaing/java25/Main.java
```

Content:

```java
package com.amazaing.java25;

import com.amazaing.java25.model.User;

public class Main {
    public static void main(String[] args) {
        User user = new User("Laura", 28);
        user.printInfo();
    }
}
```

Look at:

- `Main` and `User` are in different packages
- That's why we need `import com.amazaing.java25.model.User;`

---

## 7. `import` – how it works

When you use a class from another package, you have two options:

1. Use `import`
2. Use the fully qualified name

### 7.1. Use `import` (normal)

```java
import com.amazaing.java25.model.User;
```

Then you can write:

```java
User user = new User("Laura", 28);
```

### 7.2. Use full name (not recommended for always writing)

```java
com.amazaing.java25.model.User user =
        new com.amazaing.java25.model.User("Laura", 28);
```

It is rarely used because it messes up the code, but it is useful to understand what is happening.

---

## 8. Import multiple classes from the same package

If you have multiple classes in `model`:

- `User`
- `Product`
- `Order`

You can import them one by one:

```java
import com.amazaing.java25.model.User;
import com.amazaing.java25.model.Product;
import com.amazaing.java25.model.Order;
```

Or use wildcard (not usually recommended in large professional projects, but in learning it is valid):

```java
import com.amazaing.java25.model.*;
```

---

## 9. The _default package_ and why avoid it

If you create a class directly in `src` without a package, it will be in the **default package** (without `package ...;`).

This works on very small projects, but is bad practice because:

- You can't organize your project well
- Can cause problems with tools and tests
- It is difficult to maintain
- In real projects it is almost never used

**Recommendation:** use packages from day one.

---

## 10. Visibility and packages: _package-private_

In addition to `public`, `private`, `protected`, there is a “modifier” that is not written:

- **no modifier** → _package-private_

It means:

> Accessible only from classes in the same package.

Example:

```java
package com.amazaing.java25.model;

class InternalHelper {
    void doWork() {
        System.out.println("Working...");
    }
}
```

- `InternalHelper` is not `public`
- Can only be used from `com.amazaing.java25.model`

---

## 11. Example 2: `package-private` in action

### 11.1. `InternalHelper.java` (package-private)

```java
package com.amazaing.java25.model;

class InternalHelper {
    void log(String message) {
        System.out.println("LOG: " + message);
    }
}
```

### 11.2. `User.java` (same package)

```java
package com.amazaing.java25.model;

public class User {
    private String name;

    public User(String name) {
        this.name = name;
    }

    public void printInfo() {
        InternalHelper helper = new InternalHelper();
        helper.log("Printing user: " + name);
        System.out.println("Name: " + name);
    }
}
```

This works because they are in the same package.

### 11.3. Attempt from `Main` (another package)

```java
package com.amazaing.java25;

import com.amazaing.java25.model.InternalHelper; // NO compila
```

It doesn't compile, because `InternalHelper` is not visible outside the package.

---

## 12. `protected` and packages (key idea)

`protected` allows access:

- within the same package
- and from subclasses (even if they are in another package)

This is relevant when you work with inheritance.  
As a general rule for this course:

- Maintain `private` attributes
- Expose getters/setters or methods

---

## 13. `static import` (optional, but useful)

Sometimes you want to use static methods without writing the class name.

Instead of:

```java
double root = Math.sqrt(25);
```

You can do:

```java
import static java.lang.Math.sqrt;

double root = sqrt(25);
```

### 13.1. Complete example

```java
import static java.lang.Math.sqrt;
import static java.lang.Math.PI;

public class Main {
    public static void main(String[] args) {
        double r = 3.0;
        double area = PI * r * r;

        System.out.println(area);
        System.out.println(sqrt(81));
    }
}
```

---

## 14. Move classes between packages in IntelliJ (without breaking anything)

Steps:

1. Right click on the class (or package)
2. **Refactor** → **Move**
3. Select the new package
4. IntelliJ updates automatically:
   - the `package ...;` line
   - the `import ...;` where that class is used

---

## 15. Typical errors when working with packages

### 15.1. Package name does not match folder
If the file is in `src/es/app/model/User.java` but at the top it says:

```java
package es.other.model;
```

Then you will have errors.  
The path and package must match.

### 15.2. Forget `import`

If you are using a class from another package and you don't import it, Java doesn't recognize it (unless you use the full name).

### 15.3. Confusing packages with “any” folders

In Java, it's not just “a pretty folder”:

- the folder represents the package
- and the package defines how the class is found

---

## 16. Good practices

- Use packages from the beginning (avoid the default package).
- Follows the inverted domain convention (`com.amazaing...`).
- Separate by responsibility: `model`, `service`, `utils`, etc.
- Use `package-private` for internal stuff when it makes sense.
- Do not abuse `import *` in large projects.
- Use IntelliJ to move/rename with refactor and avoid errors.

---

## 17. To take into account

- A package organizes classes and avoids name collisions.
- `package ...;` must go to the beginning and match the file path.
- `import` allows you to use classes from other packages cleanly.
- The _default package_ is bad practice in serious projects.
- _package-private_ (no switch) limits access to the same package.
- IntelliJ can refactor and update imports automatically.

---

In the next topic we will continue advancing with more advanced concepts of Object-Oriented Programming in Java with **Abstract Classes and Abstract Methods**.
