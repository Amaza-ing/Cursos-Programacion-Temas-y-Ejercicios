# Topic 35. Sealed Classes

## 1. Introduction

In previous topics you have learned important concepts of Object-Oriented Programming:

- inheritance
- abstract classes
- interfaces
- records
- polymorphism

Now we are going to study a modern Java tool that allows us to better control class hierarchies:

- **sealed classes**
- **sealed interfaces**

A sealed class allows you to explicitly indicate which classes can inherit from it.

This is very useful when you want to design a closed and controlled hierarchy.

Typical examples:

- result types: success or error
- payment types: card, PayPal or transfer
- geometric shapes: circle, rectangle or triangle
- states of an operation
- possible responses from an API
- types of events

In this topic you will learn:

- What a sealed class is
- What problem it solves
- How to use `sealed`
- What `permits` is for
- What `final`, `sealed` and `non-sealed` mean
- How to use sealed classes with inheritance
- How to use sealed interfaces
- How to combine sealed interfaces with records
- When to use sealed classes and when not to
- Common mistakes and best practices

---

## 2. The problem: hierarchies that are too open

When you create a normal class, other classes can inherit from it unless you prevent it with `final`.

Example:

```java
public class PaymentMethod {
}
```

Now any class could do this:

```java
public class CardPayment extends PaymentMethod {
}
```

```java
public class PaypalPayment extends PaymentMethod {
}
```

But an unexpected class could also appear:

```java
public class StrangePayment extends PaymentMethod {
}
```

In some cases that is fine.  
But in others you want to control exactly which subclasses are valid.

That's where sealed classes come in.

---

## 3. What is a sealed class?

A **sealed class** is a class that limits which other classes can inherit from it.

It is declared with the keyword:

```java
sealed
```

Example:

```java
public sealed class PaymentMethod permits CardPayment, PaypalPayment {
}
```

This means:

- `PaymentMethod` is a sealed class
- only `CardPayment` and `PaypalPayment` can inherit from it

---

## 4. First basic example

### 4.1. Sealed parent class

```java
public sealed class PaymentMethod permits CardPayment, PaypalPayment {
}
```

### 4.2. Allowed subclass

```java
public final class CardPayment extends PaymentMethod {
}
```

### 4.3. Another allowed subclass

```java
public final class PaypalPayment extends PaymentMethod {
}
```

### 4.4. Class not allowed

This doesn't compile:

```java
// public final class CashPayment extends PaymentMethod {
// }
```

Why?

Because `CashPayment` is not in the `permits` list.

---

## 5. What `permits` is for

The `permits` keyword indicates which classes are allowed to inherit.

```java
public sealed class Shape permits Circle, Rectangle, Triangle {
}
```

Here, only these classes can inherit directly from `Shape`:

- `Circle`
- `Rectangle`
- `Triangle`

No other class can extend `Shape`.

---

## 6. Subclasses must declare their intent

When a class inherits from a sealed class, it must specify one of these three options:

- `final`
- `sealed`
- `non-sealed`

Example:

```java
public final class Circle extends Shape {
}
```

This is mandatory.

Java wants each subclass to clearly say whether the hierarchy ends there or continues.

---

## 7. Option 1: `final`

A `final` subclass does not allow further inheritance.

```java
public final class Circle extends Shape {
}
```

This means:

- `Circle` inherits from `Shape`
- no one can inherit from `Circle`

Invalid example:

```java
// public class SmallCircle extends Circle {
// }
```

---

## 8. Option 2: `sealed`
A subclass can also be sealed.

```java
public sealed class Rectangle extends Shape permits Square {
}
```

This means:

- `Rectangle` inherits from `Shape`
- `Rectangle` allows only `Square` to inherit from it

Subclass:

```java
public final class Square extends Rectangle {
}
```

The hierarchy remains controlled.

---

## 9. Option 3: `non-sealed`

A `non-sealed` subclass reopens inheritance.

```java
public non-sealed class Triangle extends Shape {
}
```

This means:

- `Triangle` can inherit from `Shape`
- but other classes can inherit from `Triangle`

Example:

```java
public class RightTriangle extends Triangle {
}
```

`non-sealed` lifts the restriction from that class downwards.

---

## 10. Summary of `final`, `sealed` and `non-sealed`

When a class inherits from a sealed class, it must choose:

