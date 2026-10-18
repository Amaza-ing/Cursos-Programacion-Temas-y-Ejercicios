# Topic 8. Methods: definition and use (parameters, arguments and returns)

## 1. Introduction

As a program grows, a problem appears very quickly: the code becomes long, repetitive and difficult to maintain.

The **methods** solve this because they allow you to:

- Reuse logic without copy and paste
- Divide the program into small and understandable parts
- Give clear names to actions (“calculate”, “validate”, “show”)
- Organize code to make it easier to read and modify

In this topic you will learn:

- What is a method and why is it a basic piece in Java
- How a method is defined (signature, parameters, body, return)
- Difference between **parameters** and **arguments**
- Methods with `return` and `void` methods
- How to call methods and use their result
- Typical errors and good practices

---

[![](https://img.youtube.com/vi/i7Ewxu-9BcI/0.jpg) Methods](https://www.youtube.com/watch?v=i7Ewxu-9BcI&list=PLzA2VyZwsq_-30Z1c9LjWZpq24Kf-2MjD)

---

## 2. What is a method

A **method** is a block of code with a name that:

- Can receive data (parameters)
- Perform a specific task
- Can return a result (`return`)

Think of a method as a “mini tool” within your program.

Mental example:

- `sum(2, 3)` returns 5
- `printWelcomeMessage()` displays a message
- `isEven(10)` returns `true`

---

## 3. Where are methods placed in Java

In Java, methods live **within classes**.

In a basic program (single file), the most common is:

- The `Main` class
- The `main` method
- And other auxiliary methods within the same class

Structure example:

```java
public class Main {
    public static void main(String[] args) {
        // program starts here
    }

    // other methods here
}
```

---

## 4. Parts of a method (signature and body)

One method has:

- **Modifiers** (e.g. `public`, `private`)
- **static** (we will use it for now)
- **Return type** (`int`, `double`, `boolean`, `String`, `void`, etc.)
- **Method name**
- **Parameters** (optional)
- **Body** (block between `{}`)

General syntax:

```java
modifier static returnType methodName(parameterList) {
    // method body
}
```

Real example:

```java
public static int sum(int a, int b) {
    return a + b;
}
```

---

## 5. The `main` method and why it is special

The `main` method is the entry point of the program:

```java
public static void main(String[] args) {
    // code starts here
}
```

Features:

- It is always `public static void`
- It's called exactly `main`
- Receive an `String[] args` (you will see it in more depth later)

Inside `main` normally:

- You declare variables
- Calls to methods
- Show results
- You control the flow of the program

---

## 6. Create your first method (without parameters and without return)

A method can receive nothing and return nothing.

### 6.1. `void` method

If a method returns nothing, its return type is `void`.

Example:

```java
public static void printWelcomeMessage() {
    System.out.println("Welcome to Java!");
}
```

### 6.2. Call method from `main`

```java
public class Main {
    public static void main(String[] args) {
        printWelcomeMessage();
        printWelcomeMessage();
    }

    public static void printWelcomeMessage() {
        System.out.println("Welcome to Java!");
    }
}
```

This prints the message twice without repeating the `System.out.println` in `main`.

---

## 7. Parameters and arguments (clear difference)

This difference is fundamental.

- **Parameters**: variables that appear in the method definition
- **Arguments**: real values that you pass when calling the method

### 7.1. Guided example

Definition (parameters):

```java
public static void greetUser(String userName) {
    System.out.println("Hello, " + userName);
}
```

Call (argument):

```java
greetUser("Laura");
```

Here:
- `userName` is a parameter
- `"Laura"` is an argument

---

### 7.2. Method with multiple parameters

```java
public static void printProfile(String userName, int userAge) {
    System.out.println("Name: " + userName + " | Age: " + userAge);
}
```

Call:

```java
printProfile("Alex", 25);
```

The order matters:

- First argument → first parameter
- Second argument → second parameter

---

## 8. Methods with return (return a value)

A method can return a value using `return`.

When a method returns a value:

- Return type cannot be `void`
- Must return a value compatible with the declared type

### 8.1. Example: adding two numbers

```java
public static int sum(int a, int b) {
    return a + b;
}
```

Call:

```java
int result = sum(5, 3);
System.out.println(result);
```

---

### 8.2. `return` ends method

When Java encounters `return`, the method stops and returns the value.

Example:

```java
public static int clampToZero(int value) {
    if (value < 0) {
        return 0;
    }

    return value;
}
```

What it does:

- If `value` is negative, return 0 immediately
- If not, return `value`

---

## 9. Methods that return `boolean` (very common)

These methods usually start with:

- `is...`
- `has...`
- `can...`

Example: Check if a number is even

```java
public static boolean isEven(int number) {
    return number % 2 == 0;
}
```

Usage:

```java
boolean result = isEven(10);
System.out.println(result);
```

---

## 10. Methods that return `String`

Example: construct a message

```java
public static String buildGreeting(String userName) {
    return "Hello, " + userName + "!";
}
```

Usage:

```java
String message = buildGreeting("Sara");
System.out.println(message);
```

---

## 11. Parameter types (primitives and `String`)

For now we will work mainly with:

- Primitives (`int`, `double`, `boolean`, `char`)
- `String`

Example with `double`:

```java
public static double calculateTotal(double unitPrice, int quantity) {
    return unitPrice * quantity;
}
```

Usage:

```java
double total = calculateTotal(19.99, 3);
System.out.println(total);
```

---

## 12. Scope (scope) of variables in methods

Variables declared within a method exist **only within that method**.

Example:

```java
public static void example() {
    int value = 10;
    System.out.println(value);
}
```

Outside of the method, `value` does not exist.

This helps avoid conflicts and keep code organized.

---

## 13. Methods that call other methods

It is very common to build small methods and combine them.

Example: total with discount

```java
public static double calculateDiscount(double basePrice, double discountRate) {
    return basePrice * discountRate;
}

public static double calculateFinalPrice(double basePrice, double discountRate) {
    double discount = calculateDiscount(basePrice, discountRate);
    return basePrice - discount;
}
```

Usage:

```java
double finalPrice = calculateFinalPrice(120.0, 0.15);
System.out.println(finalPrice);
```

---

## 14. Good practices when designing methods

### 14.1. A method must do one thing

Bad: does too many things at once

```java
public static void processUser() {
    // valida, calcula, imprime, guarda...
}
```

Better: divide responsibilities

- `isValidUser(...)`
- `calculateScore(...)`
- `printSummary(...)`

---

### 14.2. Clear nouns and verbs

Good ideas:

- `calculateTotal`
- `printReport`
- `isAdult`
- `buildMessage`

Avoid generic names like `doStuff` or `test`.

---

### 14.3. Avoid depending on global variables (for now)

At first, it is better for the method to receive what it needs by parameters and return a result.

This makes the method more reusable and easier to test.

---

## 15. Common mistakes when starting out (and how to avoid them)

### 15.1. Forget to use method result

This compiles, but does not take advantage of the `return`:

```java
sum(2, 3);
```

Better:

```java
int result = sum(2, 3);
System.out.println(result);
```

---

### 15.2. Incorrect return type

This doesn't compile:

```java
public static int getName() {
    return "Alex";
}
```

Solution: type must match

```java
public static String getName() {
    return "Alex";
}
```

---

### 15.3. `return` missing

If a method declares a return type, it must return it in all possible paths.

This fails:

```java
public static int getScore(boolean isPremium) {
    if (isPremium) {
        return 100;
    }
}
```

Solution:

```java
public static int getScore(boolean isPremium) {
    if (isPremium) {
        return 100;
    }

    return 50;
}
```

---

### 15.4. Confuse parameters with arguments

- Parameter: `int age`
- Argument: `25`

Example:

```java
public static boolean isAdult(int age) {
    return age >= 18;
}

boolean result = isAdult(25);
```

---
## 16. Complete example (organized program with methods)

This example shows how to use several methods to make `main` cleaner.

```java
public class Main {
    public static void main(String[] args) {
        String userName = "Laura";
        int userAge = 17;

        printWelcomeMessage();

        boolean adult = isAdult(userAge);
        String summary = buildSummary(userName, userAge, adult);

        System.out.println(summary);
    }

    public static void printWelcomeMessage() {
        System.out.println("Welcome!");
    }

    public static boolean isAdult(int age) {
        return age >= 18;
    }

    public static String buildSummary(String userName, int userAge, boolean isAdult) {
        return "User: " + userName + " | Age: " + userAge + " | Adult: " + isAdult;
    }
}
```

What this approach brings:

- `main` becomes a “high level” read of the program
- Each method has a clear responsibility
- You can change the summary format without touching the `main` logic

---

## 17. To take into account

- A method is a reusable piece of named code.
- Methods help organize, reuse and maintain programs.
- Parameters = definition, arguments = values ​​when calling.
- `void` means that the method does not return anything.
- `return` returns a value and terminates the method.
- Designing small methods with clear names greatly improves the quality of the code.

---

In the next topic we will learn about **String methods**, and we will see how to get the most out of this type of data.
