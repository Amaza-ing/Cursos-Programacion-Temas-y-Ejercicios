# Topic 17. Static methods and the `Math` library

## 1. Introduction

Until now you have mainly worked with:

- Variables and types
- Methods
- Classes and objects (POO)
- Constructors and overloading

At this point a very common question appears:

> Why do we sometimes call methods with an object, and other times call them directly with the name of a class?

Examples:

```java
String text = "Java";
System.out.println(text.length()); // método de instancia (necesita un objeto)
```

```java
System.out.println(Math.sqrt(9));   // método estático (se llama con la clase)
```

The difference is in **static**.

In this topic you will learn:

- What is a static method and how does it differ from an instance method?
- When to use `static` and when not to
- What is a static attribute (`static`) and what is it for?
- How to use the `Math` library: basic operations, rounding, powers, roots, random
- Typical errors and good practices

---

[![Methods and Static Variables](https://img.youtube.com/vi/KIGT1UcAv9Q/0.jpg)](https://www.youtube.com/watch?v=KIGT1UcAv9Q&list=PLzA2VyZwsq_-30Z1c9LjWZpq24Kf-2MjD)

---

## 2. What does `static` mean in Java

`static` indicates that a member (method or attribute) belongs to the **class**, not to a specific object.

- **instance** member: belongs to each object
- **static** member: belongs to the class and is shared

### 2.1. Quick example

Imagine an `Counter` class that counts created objects:

```java
public class Counter {
    private static int total = 0;

    public Counter() {
        total++;
    }

    public static int getTotal() {
        return total;
    }
}
```

Usage:

```java
public class Main {
    public static void main(String[] args) {
        new Counter();
        new Counter();
        new Counter();

        System.out.println(Counter.getTotal()); // 3
    }
}
```

- `total` is shared by everyone.
- `getTotal()` is static, so it is called with `Counter.getTotal()`.

---

## 3. Instance methods vs static methods

### 3.1. instance method

An instance method needs an object to exist and usually works with the state of that object.

```java
String name = "Laura";
int size = name.length();
```

Here `length()` works with the characters of the `name` object.

### 3.2. static method

A static method does not need an object. It is called with the name of the class.

```java
double root = Math.sqrt(25);
```

Here `sqrt` is a general calculation, it does not depend on the state of an `Math` object.

---

## 4. Why `main` is `static`?

The `main` method is the entry point of a Java program.

```java
public static void main(String[] args) { ... }
```

Java calls it without creating an `Main` object.  
That's why it needs to be `static`.

---

## 5. Important rules of `static`

### 5.1. A static method CANNOT access instance attributes directly

Example (error):

```java
public class User {
    private String name;

    public static void printName() {
        // System.out.println(name); // error: name no es estático
    }
}
```

Why? Because `name` belongs to concrete objects, and in a static context there is no “current” object.

To access, you need an object:

```java
public static void printUserName(User user) {
    System.out.println(user.name); // dentro de la clase se puede acceder a private
}
```

> In practice, it is common to avoid this pattern and use instance methods to print instance data.

### 5.2. An instance method can use static members

Because statics always exist at the class level.

---

## 6. When to use static methods

Use `static` when the method:

- Does not depend on the state of an object
- Makes a calculation or a general utility
- It is a “pure” function (same input → same output)
- It is a helper to reuse logic

Typical examples:

- `Math.sqrt`, `Math.max`, `Integer.parseInt`
- Utilities like `String.valueOf`
- Helper methods in `Utils` classes (when it makes sense)

---

## 7. Example: `Calculator` class with static methods

```java
public class Calculator {

    public static int sum(int a, int b) {
        return a + b;
    }

    public static int clampToZero(int value) {
        if (value < 0) {
            return 0;
        }

        return value;
    }
}
```

Usage:

```java
public class Main {
    public static void main(String[] args) {
        System.out.println(Calculator.sum(5, 7));
        System.out.println(Calculator.clampToZero(-3));
    }
}
```

Note that you do not need to create `new Calculator()`.

---

## 8. Static attributes (`static`) and constants (`static final`)

### 8.1. static attribute

A static attribute is shared among all objects.

Example: a counter of created users.

```java
public class User {
    private static int totalUsers = 0;

    private String name;

    public User(String name) {
        this.name = name;
        totalUsers++;
    }

    public static int getTotalUsers() {
        return totalUsers;
    }
}
```

Usage:

```java
public class Main {
    public static void main(String[] args) {
        new User("Laura");
        new User("Alex");

        System.out.println(User.getTotalUsers()); // 2
    }
}
```

### 8.2. Constants: `static final`

For values that do not change.

Convention: name in CAPITAL LETTERS.

```java
public class AppConfig {
    public static final int MAX_ATTEMPTS = 3;
}
```

Usage:

```java
int attempts = AppConfig.MAX_ATTEMPTS;
```

---

## 9. The `Math` library

`Math` is a class in `java.lang`, you don't need to import it.

Its most used methods are **static**, that's why they are called with `Math.`

---

## 10. Basic operations with `Math`

### 10.1. `Math.abs` (absolute value)

```java
int value = -10;
System.out.println(Math.abs(value)); // 10
```

### 10.2. `Math.max` and `Math.min`

```java
int a = 10;
int b = 25;

System.out.println(Math.max(a, b)); // 25
System.out.println(Math.min(a, b)); // 10
```

---

## 11. Powers and roots

### 11.1. `Math.pow`

Returns `double`.

```java
double result = Math.pow(2, 3);
System.out.println(result); // 8.0
```

### 11.2. `Math.sqrt`

```java
double root = Math.sqrt(81);
System.out.println(root); // 9.0
```

### 11.3. `Math.cbrt` (cubic root)

```java
double value = Math.cbrt(27);
System.out.println(value); // 3.0
```

---

## 12. Roundings

### 12.1. `Math.round`

Rounds to the nearest integer (returns `long` or `int` depending on the type).

```java
double value = 4.6;
System.out.println(Math.round(value)); // 5
```

### 12.2. `Math.floor` and `Math.ceil`

- `floor`: down
- `ceil`: up

```java
double value = 4.2;

System.out.println(Math.floor(value)); // 4.0
System.out.println(Math.ceil(value));  // 5.0
```

---

## 13. Random numbers

### 13.1. `Math.random()`

`Math.random()` returns an `double` between:

- 0.0 (included)
- 1.0 (excluded)

```java
double r = Math.random();
System.out.println(r);
```

### 13.2. Random integer in a range (very common)

We want an integer between `min` and `max` (inclusive).

Formula:

```java
int randomInt = (int) (Math.random() * (max - min + 1)) + min;
```

Example: integer between 1 and 6 (like a die)

```java
int min = 1;
int max = 6;

int dice = (int) (Math.random() * (max - min + 1)) + min;
System.out.println(dice);
```

---

## 14. Mathematical constants

### 14.1. `Math.PI`

```java
System.out.println(Math.PI);
```

Example: area of a circle

```java
double radius = 3.0;
double area = Math.PI * radius * radius;

System.out.println(area);
```

### 14.2. `Math.E`

```java
System.out.println(Math.E);
```

---

## 15. Complete Guided Examples

### 15.1. Calculate distance on a line (absolute value)

Objective: given two points on a line, calculate the distance.

```java
public class Main {
    public static void main(String[] args) {
        int x1 = -3;
        int x2 = 10;

        int distance = Math.abs(x2 - x1);
        System.out.println(distance); // 13
    }
}
```

---

### 15.2. Round a price to 2 decimal places (simple approach)

Sometimes you want to round to 2 decimal places. A typical approach is:

- Multiply by 100
- Round
- Divide by 100

```java
public class Main {
    public static void main(String[] args) {
        double price = 19.987;

        double rounded = Math.round(price * 100.0) / 100.0;
        System.out.println(rounded); // 19.99
    }
}
```

---

### 15.3. Generate a 4-digit numeric password

Generate a random number between 1000 and 9999:

```java
public class Main {
    public static void main(String[] args) {
        int min = 1000;
        int max = 9999;

        int code = (int) (Math.random() * (max - min + 1)) + min;
        System.out.println(code);
    }
}
```

---

## 16. Typical errors with `Math` and `static`

### 16.1. Thinking that `Math.random()` includes 1.0

It does not include it, it can get close but it does not reach 1.0.

### 16.2. Forget `+ 1` in inclusive ranges

For ranges that include `max`, you need `(max - min + 1)`.

### 16.3. Confusing static methods with instance methods

This is incorrect:

```java
// Math m = new Math(); // no se puede (constructor privado)
```

`Math` is used directly:

```java
double x = Math.sqrt(9);
```

### 16.4. Use `Math.pow` and wait for an `int`

`Math.pow` returns `double`. If you need `int`, please convert carefully:

```java
int value = (int) Math.pow(2, 3); // 8
```

---

## 17. Good practices

- Use static methods when you don't need object state.
- Centralize utilities in static methods (if it makes sense).
- Avoid huge “Utils” classes: they have a clear purpose.
- For randoms, remember the formula for ranges.
- To round with decimals, use clear techniques (such as multiplying and dividing).

---

## 18. To take into account

- `static` means “belongs to the class”.
- Static methods are called with `ClassName.method()`.
- Instance methods are called with `object.method()`.
- `main` is static because Java executes it without creating objects.
- `Math` is a class of utilities with static methods: `sqrt`, `pow`, `max`, `round`, etc.
- `Math.random()` generates an `double` between 0.0 and 1.0 (not including 1.0).

---

In the next topic we will continue with the important concepts of Object-Oriented Programming **Inheritance and Polymorphism**.