### 10.1. `final`

Inheritance ends here.

```java
public final class Circle extends Shape {
}
```

### 10.2. `sealed`

Inheritance continues, but it stays under control.

```java
public sealed class Rectangle extends Shape permits Square {
}
```

### 10.3. `non-sealed`

Inheritance is opened up again.

```java
public non-sealed class Triangle extends Shape {
}
```

---

## 11. Complete example: geometric shapes

### 11.1. `Shape.java`

```java
public sealed abstract class Shape permits Circle, Rectangle {
    public abstract double area();
}
```

### 11.2. `Circle.java`

```java
public final class Circle extends Shape {
    private double radius;

    public Circle(double radius) {
        if (radius <= 0) {
            this.radius = 1.0;
            return;
        }

        this.radius = radius;
    }

    @Override
    public double area() {
        return Math.PI * radius * radius;
    }
}
```

### 11.3. `Rectangle.java`

```java
public final class Rectangle extends Shape {
    private double width;
    private double height;

    public Rectangle(double width, double height) {
        if (width <= 0) {
            this.width = 1.0;
        } else {
            this.width = width;
        }

        if (height <= 0) {
            this.height = 1.0;
        } else {
            this.height = height;
        }
    }

    @Override
    public double area() {
        return width * height;
    }
}
```

### 11.4. `Main.java`

```java
public class Main {
    public static void main(String[] args) {
        Shape shape1 = new Circle(3.0);
        Shape shape2 = new Rectangle(4.0, 2.0);

        System.out.println(shape1.area());
        System.out.println(shape2.area());
    }
}
```

Here `Shape` is an abstract and sealed class.

That means:

- it can't be instantiated directly
- only the allowed classes can inherit from it

---

## 12. Sealed abstract class

A sealed class can be abstract.

This is very common.

```java
public sealed abstract class Animal permits Dog, Cat {
    private String name;

    public Animal(String name) {
        this.name = name;
    }

    public String name() {
        return name;
    }

    public abstract void makeSound();
}
```

Subclasses:

```java
public final class Dog extends Animal {
    public Dog(String name) {
        super(name);
    }

    @Override
    public void makeSound() {
        System.out.println("Woof");
    }
}
```

```java
public final class Cat extends Animal {
    public Cat(String name) {
        super(name);
    }

    @Override
    public void makeSound() {
        System.out.println("Meow");
    }
}
```

---

## 13. Sealed interfaces

Not only classes can be sealed.  
You can also create sealed interfaces.

Example:

```java
public sealed interface PaymentResult permits PaymentSuccess, PaymentError {
}
```

This means that only allowed classes or records can implement that interface.

---

## 14. Sealed interfaces with records

A very modern and useful combination is:

- sealed interface
- records

Example:

```java
public sealed interface PaymentResult permits PaymentSuccess, PaymentError {
}
```

```java
public record PaymentSuccess(String transactionId) implements PaymentResult {
}
```

```java
public record PaymentError(String message) implements PaymentResult {
}
```

Here we have two possible results:

- successful payment
- failed payment

And the hierarchy is closed.

---

## 15. Why records fit well with sealed interfaces

Records are immutable and represent data.

Sealed interfaces let you close a family of types.

Together, they are very useful for representing possible outcomes.

Conceptual example:

```text
PaymentResult
    PaymentSuccess
    PaymentError
```

The result of a payment can only be one of those types.

---

## 16. Complete example: payment result

### 16.1. `PaymentResult.java`

```java
public sealed interface PaymentResult permits PaymentSuccess, PaymentError {
}
```

### 16.2. `PaymentSuccess.java`

```java
public record PaymentSuccess(String transactionId) implements PaymentResult {
}
```

### 16.3. `PaymentError.java`

```java
public record PaymentError(String message) implements PaymentResult {
}
```

### 16.4. `PaymentService.java`

```java
public class PaymentService {
    public PaymentResult processPayment(double amount) {
        if (amount <= 0) {
            return new PaymentError("Amount must be positive");
        }

        return new PaymentSuccess("TX-12345");
    }
}
```

### 16.5. `Main.java`

```java
public class Main {
    public static void main(String[] args) {
        PaymentService service = new PaymentService();

        PaymentResult result = service.processPayment(49.99);

        System.out.println(result);
    }
}
```

