# Topic 24. `enum` in Java

## 1. Introduction

As you program in Java, you will find situations where a variable cannot take just any value, but only one from a **limited and known** set of options.

Typical examples:

- The days of the week
- The status of an order
- The difficulty level of a game
- The role of a user
- The size of a T-shirt
- The seasons of the year
- The colors allowed in a configuration

A bad solution would be to use `String`:

```java
String status = "SHIPPED";
```

This works, but it has several problems:

- you can misspell the value (`"SHIPED"`, `"shipped"`, `"Shipped"`)
- there is no real control over the set of allowed values
- the code is less safe and less clear
- future changes are harder to maintain

To solve this, Java offers **enums**.

An `enum` allows you to define a fixed set of named constants.

In this topic you will learn:

- what an `enum` is
- when to use it and why it is better than using `String` or magic numbers
- how to declare and use an `enum`
- how to use `enum` with `switch`
- how to add attributes, constructors and methods to an `enum`
- useful methods like `values()`, `valueOf()` and `name()`
- good practices and typical mistakes

---

[![Enums](https://img.youtube.com/vi/KxBI-WWq1yc/0.jpg)](https://www.youtube.com/watch?v=KxBI-WWq1yc&list=PLzA2VyZwsq_-30Z1c9LjWZpq24Kf-2MjD)

---

## 2. What is an `enum`

`enum` is short for **enumeration**.

An `enum` is a special Java type that represents a fixed set of constants.

Simple example:

```java
public enum OrderStatus {
    CREATED,
    PAID,
    SHIPPED,
    DELIVERED
}
```

Here `OrderStatus` can only take one of these four values.

---

## 3. When to use an `enum`

Use an `enum` when:

- there is a fixed and known set of values
- you want to give clear meaning to those values
- you want to avoid errors with `String` values or arbitrary numbers
- you want the compiler to help you detect incorrect usage

Clear examples:

- `DayOfWeek`
- `OrderStatus`
- `Difficulty`
- `Role`
- `TrafficLight`

It usually doesn't make sense to use an `enum` when the values:

- are completely free
- change dynamically based on external data
- do not form a fixed set

---

## 4. First basic example

### 4.1. Declaration

```java
public enum Difficulty {
    EASY,
    MEDIUM,
    HARD
}
```

### 4.2. Using it in a variable

```java
public class Main {
    public static void main(String[] args) {
        Difficulty difficulty = Difficulty.MEDIUM;

        System.out.println(difficulty);
    }
}
```

Output:

```java
MEDIUM
```

---

## 5. Comparing `enum` values

Enums are usually compared with `==`.

This is different from `String`, where you would normally have to use `equals`.

Example:

```java
Difficulty difficulty = Difficulty.HARD;

if (difficulty == Difficulty.HARD) {
    System.out.println("High difficulty");
}
```

Why does `==` work well here?

Because each constant of an `enum` is unique within the program.

---

## 6. `enum` instead of `String`

Let's see a clear comparison.

### 6.1. Using `String` (worst option)

```java
String status = "PAID";

if (status.equals("PAID")) {
    System.out.println("Order is paid");
}
```

Problems:

- if you write `"paid"` in lowercase, it fails
- if you write `"PADI"` by mistake, it compiles anyway
- there is no strong control over the set of allowed values

### 6.2. Using `enum` (best option)

```java
public enum OrderStatus {
    CREATED,
    PAID,
    SHIPPED,
    DELIVERED
}
```

```java
OrderStatus status = OrderStatus.PAID;

if (status == OrderStatus.PAID) {
    System.out.println("Order is paid");
}
```

Advantages:

- the compiler validates the values
- the code is more readable
- you avoid typos
- you can use `switch` very cleanly

---

## 7. `switch` with `enum`

One of the best combinations with `enum` is `switch`.

Example:

```java
public enum TrafficLight {
    RED,
    YELLOW,
    GREEN
}
```

```java
public class Main {
    public static void main(String[] args) {
        TrafficLight light = TrafficLight.YELLOW;

        switch (light) {
            case RED:
                System.out.println("Stop");
                break;
            case YELLOW:
                System.out.println("Be careful");
                break;
            case GREEN:
                System.out.println("Go");
                break;
        }
    }
}
```

You can also use the modern `switch`:

```java
String message = switch (light) {
    case RED -> "Stop";
    case YELLOW -> "Be careful";
    case GREEN -> "Go";
};
```

---

## 8. Useful `enum` methods

Every `enum` has some useful built-in methods.

### 8.1. `values()`

Returns an array with all the values of the `enum`.

Example:

```java
public enum Day {
    MONDAY,
    TUESDAY,
    WEDNESDAY
}
```

```java
public class Main {
    public static void main(String[] args) {
        for (Day day : Day.values()) {
            System.out.println(day);
        }
    }
}
```

Output:

```java
MONDAY
TUESDAY
WEDNESDAY
```

### 8.2. `name()`

Returns the exact name of the constant as a `String`.

```java
Day day = Day.MONDAY;
System.out.println(day.name()); // MONDAY
```

### 8.3. `ordinal()`

Returns the position of the constant according to the order in which it was declared.

```java
System.out.println(Day.MONDAY.ordinal());   // 0
System.out.println(Day.TUESDAY.ordinal());  // 1
```

**Important:** It is not advisable to base important logic on `ordinal()`, because if you change the order of the `enum`, those numbers change.

### 8.4. `valueOf(...)`

Converts a `String` into a value of the `enum`.

```java
Day day = Day.valueOf("MONDAY");
System.out.println(day);
```

But be careful: the text must match exactly or it will throw an exception.

```java
// Day.valueOf("monday"); // IllegalArgumentException
```

---

## 9. Iterating over all the values of an `enum`

This is very useful for menus, validations, debugging or showing options to the user.

Example:

```java
public enum Role {
    ADMIN,
    EDITOR,
    USER,
    GUEST
}
```

```java
public class Main {
    public static void main(String[] args) {
        for (Role role : Role.values()) {
            System.out.println(role);
        }
    }
}
```

---

## 10. `enum` with attributes, constructor and methods

This is where many people discover that an `enum` in Java is quite powerful.

An `enum` can have:

- attributes
- a constructor
- methods
- its own logic

### 10.1. Example: priority levels

```java
public enum Priority {
    LOW(1),
    MEDIUM(2),
    HIGH(3);

    private int level;

    Priority(int level) {
        this.level = level;
    }

    public int getLevel() {
        return level;
    }
}
```

Usage:

```java
public class Main {
    public static void main(String[] args) {
        Priority priority = Priority.HIGH;

        System.out.println(priority);
        System.out.println(priority.getLevel());
    }
}
```

### 10.2. Important points about the `enum` constructor

The constructor of the `enum`:

- is not called with `new`
- is used internally by Java to create each constant
- is usually implicitly `private`

You can't do this:

```java
// Priority p = new Priority(4); // error
```

---

## 11. Example: `Planet` with associated data

```java
public enum Planet {
    MERCURY(57.9),
    VENUS(108.2),
    EARTH(149.6),
    MARS(227.9);

    private double distanceFromSun;

    Planet(double distanceFromSun) {
        this.distanceFromSun = distanceFromSun;
    }

    public double getDistanceFromSun() {
        return distanceFromSun;
    }
}
```

Usage:

```java
public class Main {
    public static void main(String[] args) {
        for (Planet planet : Planet.values()) {
            System.out.println(
                    planet + " -> " + planet.getDistanceFromSun() + " million km"
            );
        }
    }
}
```

This shows that an `enum` is not just a list of words; it can encapsulate data and behavior.

---

## 12. `enum` with its own methods

You can add logic directly to the `enum`.

Example:

```java
public enum AccessLevel {
    GUEST,
    USER,
    ADMIN;

    public boolean canEdit() {
        return this == USER || this == ADMIN;
    }
}
```

Usage:

```java
public class Main {
    public static void main(String[] args) {
        AccessLevel access = AccessLevel.USER;

        System.out.println(access.canEdit());
    }
}
```

This improves cohesion: the logic associated with the concept lives within the `enum` itself.

---

## 13. Overriding `toString()` in an `enum`

By default, an `enum` prints the exact name of the constant.

Example:

```java
System.out.println(Priority.HIGH); // HIGH
```

But you can override `toString()` to get more readable output.

```java
public enum Size {
    SMALL,
    MEDIUM,
    LARGE;

    @Override
    public String toString() {
        return switch (this) {
            case SMALL -> "Small";
            case MEDIUM -> "Medium";
            case LARGE -> "Large";
        };
    }
}
```

Usage:

```java
public class Main {
    public static void main(String[] args) {
        System.out.println(Size.SMALL); // Small
    }
}
```

---

## 14. Complete example: order status with behavior

### 14.1. `OrderStatus.java`

```java
public enum OrderStatus {
    CREATED("Order created"),
    PAID("Order paid"),
    SHIPPED("Order shipped"),
    DELIVERED("Order delivered");

    private String description;

    OrderStatus(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }

    public boolean isFinalStatus() {
        return this == DELIVERED;
    }
}
```

### 14.2. Using it in an `Order` class

```java
public class Order {
    private String id;
    private OrderStatus status;

    public Order(String id) {
        this.id = id;
        this.status = OrderStatus.CREATED;
    }

    public OrderStatus getStatus() {
        return status;
    }

    public void setStatus(OrderStatus status) {
        if (status == null) {
            return;
        }

        this.status = status;
    }

    public void printInfo() {
        System.out.println(
                "Order: " + id +
                " | Status: " + status +
                " | Description: " + status.getDescription()
        );
    }
}
```

### 14.3. `Main.java`

```java
public class Main {
    public static void main(String[] args) {
        Order order = new Order("ORD-100");

        order.printInfo();

        order.setStatus(OrderStatus.PAID);
        order.printInfo();

        order.setStatus(OrderStatus.SHIPPED);
        order.printInfo();

        order.setStatus(OrderStatus.DELIVERED);
        order.printInfo();

        System.out.println(order.getStatus().isFinalStatus());
    }
}
```

---

## 15. `enum` in methods and parameters

It is very common to use an `enum` as a method parameter.

Example:

```java
public enum Role {
    ADMIN,
    USER,
    GUEST
}
```

```java
public class SecurityService {
    public static boolean canDelete(Role role) {
        return role == Role.ADMIN;
    }
}
```

Usage:

```java
public class Main {
    public static void main(String[] args) {
        System.out.println(SecurityService.canDelete(Role.ADMIN));
        System.out.println(SecurityService.canDelete(Role.USER));
    }
}
```

This makes the method much safer and more expressive.

---

## 16. `enum` in lists and collections

Enums work perfectly with collections.

Example:

```java
import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<Priority> priorities = new ArrayList<>();
        priorities.add(Priority.LOW);
        priorities.add(Priority.HIGH);
        priorities.add(Priority.MEDIUM);

        for (Priority priority : priorities) {
            System.out.println(priority + " -> " + priority.getLevel());
        }
    }
}
```

---
## 17. `EnumSet` (introduction)

Java has a special collection for working with enums: `EnumSet`.

It is very efficient and is designed specifically for them.

Simple example:

```java
import java.util.EnumSet;

public class Main {
    public static void main(String[] args) {
        EnumSet<WeekendDay> weekend = EnumSet.of(WeekendDay.SATURDAY, WeekendDay.SUNDAY);

        System.out.println(weekend);
    }
}
```

```java
public enum WeekendDay {
    SATURDAY,
    SUNDAY
}
```

You don't need to master `EnumSet` now, but it's good to know it exists.

---

## 18. Common beginner mistakes

### 18.1. Using `String` when the set of values is fixed

If the values are controlled and limited, an `enum` is usually better.

### 18.2. Thinking that an `enum` is just a list of constants

It can have attributes, a constructor, methods and logic.

### 18.3. Using `ordinal()` as an important part of the logic

It is dangerous, because changing the order of the `enum` changes the ordinals.

### 18.4. Using `valueOf(...)` with unvalidated text

If the text does not match exactly, it throws an exception.

Example:

```java
// Day.valueOf("monday"); // error
```

### 18.5. Trying to create dynamic constants

An `enum` represents a fixed set. You cannot add new values at runtime.

---

## 19. Good practices

- Use `enum` when you have a fixed, known set of values.
- Use clear, uppercase names for constants (`PENDING`, `PAID`, `DONE`).
- Avoid using `ordinal()` for important logic.
- Add attributes and methods to the `enum` when it makes things clearer.
- If some logic belongs to the concept represented by the `enum`, consider putting it inside the `enum` itself.

---

## 20. Things to keep in mind

- An `enum` defines a fixed set of constants.
- It is much safer than using `String` or magic numbers.
- You can compare it with `==`.
- You can use it with `switch`.
- It has useful methods like `values()`, `name()`, `valueOf()` and `ordinal()`.
- It can have its own attributes, constructors and methods.
- It is used a lot in real-world Java.

---

## 21. Final summary

- **`enum`** is used to represent limited and known options.
- **It improves safety and readability** compared to `String`.
- **It is compared with `==`**.
- **It works great with `switch`**.
- **It can have data and behavior**; it is not just a list of constants.
- **It is ideal** for states, roles, levels, types and closed configurations.

---

In the next topic we will keep moving forward by working with other data collections such as `HashMaps`.