This design is more expressive than returning `null`, a `boolean` or a loose piece of text.

---

## 17. Working with `instanceof`

Since `PaymentResult` can be multiple types, you can use `instanceof` to distinguish them.

```java
public class Main {
    public static void main(String[] args) {
        PaymentResult result = new PaymentSuccess("TX-12345");

        if (result instanceof PaymentSuccess success) {
            System.out.println("Payment completed: " + success.transactionId());
        } else if (result instanceof PaymentError error) {
            System.out.println("Payment failed: " + error.message());
        }
    }
}
```

Here we use pattern matching with `instanceof`, which allows you to declare the variable directly:

```java
result instanceof PaymentSuccess success
```

---

## 18. Sealed classes and `switch`

Sealed classes work really well with `switch`, because Java knows every possible type in a closed hierarchy.

Example:

```java
public static String getMessage(PaymentResult result) {
    return switch (result) {
        case PaymentSuccess success -> "Payment completed: " + success.transactionId();
        case PaymentError error -> "Payment failed: " + error.message();
    };
}
```

Since `PaymentResult` is sealed and only allows two types, the `switch` can cover all cases.

---

## 19. Complete example with `switch`

```java
public class Main {
    public static void main(String[] args) {
        PaymentResult result = new PaymentError("Invalid card");

        String message = switch (result) {
            case PaymentSuccess success -> "Payment completed: " + success.transactionId();
            case PaymentError error -> "Payment failed: " + error.message();
        };

        System.out.println(message);
    }
}
```

This style is very expressive for closed hierarchies.

---

## 20. Example: task states

Imagine that a task can be in one of several states:

- pending
- in progress
- completed
- canceled

We can model it with a sealed interface.

### 20.1. `TaskStatus.java`

```java
public sealed interface TaskStatus permits Pending, InProgress, Completed, Cancelled {
}
```

### 20.2. State records

```java
public record Pending() implements TaskStatus {
}
```

```java
public record InProgress(String assignedTo) implements TaskStatus {
}
```

```java
public record Completed(String completedBy) implements TaskStatus {
}
```

```java
public record Cancelled(String reason) implements TaskStatus {
}
```

### 20.3. Usage

```java
public class Main {
    public static void main(String[] args) {
        TaskStatus status = new InProgress("Laura");

        String text = switch (status) {
            case Pending pending -> "Task is pending";
            case InProgress inProgress -> "Assigned to: " + inProgress.assignedTo();
            case Completed completed -> "Completed by: " + completed.completedBy();
            case Cancelled cancelled -> "Cancelled: " + cancelled.reason();
        };

        System.out.println(text);
    }
}
```

This design allows each state to have its own data.

---

## 21. Difference between enum and sealed classes

Sometimes an `enum` also works for representing a closed set of options.

Example:

```java
public enum Status {
    PENDING,
    IN_PROGRESS,
    COMPLETED,
    CANCELLED
}
```

This is simple and very useful.

But an enum has a limitation:

- its constants can't usually carry different data structures as flexibly

With sealed classes or sealed interfaces, each case can have its own data.

Example:

```java
public record InProgress(String assignedTo) implements TaskStatus {
}
```

```java
public record Cancelled(String reason) implements TaskStatus {
}
```

Each state can have its own specific information.

---

## 22. When to use an enum

Use `enum` when:

- you have a fixed set of simple constants
- the cases don't need different data
- you want something direct and easy to read

Example:

```java
public enum UserRole {
    ADMIN,
    USER,
    GUEST
}
```

---

## 23. When to use sealed classes

Use sealed classes or sealed interfaces when:

- you have a closed set of types
- each type can have different data
- you want to take advantage of polymorphism
- you want to control the hierarchy
- you want to model complex results or states

Example:

```java
public sealed interface LoginResult permits LoginSuccess, LoginError {
}
```

```java
public record LoginSuccess(String username) implements LoginResult {
}
```

```java
public record LoginError(String message) implements LoginResult {
}
```

---

## 24. Complete example: login result

### 24.1. `LoginResult.java`

```java
public sealed interface LoginResult permits LoginSuccess, LoginError {
}
```

### 24.2. `LoginSuccess.java`

```java
public record LoginSuccess(String username) implements LoginResult {
}
```

### 24.3. `LoginError.java`

```java
public record LoginError(String message) implements LoginResult {
}
```

### 24.4. `LoginService.java`

```java
public class LoginService {
    public LoginResult login(String username, String password) {
        if (username == null || username.isBlank()) {
            return new LoginError("Username is required");
        }

        if (password == null || password.length() < 4) {
            return new LoginError("Password is too short");
        }

        if (username.equals("admin") && password.equals("1234")) {
            return new LoginSuccess(username);
        }

        return new LoginError("Invalid credentials");
    }
}
```

### 24.5. `Main.java`

```java
public class Main {
    public static void main(String[] args) {
        LoginService service = new LoginService();

        LoginResult result = service.login("admin", "1234");

        String message = switch (result) {
            case LoginSuccess success -> "Welcome, " + success.username();
            case LoginError error -> "Login failed: " + error.message();
        };

        System.out.println(message);
    }
}
```

---

## 25. Example with a sealed class and a `non-sealed` subclass

Sometimes you want to control part of the hierarchy, but leave a branch open.

```java
public sealed class Notification permits EmailNotification, CustomNotification {
}
```

```java
public final class EmailNotification extends Notification {
}
```

```java
public non-sealed class CustomNotification extends Notification {
}
```

Now this is valid:

```java
public class SmsNotification extends CustomNotification {
}
```

Because `CustomNotification` is `non-sealed`.

---

## 26. Example with a sealed subclass

You can also build a hierarchy in levels.

```java
public sealed class Vehicle permits Car, Motorcycle {
}
```

```java
public sealed class Car extends Vehicle permits ElectricCar, GasCar {
}
```

```java
public final class ElectricCar extends Car {
}
```

```java
public final class GasCar extends Car {
}
```

```java
public final class Motorcycle extends Vehicle {
}
```

Here:

- `Vehicle` controls its direct subclasses
- `Car` also controls its own subclasses

---

## 27. Important rules

To work with sealed classes, remember these rules:

- a sealed class uses `sealed`
- it must state which classes it allows with `permits`
- each direct subclass must be `final`, `sealed` or `non-sealed`
- a disallowed class cannot inherit from the sealed one
- records can implement sealed interfaces
- a sealed interface can be implemented by allowed classes, records or enums

---

## 28. File organization

Typically each class will be in its own file.

Example:

```text
PaymentResult.java
PaymentSuccess.java
PaymentError.java
PaymentService.java
Main.java
```

If you use packages, all these classes must be correctly organized and imported.

Example:

```java
package com.amazaing.java25.payment;
```

---

## 29. Sealed classes and packages

When you work without modules, the allowed subclasses are usually in the same package as the sealed class.

Example:

```java
package com.amazaing.java25.payment;

public sealed interface PaymentResult permits PaymentSuccess, PaymentError {
}
```

```java
package com.amazaing.java25.payment;

public record PaymentSuccess(String transactionId) implements PaymentResult {
}
```

```java
package com.amazaing.java25.payment;

public record PaymentError(String message) implements PaymentResult {
}
```

In an introductory course, what matters is keeping the hierarchy clear and in the same package.

---

## 30. Sealed classes and domain design

Sealed classes are very useful for modeling domains where you know all the possible cases.

Examples:

- payment result
- login result
- task states
- application events
- user commands
- validation responses
- message types

Conceptual example:

```text
ValidationResult
    Valid
    Invalid
```

This communicates the intent of the code much better.

---

## 31. Complete example: validation

### 31.1. `ValidationResult.java`

```java
public sealed interface ValidationResult permits Valid, Invalid {
}
```

### 31.2. `Valid.java`

```java
public record Valid() implements ValidationResult {
}
```

### 31.3. `Invalid.java`

```java
public record Invalid(String message) implements ValidationResult {
}
```

### 31.4. `UserValidator.java`

```java
public class UserValidator {
    public ValidationResult validateUsername(String username) {
        if (username == null || username.isBlank()) {
            return new Invalid("Username cannot be blank");
        }

        if (username.length() < 3) {
            return new Invalid("Username is too short");
        }

        return new Valid();
    }
}
```

### 31.5. `Main.java`

```java
public class Main {
    public static void main(String[] args) {
        UserValidator validator = new UserValidator();

        ValidationResult result = validator.validateUsername("Al");

        String message = switch (result) {
            case Valid valid -> "Valid username";
            case Invalid invalid -> "Invalid username: " + invalid.message();
        };

        System.out.println(message);
    }
}
```

---

## 32. Advantages of sealed classes

The main advantages are:

- you control who can inherit
- you make the design clearer
- you avoid unexpected subclasses
- you get more out of `switch`
- you model results and states better
- they work very well with records
- you make the intent of the code more explicit

---

## 33. Limitations of sealed classes

They also have limitations:

- can add complexity if used unnecessarily
- require careful thought about the hierarchy
- are not ideal for systems that anyone should be able to extend
- may be excessive for very simple cases

As always, the tool should be used when it fits the problem.

---

## 34. Sealed class vs normal abstract class

### 34.1. Normal abstract class

It allows open inheritance.

```java
public abstract class Shape {
}
```

Any class can extend it, as long as it has access.

### 34.2. Sealed abstract class

It allows controlled inheritance.

```java
public sealed abstract class Shape permits Circle, Rectangle {
}
```

Only allowed classes can extend it.

---

## 35. Sealed interface vs normal interface

### 35.1. Normal interface

```java
public interface PaymentResult {
}
```

Any class can implement it.

### 35.2. Sealed interface

```java
public sealed interface PaymentResult permits PaymentSuccess, PaymentError {
}
```

Only allowed classes or records can implement it.

---

## 36. When not to use sealed classes

Don't use sealed classes if:

- you want other developers to be able to freely extend
- the hierarchy may grow in ways you can't control in advance
- a simple `enum` solves the problem
- a normal class is clearer
- you are modeling objects with very open behavior

Example:

```java
public interface Plugin {
    void execute();
}
```

If you want anyone to be able to create new plugins, you don't want to seal the interface.

---

## 37. Common beginner mistakes

### 37.1. Forgetting `permits`

```java
public sealed class Shape {
}
```

In many cases you'll need to state which subclasses are allowed.

```java
public sealed class Shape permits Circle, Rectangle {
}
```

### 37.2. Forgetting `final`, `sealed` or `non-sealed`

This doesn't compile:

```java
public class Circle extends Shape {
}
```

It must be:

```java
public final class Circle extends Shape {
}
```

### 37.3. Trying to extend a sealed class without permission

```java
// public final class Triangle extends Shape { } // error si no aparece en permits
```

### 37.4. Using sealed classes when an enum would be enough

If you only have simple constants, an `enum` is probably clearer.

### 37.5. Confusing `sealed` with `final`
- `final` does not allow any subclasses
- `sealed` allows only some subclasses
- `non-sealed` reopens inheritance

---

## 38. Best practices

- Use sealed classes for closed and known hierarchies.
- Use sealed interfaces with records to represent results or states.
- Keep direct subclasses clear and well named.
- Use `final` when you don't want the inheritance to continue.
- Use `sealed` if you want to control another level of inheritance.
- Use `non-sealed` only when you really want to open a branch.
- If the cases are simple and carry no data of their own, consider using an `enum`.
- Don't seal interfaces that are meant to be freely extended.

---

## 39. Things to keep in mind

- `sealed` limits who can inherit or implement.
- `permits` indicates the allowed classes.
- Direct subclasses must be `final`, `sealed` or `non-sealed`.
- `final` closes the inheritance.
- `sealed` keeps inheritance in check.
- `non-sealed` reopens inheritance.
- Sealed interfaces combine very well with records.
- They are useful for results, states and closed hierarchies.
- They help you write safer, more expressive `switch` statements.

---

## 40. Final summary

Sealed classes allow you to better control type hierarchies in Java.

With a normal class or a normal interface, inheritance can be left too open.  
With `sealed`, you can state exactly which classes are part of the family.

Example:

```java
public sealed interface PaymentResult permits PaymentSuccess, PaymentError {
}
```

This makes the design clearer and safer.

The main idea is:

- use `sealed` when you know all possible cases
- use `final` to close a branch
- use `sealed` to keep controlling another branch
- use `non-sealed` to open a specific branch

Combined with records, sealed interfaces are a very powerful tool for modeling data in modern Java.

---

In the next topic we'll keep moving forward with modern Java and look at **Basic Concurrency**, an introduction to running tasks in parallel or in the background with tools like `Thread`, `Runnable` and `ExecutorService`.
